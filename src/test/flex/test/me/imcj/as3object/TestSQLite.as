package test.me.imcj.as3object 
{
	import flexunit.framework.Assert;
	
	import me.imcj.as3object.Order;
	import me.imcj.as3object.SQL;
	import me.imcj.as3object.Table;
	import me.imcj.as3object.expression.and;
	import me.imcj.as3object.expression.eq;
	import me.imcj.as3object.fixture.Cat;
	import me.imcj.as3object.sqlite.SQLiteTable;
	
	import org.as3commons.reflect.Type;
	import org.flexunit.asserts.assertEquals;

	public class TestSQLite
	{
		public var table  : SQL;
		public var cat : Cat;
		
		[Before]
		public function setUp():void
		{
			table = new SQLiteTable ( Type.forClass ( Cat ) );
			
			cat = new Cat ( );
			cat.name = "2B";
			cat.setAge ( 2 );
		}
		
		[After]
		public function tearDown():void
		{
		}
        
        [Test]
        public function testCreateStatement ( ) : void
        {
            var createStatement : String = table.creationStatement ( );
            trace ( createStatement );
            assertEquals ( "CREATE TABLE Cat ( id Integer PRIMARY KEY asc AUTOINCREMENT, name TEXT, age Integer );", createStatement );
        }
		
		[Test]
		public function testInsert ( ) : void
		{
			var sql : String = table.insert ( cat );
            trace ( sql );
            Assert.assertTrue ( "INSERT INTO Cat ( id, name, age ) VALUES  ( NULL, '2B', 2 );", sql );
		}
		
		[Test]
		public function testInsertArray ( ) : void
		{
			var cat2 : Cat = new Cat ( );
			cat2.name = "Xiao Hua";
			cat2.setAge ( 2 );
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
        
        [Test]
        public function testOrder ( ) : void
        {
            var select : String = table.select ( and ( eq ( "id", 1 ), eq ( "id", 1 ) ), [ Order.asc ( "id" ) ] );
            trace ( "Order:" );
            trace ( select );
        }
	}
}