package net.nobien.utils 
{
    /**
     * The NumberUtil class contains static utility functions for analyzing and manipulating Numbers.
     */
    public class NumberUtil 
    {
        /**
         * Formats a number with commas delimiting thousandths.
         * @param	value	A number to format
         * @return	String	A number formatted with commas
         */
        public static function addCommas( value:Number ):String
        {
            var pattern:RegExp = /(\d+)(\d{3}(\.|,|$))/gi;
            var str:String = value.toString();
            
            while ( str.match( pattern ).length != 0 )
            {
                str = ( str.replace( pattern, "$1,$2" ) );	
            }
            
            return str;
        }
        
        /**
         * Adds a leading zero for numbers less than ten.
         * @param value: Number to add leading zero.
         * @return Number as a String; if the number was less than ten the number will have a leading zero.
         */
        public static function addLeadingZero( value:Number ):String 
        {
            return ( value < 10 ) ? '0' + value : value.toString();
        }
        
        /**
         * Determines if value falls within a range; if not it is snapped to the nearest range value.
         * @param value: Number to determine if it is included in the range.
         * @param firstValue: First value of the range.
         * @param secondValue: Second value of the range.
         * @return Returns either the number as passed, or its value once snapped to nearest range value.
         */
        public static function constrain( value:Number, firstValue:Number, secondValue:Number ):Number 
        {
            return Math.min( Math.max( value, Math.min( firstValue, secondValue ) ), Math.max( firstValue, secondValue ) );
        }
        
        /**
         * Creates evenly spaced numerical increments between two numbers.
         * @param begin: The starting value.
         * @param end: The ending value.
         * @param steps: The number of increments between the starting and ending values.
         * @return Returns an Array composed of the increments between the two values.
         */
        public static function createStepsBetween( begin:Number, end:Number, steps:Number ):Array 
        {
            steps++;
            
            var i:uint = 0;
            var stepsBetween:Array = new Array();
            var increment:Number = ( end - begin ) / steps;
            
            while ( ++i < steps )
            {
                stepsBetween.push( i * increment + begin );
            }
            
            return stepsBetween;
        }
        
        /**
         * Finds the English ordinal suffix for the number given.
         * @param value: Number to find the ordinal suffix of.
         * @return Returns the suffix for the number, 2 characters.
         */
        public static function getOrdinalSuffix( value:int ):String 
        {
            if ( value >= 10 && value <= 20 )
                return 'th';
            
            switch ( value % 10 ) 
            {
                case 0 :
                case 4 :
                case 5 :
                case 6 :
                case 7 :
                case 8 :
                
                case 9 :
                    return 'th';
                    
                case 3 :
                    return 'rd';
                    
                case 2 :
                    return 'nd';
                    
                case 1 :
                    return 'st';
                    
                default :
                    return '';
                    
            }
        }
        
        /**
         * Determines a value between two specified values.
         * @param amount: The level of interpolation between the two values. If 0%, begin value is returned; if 100%, end value is returned.
         * @param minimum: The lower value.
         * @param maximum: The upper value.
         */
        public static function interpolate( amount:Number, minimum:Number, maximum:Number ):Number 
        {
            return minimum + ( maximum - minimum ) * amount;
        }
        
        /**
         * Determines if the value is included within a range.
         * @param value: Number to determine if it is included in the range.
         * @param firstValue: First value of the range.
         * @param secondValue: Second value of the range.
         * @return Returns true if the number falls within the range; otherwise false.
         */
        public static function isBetween( value:Number, firstValue:Number, secondValue:Number ):Boolean 
        {
            return !( value < Math.min( firstValue, secondValue ) || value > Math.max( firstValue, secondValue ) );
        }
        
        /**
         * Determines if the two values are equal, with the option to define the precision.
         * @param val1: A value to compare.
         * @param val2: A value to compare.
         * @param precision: The maximum amount the two values can differ and still be considered equal.
         * @return Returns true the values are equal; otherwise false.
         */
        public static function isEqual( val1:Number, val2:Number, precision:Number = 0 ):Boolean 
        {
            return Math.abs( val1 - val2 ) <= Math.abs( precision );
        }
        
        /**
         * Determines if the number is even.
         * @param value: A number to determine if it is divisible by {@code 2}.
         * @return Returns true if the number is even; otherwise false.
         */
        public static function isEven( value:Number ):Boolean 
        {
            return ( value & 1 ) == 0;
        }
        
        /**
         * Determines if the number is an integer.
         * @param value: A number to determine if it contains no decimal values.
         *  @return Returns true if the number is an integer; otherwise false.
         */
        public static function isInteger( value:Number ):Boolean 
        {
            return ( value % 1 ) == 0;
        }
        
        /**
         * Determines if the number is odd.
         * @param value: A number to determine if it is not divisible by 2.
         * @return Returns true if the number is odd; otherwise false.
         */
        public static function isOdd( value:Number ):Boolean 
        {
            return !NumberUtil.isEven( value );
        }
        
        /**
         * Determines if the number is prime.
         * @param value: A number to determine if it is only divisible by 1 and itself.
         * @return Returns true if the number is prime; otherwise false.
        */
        public static function isPrime( value:Number ):Boolean 
        {
            if ( value == 1 || value == 2 )
                return true;
            
            if ( NumberUtil.isEven( value ) )
                return false;
            
            var s:Number = Math.sqrt( value );
            
            for ( var i:Number = 3; i <= s; i++ )
                if ( value % i == 0 )
                    return false;
            
            return true;
        }
        
        /**
         * Determines if index is included within the collection length otherwise the index loops to the beginning or end of the range and continues.
         * @param index: Index to loop if needed.
         * @param length: The total elements in the collection.
         * @return A valid zero-based index.
         */
        public static function loopIndex( index:int, length:uint ):uint 
        {
            if ( index < 0 )
                index = length + index % length;
            
            if ( index >= length )
                return index % length;
            
            return index;
        }
        
        /**
         * Maps a value from one coordinate space to another.
         * @param value: Value from the input coordinate space to map to the output coordinate space.
         * @param min1: Starting value of the input coordinate space.
         * @param max1: Ending value of the input coordinate space.
         * @param min2: Starting value of the output coordinate space.
         * @param max2: Ending value of the output coordinate space.
         * @return The mapped coordinate number.
         */
        public static function map( value:Number, min1:Number, max1:Number, min2:Number, max2:Number ):Number 
        {
            return NumberUtil.interpolate( NumberUtil.normalize( value, min1, max1 ), min2, max2 );
        }
        
        /**
         * Determines a percentage of a value in a given range.
         * @param value: The value to be converted.
         * @param minimum: The lower value of the range.
         * @param maximum: The upper value of the range.
         * @return A normalized number.
         */
        public static function normalize( value:Number, minimum:Number, maximum:Number ):Number 
        {
            return ( value - minimum ) / ( maximum - minimum );
        }
        
        /**
         * Creates a random number within the defined range.
         * @param min: The minimum value the random number can be.
         * @param min: The maximum value the random number can be.
         * @return Returns a random number within the range.
         */
        public static function randomWithinRange( min:Number, max:Number ):Number 
        {
            return min + ( Math.random() * ( max - min ) );
        }
        
        /**
         * Creates a random integer within the defined range.
         * @param min: The minimum value the random integer can be.
         * @param min: The maximum value the random integer can be.
         * @return Returns a random integer within the range.
         */
        public static function randomIntegerWithinRange( min:int, max:int ):int 
        {
            return Math.round( NumberUtil.randomWithinRange( min, max ) );
        }
        
        /**
         * Rounds a number's decimal value to a specific place.
         * @param value: The number to round.
         * @param place: The decimal place to round.
         * @return Returns the value rounded to the defined place. 
         */
        public static function roundDecimalToPlace(value:Number, place:uint):Number 
        {
            var p:Number = Math.pow( 10, place );
            return Math.round(value * p) / p;
        }
    }
}