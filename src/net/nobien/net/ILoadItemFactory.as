package net.nobien.net
{
    import flash.net.URLRequest;
    
    public interface ILoadItemFactory
    {
        /**
         * Creates an appropriate LoadItem object based on the request's URL.
         * @param	id      The ID name for the new LoadItem.
         * @param	request The request for the new LoadItem.
         * @param	weight  The weight for the new LoadItem.
         * @param	context The context for the new LoadItem.
         * @return  A concrete class based on LoadItem (ImageLoadItem, SWFLoadItem, XMLLoadItem, or SoundLoadItem).
         */
        function createLoadItem( id:String, request:URLRequest, weight:Number = 1, context:Object = null ):LoadItem
    }
}