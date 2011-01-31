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
		protected var xml:XML;
		[Embed(source="../zillowtest.xml", mimeType="application/octet-stream")]
		protected var xmlClass:Class;
		
		[Before]
		public function setUp():void
		{
			var file:ByteArray=new xmlClass();
			var str:String=file.readUTFBytes(file.length);
			xml=new XML(str);
		}
		
		[After]
		public function tearDown():void
		{
			xml=null;
		}
		
		[Test]
		public function testZillowToGraphics():void
		{
			//Assert.fail("test not ready yet");
			assertNotNull("this test xml should not be null", xml);
			assertNotNull("verify that it has a result node", xml.result);
			var list:XMLList=new XMLList(xml);
			assertNotNull("verify that it can be made into a XMLList", list);
			var listColl:XMLListCollection=new XMLListCollection(list);
			assertNotNull("verify that XMLList can be made into valid XMLListCollection", listColl);
			var ac:ArrayCollection;
			assertNull("collection starts null and empty", ac);
			ac = ZillowUtil.toGraphics(listColl, ac);
			assertNotNull("ac not null", ac);
			assertTrue("ac host more than 0 item", ac.length > 0);
			var ac_null:ArrayCollection=ZillowUtil.toGraphics(null, null);
			assertTrue("when sent null, return should be o length", ac_null.length == 0);
		}
	}
}