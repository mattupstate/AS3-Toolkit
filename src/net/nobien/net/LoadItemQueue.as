package net.nobien.net 
{
	import net.nobien.events.LoadEvent;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.ErrorEvent;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.utils.getTimer;
    
    /**
     * Dispatched when the queue has completely loaded.
     * @eventType net.nobien.events.LoadEvent
     */
    [Event(name="loadComplete", type="net.nobien.events.LoadEvent")]
    
    /**
     * Dispatched while the queue is loading.
     * @eventType net.nobien.events.LoadEvent
     */
    [Event(name="loadProgress", type="net.nobien.events.LoadEvent")]
    
    /**
     * Dispatched when the queue starts loading.
     * @eventType net.nobien.events.LoadEvent
     */
    [Event(name="loadStart", type="net.nobien.events.LoadEvent")]
    
    /**
     * Dispatched when the queue stops loading.
     * @eventType net.nobien.events.LoadEvent
     */
    [Event(name="loadStop", type="net.nobien.events.LoadEvent")]
    
    /**
     * Dispatched when an input or output error occurs with an item in the queue that causes a load operation to fail.
     * @eventType flash.events.IOErrorEvent
     */
    [Event(name="ioError", type="flash.events.IOErrorEvent")]
    
    /**
     * Dispatched when an security error occurs with an item in the queue that causes a load operation to fail.
     * @eventType flash.events.SecurityErrorEvent
     */
    [Event(name="securityError", type="flash.events.SecurityErrorEvent")]
    
    /**
     * The LoadItemQueue class allows for managing a queue of LoadItem objects.
     */
    public class LoadItemQueue extends EventDispatcher
    {
        private var _currentItems:Vector.<LoadItem>;
		private var _completedItems:Vector.<LoadItem>;
        private var _currentIndex:int = -1;
        private var _startTime:int = -1;
        private var _endTime:int = -1;
        private var _totalWeight:Number;
        private var _totalBytes:Number;
		private var _numConnections:int;
		private var _connectionCount:int = 0;
        private var _items:Vector.<LoadItem>;
        private var _factory:LoadItemFactory;
        private var _isLoading:Boolean = false;
        private var _isComplete:Boolean = false;
        private var _progress:Number = 0;
        private var _continueOnError:Boolean = false;
        
        /**
         * Creates a new LoadItemQueue object.
         * @param   continueOnError Flag to denote if the queue should continue if encountering an error.
         */
        public function LoadItemQueue() 
        {
            _factory = new LoadItemFactory();
            _items = new Vector.<LoadItem>();
        }
        
        private function onItemStart( event:LoadEvent ):void
        {
			var loadItem:LoadItem = event.target as LoadItem;
            applyItemProgress( loadItem.weightProgress );
            dispatchEvent( new LoadEvent( LoadEvent.LOAD_PROGRESS, false, false, progress ) );
        }
        
        private function onItemProgress( event:LoadEvent ):void
        {
			var loadItem:LoadItem = event.target as LoadItem;
            applyItemProgress( loadItem.weightProgress );
            dispatchEvent( new LoadEvent( LoadEvent.LOAD_PROGRESS, false, false, progress ) );
        }
        
        private function onItemComplete( event:LoadEvent ):void
        {
			var loadItem:LoadItem = event.target as LoadItem;
			
			applyItemProgress( loadItem.weightProgress );
            
			_totalBytes += loadItem.bytesTotal;
			_completedItems.push( loadItem );
			
            removeItemListeners( loadItem );
            
			removeCurrentItem(loadItem );
			
			dispatchEvent( new LoadEvent( LoadEvent.LOAD_PROGRESS, false, false, progress ) );
            
			loadNext();
        }
		
		private function removeCurrentItem( item:LoadItem ):void
		{
			for( var i:int = 0; i < _currentItems.length; i++ )
			{
				if( item.id == _currentItems[i].id )
				{
					_currentItems.splice(i, i);
				}
			}
			_connectionCount--;
		}
        
        private function onItemError( event:ErrorEvent ):void
        {
			var loadItem:LoadItem = event.target as LoadItem;
            removeItemListeners( loadItem );
            dispatchEvent( event );
            loadItem.cleanup();
            
			_completedItems.push( loadItem );
			removeCurrentItem( loadItem );
			
            if( _continueOnError )
                loadNext();
        }
        
        private function onAllItemsComplete():void
        {
            _endTime = getTimer();
            _isLoading = false;
            _isComplete = true;
            dispatchEvent( new LoadEvent( LoadEvent.LOAD_COMPLETE, false, false, 1 ) );
        }
        
        private function applyItemProgress( progress:Number ):void
        {
            var perItem:Number = 1 / _items.length;
            var calculatedProgress:Number = 0;
            for( var i:int = 0; i < _completedItems.length; i++ )
            {
                calculatedProgress += perItem;
            }
            _progress = calculatedProgress + ( perItem * progress );
        }
        
        private function loadNext():void
        {
            if( allItemsComplete() )
            {
                onAllItemsComplete();
				return;
            }
            else
            {
				_isLoading = true;
                _currentIndex++;
				
				if( _currentIndex >= _items.length )
				{
					return;
				}
				
                _connectionCount++
                var loadItem:LoadItem = _items[_currentIndex];
                addItemListeners( loadItem );
				_currentItems.push( loadItem );
                loadItem.load();
				
				if( _connectionCount < _numConnections )
				{
					loadNext();
				}
            }
        }
        
        private function allItemsComplete():Boolean
        {
			/*
            for( var i:int = 0; i < _items.length; i++ )
            {
                if( !_items[i].isComplete )
                    return false;
            }
            return true;
			*/
			return ( _items.length == _completedItems.length );
        }
        
        private function addItemListeners( item:LoadItem ):void
        {
            if( item )
            {
                item.addEventListener( LoadEvent.LOAD_COMPLETE, onItemComplete );
                item.addEventListener( LoadEvent.LOAD_START, onItemStart );
                item.addEventListener( LoadEvent.LOAD_PROGRESS, onItemProgress );
                item.addEventListener( IOErrorEvent.IO_ERROR, onItemError );
                item.addEventListener( SecurityErrorEvent.SECURITY_ERROR, onItemError );
            }
        }
        
        private function removeItemListeners( item:LoadItem ):void
        {
            if( item )
            {
                item.removeEventListener( LoadEvent.LOAD_COMPLETE, onItemComplete );
                item.removeEventListener( LoadEvent.LOAD_START, onItemStart );
                item.removeEventListener( LoadEvent.LOAD_PROGRESS, onItemProgress );
                item.removeEventListener( IOErrorEvent.IO_ERROR, onItemError );
                item.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, onItemError );
            }
        }
        
        private function getTime():Number
        {
            if( _startTime > -1 && _endTime == -1 )
                return getTimer() - _startTime;
                
            else if( _startTime > -1 && _endTime > -1 )
                return _endTime - _startTime;
                
            else
                return -1;
        }
        
        /**
         * Gets loaded content based on the LoadItem's ID name.
         * @param	id          The LoadItem ID name
         * @param	clearMemory Flag to denote if the content should be cleared from the queue after retrieval.
         * @return  The instance of the loaded content as an ambiguous class type.
         */
        public function getContent( id:String, clearMemory:Boolean = false ):Object
        {
            var item:Object = getItem( id );
            
            if( !item || !item.content )
            {
                return null;
            }
            else
            {
				var result:Object = item.content;
				
                if( clearMemory )
                    remove( id );
                    
                return result;
            }
        }
        
        /**
         * Gets a LoadItem by its ID name.
         * @param	id  The LoadItem ID name
         * @return  A LoadItem instance.
         */
        public function getItem( id:String ):LoadItem
        {
            for( var i:int = 0; i < _items.length; i++ )
            {
                if( id == _items[i].id )
                    return _items[i];
            }
            return null;
        }
        
        /**
         * Add's an item to the loading queue.
         * @param	id      An ID name for the item.
         * @param	request The request object for the item to be loaded.
         * @param	weight  The queue weight for the item.
         * @param	context The context object for the item if needed.
         * @return  A LoadItem instance.
         */
        public function add( id:String, request:URLRequest, weight:Number = 1, context:Object = null ):LoadItem
        {
            if( getItem( id ) != null )
            {
                throw new Error( "Error: Item with id: '" + id + "' already exists in LoadItemQueue instance." );
                return null;
            }
            
            var item:LoadItem = _factory.createLoadItem( id, request, weight, context );
            
            if( !item )
            {
                throw new Error( "Error: LoadItemQueue does not support the supplied file type at: " + request.url );
                return null;
            }
            else
            {
                _items.push( item );
                _totalWeight += weight;
                return item;
            }
        }
        
        /**
         * Removes the specified item based on the item's ID name.
         * @param	id  The LoadItem ID name.
         */
        public function remove( id:String ):void
        {
            var item:LoadItem = getItem( id );
            
            if( !item )
            { 
                return;
            }
            else
            {
                var index:int = _items.indexOf( item );
                
                if( index > - 1)
                    _items.splice( index, 1 );
                    
                removeItemListeners( item );
                item.cleanup();
            }
        }
        
        /**
         * Starts the loading queue.
         */
        public function start( numConnections:int = 1, continueOnError:Boolean = false ):void
        {
            if( _isLoading )
                return;
            
			_numConnections = numConnections;
			_continueOnError = continueOnError;
            _startTime = getTimer();
			_connectionCount = 0;
            _totalBytes = 0;
            _isLoading = true;
			_completedItems = new Vector.<LoadItem>();
			_currentItems = new Vector.<LoadItem>();
            loadNext();
            dispatchEvent( new LoadEvent( LoadEvent.LOAD_START, false, false, 0 ) );
        }
        
        /**
         * Stops the loading queue. If an item is currently loading, it will be canceled.
         */
        public function stop():void
        {
            if( isLoading && !isComplete )
            {
				var i:int = 0;
                _isLoading = false;
				
				for( i = 0; i < _currentItems.length; i++ )
				{
					removeItemListeners( _currentItems[i] );
					if( _currentItems[i].isLoading )
					{
						_currentItems[i].stop();
					}
				}
                
				_currentIndex = -1;
                dispatchEvent( new LoadEvent( LoadEvent.LOAD_STOP, false, false, 0 ) );
            }
        }
        
        /**
         * Resumes the loading queue if it has been stoped.
         */
        public function resume():void
        {
            if( !isComplete && !isLoading )
                loadNext();
        }
        
        /**
         * Retrieves an instance of a loaded image (JPG, PNG, GIF).
         * @param	id          The LoadItem ID name.
         * @param	clearMemory Flag to denote if the content should be cleared from the queue after retrieval.
         * @return  The loaded content as a Bitmap instance.
         */
        public function getImage( id:String, clearMemory:Boolean = false ):Bitmap
        {
            return Bitmap( getContent( id, clearMemory ) );
        }
        
        /**
         * Retrieves an instance of a loaded XML.
         * @param	id          The LoadItem ID name.
         * @param	clearMemory Flag to denote if the content should be cleared from the queue after retrieval.
         * @return  The loaded content as an XML instance.
         */
        public function getXML( id:String, clearMemory:Boolean = false ):XML
        {
            return XML( getContent( id, clearMemory ) );
        }
        
        /**
         * Retrieves an instance of a loaded Flash (SWF) file.
         * @param	id          The LoadItem ID name.
         * @param	clearMemory Flag to denote if the content should be cleared from the queue after retrieval.
         * @return  The loaded content as a Sprite instance.
         */
        public function getSWF( id:String, clearMemory:Boolean = false ):Sprite
        {
            return Sprite( getContent( id, clearMemory ) );
        }
        
        /**
         * Retrieves an instance of a loaded sound (MP3) file.
         * @param	id          The LoadItem ID name.
         * @param	clearMemory Flag to denote if the content should be cleared from the queue after retrieval.
         * @return  The loaded content as a Sound instance.
         */
        public function getSound( id:String, clearMemory:Boolean = false ):Sound
        {
            return Sound( getContent( id, clearMemory ) );
        }
        
        /**
         * Clears necessary objects to prepare the LoadItemQueue for garbage collection.
         */
        public function cleanup():void
        {
            _factory = null;
            
            for( var i:int = 0; i < _items.length; i++ )
            {
                removeItemListeners( _items[i] );
                _items[i].cleanup();
                _items[i] = null;
            }
			
			_currentItems = null;
			_completedItems = null;
        }
        
		/**
		 * A list of the items that have completed loading.
		 */
		public function get completedItems():Vector.<LoadItem> { return _completedItems; }
		
        /**
         * The index of the currently loading item.
         */
        public function get currentIndex():int { return _currentIndex; }
        
        /**
         * A list of current loading items.
         */
        public function get currentItems():Vector.<LoadItem> { return _currentItems; }
        
        /**
         * Denotes if the queue is complete or not.
         */
        public function get isComplete():Boolean { return _isComplete; }
        
        /**
         * Denotes if the queue is currently loading items or not.
         */
        public function get isLoading():Boolean { return _isLoading; }
        
        /**
         * All the items in the queue.
         */
        public function get items():Vector.<LoadItem> { return _items; }
        
        /**
         * The current progress of the queue represented as a number between 0 and 1.
         */
        public function get progress():Number { return _progress; }
        
        /**
         * The elapsed or total amount of time of the queue's loading process.
         */
        public function get time():int { return getTime();  }
        
        /**
         * The total amount of bytes loaded. Updated after an item completes.
         */
        public function get totalBytes():Number { return _totalBytes; }
        
        /**
         * The total amount of items in the queue.
         */
        public function get totalItems():Number { return _items.length; }        
    }
}