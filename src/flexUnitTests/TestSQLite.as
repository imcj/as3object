package flexUnitTests
{
	import flexunit.framework.Assert;
	
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
            var createStatement : String = table.creationStatement ( );
            assertEquals ( "CREATE TABLE Cat ( id INTEGER PRIMARY KEY asc AUTOINCREMENT, name TEXT, age INTEGER );", createStatement );
        }
		
		[Test]
		public function testInsert ( ) : void
		{
			var sql : String = table.insert ( cat );
            Assert.assertTrue ( 0 < sql.length );
		}
		
		[Test]
		public function testInsertArray ( ) : void
		{
			var cat2 : Cat = new Cat ( );
			cat2.name = "Xiao Hua";
			cat2.age  = 1;
			var sql : String = table.insert ( [ cat, cat2 ] );
			Assert.assertTrue ( 0 < sql.length );
		}
		
		[Test]
		public function testRemove ( ) : void
		{
//			var sql : String = table.remove ( cat );
		}
		
		[Test]
		public function testUpdate ( ) : void
		{
//			var sql : String = table.update ( cat );
		}
        
        [Test]
        public function testSelect ( ) : void
        {
            var select : String = table.select ( and ( eq ( "id", 1 ), eq ( "id", 1 ) ) ); 
            trace ( select );
        }
	}
}