package net.nobien.utils 
{
    import flash.geom.Rectangle;

    /**
     * The RatioUtil class contains static utility functions for manipulating and determining ratios.
     */
    public class RatioUtil
    {
        /**
         * Determines the ratio of width to height.
         * @param size: The area's width and height expressed as a Rectangle. The Rectangle's x and y values are ignored.
         * @return The ratio of width to height
         */
        public static function widthToHeight( size:Rectangle ):Number 
        {
            return size.width / size.height;
        }
        
        /**
         * Determines the ratio of height to width.
         * @param size: The area's width and height expressed as a Rectangle. The Rectangle's x and y values are ignored.
         * @return  The ratio of height to width
         */
        public static function heightToWidth( size:Rectangle ):Number 
        {
            return size.height / size.width;
        }
        
        /**
         * Scales an area's width and height while preserving aspect ratio.
         * @param size: The area's width and height expressed as a Rectangle. The Rectangle's x and y values are ignored.
         * @param amount: The amount you wish to scale by.
         * @return The scaled Rectangle
         */
        public static function scale( size:Rectangle, amount:Number ):Rectangle 
        {
            var scaled:Rectangle = size.clone();
            scaled.width *= amount;
            scaled.height *= amount;
            return scaled;
        }
        
        /**
         * Scales the width of an area while preserving aspect ratio.
         * @param size: The area's width and height expressed as a Rectangle. The Rectangle's x and y values are ignored.
         * @param height: The new height of the area.
         * @return The scaled Rectangle 
         */
        public static function scaleWidth( size:Rectangle, height:Number ):Rectangle 
        {
            var scaled:Rectangle = size.clone();
            var ratio:Number = RatioUtil.widthToHeight( size );
            scaled.width = height * ratio;
            scaled.height = height;
            return scaled;
        }
        
        /**
         * Scales the height of an area while preserving aspect ratio.
         * @param size: The area's width and height expressed as a Rectangle. The Rectangle's x and y values are ignored.
         * @param width: The new width of the area.
         * @return The scaled Rectangle 
         */
        public static function scaleHeight( size:Rectangle, width:Number ):Rectangle 
        {
            var scaled:Rectangle = size.clone();
            var ratio:Number = RatioUtil.heightToWidth( size );
            scaled.width = width;
            scaled.height = width * ratio;
            return scaled;
        }
        
        /**
         * Resizes an area to fill the bounding area while preserving aspect ratio.
         * @param size: The area's width and height expressed as a Rectangle. The Rectangle's x and y values are ignored.
         * @param bounds: The area to fill. The Rectangle's x and y values are ignored.
         * @return The resized Rectangle 
         */
        public static function scaleToFill( size:Rectangle, bounds:Rectangle ):Rectangle 
        {
            var scaled:Rectangle = RatioUtil.scaleHeight( size, bounds.width );
            
            if ( scaled.height < bounds.height )
                scaled = RatioUtil.scaleWidth( size, bounds.height );
            
            return scaled;
        }
        
        /**
         * Resizes an area to the maximum size of a bounding area without exceeding while preserving aspect ratio.
         * @param size: The area's width and height expressed as a Rectangle. The Rectangle's x and y values are ignored.
         * @param bounds: The area the rectangle needs to fit within. The Rectangle's x and y values are ignored.
         * @return The resized Rectangle 
         */
        public static function scaleToFit( size:Rectangle, bounds:Rectangle ):Rectangle 
        {
            var scaled:Rectangle = RatioUtil.scaleHeight( size, bounds.width );
            
            if (scaled.height > bounds.height)
                scaled = RatioUtil.scaleWidth(size, bounds.height);
            
            return scaled;
        }
    }
}