package net.nobien.utils 
{
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.display.DisplayObject;

    /**
     * The AlignUtil class contains static utility methods for aligning display objects.
     */
    public class AlignUtil
    {
        public static const BOTTOM:String = "B";
        public static const BOTTOM_LEFT:String = "BL";
        public static const BOTTOM_CENTER:String = "BC";
        public static const BOTTOM_RIGHT:String = "BR";
        public static const CENTER:String = "C";
        public static const LEFT:String = "L";
        public static const MIDDLE:String = "M";
        public static const MIDDLE_LEFT:String = "ML";
        public static const MIDDLE_CENTER:String = "MC";
        public static const MIDDLE_RIGHT:String = "MR";
        public static const RIGHT:String = "R";
        public static const TOP:String = "T";
        public static const TOP_LEFT:String = "TL";
        public static const TOP_CENTER:String = "TC";
        public static const TOP_RIGHT:String = "TR";
        
        /**
         * Aligns a DisplayObject according ot the specified alignment rule within the bounding Rectangle regardless of its registration point.
         * @param displayObject: The DisplayObject to align.
         * @param ruleConstant: The alignment rule String constant.
         * @param bounds: The area in which to align the DisplayObject.
         * @param snapToPixel: Force the position to whole pixels {@code true}, or to let the DisplayObject be positioned on sub-pixels {@code false}.
         */
        public static function align( displayObject:DisplayObject, ruleConstant:String, bounds:Rectangle, snapToPixel:Boolean = true ):void
        {
            switch ( ruleConstant )
            {
                case TOP_LEFT:
                    AlignUtil.alignTopLeft( displayObject, bounds, snapToPixel );
                    break;
                    
                case TOP_CENTER:
                    AlignUtil.alignTopCenter( displayObject, bounds, snapToPixel );
                    break;
                    
                case TOP_RIGHT:
                    AlignUtil.alignTopRight( displayObject, bounds, snapToPixel );
                    break;
                    
                case MIDDLE_LEFT:
                    AlignUtil.alignMiddleLeft( displayObject, bounds, snapToPixel );
                    break;
                    
                case MIDDLE_CENTER:
                    AlignUtil.alignMiddleCenter( displayObject, bounds, snapToPixel );
                    break;
                    
                case MIDDLE_RIGHT:
                    AlignUtil.alignMiddleRight( displayObject, bounds, snapToPixel );
                    break;
                    
                case BOTTOM_LEFT:
                    AlignUtil.alignBottomLeft( displayObject, bounds, snapToPixel );
                    break;
                    
                case BOTTOM_CENTER:
                    AlignUtil.alignBottomCenter( displayObject, bounds, snapToPixel );
                    break;
                    
                case BOTTOM_RIGHT:
                    AlignUtil.alignBottomRight( displayObject, bounds, snapToPixel );
                    break;
                    
            }
        }
        
        /**
         * Aligns a DisplayObject to the top left of the bounding Rectangle regardless of its registration point.
         * @param displayObject: The DisplayObject to align.
         * @param bounds: The area in which to align the DisplayObject.
         * @param snapToPixel: Force the position to whole pixels {@code true}, or to let the DisplayObject be positioned on sub-pixels {@code false}.
         */
        public static function alignTopLeft( displayObject:DisplayObject, bounds:Rectangle, snapToPixel:Boolean = true ):void 
        {
            AlignUtil.alignTop( displayObject, bounds, snapToPixel );
            AlignUtil.alignLeft( displayObject, bounds, snapToPixel );
        }
        
        /**
         * Aligns a DisplayObject to the top center of the bounding Rectangle regardless of its registration point.
         * @param displayObject: The DisplayObject to align.
         * @param bounds: The area in which to align the DisplayObject.
         * @param snapToPixel: Force the position to whole pixels {@code true}, or to let the DisplayObject be positioned on sub-pixels {@code false}.
         */
        public static function alignTopCenter( displayObject:DisplayObject, bounds:Rectangle, snapToPixel:Boolean = true ):void
        {
            AlignUtil.alignTop( displayObject, bounds, snapToPixel );
            AlignUtil.alignCenter( displayObject, bounds, snapToPixel );
        }
        
        /**
         * Aligns a DisplayObject to the top right of the bounding Rectangle regardless of its registration point.
         * @param displayObject: The DisplayObject to align.
         * @param bounds: The area in which to align the DisplayObject.
         * @param snapToPixel: Force the position to whole pixels {@code true}, or to let the DisplayObject be positioned on sub-pixels {@code false}.
         */
        public static function alignTopRight( displayObject:DisplayObject, bounds:Rectangle, snapToPixel:Boolean = true ):void 
        {
            AlignUtil.alignTop( displayObject, bounds, snapToPixel );
            AlignUtil.alignRight( displayObject, bounds, snapToPixel );
        }
        
        /**
         * Aligns a DisplayObject to the middle left of the bounding Rectangle regardless of its registration point.
         * @param displayObject: The DisplayObject to align.
         * @param bounds: The area in which to align the DisplayObject.
         * @param snapToPixel: Force the position to whole pixels {@code true}, or to let the DisplayObject be positioned on sub-pixels {@code false}.
         */
        public static function alignMiddleLeft(displayObject:DisplayObject, bounds:Rectangle, snapToPixel:Boolean = true):void {
            AlignUtil.alignMiddle( displayObject, bounds, snapToPixel );
            AlignUtil.alignLeft( displayObject, bounds, snapToPixel );
        }
        
        /**
         * Aligns a DisplayObject to the middle center of the bounding Rectangle regardless of its registration point.
         * @param displayObject: The DisplayObject to align.
         * @param bounds: The area in which to align the DisplayObject.
         * @param snapToPixel: Force the position to whole pixels {@code true}, or to let the DisplayObject be positioned on sub-pixels {@code false}.
         */
        public static function alignMiddleCenter(displayObject:DisplayObject, bounds:Rectangle, snapToPixel:Boolean = true):void {
            AlignUtil.alignMiddle( displayObject, bounds, snapToPixel );
            AlignUtil.alignCenter( displayObject, bounds, snapToPixel );
        }
        
        /**
         * Aligns a DisplayObject to the middle right of the bounding Rectangle regardless of its registration point.
         * @param displayObject: The DisplayObject to align.
         * @param bounds: The area in which to align the DisplayObject.
         * @param snapToPixel: Force the position to whole pixels {@code true}, or to let the DisplayObject be positioned on sub-pixels {@code false}.
         */
        public static function alignMiddleRight(displayObject:DisplayObject, bounds:Rectangle, snapToPixel:Boolean = true):void {
            AlignUtil.alignMiddle( displayObject, bounds, snapToPixel );
            AlignUtil.alignRight( displayObject, bounds, snapToPixel );
        }
        
        /**
         * Aligns a DisplayObject to the bottom left of the bounding Rectangle regardless of its registration point.
         * @param displayObject: The DisplayObject to align.
         * @param bounds: The area in which to align the DisplayObject.
         * @param snapToPixel: Force the position to whole pixels {@code true}, or to let the DisplayObject be positioned on sub-pixels {@code false}.
         */
        public static function alignBottomLeft( displayObject:DisplayObject, bounds:Rectangle, snapToPixel:Boolean = true ):void 
        {
            AlignUtil.alignBottom( displayObject, bounds, snapToPixel );
            AlignUtil.alignLeft( displayObject, bounds, snapToPixel );
        }
        
        /**
         * Aligns a DisplayObject to the bottom center of the bounding Rectangle regardless of its registration point.
         * @param displayObject: The DisplayObject to align.
         * @param bounds: The area in which to align the DisplayObject.
         * @param snapToPixel: Force the position to whole pixels {@code true}, or to let the DisplayObject be positioned on sub-pixels {@code false}.
         */
        public static function alignBottomCenter( displayObject:DisplayObject, bounds:Rectangle, snapToPixel:Boolean = true ):void 
        {
            AlignUtil.alignBottom( displayObject, bounds, snapToPixel );
            AlignUtil.alignCenter( displayObject, bounds, snapToPixel );
        }
        
        /**
         * Aligns a DisplayObject to the bottom right of the bounding Rectangle regardless of its registration point.
         * @param displayObject: The DisplayObject to align.
         * @param bounds: The area in which to align the DisplayObject.
         * @param snapToPixel: Force the position to whole pixels {@code true}, or to let the DisplayObject be positioned on sub-pixels {@code false}.
         */
        public static function alignBottomRight( displayObject:DisplayObject, bounds:Rectangle, snapToPixel:Boolean = true ):void 
        {
            AlignUtil.alignBottom( displayObject, bounds, snapToPixel );
            AlignUtil.alignRight( displayObject, bounds, snapToPixel );
        }
        
        /**
         * Aligns a DisplayObject to the top of the bounding Rectangle regardless of its registration point.
         * @param displayObject: The DisplayObject to align.
         * @param bounds: The area in which to align the DisplayObject.
         * @param snapToPixel: Force the position to whole pixels {@code true}, or to let the DisplayObject be positioned on sub-pixels {@code false}.
         */
        public static function alignTop( displayObject:DisplayObject, bounds:Rectangle, snapToPixel:Boolean = true ):void 
        {
            var dY:Number = AlignUtil.getTop( displayObject.getBounds( null ), bounds );
            displayObject.y = ( snapToPixel ) ? Math.round( dY ) : dY;
        }
        
        /**
         * Aligns a DisplayObject to the bottom of the bounding Rectangle regardless of its registration point.
         * @param displayObject: The DisplayObject to align.
         * @param bounds: The area in which to align the DisplayObject.
         * @param snapToPixel: Force the position to whole pixels {@code true}, or to let the DisplayObject be positioned on sub-pixels {@code false}.
         */
        public static function alignBottom( displayObject:DisplayObject, bounds:Rectangle, snapToPixel:Boolean = true ):void
        {
            var dY:Number = AlignUtil.getBottom( displayObject.getBounds( null ), bounds );
            displayObject.y = ( snapToPixel ) ? Math.round( dY ) : dY;
        }
        
        /**
         * Aligns a DisplayObject to the left of the bounding Rectangle regardless of its registration point.
         * @param displayObject: The DisplayObject to align.
         * @param bounds: The area in which to align the DisplayObject.
         * @param snapToPixel: Force the position to whole pixels {@code true}, or to let the DisplayObject be positioned on sub-pixels {@code false}.
         */
        public static function alignLeft( displayObject:DisplayObject, bounds:Rectangle, snapToPixel:Boolean = true ):void 
        {
            var dX:Number = AlignUtil.getLeft( displayObject.getBounds( null ), bounds );
            displayObject.x = ( snapToPixel ) ? Math.round( dX ) : dX;
        }
        
        /**
         * Aligns a DisplayObject to the right of the bounding Rectangle regardless of its registration point.
         * @param displayObject: The DisplayObject to align.
         * @param bounds: The area in which to align the DisplayObject.
         * @param snapToPixel: Force the position to whole pixels {@code true}, or to let the DisplayObject be positioned on sub-pixels {@code false}.
         */
        public static function alignRight( displayObject:DisplayObject, bounds:Rectangle, snapToPixel:Boolean = true ):void 
        {
            var dX:Number = AlignUtil.getRight( displayObject.getBounds( null ), bounds );
            displayObject.x = ( snapToPixel ) ? Math.round( dX ) : dX;
        }
        
        /**
         * Aligns a DisplayObject to the horizontal center of the bounding Rectangle regardless of its registration point.
         * @param displayObject: The DisplayObject to align.
         * @param bounds: The area in which to align the DisplayObject.
         * @param snapToPixel: Force the position to whole pixels {@code true}, or to let the DisplayObject be positioned on sub-pixels {@code false}.
         */
        public static function alignCenter( displayObject:DisplayObject, bounds:Rectangle, snapToPixel:Boolean = true ):void 
        {
            var dX:Number = AlignUtil.getCenter( displayObject.getBounds( null ), bounds );
            displayObject.x = ( snapToPixel ) ? Math.round( dX ) : dX;
        }
        
        /**
         * Aligns a DisplayObject to the vertical middle of the bounding Rectangle regardless of its registration point.
         * @param displayObject: The DisplayObject to align.
         * @param bounds: The area in which to align the DisplayObject.
         * @param snapToPixel: Force the position to whole pixels {@code true}, or to let the DisplayObject be positioned on sub-pixels {@code false}.
         */
        public static function alignMiddle( displayObject:DisplayObject, bounds:Rectangle, snapToPixel:Boolean = true ):void 
        {
            var dY:Number = AlignUtil.getMiddle( displayObject.getBounds( null ), bounds );
            displayObject.y = ( snapToPixel ) ? Math.round( dY ) : dY;
        }
        
        /**
         * Determines the alignment position based on the specified parameters
         * @param	ruleConstant	The rule constant
         * @param	objBounds		The object bounds
         * @param	alignBounds		The alignment bounds
         * @return	A Point object
         */
        public static function getAlign( ruleConstant:String, objBounds:Rectangle, alignBounds:Rectangle ):Point
        {
            var result:Point;
            
            switch ( ruleConstant )
            {
                case TOP_LEFT:
                    result = getTopLeft( objBounds, alignBounds );
                    break;
                    
                case TOP_CENTER:
                    result = getTopCenter( objBounds, alignBounds );
                    break;
                    
                case TOP_RIGHT:
                    result = getTopRight( objBounds, alignBounds );
                    break;
                    
                case MIDDLE_LEFT:
                    result = getMiddleLeft( objBounds, alignBounds );
                    break;
                    
                case MIDDLE_CENTER:
                    result = getMiddleCenter( objBounds, alignBounds );
                    break;
                    
                case MIDDLE_RIGHT:
                    result = getMiddleRight( objBounds, alignBounds );
                    break;
                    
                case BOTTOM_LEFT:
                    result = getBottomLeft( objBounds, alignBounds );
                    break;
                    
                case BOTTOM_CENTER:
                    result = getBottomCenter( objBounds, alignBounds );
                    break;
                    
                case BOTTOM_RIGHT:
                    result = getBottomRight( objBounds, alignBounds );
                    break;
                    
            }
            
            return result;
        }
        
        /**
         * Get the top alignment value.
         * @param	objBounds	Object bounds
         * @param	alignBounds	Alignment bounds
         * @return	The top alignment value
         */
        public static function getTop( objBounds:Rectangle, alignBounds:Rectangle ):Number
        {
            return alignBounds.y - objBounds.y;
        }
        
        /**
         * Get the bottom alignment value.
         * @param	objBounds	Object bounds
         * @param	alignBounds	Alignment bounds
         * @return	The bottom alignment value
         */
        public static function getBottom( objBounds:Rectangle, alignBounds:Rectangle ):Number
        {
            return alignBounds.bottom - objBounds.bottom;
        }
        
        /**
         * Get the left alignment value.
         * @param	objBounds	Object bounds
         * @param	alignBounds	Alignment bounds
         * @return	The left alignment value
         */
        public static function getLeft( objBounds:Rectangle, alignBounds:Rectangle ):Number
        {
            return alignBounds.x - objBounds.x;
        }
        
        /**
         * Get the right alignment value.
         * @param	objBounds	Object bounds
         * @param	alignBounds	Alignment bounds
         * @return	The right alignment value
         */
        public static function getRight( objBounds:Rectangle, alignBounds:Rectangle ):Number
        {
            return alignBounds.right - objBounds.right;
        }
        
        /**
         * Get the center alignment value.
         * @param	objBounds	Object bounds
         * @param	alignBounds	Alignment bounds
         * @return	The center alignment value
         */
        public static function getCenter( objBounds:Rectangle, alignBounds:Rectangle ):Number
        {
            return ( alignBounds.x + alignBounds.width / 2 ) - ( objBounds.x + objBounds.width / 2 );
        }
        
        /**
         * Get the middle alignment value.
         * @param	objBounds	Object bounds
         * @param	alignBounds	Alignment bounds
         * @return	The middle alignment value
         */
        public static function getMiddle( objBounds:Rectangle, alignBounds:Rectangle ):Number
        {
            return ( alignBounds.y + alignBounds.height / 2 ) - ( objBounds.y + objBounds.height / 2 );
        } 
        
        /**
         * Get the top left alignment value.
         * @param	objBounds	Object bounds
         * @param	alignBounds	Alignment bounds
         * @return	The top left alignment value
         */
        public static function getTopLeft( objBounds:Rectangle, alignBounds:Rectangle ):Point
        {
            return new Point( AlignUtil.getLeft( objBounds, alignBounds ), AlignUtil.getTop( objBounds, alignBounds ) );
        }
        
        /**
         * Get the top center alignment value.
         * @param	objBounds	Object bounds
         * @param	alignBounds	Alignment bounds
         * @return	The top center alignment value
         */
        public static function getTopCenter( objBounds:Rectangle, alignBounds:Rectangle ):Point
        {
            return new Point( AlignUtil.getCenter( objBounds, alignBounds ), AlignUtil.getTop( objBounds, alignBounds ) );
        }
        
        /**
         * Get the top right alignment value.
         * @param	objBounds	Object bounds
         * @param	alignBounds	Alignment bounds
         * @return	The top right alignment value
         */
        public static function getTopRight( objBounds:Rectangle, alignBounds:Rectangle ):Point
        {
            return new Point( AlignUtil.getRight( objBounds, alignBounds ), AlignUtil.getTop( objBounds, alignBounds ) );
        }
        
        /**
         * Get the middle left alignment value.
         * @param	objBounds	Object bounds
         * @param	alignBounds	Alignment bounds
         * @return	The middle left alignment value
         */
        public static function getMiddleLeft( objBounds:Rectangle, alignBounds:Rectangle ):Point
        {
            return new Point( AlignUtil.getLeft( objBounds, alignBounds ), AlignUtil.getMiddle( objBounds, alignBounds ) );
        }
        
        /**
         * Get the middle center alignment value.
         * @param	objBounds	Object bounds
         * @param	alignBounds	Alignment bounds
         * @return	The middle center alignment value
         */
        public static function getMiddleCenter( objBounds:Rectangle, alignBounds:Rectangle ):Point
        {
            return new Point( AlignUtil.getCenter( objBounds, alignBounds ), AlignUtil.getMiddle( objBounds, alignBounds ) );
        }
        
        /**
         * Get the middle right alignment value.
         * @param	objBounds	Object bounds
         * @param	alignBounds	Alignment bounds
         * @return	The middle right alignment value
         */
        public static function getMiddleRight( objBounds:Rectangle, alignBounds:Rectangle ):Point
        {
            return new Point( AlignUtil.getRight( objBounds, alignBounds ), AlignUtil.getMiddle( objBounds, alignBounds ) );
        }
        
        /**
         * Get the bottom left alignment value.
         * @param	objBounds	Object bounds
         * @param	alignBounds	Alignment bounds
         * @return	The bottom left alignment value
         */
        public static function getBottomLeft( objBounds:Rectangle, alignBounds:Rectangle ):Point
        {
            return new Point( AlignUtil.getLeft( objBounds, alignBounds ), AlignUtil.getBottom( objBounds, alignBounds ) );
        }
        
        /**
         * Get the bottom center alignment value.
         * @param	objBounds	Object bounds
         * @param	alignBounds	Alignment bounds
         * @return	The bottom center alignment value
         */
        public static function getBottomCenter( objBounds:Rectangle, alignBounds:Rectangle ):Point
        {
            return new Point( AlignUtil.getCenter( objBounds, alignBounds ), AlignUtil.getBottom( objBounds, alignBounds ) );
        }
        
        /**
         * Get the bottom right alignment value.
         * @param	objBounds	Object bounds
         * @param	alignBounds	Alignment bounds
         * @return	The bottom right alignment value
         */
        public static function getBottomRight( objBounds:Rectangle, alignBounds:Rectangle ):Point
        {
            return new Point( AlignUtil.getRight( objBounds, alignBounds ), AlignUtil.getBottom( objBounds, alignBounds ) );
        }   
    }
}