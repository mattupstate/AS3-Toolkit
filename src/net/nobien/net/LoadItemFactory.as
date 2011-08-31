package net.nobien.net 
{
    import flash.media.SoundLoaderContext;
    import flash.net.URLRequest;
    import flash.system.LoaderContext;

    /**
     * The LoadItemFactory class facilities the creation of LoadItem objects based on the item's URL.
     */
    public class LoadItemFactory implements ILoadItemFactory
    {
        public static var IMAGE_EXTENSIONS:Array = ["jpg", "jpeg", "gif", "png"];
        public static var XML_EXTENSIONS:Array = ["xml"];
        public static var SWF_EXTENSIONS:Array = ["swf"];
        public static var SOUND_EXTENSIONS:Array = ["mp3", "f4a", "f4b"];
        public static var TEXT_EXTENSIONS:Array = ["txt", "text", "json"];
        
        /**
         * Creates a new LoadItemFactory object.
         */
        public function LoadItemFactory() 
        {
            
        }
        
        /**
         * Creates an appropriate LoadItem object based on the request's URL.
         * @param	id      The ID name for the new LoadItem.
         * @param	request The request for the new LoadItem.
         * @param	weight  The weight for the new LoadItem.
         * @param	context The context for the new LoadItem.
         * @return  A concrete class based on LoadItem (ImageLoadItem, SWFLoadItem, XMLLoadItem, or SoundLoadItem).
         */
        public function createLoadItem( id:String, request:URLRequest, weight:Number = 1, context:Object = null ):LoadItem
        {
            var url:String = request.url;
            
            var searchStr:String = ( url.indexOf( "?" ) > -1 ) ?
                url.substring( 0, url.indexOf("?") ) :
                url;
                
            var finalPart:String = searchStr.substring( searchStr.lastIndexOf( "/" ) );
            var extension:String = finalPart.substring( finalPart.lastIndexOf(".") + 1 ).toLowerCase();
            
            var item:LoadItem = null;
            
            if ( IMAGE_EXTENSIONS.indexOf( extension ) > -1 )
                item = new ImageLoadItem( id, request, weight, context as LoaderContext );
                
            if ( XML_EXTENSIONS.indexOf( extension ) > -1 )
                item = new XMLLoadItem( id, request, weight );
                
            if ( SWF_EXTENSIONS.indexOf( extension ) > -1 )
                item = new SWFLoadItem( id, request, weight, context as LoaderContext );
                
            if ( SOUND_EXTENSIONS.indexOf( extension ) > -1 )
                item = new SoundLoadItem( id, request, weight, context as SoundLoaderContext );
            
            if ( TEXT_EXTENSIONS.indexOf( extension ) > -1 )
                item = new TextLoadItem( id, request, weight );
            
            return item;
        }
        
    }

}