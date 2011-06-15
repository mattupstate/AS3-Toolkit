package net.nobien.utils 
{
    import flash.system.Capabilities;

    /**
     * The LocationUtil class contains static utility functions for determining a SWF file's location.
     */
    public class LocationUtil
    {
        /**
         * Determines if the SWF is running in a browser plug-in.
         * @return Returns true if SWF is running in the Flash Player browser plug-in; otherwise false.
         */
        public static function isPlugin():Boolean 
        {
            return Capabilities.playerType == 'PlugIn' || Capabilities.playerType == 'ActiveX';
        }
        
        /**
         * Determines if the SWF is running in the IDE.
         * @return Returns true if SWF is running in the Flash Player version used by the external player or test movie mode; otherwise false.
        */
        public static function isIde():Boolean 
        {
            return Capabilities.playerType == 'External';
        }
        
        /**
         * Determines if the SWF is running in the StandAlone player.
         * @return Returns true if SWF is running in the Flash StandAlone Player; otherwise false.
         */
        public static function isStandAlone():Boolean 
        {
            return Capabilities.playerType == 'StandAlone';
        }
        
        /**
         * Determines if the runtime environment is an Air application.
         * @return Returns true if the runtime environment is an Air application; otherwise false.
         */
        public static function isAirApplication():Boolean 
        {
            return Capabilities.playerType == 'Desktop';
        }
    }
}