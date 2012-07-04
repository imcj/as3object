package flexUnitTests
{
	import me.imcj.as3object.Table;
	import me.imcj.as3object.expression.and;
	import me.imcj.as3object.expression.eq;
	import me.imcj.as3object.fixture.Cat;
	import me.imcj.as3object.sqlite.SQLiteTable;
	
	import org.flexunit.asserts.assertEquals;

	public class TestSQLite
	{
		public var table  : Table;
		public var cat : Cat;
		
		[Before]
		public function setUp():void
		{
			table = new SQLiteTable ( Cat );
			
			cat = new Cat ( );
			cat.name = "2B";
			cat.age = 2;
		}
		
		[After]
		public function tearDown():void
		{
		}
        
        [Test]
        public function testCreateStatement ( ) : void
        {
            var createStatement : String = table.sql.creationStatement ( );
            assertEquals ( "CREATE TABLE Cat ( id INTEGER PRIMARY KEY asc AUTOINCREMENT, name TEXT, age INTEGER );", createStatement );
        }
		
		[Test]
		public function testInsert ( ) : void
		{
			var sql : String = table.sql.insert ( cat );
            assertEquals ( "INSERT INTO Cat ( id, name, age ) VALUES ( 0, '2B', 2 );\n", sql );
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
        
        [Test]
        public function testSelect ( ) : void
        {
            var select : String = table.sql.select ( and ( eq ( "id", 1 ), eq ( "id", 1 ) ) ); 
            trace ( select );
        }
	}
}