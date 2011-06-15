package net.nobien.utils.tests
{
	import net.nobien.utils.StringUtil;
    import org.flexunit.Assert;
    
    public class StringUtilTestCase
    {
        [Before]
        public function before():void
        {
            
        }
        
        [After]
        public function after():void
        {
            
        }
        
        [Test(order="1")]
        public function trim_removes_whitespace_on_both_ends():void
        {
            var str:String = " hello world ";
			var result:String = StringUtil.trim( str );
			Assert.assertTrue( "Returned string should not have white space on either end", result == "hello world" );
        }
    }
}