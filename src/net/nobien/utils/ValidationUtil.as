package net.nobien.utils 
{
    /**
     * The ValidationUtil class contains static utility functions for validating input data.
     */
    public class ValidationUtil
    {
        public static const STATE_ABBREVIATIONS:Array = ['ak', 'al', 'ar', 'az', 'ca', 'co', 'ct', 'dc', 'de', 'fl', 'ga', 'hi', 'ia', 'id', 'il', 'in', 'ks', 'ky', 'la', 'ma', 'md', 'me', 'mi', 'mn', 'mo', 'ms', 'mt', 'nb', 'nc', 'nd', 'nh', 'nj', 'nm', 'nv', 'ny', 'oh', 'ok', 'or', 'pa', 'ri', 'sc', 'sd', 'tn', 'tx', 'ut', 'va', 'vt', 'wa', 'wi', 'wv', 'wy'];
        
        /**
         * Validates an email address.
         * @param	email	Email address to validate
         * @return	True or false
         */
        public static function isValidEmail(email:String):Boolean {
            var pattern:RegExp = /^[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\.)+[A-Z]{2,4}$/i;
            return email.match(pattern) != null;
        }
        
        /**
         * Validates a state abbreviation.
         * @param	state	State abbreviation to validate
         * @return	True or false
         */
        public static function isValidStateAbbreviation( state:String ):Boolean
        {
            return ( STATE_ABBREVIATIONS.indexOf( StringUtil.trim( state.toLowerCase() ) ) > -1 ) ? true : false;
        }
        
        /**
         * Validates a month value
         * @param	month	Month value to validate
         * @return	True or false
         */
        public static function isValidMonth( month:Number ):Boolean
        {
            if ( month > 12 || month < 1 )
                return false;
            else
                return true;
        }
        
        /**
         * Validates a day value
         * @param	day	Day value to validate
         * @return	True or false
         */
        public static function isValidDay( day:Number ):Boolean
        {
            if ( day > 31 || day < 1 )
                return false;
            else
                return true;
        }
        
        /**
         * Validates a year value
         * @param	year	Year value to validate
         * @return	True or false
         */
        public static function isValidYear( year:Number ):Boolean
        {
            if ( year > 2009 || year < 1900 )
                return false;
            else
                return true;
        }
    }
}