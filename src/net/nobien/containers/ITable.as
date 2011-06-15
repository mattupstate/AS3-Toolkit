package net.nobien.containers 
{
    import flash.geom.Rectangle;
    import net.nobien.core.IDisplayObjectContainer;

    /**
     * The IBox interface defines a set of common methods and properties for table containers.
     */
    public interface ITable extends IDisplayObjectContainer
    {
        /**
         * Gets a table cell layout definition.
         * @param	row		Row number
         * @param	column	Column number
         * @return	A Rectangle representing the table cell.
         */
        function getCell( row:int, column:int ):Rectangle;
        
        /**
         * The table's cell alignment constant.
         */
        function get align():String;
        function set align( value:String ):void;
        
        /**
         * The amount of rows in the table.
         */
        function get rows():int;
        function set rows( value:int ):void;
        
        /**
         * The amount of columns in the table.
         */
        function get columns():int;
        function set columns( value:int ):void;
    }
}