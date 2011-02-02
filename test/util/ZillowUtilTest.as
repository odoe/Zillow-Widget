package widgets.Zillow.test.util
{
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	import mx.collections.XMLListCollection;
	
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertTrue;
	
	import widgets.Zillow.main.util.ZillowUtil;
	public class ZillowUtilTest
	{
		
		[Embed(source="../regionPostingsTest.xml", mimeType="application/octet-stream")]
		protected var regionsPostingsXmlClass:Class;
		protected var rpXml:XML;
		
		[Embed(source="../searchResultsTest.xml", mimeType="application/octet-stream")]
		protected var searchResultsXmlClass:Class;
		protected var srXml:XML;
		
		[Before]
		public function setUp():void
		{
			var file:ByteArray = new regionsPostingsXmlClass();
			var str:String = file.readUTFBytes(file.length);
			rpXml = new XML(str);
			
			var file2:ByteArray = new searchResultsXmlClass();
			var str2:String = file2.readUTFBytes(file2.length);
			srXml = new XML(str2);
		}
		
		[After]
		public function tearDown():void
		{
			rpXml = null;
            srXml = null;
		}
		
		[Test]
		public function testThatXmlDataValid():void
		{
			assertNotNull("this test xml should not be null", rpXml);
			assertNotNull("verify that it has a result node", rpXml.result);
            
            assertNotNull("this test xml should not be null", srXml);
            assertNotNull("verify that it has a result node", srXml.result);
		}
		
		[Test]
		public function testRegionPostingsToGraphics():void
		{
			//Assert.fail("test not ready yet");
			var list:XMLList=new XMLList(rpXml);
			assertNotNull("verify that it can be made into a XMLList", list);
			var listColl:XMLListCollection=new XMLListCollection(list);
			assertNotNull("verify that XMLList can be made into valid XMLListCollection", listColl);
			var ac:ArrayCollection;
			assertNull("collection starts null and empty", ac);
			ac = ZillowUtil.regionPostingsToGraphics(listColl, ac);
			assertNotNull("ac not null", ac);
			assertTrue("ac host more than 0 item", ac.length > 0);
			var ac_null:ArrayCollection=ZillowUtil.regionPostingsToGraphics(null, null);
			assertTrue("when sent null, return should be o length", ac_null.length == 0);
		}
        
        [Test]
        public function testSearchResultsToGraphics():void
        {
            var list:XMLList=new XMLList(rpXml);
            assertNotNull("verify that it can be made into a XMLList", list);
            var listColl:XMLListCollection=new XMLListCollection(list);
            assertNotNull("verify that XMLList can be made into valid XMLListCollection", listColl);
            var ac:ArrayCollection;
            assertNull("collection starts null and empty", ac);
            ac = ZillowUtil.searchResultsToGraphics(listColl, ac);
            
            assertNotNull("ac should not be null after being processed", ac);
            assertTrue("ac should have only a single result", ac.length == 1);
        }
	}
}