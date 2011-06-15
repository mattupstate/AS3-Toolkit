package net.nobien.net 
{
    /**
     * The <code>URL</code> class parses a full URL into its different parts.
     */
    public class URL
    {
        private var _fullURL:String;
        private var _host:String = "";
        private var _port:String = "";
        private var _protocol:String = "";
        private var _path:String = "";
        private var _parameters:Object = {};   
        
        /**
         * Creates a new <code>URL</code> object.
         * @param	url	A full URL starting with http://....
         */
        public function URL( url:String ) 
        {
            _fullURL = url;
            
            var reg:RegExp = /(?P<protocol>[a-zA-Z]+) : \/\/  (?P<host>[^:\/]*) (:(?P<port>\d+))?  ((?P<path>[^?]*))? ((?P<parameters>.*))? /x;
            var results:Array = reg.exec( fullURL );
            
            try
            {
                _protocol = results.protocol
                _host = results.host;
                _port = results.port;
                _path = results.path;
                
                var paramsStr:String = results.parameters;
                
                if( paramsStr != "" )
                {
                    if( paramsStr.charAt( 0 ) == "?" )
                    {
                        paramsStr = paramsStr.substring( 1 );
                    }
                    
                    var params:Array = paramsStr.split("&");
                    
                    for each( var paramStr:String in params )
                    {
                        var param:Array = paramStr.split( "=" );
                        _parameters[param[0]] = param[1];
                    }                               
                }
            }
            catch( error:Error )
            {
                
            }
        }
        
        /**
         * The full URL.
         */
        public function get fullURL():String { return _fullURL; }
        
        /**
         * The host name.
         */
        public function get host():String { return _host; }
        
        /**
         * The port number.
         */
        public function get port():String { return _port; }
        
        /**
         * The URL protocol.
         */
        public function get protocol():String { return _protocol; }
        
        /**
         * The folder path.
         */
        public function get path():String { return _path; }
        
        /**
         * The query string.
         */
        public function get parameters():Object { return _parameters; }
        
        public function toString():String 
        {
            return '[URL fullURL="' + fullURL + '" protocol="' + protocol + '" host="' + host + '" port="' + port + '" path="' + path + '" parameters="' + parameters + '"]';
        }
    }
}