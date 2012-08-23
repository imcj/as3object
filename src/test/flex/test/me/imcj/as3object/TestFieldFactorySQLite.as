package test.me.imcj.as3object
{
    import me.imcj.as3object.FieldFactory;
    import me.imcj.as3object.core.Iterator;
    import me.imcj.as3object.fixture.Cat;
    import me.imcj.as3object.sqlite.FieldFactorySQLite;
    import me.imcj.as3object.sqlite.SQLiteTable;
    import me.imcj.as3object.sqlite.field.IntegerField;
    import me.imcj.as3object.sqlite.field.RelationField;
    import me.imcj.as3object.sqlite.field.StringField;
    
    import org.as3commons.reflect.Type;
    import org.flexunit.asserts.assertEquals;
    import org.flexunit.asserts.assertTrue;

    public class TestFieldFactorySQLite
    {
        public var table : SQLiteTable;
        public var factory : FieldFactory;
        
        [Before]
        public function setUp ( ) : void
        {
            table = new SQLiteTable ( Type.forClass ( Cat ) );
            factory = new FieldFactorySQLite ( table );
        }
        
        [After]
        public function tearDown ( ) : void
        {
        }
        
        [Test]
        public function testCreate ( ) : void
        {
            factory.create ( );
            
            assertTrue ( table.fields.get ( "id" ) is IntegerField );
            assertTrue ( table.fields.get ( "name" ) is StringField );
        }
    }
}