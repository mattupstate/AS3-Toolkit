package net.nobien.utils 
{
    /**
     * The BandwithUtil class contains static utility methods for determining a users connection speed.
     */
    public class BandwithUtil
    {
        /**
         * Calculates the load speed in bytes per second (Bps).
         * @param bytesLoaded: Number of bytes that have loaded between {@code startTime} and {@code elapsedTime}.
         * @param startTime: Time in milliseconds when the load started.
         * @param elapsedTime: Time in milliseconds since the load started or time when load completed.
         * @return Bytes per second.
         */
        public static function calculateBps( bytesLoaded:uint, startTime:uint, elapsedTime:uint ):int
        {
            return Math.max( 0, ( bytesLoaded / ConversionUtil.millisecondsToSeconds( elapsedTime - startTime ) ) );
        }
        
        /**
         * Calculates the load speed in kilobytes per second (kBps).
         * @param bytesLoaded: Number of bytes that have loaded between {@code startTime} and {@code elapsedTime}.
         * @param startTime: Time in milliseconds when the load started.
         * @param elapsedTime: Time in milliseconds since the load started or time when load completed.
         * @return Kilobytes per second.
         */
        public static function calculateKBps( bytesLoaded:uint, startTime:uint, elapsedTime:uint ):Number 
        {
            return ConversionUtil.bytesToKilobytes( BandwithUtil.calculateBps( bytesLoaded, startTime, elapsedTime ) );
        }
    }
}