package net.nobien.core 
{
    import flash.display.DisplayObject;
    import flash.display.Graphics;
    import flash.display.Sprite;
    import flash.media.SoundTransform;

    /**
     * The ISprite interface defines methods and properties for Sprite objects. This interface is
     * mostly for convenience.
     * @see flash.display.Sprite
     */
    public interface ISprite extends IDisplayObjectContainer
    {
        function get buttonMode():Boolean;
        function set buttonMode(value:Boolean):void;
        function get dropTarget():DisplayObject;
        function get graphics():Graphics;
        function get hitArea():Sprite
        function set hitArea(value:Sprite):void
        function get soundTransform():SoundTransform
        function set soundTransform(value:SoundTransform):void
        function get useHandCursor():Boolean
        function set useHandCursor(value:Boolean):void
    }
}