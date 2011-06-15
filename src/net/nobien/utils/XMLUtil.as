package net.nobien.utils {

    /**
     * ...
     */
	public class XMLUtil{
		
        public static function convertVariableXml(content:String):XML {
			var data:XML = new XML(content);
			var vars:Array = [];
			for each(var item:XML in data.variables.variable) {
				var name:String = item.@name.toString();
				var value:String = item.toString();
				if(vars.indexOf(name) == -1) {
					vars.push({ name:name, value:value });
				}
			}
			
			delete data.variables;
			var xmlStr:String = data.toXMLString();
			
			for(var i:int = 0; i < vars.length; i++) {
				var exp:RegExp = new RegExp(vars[i].name, "g");
				xmlStr = xmlStr.replace(exp, vars[i].value);
			}
			
			return new XML( xmlStr );
		}
		
	}

}