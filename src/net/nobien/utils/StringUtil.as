package net.nobien.utils 
{
    /**
     * The StringUtil class contains static utility methods for manipulating Strings.
     */
    public class StringUtil
    {
        /**
         * Removes whitespace from the front and the end of the specified string.
         * @param input The String whose beginning and ending whitespace will will be removed.
         * @return A String with whitespace removed from the begining and end
         */			
        public static function trim( input:String ):String
        {
            return StringUtil.ltrim( StringUtil.rtrim( input ) );
        }

        /**
         * Removes whitespace from the front of the specified string.
         * @param input The String whose beginning whitespace will will be removed.
         * @return A String with whitespace removed from the begining
         */	
        public static function ltrim( input:String ):String
        {
            var size:Number = input.length;
            
            for ( var i:Number = 0; i < size; i++ )
            {
                if( input.charCodeAt( i ) > 32 )
                {
                    return input.substring( i );
                }
            }
            
            return "";
        }

        /**
         * Removes whitespace from the end of the specified string.
         * @param input The String whose ending whitespace will will be removed.
         * @return A String with whitespace removed from the end	
         */	
        public static function rtrim( input:String ):String
        {
            var size:Number = input.length;
            
            for ( var i:Number = size; i > 0; i--) 
            {
                if( input.charCodeAt( i - 1 ) > 32 )
                {
                    return input.substring( 0, i );
                }
            }

            return "";
        }
        
        /**
         * Removes all instances of the remove string in the input string.
         * @param input The string that will be checked for instances of remove string.
         * @param remove The string that will be removed from the input string.
         * @return A String with the remove string removed.
         */	
        public static function remove( input:String, remove:String ):String
        {
            return StringUtil.replace( input, remove, "" );
        }
        
        /**
         * Removes all hidden line breaks from the content string.
         * @param	str The string that will have the line breaks removed.
         * @return  A String with line breaks removed.
         */
        static public function removeLineBreaks( str:String ):String
        {
            var pcLB:RegExp = /\r\n/g;
            var macLB:RegExp = /\r/g;
            var linuxLB:RegExp = /\n/g;
            
            str = str.replace( pcLB, "" );
            str = str.replace( macLB, "" );
            str = str.replace( linuxLB, "" );
            
            return str;
        }
        
        /**
         * Replaces all instances of the replace string in the input string with the replaceWith string.
         * @param input The string that instances of replace string will be replaces with removeWith string.
         * @param replace The string that will be replaced by instances of the replaceWith string.
         * @param replaceWith The string that will replace instances of replace string.
         * @return A new String with the replace string replaced with the replaceWith string.
         */
        public static function replace( input:String, replace:String, replaceWith:String ):String
        {
            var sb:String = new String();
            var found:Boolean = false;

            var sLen:Number = input.length;
            var rLen:Number = replace.length;

            for ( var i:Number = 0; i < sLen; i++ )
            {
                if ( input.charAt( i ) == replace.charAt( 0 ) )
                {   
                    found = true;
                    
                    for ( var j:Number = 0; j < rLen; j++ )
                    {
                        if ( !( input.charAt( i + j ) == replace.charAt( j ) ) )
                        {
                            found = false;
                            break;
                        }
                    }

                    if ( found )
                    {
                        sb += replaceWith;
                        i = i + ( rLen - 1 );
                        continue;
                    }
                }
                
                sb += input.charAt( i );
            }
            
            return sb;
        }
    }
}