package net.nobien.controls 
{
    import net.nobien.core.IComponent;

    /**
     * The IComboBox interface defines a set of common methods and properties for combo boxes.
     */
    public interface IComboBox extends IComponent
    {
        /**
         * Opens the combo box.
         */
        function open():void;
        
        /**
         * Closes the combo box.
         */
        function close():void;
        
        /**
         * The data used when creating the menu items.
         */
        function get data():Array;
        function set data( value:Array ):void;
        
        /**
         * The property of the data set to use as the selection label.
         */
        function get labelProperty():String;
        function set labelProperty( value:String ):void;
        
        /**
         * The property of the data set to use as the selected item.
         */
        function get valueProperty():String;
        function set valueProperty( value:String ):void ;
        
        /**
         * The button that opens and closes the combo box. This button commonly has
         * a downward facing arrow on it.
         */
        function get button():IButton;
        function set button( value:IButton ):void;
        
        /**
         * The comb box label. Commonly used to display text representing the selection.
         */
        function get label():ITextControl;
        function set label( value:ITextControl ):void ;
        
        /**
         * The menu of options for the combo box.
         */
        function get menu():IMenu
        function set menu( value:IMenu ):void;
        
        /**
         * The current selected index.
         */
        function get selectedIndex():int;
        function set selectedIndex( value:int ):void;
        
        /**
         * The current selected menu data item.
         */
        function get selectedItem():Object
    }
}