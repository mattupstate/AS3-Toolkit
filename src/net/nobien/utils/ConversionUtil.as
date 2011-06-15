package net.nobien.utils 
{
    /**
     * The ConversionUtil class contains static utility functions for various number conversions.
     */
    public class ConversionUtil
    {
        /**
         * Converts bits to bytes.
         * @param bits: The number of bits. 
         * @return Returns the number of bytes.
         */
        public static function bitsToBytes( bits:Number ):Number 
        {
            return bits / 8;
        }
        
        /**
         * Converts bits to kilobits.
         * @param bits: The number of bits.
         * @return Returns the number of kilobits.
         */
        public static function bitsToKilobits( bits:Number ):Number 
        {
            return bits / 1024;
        }
        
        /**
         * Converts bits to kilobytes.
         * @param bits: The number of bits. 
         * @return Returns the number of kilobits.
         */
        public static function bitsToKilobytes( bits:Number ):Number 
        {
            return bits / 8192;
        }
        
        /**
         * Converts bytes to bits.
         * @param bytes: The number of bytes.
         * @return Returns the number of bits.
         */
        public static function bytesToBits( bytes:Number ):Number 
        {
            return bytes * 8;
        }
        
        /**
         * Converts bytes to kilobits.
         * @param bytes: The number of bytes.
         * @return Returns the number of kilobits.
         */
        public static function bytesToKilobits( bytes:Number ):Number 
        {
            return bytes / 128;
        }
        
        /**
         * Converts bytes to kilobytes.
         * @param bytes: The number of bytes.
         * @return Returns the number of kilobytes.
         */
        public static function bytesToKilobytes( bytes:Number ):Number 
        {
            return bytes / 1024;
        }
        
        /**
         * Converts kilobits to bits.
         * @param kilobits: The number of kilobits.
         * @return Returns the number of bits.
         */
        public static function kilobitsToBits( kilobits:Number ):Number 
        {
            return kilobits * 1024;
        }
        
        /**
         * Converts kilobits to bytes.
         * @param kilobits: The number of kilobits.
         * @return Returns the number of bytes.
         */
        public static function kilobitsToBytes( kilobits:Number ):Number 
        {
            return kilobits * 128;
        }
            
        /**
         * Converts kilobits to kilobytes.
         * @param kilobytes: The number of kilobits.
         * @return Returns the number of kilobytes.
         */
        public static function kilobitsToKilobytes( kilobits:Number ):Number 
        {
            return kilobits / 8;
        }
        
        /**
         * Converts kilobytes to bits.
         * @param kilobytes: The number of kilobytes.
         * @return Returns the number of bits.
         */
        public static function kilobytesToBits( kilobytes:Number ):Number 
        {
            return kilobytes * 8192;
        }
        
        /**
         * Converts kilobytes to bytes.
         * @param kilobytes: The number of kilobytes.
         * @return Returns the number of bytes.
         */
        public static function kilobytesToBytes( kilobytes:Number ):Number 
        {
            return kilobytes * 1024;
        }
        
        /**
         * Converts kilobytes to kilobits.
         * @param kilobytes: The number of kilobytes.
         * @return Returns the number of kilobits.
         */
        public static function kilobytesToKilobits( kilobytes:Number ):Number 
        {
            return kilobytes * 8;
        }
        
        /**
         * Converts milliseconds to seconds.
         * @param milliseconds: The number of milliseconds.
         * @return Returns the number of seconds.
         */
        public static function millisecondsToSeconds( milliseconds:Number ):Number 
        {
            return milliseconds / 1000;
        }
        
        /**
         * Converts milliseconds to minutes.
         * @param milliseconds: The number of milliseconds.
         * @return Returns the number of minutes.
         */
        public static function millisecondsToMinutes( milliseconds:Number ):Number 
        {
            return ConversionUtil.secondsToMinutes( ConversionUtil.millisecondsToSeconds( milliseconds ) );
        }
        
        /**
         * Converts milliseconds to hours.
         * @param milliseconds: The number of milliseconds.
         * @return Returns the number of hours.
         */
        public static function millisecondsToHours( milliseconds:Number ):Number 
        {
            return ConversionUtil.minutesToHours( ConversionUtil.millisecondsToMinutes( milliseconds ) );
        }
        
        /**
         * Converts milliseconds to days.
         * @param milliseconds: The number of milliseconds.
         * @return Returns the number of days.
         */
        public static function millisecondsToDays( milliseconds:Number ):Number 
        {
            return ConversionUtil.hoursToDays( ConversionUtil.millisecondsToHours( milliseconds ) );
        }
        
        /**
         * Converts seconds to milliseconds.
         * @param seconds: The number of seconds.
         * @return Returns the number of milliseconds.
         */
        public static function secondsToMilliseconds( seconds:Number ):Number 
        {
            return seconds * 1000;
        }
        
        /**
         * Converts seconds to minutes.
         * @param seconds: The number of seconds.
         * @return Returns the number of minutes.
         */
        public static function secondsToMinutes( seconds:Number ):Number 
        {
            return seconds / 60;
        }
        
        /**
         * Converts seconds to hours.
         * @param seconds: The number of seconds.
         * @return Returns the number of hours.
         */
        public static function secondsToHours( seconds:Number ):Number 
        {
            return ConversionUtil.minutesToHours( ConversionUtil.secondsToMinutes( seconds ) );
        }
        
        /**
         * Converts seconds to days.
         * @param seconds: The number of seconds.
         * @return Returns the number of days.
         */
        public static function secondsToDays( seconds:Number ):Number 
        {
            return ConversionUtil.hoursToDays( ConversionUtil.secondsToHours( seconds ) );
        }
        
        /**
         * Converts minutes to milliseconds.
         * @param minutes: The number of minutes.
         * @return Returns the number of milliseconds.
         */
        public static function minutesToMilliseconds( minutes:Number ):Number 
        {
            return ConversionUtil.secondsToMilliseconds( ConversionUtil.minutesToSeconds( minutes ) );
        }
        
        /**
         * Converts minutes to seconds.
         * @param minutes: The number of minutes.
         * @return Returns the number of seconds.
         */
        public static function minutesToSeconds( minutes:Number ):Number 
        {
            return minutes * 60;
        }
        
        /**
         * Converts minutes to hours.
         * @param minutes: The number of minutes.
         * @return Returns the number of hours.
         */
        public static function minutesToHours( minutes:Number ):Number 
        {
            return minutes / 60;
        }
        
        /**
         * Converts minutes to days.
         * @param minutes: The number of minutes.
         * @return Returns the number of days.
         */
        public static function minutesToDays( minutes:Number ):Number 
        {
            return ConversionUtil.hoursToDays( ConversionUtil.minutesToHours( minutes ) );
        }
        
        /**
         * Converts hours to milliseconds.
         * @param hours: The number of hours.
         * @return Returns the number of milliseconds.
         */
        public static function hoursToMilliseconds( hours:Number ):Number 
        {
            return ConversionUtil.secondsToMilliseconds( ConversionUtil.hoursToSeconds( hours ) );
        }
        
        /**
         * Converts hours to seconds.
         * @param hours: The number of hours.
         * @return Returns the number of seconds.
         */
        public static function hoursToSeconds( hours:Number ):Number 
        {
            return ConversionUtil.minutesToSeconds( ConversionUtil.hoursToMinutes( hours ) );
        }
        
        /**
         * Converts hours to minutes.
         * @param hours: The number of hours.
         * @return Returns the number of minutes.
         */
        public static function hoursToMinutes( hours:Number ):Number 
        {
            return hours * 60;
        }
        
        /**
         * Converts hours to days.
         * @param hours: The number of hours.
         * @return Returns the number of days.
         */
        public static function hoursToDays( hours:Number ):Number 
        {
            return hours / 24;
        }
        
        /**
         * Converts days to milliseconds.
         * @param days: The number of days.
         * @return Returns the number of milliseconds.
         */
        public static function daysToMilliseconds( days:Number ):Number 
        {
            return ConversionUtil.secondsToMilliseconds( ConversionUtil.daysToSeconds( days ) );
        }
        
        /**
         * Converts days to seconds.
         * @param days: The number of days.
         * @return Returns the number of seconds.
         */
        public static function daysToSeconds( days:Number ):Number 
        {
            return ConversionUtil.minutesToSeconds( ConversionUtil.daysToMinutes( days ) );
        }
        
        /**
         * Converts days to minutes.
         * @param days: The number of days.
         * @return Returns the number of minutes.
         */
        public static function daysToMinutes( days:Number ):Number 
        {
            return ConversionUtil.hoursToMinutes( ConversionUtil.daysToHours( days ) );
        }

        /**
         * Converts days to hours.
         * @param days: The number of days.
         * @return Returns the number of hours.
         */
        public static function daysToHours( days:Number ):Number 
        {
            return days * 24;
        }
        
        /**
         * Converts degrees to radians.
         * @param degrees: The number of degrees.
         * @return Returns the number of radians.
         */
        public static function degreesToRadians( degrees:Number ):Number 
        {
            return degrees * ( Math.PI / 180 );
        }
        
        /**
         * Converts radians to degrees.
         * @param radians: The number of radians.
         * @return Returns the number of degrees.
         */
        public static function radiansToDegrees( radians:Number ):Number 
        {
            return radians * ( 180 / Math.PI );
        }
    }
}