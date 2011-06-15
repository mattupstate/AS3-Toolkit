package net.nobien.utils 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Transform;

    /**
     * The DisplayObjectUtil class contains static utility functions for analyzing and manipulating diplay objects.
     */
    public class DisplayObjectUtil
    {
        /**
         * Destroys a Loader object. If the content is still loading, it cancels the loading operation.
         * If the content is loaded all timelines will be stopped and frame scripts will be removed.
         * @param	loader  A loader to destroy.
         */
        public static function destroyLoader( loader:Loader ):void
        {
            if( loader.contentLoaderInfo.bytesTotal > 0 && loader.contentLoaderInfo.bytesLoaded == loader.contentLoaderInfo.bytesTotal )
            {
                stopAllTimelines( loader );
                removeAllFrameScripts( loader );
            }
            
            try
            {
                loader["unloadAndStop"]();
            }
            catch( error:Error )
            {
                try
                {
                    loader.unload();
                }
                catch( error:Error )
                {
                    
                }
            }
        }
        
        /**
         * Get the children of a container as an array
         * @param container Container to get the children of
         * @return The children of the given container as an array
         */
        public static function getChildren( container:DisplayObjectContainer ):Array
        {
            var ret:Array = [];
         
            var numChildren:int = container.numChildren;
            
            for ( var i:int = 0; i < numChildren; ++i )
            {
                ret.push( container.getChildAt( i ) );
            }
         
            return ret;
        }
        
        /**
         * Determines the full bounds of the display object regardless of masking elements.
         * @param	displayObject	The display object to analyze.
         * @return	the display object dimensions.
         */
        public static function getFullBounds( displayObject:DisplayObject ):Rectangle
        {
            var bounds:Rectangle, transform:Transform, toGlobalMatrix:Matrix, currentMatrix:Matrix;

            transform = displayObject.transform;
            currentMatrix = transform.matrix;
            toGlobalMatrix = transform.concatenatedMatrix;
            toGlobalMatrix.invert();
            transform.matrix = toGlobalMatrix;
         
            bounds = transform.pixelBounds.clone();
         
            transform.matrix = currentMatrix;
         
            return bounds;
        }
        
        /**
         * Get the parents of a display object as an array
         * @param obj Object whose parents should be retrieved
         * @param includeSelf If obj should be included in the returned array
         * @param stopAt Display object to stop getting parents at. Passing null indicates that all parents should be included.
         * @return An array of the parents of the given display object. This includes all parents unless stopAt is non-null. If 
         * 		   stopAt is non-null, it and its parents will not be included in the returned array.
         */
        public static function getParents( obj:DisplayObject, includeSelf:Boolean=true, stopAt:DisplayObject=null ):Array
        {
            var ret:Array = [];
         
            for ( var cur:DisplayObject = includeSelf ? obj : obj.parent; cur != stopAt && cur != null; cur = cur.parent )
            {
                ret.push( cur );
            }
         
            return ret;
        }
        
        /**
         * Determines the tallest child.
         * @param	container   The container display object
         * @return  The tallest display object
         */
        public static function getTallestChild( container:DisplayObjectContainer ):DisplayObject
        {
            var value:Number = 0;
            var result:DisplayObject;
            
            for( var i:int = 0; i < container.numChildren; i++ )
            {
                var child:DisplayObject = container.getChildAt( i );
                
                if( child.height > value )
                {
                    value = child.height;
                    result = child;
                }
            }
            
            return result;
        }
        
        /**
         * Determines the widest child.
         * @param	container   The container display object
         * @return  The widest display object
         */
        public static function getWidestChild( container:DisplayObjectContainer ):DisplayObject
        {
            var value:Number = 0;
            var result:DisplayObject;
            
            for( var i:int = 0; i < container.numChildren; i++ )
            {
                var child:DisplayObject = container.getChildAt( i );
                
                if( child.width > value )
                {
                    value = child.width;
                    result = child;
                }
            }
            
            return result;
        }
        
        /**
         * Check if a display object is visible. This checks all of its parents' visibilities.
         * @param obj Display object to check
         * @return False if the display object is not visible to the user. True if it is.
         */
        public static function isVisible( obj:DisplayObject ):Boolean
        {
            for ( var cur:DisplayObject = obj; cur != null; cur = cur.parent )
            {
                if ( !cur.visible )
                {
                    return false;
                }
            }
            
            return true;
        }
        
        /**
         * Remove all children from a container and leave the bottom few
         * @param container Container to remove from
         * @param leave (optional) Number of bottom children to leave
         */
        public static function removeAllChildren( container:DisplayObjectContainer, leave:int = 0 ):void
        {
            while( container.numChildren > leave )
            {
                container.removeChildAt( leave );
            }
        }
        
        /**
         * Removes all frame scripts from the specified display object and its children.
         * @param	displayObject	The display object to loop through.
         */
        public static function removeAllFrameScripts( displayObject:DisplayObjectContainer ):void
        {
            var numChildren:int = displayObject.numChildren;
            
            for (var i:int = 0; i < numChildren; i++ )
            {
                var child:DisplayObject = displayObject.getChildAt( i );
                
                if ( child is DisplayObjectContainer ) 
                {
                    if ( child is MovieClip ) 
                    {
                        var numFrames:int = MovieClip( child ).totalFrames;
                        
                        for( var f:int = 0; f < numFrames; f++ )
                        {
                            MovieClip( child ).addFrameScript( f, null );
                        }
                    }
                    
                    removeAllFrameScripts( child as DisplayObjectContainer );
                }
            }
        }
        
        /**
         * Stops all timelines of the specified display object and its children.
         * @param	displayObject	The display object to loop through.
         */
        public static function stopAllTimelines( displayObject:DisplayObjectContainer ):void
        {
            var numChildren:int = displayObject.numChildren;
            
            for (var i:int = 0; i < numChildren; i++ )
            {
                var child:DisplayObject = displayObject.getChildAt( i );
                
                if ( child is DisplayObjectContainer ) 
                {
                    if ( child is MovieClip ) 
                    {
                        MovieClip( child ).stop();
                    }
                    
                    stopAllTimelines( child as DisplayObjectContainer );
                }
            }
        }
        
        /**
         * Determines if the mouse cursor is over a diplay object.
         * @param	obj	The display object to check.
         * @return  True if the mouse is over the display object. False if not.
         */
        public static function isMouseOver( obj:DisplayObject ):Boolean
        {
            var pt:Point = new Point( obj.stage.mouseX, obj.stage.mouseY );
            obj.globalToLocal( pt );
            return obj.hitTestPoint( pt.x, pt.y );
        }
    }
}