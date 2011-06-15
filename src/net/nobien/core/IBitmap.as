package net.nobien.core 
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;

    /**
     * The IBitmap interface defines methods and properties for Bitmap objects. 
     * This interface is mostly for convenience.
     * @see flash.display.Bitmap
     */
    public interface IBitmap extends IDisplayObject
    {
        function get bitmapData():BitmapData;
        function set bitmapData(value:BitmapData):void ;
        function get content():Bitmap;
        function get pixelSnapping():String;
        function set pixelSnapping(value:String):void;
        function get smoothing():Boolean;
        function set smoothing(value:Boolean):void;
    }
}