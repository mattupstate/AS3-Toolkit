package net.nobien.controls 
{
    import net.nobien.core.IComponent;

    /**
     * The IMenu interface defines a set of common methods and properties for menus.
     */
    public interface IMenu extends IComponent
    {
        /**
         * The Class used when creating menu buttons.
         */
        function get itemClass():Class;
        function set itemClass( value:Class ):void;
        
        /**
         * An Array of the menu's buttons.
         */
        function get items():Array;
        
        /**
         * The data used when creating the menu items.
         */
        function get data():Array;
        function set data( value:Array ):void;
        
        /**
         * The current selected index.
         */
        function get selectedIndex():int;
        function set selectedIndex( value:int ):void;
        
        /**
         * The current selected menu item.
         */
        function get selectedItem():IButton;
        
        /**
         * The current selected data item.
         */
        function get selectedData():Object;
    }
}