package net.nobien.net 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
    
    /**
     * The ImageLoadItem class is used to load image (JPG, PNG, GIF) files.
     */
    public class ImageLoadItem extends LoadItem
    {
        /**
         * Creates a new ImageLoadItem object.
         * @param	id      The item's ID name.
         * @param	request The item's URLRequest object.
         * @param	weight  The item's weight for use in a queue.
         * @param	context The item's LoaderContext object.
         */
        public function ImageLoadItem( id:String, request:URLRequest, weight:Number = 1, context:LoaderContext = null ) 
        {
            super( id, request, weight, context );
        }
        
        /**
         * @inheritDoc
         */
        override protected function onLoadComplete(event:Event):void 
        {
            setContent( loader.content );
            super.onLoadComplete( event );
        }
        
        /**
         * @inheritDoc
         */
        override public function load():void
        {
            super.load();
            loader = new Loader();
            addListeners( loader.contentLoaderInfo );
            loader.load( request, context as LoaderContext );
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
         * @inheritDoc
         */
        override public function cleanup():void 
        {
            try { loader.unload(); }
            catch( error:Error ) { }
            super.cleanup();
        }
        
        /**
         * The loaded image content.
         */
        public function get image():Bitmap { return content as Bitmap; }
    }

}