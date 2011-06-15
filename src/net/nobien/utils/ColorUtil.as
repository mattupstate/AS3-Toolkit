package net.nobien.utils 
{
    import flash.geom.ColorTransform;

    /**
     * The ColorUtil class contains static utiliy function for manipulating color values.
     */
    public class ColorUtil
    {
        /**
         * Converts a 32-bit ARGB color value into a hexidecimal String representation.
         * @param a: A uint from 0 to 255 representing the alpha value.
         * @param r: A uint from 0 to 255 representing the red color value.
         * @param g: A uint from 0 to 255 representing the green color value.
         * @param b: A uint from 0 to 255 representing the blue color value.
         * @return A hexidecimal color.
         */
        public static function ARGBToHex( a:uint, r:uint, g:uint, b:uint ):uint
        {
            return ( a << 24 ) | ( r << 16 ) | ( g << 8 ) | b;
        }
        
        /**
         * Converts an RGB color value into a hexidecimal String representation.
         * @param r: A uint from 0 to 255 representing the red color value.
         * @param g: A uint from 0 to 255 representing the green color value.
         * @param b: A uint from 0 to 255 representing the blue color value.
         * @return A hexidecimal color.
         */
        public static function RGBToHex( r:uint, g:uint, b:uint ):uint
        {
            return (r << 16 | g << 8 | b);
        }
        
        /**
         * Converts RGB values to HSV values.
         * @param r: A uint from 0 to 255 representing the red color value.
         * @param g: A uint from 0 to 255 representing the green color value.
         * @param b: A uint from 0 to 255 representing the blue color value.
         * @return Returns an object with the properties h, s, and v defined.
         */
        public static function RGBtoHSV( r:uint, g:uint, b:uint ):Object
        {
            var max:uint = Math.max( r, g, b );
            var min:uint = Math.min( r, g, b );
            
            var hue:Number = 0;
            var saturation:Number = 0;
            var value:Number = 0;
            
            //get Hue
            if( max == min )
                hue = 0;
            else if( max == r )
                hue = ( 60 * ( g - b ) / ( max - min ) + 360 ) % 360;
            else if( max == g )
                hue = ( 60 * ( b - r ) / ( max - min ) + 120 );
            else if( max == b )
                hue = ( 60 * ( r - g ) / ( max - min ) + 240 );
            
            //get Value
            value = max;
            
            //get Saturation
            if(max == 0){
                saturation = 0;
            }else{
                saturation = ( max - min ) / max;
            }
            
            var hsv:Object = {};
            hsv.h = Math.round(hue);
            hsv.s = Math.round(saturation * 100);
            hsv.v = Math.round(value / 255 * 100);
            return hsv;
        }
        
        /**
         * Converts a 24-bit RGB color value into an RGB object.
         * @param color: The 24-bit RGB color value.
         * @return Returns an object with the properties r, g, and b defined.
         */
        public static function HexToRGB( hex:uint ):Object
        {
            var rgb:Object = {};
            rgb.r = hex >> 16 & 0xFF;
            rgb.g = hex >> 8 & 0xFF;
            rgb.b = hex & 0xFF;
            return rgb;
        }
        
        /**
         * Converts a 32-bit ARGB color value into an ARGB object.
         * @param color: The 32-bit ARGB color value.
         * @return Returns an object with the properties a, r, g, and b defined.
         */
        public static function HexToARGB( hex:uint ):Object
        {
            var rgb:Object = { };
            rgb.a = hex >> 24 & 0xFF;
            rgb.r = hex >> 16 & 0xFF;
            rgb.g = hex >> 8 & 0xFF;
            rgb.b = hex & 0xFF;
            return rgb;
        }
        
        /**
         * Converts HSV values to RGB values.
         * @param h: A uint from 0 to 360 representing the hue value.
         * @param s: A uint from 0 to 100 representing the saturation value.
         * @param v: A uint from 0 to 100 representing the lightness value.
         * @return Returns an object with the properties r, g, and b defined.
         */
        public static function HSVtoRGB( h:Number, s:Number, v:Number ):Object
        {
            var r:Number = 0;
            var g:Number = 0;
            var b:Number = 0;
            
            var tempS:Number = s / 100;
            var tempV:Number = v / 100;

            var hi:int = Math.floor(h/60) % 6;
            var f:Number = h/60 - Math.floor(h/60);
            var p:Number = (tempV * (1 - tempS));
            var q:Number = (tempV * (1 - f * tempS));
            var t:Number = (tempV * (1 - (1 - f) * tempS));

            switch(hi){
                case 0: r = tempV; g = t; b = p; break;
                case 1: r = q; g = tempV; b = p; break;
                case 2: r = p; g = tempV; b = t; break;
                case 3: r = p; g = q; b = tempV; break;
                case 4: r = t; g = p; b = tempV; break;
                case 5: r = tempV; g = p; b = q; break;
            }

            var rgb:Object = {};
            rgb.r = Math.round( r * 255 );
            rgb.g = Math.round( g * 255 );
            rgb.b = Math.round( b * 255 );
            return rgb;
        }
        
        /**
         * Converst HSV values to a hexadecimal color value
         * @param h: A uint from 0 to 360 representing the hue value.
         * @param s: A uint from 0 to 100 representing the saturation value.
         * @param v: A uint from 0 to 100 representing the lightness value.
         * @return A hexidecimal color.
         */
        public static function HSVtoHEX( h:Number, s:Number, v:Number ):uint
        {
            var rgb:Object = ColorUtil.HSVtoRGB( h, s, v );
            return ColorUtil.RGBToHex( rgb.r, rgb.g, rgb.b );
        }
        
        /**
         * Interpolates (tints) between two colors.
         * @param begin: The start color.
         * @param end: The finish color.
         * @param amount: The level of interpolation between the two colors.
         * @return The new interpolated color.
         */
        public static function interpolateColor( begin:ColorTransform, end:ColorTransform, amount:Number ):ColorTransform 
        {
            var interpolation:ColorTransform = new ColorTransform();
            
            interpolation.redMultiplier = NumberUtil.interpolate( amount, begin.redMultiplier, end.redMultiplier );
            interpolation.greenMultiplier = NumberUtil.interpolate( amount, begin.greenMultiplier, end.greenMultiplier );
            interpolation.blueMultiplier = NumberUtil.interpolate( amount, begin.blueMultiplier, end.blueMultiplier );
            interpolation.alphaMultiplier = NumberUtil.interpolate( amount, begin.alphaMultiplier, end.alphaMultiplier );
            interpolation.redOffset = NumberUtil.interpolate( amount, begin.redOffset, end.redOffset );
            interpolation.greenOffset = NumberUtil.interpolate( amount, begin.greenOffset, end.greenOffset );
            interpolation.blueOffset = NumberUtil.interpolate( amount, begin.blueOffset, end.blueOffset );
            interpolation.alphaOffset = NumberUtil.interpolate( amount, begin.alphaOffset, end.alphaOffset );
            
            return interpolation;
        }
        
        /**
         * Generates a random color.
         * @return A random color.
         */
        public static function randomRBG():uint
        {
            return ColorUtil.RGBToHex( NumberUtil.randomIntegerWithinRange( 0, 255 ), 
                NumberUtil.randomIntegerWithinRange( 0, 255 ), 
                NumberUtil.randomIntegerWithinRange( 0, 255 ) );
        }
        
        /**
         * Generates a random color.
         * @return A random color.
         */
        public static function randomARBG():uint
        {
            return ColorUtil.ARGBToHex( NumberUtil.randomIntegerWithinRange( 0, 255 ), 
                NumberUtil.randomIntegerWithinRange( 0, 255 ), 
                NumberUtil.randomIntegerWithinRange( 0, 255 ),
                NumberUtil.randomIntegerWithinRange( 0, 255 ) );
        }
        
        /**
         * Returns a hex value at the specified ratio between the to specified hex values.
         * @param	hex		Start hex value.
         * @param	hex2	End hex value.
         * @param	ratio	A number between 0 and 1 representing the distance between the two values to calculate.
         * @return
         */
        public static function getGradientColor( hex:uint, hex2:uint, ratio:Number ):uint
        {
            var r:uint = hex >> 16;
            var g:uint = hex >> 8 & 0xFF;
            var b:uint = hex & 0xFF;
            r += ((hex2 >> 16)-r)*ratio;
            g += ((hex2 >> 8 & 0xFF)-g)*ratio;
            b += ((hex2 & 0xFF)-b)*ratio;
            return ( r<<16 | g<<8 | b );
        }
        
        /**
         * Returns an array of hex values representing a gradient between the two specified hex values.
         * @param	hex1	Start hex value.
         * @param	hex2	End hex value.
         * @param	steps	The amount of gradient steps to create.
         * @return	An array of hex values.
         */
        public static function getGradientSteps( hex1:uint, hex2:uint, steps:int ):Array
        {
            var newArry:Array = [hex1];
            
            var r:uint = hex1 >> 16;
            var g:uint = hex1 >> 8 & 0xFF;
            var b:uint = hex1 & 0xFF;
            
            var rd:uint = ( hex2 >> 16 ) - r;
            var gd:uint = ( hex2 >> 8 & 0xFF ) - g;
            var bd:uint = ( hex2 & 0xFF ) - b;
            
            steps++;
            
            for ( var i:int = 1; i < steps; i++ )
            {
                var ratio:Number = i / steps;
                
                newArry.push( ( r + rd * ratio ) << 16 | ( g + gd * ratio ) << 8 | ( b + bd * ratio ) );
            }
            
            newArry.push( hex2 );
            return newArry;
        }
    }
}