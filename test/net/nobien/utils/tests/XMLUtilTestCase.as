package net.nobien.utils.tests {

	import net.nobien.utils.XMLUtil;
    import org.flexunit.Assert;
	
	public class XMLUtilTestCase {
		
        [Before]
        public function before():void
        {
            
        }
        
        [After]
        public function after():void
        {
            
        }
        
        [Test(order="1")]
        public function convertVariableXml_works():void
        {
            var xcontent:String = '<data><variables><variable name="{var1}">hello world</variable></variables><content>{var1}</content></data>';
			var x:XML = XMLUtil.convertVariableXml(xcontent);
			Assert.assertTrue("content node should be equal to hello world", x.content == "hello world");
        }
		
		[Test(order="2")]
        public function convertVariableXml_finds_all_occurances_of_one_variable():void
        {
            var xcontent:String = '<data><variables><variable name="{var1}">hello world</variable></variables><content>{var1}</content><content2>{var1}</content2></data>';
			var x:XML = XMLUtil.convertVariableXml(xcontent);
			Assert.assertTrue("content node should be equal to hello world", x.content == "hello world");
			Assert.assertTrue("content2 node should be equal to hello world", x.content2 == "hello world");
        }
		
	}

}