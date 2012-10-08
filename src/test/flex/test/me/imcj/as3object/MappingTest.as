package test.me.imcj.as3object
{
    import as3.sql.Types;
    
    import me.imcj.as3object.Mapping;
    
    import org.as3commons.reflect.Type;
    import org.flexunit.asserts.assertTrue;

    public class MappingTest
    {
        public var mapping : Mapping;
        
        [Before]
        public function setUp():void
        {
            mapping = new Mapping ( );
        }
        
        [After]
        public function tearDown():void
        {
        }
        
        [Test]
        public function testGetColumnTypeWithType ( ) : void
        {
            var sqlType : String = mapping.getColumnTypeWithType ( Type.forClass ( String ).fullName );
            assertTrue ( sqlType, mapping.dialect.get ( Types.CHAR.toString ( ) ) );
        }
    }
}