package flexUnitTests
{
	import me.imcj.as3object.Table;
	import me.imcj.as3object.fixture.Dog;
	import me.imcj.as3object.sqlite.SQLiteTable;
	
	import org.flexunit.asserts.assertEquals;

	public class TestTable
	{		
		public var table : Table;
		
		[Before]
		public function setUp():void
		{
			table = new SQLiteTable ( Dog );
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[Test]
		public function testFieldLength () : void
		{
			assertEquals ( 2, table.fields.keys.length );
		}
	}
}