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
        
        [Test(order="2")]
        public function ltrim_removes_whitespace_on_left_end():void
        {
            var str:String = " hello world ";
			var result:String = StringUtil.ltrim( str );
			Assert.assertTrue( "Returned string should not have white space on left end", result == "hello world " );
        }
        
        [Test(order="3")]
        public function rtrim_removes_whitespace_on_right_end():void
        {
            var str:String = " hello world ";
			var result:String = StringUtil.rtrim( str );
			Assert.assertTrue( "Returned string should not have white space on right end", result == " hello world" );
        }
        
        [Test(order="4")]
        public function remove_removes_occurences():void
        {
            var str:String = "hello world";
			var result:String = StringUtil.remove( str, "hello" );
			Assert.assertTrue( "Remove should remove occurance of specified character(s)", result == " world" );
        }
    }
}