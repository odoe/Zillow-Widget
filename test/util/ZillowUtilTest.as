package widgets.Zillow.test.util
{
	import flash.utils.ByteArray;
	
	import flexunit.framework.Assert;
	
	import mx.collections.ArrayCollection;
	import mx.collections.XMLListCollection;
	
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertTrue;
	
	import widgets.Zillow.main.util.ZillowUtil;
	
	public class ZillowUtilTest
	{
		//protected var service:ZillowService;
		[Embed(source="../zillowtest.xml", mimeType="application/octet-stream")]
		protected var xmlClass:Class;
		
		protected var xml:XML;
		
		[Before]
		public function setUp():void
		{
			//service = new ZillowService();
			var file:ByteArray = new xmlClass();
			var str:String = file.readUTFBytes( file.length );
			xml = new XML( str );
		}
		
		[After]
		public function tearDown():void
		{
			//service = null;
			xml = null;
		}
		
		[Test]
		public function testZillowToGraphics():void
		{
			//Assert.fail("test not ready yet");
			assertNotNull(xml);
			assertNotNull(xml.result);
			var list:XMLList = new XMLList(xml);
			assertNotNull(list);
			var listColl:XMLListCollection = new XMLListCollection(list);
			assertNotNull(listColl);
			var ac:ArrayCollection = ZillowUtil.toGraphics(listColl);
			assertNotNull("ac not null", ac);
			assertTrue("ac host more than 0 item", ac.length > 0);
		}
	}
}