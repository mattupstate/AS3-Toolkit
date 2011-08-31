package net.nobien.net
{
    import flash.events.Event;
    import flash.events.IEventDispatcher;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    
    public class TextLoadItem extends LoadItem
    {
        public function TextLoadItem( id:String, request:URLRequest, weight:Number = 1 ) 
        {
            super( id, request, weight );
        }
        
        /**
         * @inheritDoc
         */
        override protected function onLoadComplete(event:Event):void 
        {
            setContent( String( loader.data ) );
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
        public function get text():String { return content as String; }
    }
}