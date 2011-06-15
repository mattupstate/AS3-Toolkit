package net.nobien.containers 
{
    import net.nobien.constants.Direction;
    import net.nobien.containers.abstract.AbstractBox;

    /**
     * The VBox container lays out its children in a single vertical column.
     */
    public class VBox extends AbstractBox implements IBox
    {
        /**
         * Creates a new VBox container.
         */
        public function VBox() 
        {
            _direction = Direction.VERTICAL;
            initialized = true;
        }
        
        override public function get direction():String { return super.direction; }
        override public function set direction( value:String ):void { }
    }
}