﻿package net.nobien.utils 
{
    /**
     * The DateUtil class containst static utility functions for manipulating and analyzing dates.
     */
    public class DateUtil
    {
        /**
         * Get the day of year of the specified date.
         * @param	date    The date
         * @return  The day of year.
         */
        public static function getDayOfYear( date:Date ):Number
        {
            var monthLengths:Array = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
            
            if( ( ( date.getFullYear() % 4 == 0 ) && ( date.getFullYear() % 100 != 0 ) ) || ( date.getFullYear() % 400 == 0 ) )
                monthLengths[1] = 29;

            var dayInYear:int = 0;

            for( var i:Number = 0; i < date.getMonth(); i++ )
                dayInYear += monthLengths[i];
            
            dayInYear += date.getDate();

            return dayInYear;
        }
        
        /**
         * Returns the English Short Month name (3 letters) for the Month that the Date represents.  
         * @param d The Date instance whose month will be used to retrieve the short month name.
         * @return An English 3 Letter Month abbreviation.
         */
        public static function getShortMonthName( d:Date ):String
        {
            return DateBase.monthNamesShort[d.getMonth()];
        }

        /**
         * Returns the index of the month that the short month name string represents.
         * @param m The 3 letter abbreviation representing a short month name.
         * @param Optional parameter indicating whether the search should be case sensitive
         * @return A int that represents that month represented by the specifed short name.
         */	
        public static function getShortMonthIndex( m:String ):int
        {
            return DateBase.monthNamesShort.indexOf( m );
        }
        
        /**
         * Returns the English full Month name for the Month that the Date represents. 
         * @param d The Date instance whose month will be used to retrieve the full month name.
         * @return An English full month name.
         */	
        public static function getFullMonthName( d:Date ):String
        {
            return DateBase.monthNamesLong[d.getMonth()];	
        }

        /**
         * Returns the index of the month that the full month name string represents.
         * @param m A full month name.
         * @return A int that represents that month represented by the specifed full month name.
         */	
        public static function getFullMonthIndex( m:String ):int
        {
            return DateBase.monthNamesLong.indexOf( m );
        }

        /**
         * Returns the English Short Day name (3 letters) for the day that the Date represents.
         * @param d The Date instance whose day will be used to retrieve the short day name.
         * @return An English 3 Letter day abbreviation.
         */	
        public static function getShortDayName( d:Date ):String
        {
            return DateBase.dayNamesShort[d.getDay()];	
        }
        
        /**
         * Returns the index of the day that the short day name string represents. 
         * @param m A short day name.
         * @return A int that represents that short day represented by the specifed full month name.
         */			
        public static function getShortDayIndex( d:String ):int
        {
            return DateBase.dayNamesShort.indexOf( d );
        }

        /**
         * Returns the English full day name for the day that the Date represents. 
         * @param d The Date instance whose day will be used to retrieve the full day name.
         * @return An English full day name.
         */	
        public static function getFullDayName( d:Date ):String
        {
            return DateBase.dayNamesLong[d.getDay()];	
        }		

        /**
         * Returns the index of the day that the full day name string represents.
         * @param m A full day name.
         * @return A int that represents that full day represented by the specifed full month name.
         */		
        public static function getFullDayIndex( d:String ):int
        {
            return DateBase.dayNamesLong.indexOf( d );
        }

        /**
         * Returns a two digit representation of the year represented by the specified date.
         * @param d The Date instance whose year will be used to generate a two digit string representation of the year.
         * @return A string that contains a 2 digit representation of the year. Single digits will be padded with 0.
         */	
        public static function getShortYear( d:Date ):String
        {
            var dStr:String = String( d.getFullYear() );
            
            if ( dStr.length < 3 )
            {
                return dStr;
            }

            return dStr.substr( dStr.length - 2 );
        }

        /**
         * Compares two dates and returns an integer depending on their relationship.
         * Returns -1 if d1 is greater than d2.
         * Returns 1 if d2 is greater than d1.
         * Returns 0 if both dates are equal.
         * @param d1 The date that will be compared to the second date.
         * @param d2 The date that will be compared to the first date.
         * @return An int indicating how the two dates compare.
         */	
        public static function compareDates( d1:Date, d2:Date ):int
        {
            var d1ms:Number = d1.getTime();
            var d2ms:Number = d2.getTime();
            
            if ( d1ms > d2ms )
            {
                return -1;
            }
            else if( d1ms < d2ms )
            {
                return 1;
            }
            else
            {
                return 0;
            }
        }

        /**
         * Returns a short hour (0 - 12) represented by the specified date. If the hour is less 
         * than 12 (0 - 11 AM) then the hour will be returned. If the hour is greater than 12 
         * (12 - 23 PM) then the hour minus 12 will be returned.
         * @param d1 The Date from which to generate the short hour
         * @return An int between 0 and 13 ( 1 - 12 ) representing the short hour.
         */	
        public static function getShortHour( d:Date ):int
        {
            var h:int = d.hours;
            
            if ( h == 0 || h == 12 )
            {
                return 12;
            }
            else if( h > 12 )
            {
                return h - 12;
            }
            else
            {
                return h;
            }
        }
        
        /**
         * Returns a string indicating whether the date represents a time in the ante meridiem 
         * (AM) or post meridiem (PM). If the hour is less than 12 then "AM" will be returned.
         * If the hour is greater than 12 then "PM" will be returned.
         * @param d1 The Date from which to generate the 12 hour clock indicator.
         * @return A String ("AM" or "PM") indicating which half of the day the hour represents.
         */	
        public static function getAMPM( d:Date ):String
        {
            return ( d.hours > 11 )? "PM" : "AM";
        }

        /**
         * Parses dates that conform to RFC822 into Date objects. This method also supports four-digit 
         * years (not supported in RFC822), but two-digit years (referring to the 20th century) are 
         * fine, too. This function is useful for parsing RSS .91, .92, and 2.0 dates.
         * @param str A string formatted as a RFC822 date.
         * @return A Date object equivalent to the RFC822 date.
         * @see http://asg.web.cmu.edu/rfc/rfc822.html
         */		
        public static function parseRFC822( str:String ):Date
        {
            var finalDate:Date;
            try
            {
                var dateParts:Array = str.split( " " );
                var day:String = null;
                
                if ( dateParts[0].search( /\d/) == -1 )
                {
                    day = dateParts.shift().replace( /\W/, "" );
                }
                
                var date:Number = Number( dateParts.shift() );
                var month:Number = Number( DateUtil.getShortMonthIndex( dateParts.shift() ) );
                var year:Number = Number( dateParts.shift() );
                var timeParts:Array = dateParts.shift().split( ":" );
                var hour:Number = int( timeParts.shift() );
                var minute:Number = int( timeParts.shift() );
                var second:Number = ( timeParts.length > 0 ) ? int( timeParts.shift() ): 0;
                var milliseconds:Number = Date.UTC( year, month, date, hour, minute, second, 0 );
                var timezone:String = dateParts.shift();
                var offset:Number = 0;

                if ( timezone.search( /\d/ ) == -1 )
                {
                    switch ( timezone )
                    {
                        case "UT":
                            offset = 0;
                            break;
                            
                        case "UTC":
                            offset = 0;
                            break;
                            
                        case "GMT":
                            offset = 0;
                            break;
                            
                        case "EST":
                            offset = -5 * 3600000;
                            break;
                            
                        case "EDT":
                            offset = -4 * 3600000;
                            break;
                            
                        case "CST":
                            offset = -6 * 3600000;
                            break;
                            
                        case "CDT":
                            offset = -5 * 3600000;
                            break;
                            
                        case "MST":
                            offset = -7 * 3600000;
                            break;
                            
                        case "MDT":
                            offset = -6 * 3600000;
                            break;
                            
                        case "PST":
                            offset = -8 * 3600000;
                            break;
                            
                        case "PDT":
                            offset = -7 * 3600000;
                            break;
                            
                        case "Z":
                            offset = 0;
                            break;
                            
                        case "A":
                            offset = -1 * 3600000;
                            break;
                            
                        case "M":
                            offset = -12 * 3600000;
                            break;
                            
                        case "N":
                            offset = 1 * 3600000;
                            break;
                            
                        case "Y":
                            offset = 12 * 3600000;
                            break;
                            
                        default:
                            offset = 0;
                            
                    }
                }
                else
                {
                    var multiplier:Number = 1;
                    var oHours:Number = 0;
                    var oMinutes:Number = 0;
                    
                    if ( timezone.length != 4 )
                    {
                        if ( timezone.charAt( 0 ) == "-" )
                        {
                            multiplier = -1;
                        }
                        timezone = timezone.substr( 1, 4 );
                    }
                    oHours = Number( timezone.substr( 0, 2 ) );
                    oMinutes = Number( timezone.substr( 2, 2 ) );
                    offset = ( ( oHours * 3600000 ) + ( oMinutes * 60000 ) ) * multiplier;
                }

                finalDate = new Date( milliseconds - offset );

                if ( finalDate.toString() == "Invalid Date" )
                {
                    throw new Error( "This date does not conform to RFC822." );
                }
            }
            catch ( e:Error )
            {
                var eStr:String = "Unable to parse the string [" + str + "] into a date. ";
                eStr += "The internal error was: " + e.toString();
                throw new Error( eStr );
            }
            
            return finalDate;
        }
         
        /**
         * Returns a date string formatted according to RFC822.
         * @param d A Date object to convert.
         * @return A String formatted as an RFC822 date.
         * @see http://asg.web.cmu.edu/rfc/rfc822.html
         */	
        public static function toRFC822( d:Date ):String
        {
            var date:Number = d.getUTCDate();
            var hours:Number = d.getUTCHours();
            var minutes:Number = d.getUTCMinutes();
            var seconds:Number = d.getUTCSeconds();
            var sb:String = new String();
            sb += DateBase.dayNamesShort[ d.getUTCDay() ];
            sb += ", ";
            
            if ( date < 10 )
            {
                sb += "0";
            }
            sb += date;
            sb += " ";
            sb += DateBase.monthNamesShort[d.getUTCMonth()];
            sb += " ";
            sb += d.getUTCFullYear();
            sb += " ";
            
            if ( hours < 10 )
            {			
                sb += "0";
            }
            
            sb += hours;
            sb += ":";
            
            if ( minutes < 10 )
            {			
                sb += "0";
            }
            
            sb += minutes;
            sb += ":";
            
            if ( seconds < 10 )
            {			
                sb += "0";
            }
            
            sb += seconds;
            sb += " GMT";
            
            return sb;
        }
        
        /**
         * Parses dates that conform to the W3C Date-time Format into Date objects.
         * This function is useful for parsing RSS 1.0 and Atom 1.0 dates.
         * @param str A String formatted as a W3CDTF date.
         * @return A Date object equivalent to the provided W3CDTF date.
         * @see http://www.w3.org/TR/NOTE-datetime
         */		     
        public static function parseW3CDTF( str:String ):Date
        {
            var finalDate:Date;
            
            try
            {
                var dateStr:String = str.substring( 0, str.indexOf( "T" ) );
                var timeStr:String = str.substring( str.indexOf( "T" ) + 1, str.length );
                var dateArr:Array = dateStr.split( "-" );
                var year:Number = Number( dateArr.shift() );
                var month:Number = Number( dateArr.shift() );
                var date:Number = Number( dateArr.shift() );
                var multiplier:Number;
                var offsetHours:Number;
                var offsetMinutes:Number;
                var offsetStr:String;
                
                if ( timeStr.indexOf( "Z" ) != -1 )
                {
                    multiplier = 1;
                    offsetHours = 0;
                    offsetMinutes = 0;
                    timeStr = timeStr.replace( "Z", "" );
                }
                else if ( timeStr.indexOf( "+" ) != -1 )
                {
                    multiplier = 1;
                    offsetStr = timeStr.substring( timeStr.indexOf( "+" )+1, timeStr.length );
                    offsetHours = Number( offsetStr.substring( 0, offsetStr.indexOf( ":" ) ) );
                    offsetMinutes = Number( offsetStr.substring( offsetStr.indexOf( ":" ) + 1, offsetStr.length ) );
                    timeStr = timeStr.substring( 0, timeStr.indexOf( "+" ) );
                }
                else
                {
                    multiplier = -1;
                    offsetStr = timeStr.substring( timeStr.indexOf( "-" ) + 1, timeStr.length );
                    offsetHours = Number( offsetStr.substring( 0, offsetStr.indexOf( ":" ) ) );
                    offsetMinutes = Number( offsetStr.substring( offsetStr.indexOf( ":" ) + 1, offsetStr.length ) );
                    timeStr = timeStr.substring( 0, timeStr.indexOf( "-" ) );
                }
                
                var timeArr:Array = timeStr.split( ":" );
                var hour:Number = Number( timeArr.shift() );
                var minutes:Number = Number( timeArr.shift() );
                var secondsArr:Array = ( timeArr.length > 0 ) ? String( timeArr.shift() ).split( "." ) : null;
                var seconds:Number = ( secondsArr != null && secondsArr.length > 0 ) ? Number( secondsArr.shift() ) : 0;
                var milliseconds:Number = ( secondsArr != null && secondsArr.length > 0) ? Number( secondsArr.shift() ) : 0;
                var utc:Number = Date.UTC( year, month-1, date, hour, minutes, seconds, milliseconds );
                var offset:Number = ( ( offsetHours * 3600000 ) + ( offsetMinutes * 60000 ) ) * multiplier;
                finalDate = new Date( utc - offset );

                if ( finalDate.toString() == "Invalid Date" )
                {
                    throw new Error( "This date does not conform to W3CDTF." );
                }
            }
            catch ( e:Error )
            {
                var eStr:String = "Unable to parse the string [" + str + "] into a date. ";
                eStr += "The internal error was: " + e.toString();
                throw new Error( eStr );
            }
            
            return finalDate;
        }
         
        /**
         * Returns a date string formatted according to W3CDTF.
         * @param d A Date object to convert
         * @param includeMilliseconds Determines whether to include the milliseconds value (if any) in the formatted string.
         * @return A string formatted as a W3CDTF date.
         * @see http://www.w3.org/TR/NOTE-datetime
         */		     
        public static function toW3CDTF( d:Date, includeMilliseconds:Boolean = false ):String
        {
            var date:Number = d.getUTCDate();
            var month:Number = d.getUTCMonth();
            var hours:Number = d.getUTCHours();
            var minutes:Number = d.getUTCMinutes();
            var seconds:Number = d.getUTCSeconds();
            var milliseconds:Number = d.getUTCMilliseconds();
            var sb:String = new String();
            
            sb += d.getUTCFullYear();
            sb += "-";
            
            if ( month + 1 < 10 )
            {
                sb += "0";
            }
            
            sb += month + 1;
            sb += "-";
            
            if ( date < 10 )
            {
                sb += "0";
            }
            
            sb += date;
            sb += "T";
            
            if ( hours < 10 )
            {
                sb += "0";
            }
            
            sb += hours;
            sb += ":";
            
            if ( minutes < 10 )
            {
                sb += "0";
            }
            
            sb += minutes;
            sb += ":";
            
            if ( seconds < 10 )
            {
                sb += "0";
            }
            
            sb += seconds;
            
            if ( includeMilliseconds && milliseconds > 0 )
            {
                sb += ".";
                sb += milliseconds;
            }
            
            sb += "-00:00";
            
            return sb;
        }
        
        /**
         * Converts a date into just after midnight.
         * @param d A Date to convert
         * @return The converted date.
         */
        public static function makeMorning( d:Date ):Date
        {
            var d:Date = new Date( d.time );
            d.hours = 0;
            d.minutes = 0;
            d.seconds = 0;
            d.milliseconds = 0;
            return d;
        }
        
        /**
         * Converts a date into just befor midnight.
         * @param d A Date to convert
         * @return The converted date.
         */
        public static function makeNight( d:Date ):Date
        {
            var d:Date = new Date( d.time );
            d.hours = 23;
            d.minutes = 59;
            d.seconds = 59;
            d.milliseconds = 999;				
            return d;
        }

        /**
         * Sort of converts a date into UTC.
         * @param d A Date to convert
         * @return The converted date.
         */
        public static function getUTCDate( d:Date ):Date
        {
            var nd:Date = new Date();
            var offset:Number = d.getTimezoneOffset() * 60 * 1000; 
            nd.setTime( d.getTime() + offset );
            return nd;
        }
    }
}