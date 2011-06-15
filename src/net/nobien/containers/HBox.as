package net.nobien.containers 
{
	import net.nobien.containers.abstract.AbstractBox;

    /**
     * The HBox container lays out its children in a single horizontal row.
     */
    public class HBox extends AbstractBox implements IBox
    {
        /**
         * Creates a new HBox container.
         */
        public function HBox() 
        {
            initialized = true;
        }
        
        override public function get direction():String { return super.direction; }
        override public function set direction( value:String ):void { }
    }
}