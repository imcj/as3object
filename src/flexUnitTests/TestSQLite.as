package flexUnitTests
{
	import me.imcj.as3object.Table;
	import me.imcj.as3object.fixture.Cat;
	import me.imcj.as3object.sqlite.SQLite;
	import me.imcj.as3object.sqlite.SQLiteTable;

	public class TestSQLite
	{
		public var table  : Table;
		public var sqlite : SQLite;
		public var cat : Cat;
		
		[Before]
		public function setUp():void
		{
			table = new SQLiteTable ( Cat );
			sqlite = new SQLite ( table );
			table.sql = sqlite;
			
			cat = new Cat ( );
			cat.name = "2B";
			cat.age = 2;
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[Test]
		public function testInsert ( ) : void
		{
			var sql : String = table.sql.insert ( cat == null );
		}
		
		[Test]
		public function testRemove ( ) : void
		{
			var sql : String = table.sql.remove ( cat );
		}
		
		[Test]
		public function testUpdate ( ) : void
		{
			var sql : String = table.sql.update ( cat );
		}
	}
}