package net.nobien.utils 
{
    import flash.display.Shape;
    import flash.events.Event;

    /**
     * The TimeUtil class contains static utility functions for manipulating and generating time based values.
     */
    public class TimeUtil
    {
        /**
         * Converts the amount of milliseconds into a string based time code.
         * @param	milliseconds
         * @param	delimiter
         * @param 	withHours
         * @return	The time code as a string.
         */
        public static function getTimeCode( milliseconds:Number, delimeter:String = ":", withHours:Boolean = false ):String
        {
            var posHours:Number = Math.floor( ConversionUtil.millisecondsToHours( milliseconds ) );
            var posMins:Number = Math.floor( ConversionUtil.millisecondsToMinutes( milliseconds ) );
            var posSecs:Number = Math.round( ConversionUtil.millisecondsToSeconds( milliseconds ) % 60 );
            
            if( posSecs >= 60 )
            {
                posSecs = 0;
                posMins++;
            }
            
            if( posMins >= 60 )
            {
                posMins = 0;
                posHours++;
            }
            
            var timeHours:String = ( posHours < 10 ) ? "0" + posHours.toString() : posHours.toString();
            var timeMins:String = ( posMins < 10 ) ? "0" + posMins.toString() : posMins.toString();
            var timeSecs:String = ( posSecs < 10 ) ? "0" + posSecs.toString() : posSecs.toString();
            var result:String = timeMins + delimeter + timeSecs;
            
            if( withHours )
            {
                result = timeHours + delimeter + result;
            }
            
            return result;
        }
        
        /**
         * Wait a given number of frames then call a callback
         * @param numFrames Number of frames to wait before calling the callback
         * @param callback Function to call once the given number of frames have passed
         */
        public static function wait( numFrames:uint, callback:Function ):void
        {
            var obj:Shape = new Shape();
            var f:Function;
            
            f = function( event:Event ):void
                {
                    numFrames--;
                    if( numFrames == 0 )
                    {
                        obj.removeEventListener( Event.ENTER_FRAME, arguments.callee );
                        callback();
                    }
                }
                
            obj.addEventListener( Event.ENTER_FRAME, f );
        }
    }
}