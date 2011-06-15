package net.nobien.net 
{
    import flash.events.Event;
    import flash.events.IEventDispatcher;
    import flash.media.Sound;
    import flash.media.SoundLoaderContext;
    import flash.net.URLRequest;
    
    /**
     * The SoundLoadItem class is used to load sound (MP3) files.
     */
    public class SoundLoadItem extends LoadItem
    {
        //protected var loader:Sound;
        
        /**
         * Creates a new SoundLoadItem object.
         * @param	id      The item's ID name.
         * @param	request The item's URLRequest object.
         * @param	weight  The item's weight for use in a queue.
         * @param	context The item's LoaderContext object.
         */
        public function SoundLoadItem( id:String, request:URLRequest, weight:Number = 1, context:SoundLoaderContext = null ) 
        {
            super( id, request, weight, context );
        }
        
        /**
         * @inheritDoc
         */
        override protected function onLoadStart(event:Event):void 
        {
            setContent( loader );
            super.onLoadStart( event );
        }
        
        /**
         * @inheritDoc
         */
        override public function load():void 
        {
            super.load();
            loader = new Sound();
            addListeners( loader as IEventDispatcher );
            loader.load( request, context as SoundLoaderContext );
        }
        
        /**
         * @inheritDoc
         */
        override public function stop():void 
        {
            super.stop();
            try { loader.close(); }
            catch( error:Error ) { }
        }
        
        /**
         * The loaded sound content.
         */
        public function get sound():Sound { return content as Sound; }
    }
}