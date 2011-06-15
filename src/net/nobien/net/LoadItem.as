package net.nobien.net 
{
	import net.nobien.events.LoadEvent;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.utils.getTimer;
    
    /**
     * Dispatched when the content has completely loaded.
     * @eventType net.nobien.events.LoadEvent
     */
    [Event(name="loadComplete", type="net.nobien.events.LoadEvent")]
    
    /**
     * Dispatched while the content is loading.
     * @eventType net.nobien.events.LoadEvent
     */
    [Event(name="loadProgress", type="net.nobien.events.LoadEvent")]
    
    /**
     * Dispatched when the content starts loading.
     * @eventType net.nobien.events.LoadEvent
     */
    [Event(name="loadStart", type="net.nobien.events.LoadEvent")]
    
    /**
     * Dispatched when the queue stops loading.
     * @eventType net.nobien.events.LoadEvent
     */
    [Event(name="loadStop", type="net.nobien.events.LoadEvent")]
    
    /**
     * Dispatched when an input or output error occurs that causes a load operation to fail.
     * @eventType flash.events.IOErrorEvent
     */
    [Event(name="ioError", type="flash.events.IOErrorEvent")]
    
    /**
     * Dispatched when an security error occurs with an item in the queue that causes a load operation to fail.
     * @eventType flash.events.SecurityErrorEvent
     */
    [Event(name="securityError", type="flash.events.SecurityErrorEvent")]
    
    /**
     * Base class for loadable items. This class does not inheritently load anything. It must be extended.
     */
    public class LoadItem extends EventDispatcher
    {
        protected var loader:Object;
        
        private var _startTime:int = -1;
        private var _endTime:int = -1;
        private var _content:Object;
        private var _id:String;
        private var _request:URLRequest;
        private var _weight:Number;
        private var _weightProgress:Number = 0;
        private var _context:Object;
        private var _bytesTotal:int = -1;
        private var _bytesLoaded:int = -1;
        private var _progress:Number = 0;
        private var _httpStatus:int = -1;
        private var _isLoading:Boolean = false;
        private var _isComplete:Boolean = false;
        
        /**
         * Creates a new LoadItem object.
         * @param	id      The item's ID name.
         * @param	request The item's URLRequest object.
         * @param	weight  The item's weight for use in a queue.
         * @param	context The item's context object.
         */
        public function LoadItem( id:String, request:URLRequest, weight:Number = 1, context:Object = null ) 
        {
            _id = id;
            _request = request;
            _weight = weight;
            _context = context;
        }
        
        protected function notifyLoadStart():void
        {
            dispatchEvent( new LoadEvent( LoadEvent.LOAD_START, false, false, 0 ) );
        }
        
        protected function notifyLoadStop():void
        {
            dispatchEvent( new LoadEvent( LoadEvent.LOAD_STOP, false, false, 0 ) );
        }
        
        protected function notifyLoadProgress( progress:Number ):void
        {
            dispatchEvent( new LoadEvent( LoadEvent.LOAD_PROGRESS, false, false, progress ) );
        }
        
        protected function notifyLoadComplete():void
        {
            dispatchEvent( new LoadEvent( LoadEvent.LOAD_COMPLETE, false, false, 1 ) );
        }
        
        /**
         * Error handler.
         * @param	event
         */
        protected function onError( event:ErrorEvent ):void
        {
            _bytesLoaded = _bytesTotal = 0;
            setComplete( event.target as IEventDispatcher );
            dispatchEvent( event );
            notifyLoadStop();
        }
        
        /**
         * HTTP status handler.
         * @param	event
         */
        protected function onHTTPStatus( event:HTTPStatusEvent ):void
        {
            _httpStatus = event.status;
        }
        
        /**
         * Load start handler.
         * @param	event
         */
        protected function onLoadStart( event:Event ):void
        {
            notifyLoadStart();
        }
        
        /**
         * Load progress handler.
         * @param	event
         */
        protected function onLoadProgress( event:ProgressEvent ):void
        {
            _bytesTotal = event.bytesTotal;
            _bytesLoaded = event.bytesLoaded;
            _progress = bytesLoaded / bytesTotal;
            _weightProgress = progress * weight;
            notifyLoadProgress( progress );
        }
        
        /**
         * Load complete handler.
         * @param	event
         */
        protected function onLoadComplete( event:Event ):void
        {
            setComplete( event.target as IEventDispatcher );
            notifyLoadComplete();
        }
        
        /**
         * Utility function for when loading has completed successfully or stopped due to an error.
         * @param	loader  The object perfoming the loading of the content (Loader, URLLoader, Sound, etc.).
         */
        protected function setComplete( loader:IEventDispatcher ):void
        {
            _endTime = getTimer();
            _isComplete = true;
            _isLoading = false;
            _weightProgress = 1;
            removeListeners( loader );
        }
        
        /**
         * Removes standard event listeners from the object peforming the loading of the content.
         * @param	loader  The object perfoming the loading of the content (Loader, URLLoader, Sound, etc.).
         */
        protected function removeListeners( loader:IEventDispatcher ):void
        {
            if( loader )
            {
                loader.removeEventListener( Event.OPEN, onLoadStart );
                loader.removeEventListener( ProgressEvent.PROGRESS, onLoadProgress );
                loader.removeEventListener( Event.COMPLETE, onLoadComplete );
                loader.removeEventListener( HTTPStatusEvent.HTTP_STATUS, onHTTPStatus );
                loader.removeEventListener( IOErrorEvent.IO_ERROR, onError );
                loader.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, onError );
            }
        }
        
        /**
         * Adds standard event listeners to the object peforming the loading of the content.
         * @param	loader  The object perfoming the loading of the content (Loader, URLLoader, Sound, etc.).
         */
        protected function addListeners( loader:IEventDispatcher ):void
        {
            if( loader )
            {
                loader.addEventListener( Event.OPEN, onLoadStart );
                loader.addEventListener( ProgressEvent.PROGRESS, onLoadProgress );
                loader.addEventListener( Event.COMPLETE, onLoadComplete );
                loader.addEventListener( HTTPStatusEvent.HTTP_STATUS, onHTTPStatus );
                loader.addEventListener( IOErrorEvent.IO_ERROR, onError );
                loader.addEventListener( SecurityErrorEvent.SECURITY_ERROR, onError );
            }
        }
        
        /**
         * Gets the elapsed or total amount of time of the loading process.
         * @return  The amount of time in milliseconds.
         */
        protected function getTime():Number
        {
            if( _startTime > -1 && _endTime == -1 )
                return getTimer() - _startTime;
                
            else if( _startTime > -1 && _endTime > -1 )
                return _endTime - _startTime;
                
            else
                return -1;
        }
        
        /**
         * Sets the content object as an ambiguous class type.
         * @param	content The loaded content object.
         */
        protected function setContent( content:Object ):void
        {
            _content = content;
        }
        
        /**
         * Begins the loading of the content. Override with specific implementation based on content type.
         */
        public function load():void
        {
            if( _isLoading )
                return;
                
            _isLoading = true;
            _startTime = getTimer();
        }
        
        /**
         * Stops the loading of the content. Override with specific implementation based on content type.
         */
        public function stop():void
        {
            if( _isComplete )
                return;
                
            _isLoading = false;
        }
        
        /**
         * Clears necessary objects to prepare the LoadItem for garbage collection.
         */
        public function cleanup():void
        {
            stop();
            removeListeners( loader as IEventDispatcher );
            loader = null;
            _content = null;
            _request = null;
            _context = null;
        }
        
        /**
         * Bytes loaded.
         */
        public function get bytesLoaded():int { return _bytesLoaded; }
        
        /**
         * Bytes total.
         */
        public function get bytesTotal():int { return _bytesTotal; }
        
        /**
         * The loaded content object.
         */
        public function get content():Object { return _content; }
        
        /**
         * The loader context object (LoaderContext, SoundLoaderContext, etc).
         */
        public function get context():Object { return _context; }
        
        /**
         * LoadItem ID.
         */
        public function get id():String { return _id; }
        
        /**
         * Flag indicating if the item has completed loading.
         */
        public function get isComplete():Boolean { return _isComplete; }
        
        /**
         * Flag indicating if the item is currently loading or not.
         */
        public function get isLoading():Boolean { return _isLoading; }
        
        /**
         * A number between 0 and 1 representing load progress.
         */
        public function get progress():Number { return _progress; }
        
        /**
         * The items request object.
         */
        public function get request():URLRequest { return _request; }
        
        /**
         * The elapsed or total amount of time of the item's loading process.
         */
        public function get time():int { return getTime();  }
        
        /**
         * The weight of the item for when placed in a queue.
         */
        public function get weight():Number { return _weight; }
        
        /**
         * A number between 0 and 1 representing weighted progress.
         */
        public function get weightProgress():Number { return _weightProgress; }
        
    }
}