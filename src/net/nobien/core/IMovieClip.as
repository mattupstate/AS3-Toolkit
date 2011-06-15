package net.nobien.core 
{
    import flash.display.Scene;

    /**
     * The IMovieClip interface defines methods and properties for MovieClip objects. This interface is
     * mostly for convenience.
     * @see flash.display.MovieClip
     */
    public interface IMovieClip extends ISprite
    {
        function get currentFrame():int;
        function get currentLabel():String;
        function get currentLabels():Array;
        function get currentScene():Scene;
        function get enabled():Boolean;
        function set enabled(value:Boolean):void;
        function get framesLoaded():int;
        function get scenes():Array;
        function get totalFrames():int;
        function get trackAsMenu():Boolean;
        function set trackAsMenu(value:Boolean):void;
        
        function gotoAndPlay(frame:Object, scene:String = null):void;
        function gotoAndStop(frame:Object, scene:String = null):void;
        function nextFrame():void;
        function nextScene():void;
        function play():void;
        function prevFrame():void;
        function prevScene():void;
        function stop():void;
    }
}