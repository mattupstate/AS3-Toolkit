package net.nobien.net 
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
    
    /**
     * The XMLLoadItem class is used to load XML files.
     */
    public class XMLLoadItem extends LoadItem
    {
        //protected var loader:URLLoader;
        
        /**
         * Creates a new XMLLoadItem object.
         * @param	id      The item's ID name.
         * @param	request The item's URLRequest object.
         * @param	weight  The item's weight for use in a queue.
         */
        public function XMLLoadItem( id:String, request:URLRequest, weight:Number = 1 ) 
        {
            super( id, request, weight );
        }
        
        /**
         * @inheritDoc
         */
        override protected function onLoadComplete(event:Event):void 
        {
            setContent( new XML( loader.data ) );
            super.onLoadComplete( event );
        }
        
        /**
         * @inheritDoc
         */
        override public function load():void
        {
            super.load();
            loader = new URLLoader();
            addListeners( loader as IEventDispatcher );
            loader.load( request ); 
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
         * The loaded XML content.
         */
        public function get xml():XML { return content as XML; }
    }
}