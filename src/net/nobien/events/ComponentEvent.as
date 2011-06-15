package net.nobien.events 
{	
    import flash.events.Event;

    /**
     * The ComponentEvent class represents the event object passed to the event listener for many visual component events.
     */
    public class ComponentEvent extends Event 
    {
        /**
         * The <code>ComponentEvent.CHANGE</code> constant defines the value of the type property of an <code>componentChange</code> event object.
         */
        public static const CHANGE:String = "componentChange";
        
        /**
         * The <code>ComponentEvent.CLOSE</code> constant defines the value of the type property of an <code>componentClose</code> event object.
         */
        public static const CLOSE:String = "componentClose";
        
        /**
         * The <code>ComponentEvent.DISABLE</code> constant defines the value of the type property of an <code>componentDisabled</code> event object.
         */
        public static const DISABLE:String = "componentDisabled";
        
        /**
         * The <code>ComponentEvent.DRAW</code> constant defines the value of the type property of an <code>componentDraw</code> event object.
         */
        public static const DRAW:String = "componentDraw";
        
        /**
         * The <code>ComponentEvent.ENABLE</code> constant defines the value of the type property of an <code>componentEnabled</code> event object.
         */
        public static const ENABLE:String = "componentEnabled";
        
        /**
         * The <code>ComponentEvent.INIT</code> constant defines the value of the type property of an <code>componentInit</code> event object.
         */
        public static const INIT:String = "componentInit";
        
        /**
         * The <code>ComponentEvent.MOVE</code> constant defines the value of the type property of an <code>componentMove</code> event object.
         */
        public static const MOVE:String = "componentMove";
        
        /**
         * The <code>ComponentEvent.OPEN</code> constant defines the value of the type property of an <code>componentOpen</code> event object.
         */
        public static const OPEN:String = "componentOpen";
        
        /**
         * The <code>ComponentEvent.SELECT</code> constant defines the value of the type property of an <code>componentSelect</code> event object.
         */
        public static const SELECT:String = "componentSelect";
        
        /**
         * The <code>ComponentEvent.DESELECT</code> constant defines the value of the type property of an <code>componentDeselect</code> event object.
         */
        public static const DESELECT:String = "componentDeselect";
        
        /**
         * Creates a ComponentEvent object to pass as a parameter to event listeners.
         * @param	type		The type of the event, accessible as ComponentEvent.type.
         * @param	bubbles		Determines whether the ComponentEvent object participates in the bubbling stage of the event flow. The default value is false.
         * @param	cancelable	Determines whether the ComponentEvent object can be canceled. The default values is false.
         */
        public function ComponentEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false ) 
        { 
            super( type, bubbles, cancelable );
        } 
        
        public override function clone():Event 
        { 
            return new ComponentEvent( type, bubbles, cancelable );
        } 
        
        public override function toString():String 
        { 
            return formatToString( "ComponentEvent", "type", "bubbles", "cancelable", "eventPhase" ); 
        }
    }
}