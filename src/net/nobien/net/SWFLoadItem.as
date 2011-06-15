package net.nobien.net 
{
	import net.nobien.utils.DisplayObjectUtil;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
    
    /**
     * The SWFLoadItem class is used to load Flash (SWF) files.
     */
    public class SWFLoadItem extends LoadItem
    {
        //protected var loader:Loader;
        
        /**
         * Creates a new SWFLoadItem object.
         * @param	id      The item's ID name.
         * @param	request The item's URLRequest object.
         * @param	weight  The item's weight for use in a queue.
         * @param	context The item's LoaderContext object.
         */
        public function SWFLoadItem( id:String, request:URLRequest, weight:Number = 1, context:LoaderContext = null ) 
        {
            super( id, request, weight, context );
        }
        
        /**
         * @inheritDoc
         */
        override protected function onLoadComplete( event:Event ):void 
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
            addListeners( loader.contentLoaderInfo as IEventDispatcher );
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
            DisplayObjectUtil.destroyLoader( loader as Loader );
            super.cleanup();
        }
        
        /**
         * The loaded SWF content.
         */
        public function get swf():Sprite { return content as Sprite ; } 
        
    }

}