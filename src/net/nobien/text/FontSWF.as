package net.nobien.text 
{
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.system.ApplicationDomain;
    import flash.system.Security;
    import flash.text.Font;

    /**
     * The FontSWF class is a SWF container for a font or set of fonts to be registered in the application. Always
     * define the class definition of the font and the allowed domains before calling the super() method. Once the
     * resulting SWF is loaded into the current application domain, the fonts will automatically be registered.
     * 
     * @example <div class="listing"><pre>package fonts
     * {
     *     import net.nobien.text.FontSWF;
     * 
     *     public class CooperSWF extends FontSWF
     *     {
     * 
     *         public function CooperSWF() 
     *         {
     *             _allowedDomains = ["*.nobien.net"];
     *			   _fontClassDefinitions = ["fonts.Cooper"];
     * 			   super();
     *         }
     *     }
     * }</div></pre>
     */
    public class FontSWF extends MovieClip
    {
        protected var _allowedDomains:Array = [];
        protected var _fontClassDefinitions:Array = [];
        
        /**
         * Creates a new FontSWF object.
         */
        public function FontSWF() 
        {
            setAllowedDomains();
            loaderInfo.addEventListener( Event.INIT, onInit );
        }
        
        private function onInit( event:Event ):void 
        {
            loaderInfo.removeEventListener( Event.INIT, onInit );
            
            var nDef:int = fontClassDefinitions.length;
            
            for( var i:int = 0; i < nDef; i++ )
            {
                if( ApplicationDomain.currentDomain.hasDefinition( fontClassDefinitions[i] ) )
                {
                    var fontClass:Class = ApplicationDomain.currentDomain.getDefinition( fontClassDefinitions[i] ) as Class;
                    Font.registerFont( fontClass );
                }
            }
        }
        
        /**
         * Sets the allowed domains that are listed in the <code>allowedDomains</code> property.
         */
        protected function setAllowedDomains():void
        {
            for( var i:int = 0; i < allowedDomains.length; i++ )
            {
                Security.allowDomain( allowedDomains[i] );
            }
        }
        
        /**
         * An array of strings representing the class names of the fonts within the SWF file.
         */
        public function get fontClassDefinitions():Array { return _fontClassDefinitions; }
        
        /**
         * An array of strings representing the allowed domains for the SWF file.
         */
        public function get allowedDomains():Array { return _allowedDomains; }
        
    }

}