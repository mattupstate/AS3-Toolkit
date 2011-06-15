package net.nobien.containers 
{
	import net.nobien.containers.abstract.AbstractContainer;
	import net.nobien.events.ComponentEvent;
	import flash.display.DisplayObject;
    
    /**
     * ...
     */
    public class ViewStack extends AbstractContainer
    {
        protected var _selectedIndex:int = -1;
        
        /**
         * Creates a new ViewStack object.
         */
        public function ViewStack() 
        {
            
        }
        
        override protected function onInitialized( event:ComponentEvent ):void 
        {
            _selectedIndex = 0;
            super.onInitialized( event );
        }
        
        override protected function draw():void 
        {
            for( var i:int = 0; i < numChildren; i++ )
            {
                var child:DisplayObject = getChildAt( i );
                
                if( child.parent == this && i != selectedIndex )
                    removeChild( child );
                
                if( child.parent != this && i == selectedIndex )
                    addChild( child );
            }
            
            super.draw();
        }
        
        override public function validate():void 
        {
            if( numChildren > 0 )
                initialized = true;
                
            super.validate();
        }
        
        public function get selectedIndex():int { return _selectedIndex; }
        public function set selectedIndex( value:int ):void 
        {
            _selectedIndex = value;
            invalidate();
        }
        
    }

}