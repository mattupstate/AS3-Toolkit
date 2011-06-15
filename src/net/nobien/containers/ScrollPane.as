package net.nobien.containers 
{
    import flash.geom.Rectangle;
    import net.nobien.containers.abstract.AbstractScrollPane;

    /**
     * The ScrollPane container creates a display container with a scroll window.
     */
    public class ScrollPane extends AbstractScrollPane
    {
        /**
         * Creates a new ScrollPane container.
         * @param	width		The width of the scroll window.
         * @param	height		The height of the scroll window.
         */
        public function ScrollPane( width:Number, height:Number ) 
        {
            cacheAsBitmap = true;
            scrollWindow = new Rectangle( 0, 0, width, height );
        }
    }
}