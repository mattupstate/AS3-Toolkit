package net.nobien.utils 
{   
    /**
     * The HTMLUtil class contains static utility functions for manipulating HTML formatted text.
     */
    public class HTMLUtil
    {
        /**
         * Converts links in a string to HTML links using the <a> tag.
         * @param	text    The text to convert.
         * @return  The converted text.
         */
        public static function convertUrlsToLinks( text:String ) :String
        {
            var re:RegExp = /(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/ig;
            return text.replace( re, "<a href='$1'>$1</a>" ); 
        }
        
        /**
         * Strips the specified HTML tags from the HTML formatted content.
         * @param	html	The HTML content.
         * @param	tags	A comma delimited list of tags to remove. For example: "a,b,i,p"
         * @return  The HTML string stripped of the specified tags
         */
        static public function removeHTMLTags( html:String, tags:String = "" ):String
        {
            var tagsToBeKept:Array = [];
            
            if( tags.length > 0 )
            {
                tagsToBeKept = tags.split( new RegExp( "\\s*,\\s*" ) );
            }
         
            var tagsToKeep:Array = new Array();
            
            for( var i:int = 0; i < tagsToBeKept.length; i++ )
            {
                if( tagsToBeKept[i] != null && tagsToBeKept[i] != "" )
                {
                    tagsToKeep.push( tagsToBeKept[i] );
                }
            }
         
            var toBeRemoved:Array = [];
            var tagRegExp:RegExp = new RegExp( "<([^>\\s]+)(\\s[^>]+)*>", "g" );
            var foundedStrings:Array = html.match( tagRegExp );
            
            for( i = 0; i < foundedStrings.length; i++ ) 
            {
                var tagFlag:Boolean = false;
                
                if( tagsToKeep != null ) 
                {
                    for( var j:int = 0; j < tagsToKeep.length; j++ )
                    {
                        var tmpRegExp:RegExp = new RegExp( "<\/?" + tagsToKeep[j] + "[^<>]*?>", "i" );
                        var tmpStr:String = foundedStrings[i] as String;
                        
                        if( tmpStr.search(tmpRegExp) != -1 ) 
                        {
                            tagFlag = true;
                        }
                    }
                }
                
                if( !tagFlag )
                {
                    toBeRemoved.push( foundedStrings[i] );
                }
            }
            
            for( i = 0; i < toBeRemoved.length; i++ ) 
            {
                var tmpRE:RegExp = new RegExp( "([\+\*\$\/])", "g" );
                var tmpRemRE:RegExp = new RegExp( ( toBeRemoved[i] as String ).replace( tmpRE, "\\$1" ), "g" );
                html = html.replace( tmpRemRE, "" );
            }
            
            return html;
        }
    }
}