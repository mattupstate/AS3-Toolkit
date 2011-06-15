package net.nobien.containers.abstract 
{
    import flash.display.DisplayObject;
    import flash.events.Event;
    import net.nobien.core.SpriteComponent;

    /**
     * The AbstractContainer class is used to create custom display object container 
     * components. Extending this class will give your custom display object container 
     * a set of common methods and properties that a basic container should have.
     */
    public class AbstractContainer extends SpriteComponent
    {
        /**
         * Creates a new <code>AbstractContainer</code> object.
         */
        public function AbstractContainer() 
        {
            super();
        }
        
        /**
         * @inheritDoc
         */
        override protected function onAddedToStage( event:Event ):void 
        {
            super.onAddedToStage( event );
            stage.addEventListener( Event.RESIZE, onStageResize );
        }
        
        /**
         * @inheritDoc
         */
        override protected function onRemovedFromStage( event:Event ):void 
        {
            super.onRemovedFromStage( event );
            stage.removeEventListener( Event.RESIZE, onStageResize );
        }
        
        /**
         * Event handler for when the stage is resized. Override with custom routine.
         * @param	event
         */
        protected function onStageResize( event:Event ):void 
        {
            
        }
        
        override protected function draw():void 
        {
            arrangeChildren();
            super.draw();
        }
        
        /**
         * Utility function which allows for a custom routine when children are added or removed 
         * from the display list by calling <code>addChild()</code> <code>addChildAt()</code> 
         * <code>removeChild()</code> and <code>removeChildAt()</code>. Override with custom routine.
         * @param	func
         * @param	args
         * @return
         */
        protected function displayOverrideHandler( func:Function, args:Array ):DisplayObject
        {
            var result:DisplayObject = func.apply( this, args );
            invalidate();
            return result;
        }
        
        /**
         * Utility function which allows for a custom routine to arrange children are added or removed 
         * from the display list by calling <code>addChild()</code> <code>addChildAt()</code> 
         * <code>removeChild()</code> and <code>removeChildAt()</code>. Override with custom routine.
         * @param	func
         * @param	args
         * @return
         */
        protected function arrangeChildren():void
        {
            
        }
        
        /**
         * @inheritDoc
         */
        override public function addChild( child:DisplayObject ):DisplayObject 
        {
            return displayOverrideHandler( super.addChild, [child] );
        }
        
        /**
         * @inheritDoc
         */
        override public function addChildAt( child:DisplayObject, index:int ):DisplayObject 
        {
            return displayOverrideHandler( super.addChildAt, [child, index] );
        }
        
        /**
         * @inheritDoc
         */
        override public function removeChild( child:DisplayObject ):DisplayObject 
        {
            return displayOverrideHandler( super.removeChild, [child] );
        }
        
        /**
         * @inheritDoc
         */
        override public function removeChildAt( index:int ):DisplayObject 
        {
            return displayOverrideHandler( super.removeChildAt, [index] );
        }
    }
}