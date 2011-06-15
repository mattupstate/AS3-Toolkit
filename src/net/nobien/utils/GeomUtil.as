package net.nobien.utils 
{
    import flash.geom.Point;
    import flash.geom.Rectangle;

    /**
     * The GeomUtil class contains static utility functions to help with common geometric calculations.
     */
    public class GeomUtil
    {
        /**
         * Rotates a Point around another Point by the specified angle.
         * @param point: The Point to rotate.
         * @param centerPoint: The Point to rotate this Point around.
         * @param angle: The angle (in degrees) to rotate this point.
        */
        public static function rotatePoint( point:Point, centerPoint:Point, angle:Number ):void 
        {
            var radians:Number = ConversionUtil.degreesToRadians( angle );
            var baseX:Number   = point.x - centerPoint.x;
            var baseY:Number   = point.y - centerPoint.y;
            
            point.x = ( Math.cos( radians ) * baseX ) - ( Math.sin( radians ) * baseY ) + centerPoint.x;
            point.y = ( Math.sin( radians ) * baseX ) + ( Math.cos( radians ) * baseY ) + centerPoint.y;
        }
        
        /**
         * Determines the angle/degree between the first and second point.
         * @param first: The first Point.
         * @param second: The second Point.
         * @return The degree between the two points.
         */
        public static function angle( first:Point, second:Point ):Number 
        {
            return Math.atan( ( first.y - second.y ) / ( first.x - second.x ) ) / ( Math.PI / 180 );
        }
        
        /**
         * Calculates the perimeter of a rectangle.
         * @param rect: Rectangle to determine the perimeter of.
         */
        public static function getRectanglePerimeter( rect:Rectangle ):Number 
        {
            return rect.width * 2 + rect.height * 2;
        }
    }
}