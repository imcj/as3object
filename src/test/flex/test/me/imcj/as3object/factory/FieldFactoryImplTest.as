package test.me.imcj.as3object.factory {
    
import me.imcj.as3object.Field;
import me.imcj.as3object.core.Dict;
import me.imcj.as3object.factory.FieldFactory;
import me.imcj.as3object.factory.FieldFactoryImpl;
import me.imcj.as3object.fixture.Cat;

import org.as3commons.reflect.Type;
import org.flexunit.asserts.assertNotNull;
import org.flexunit.asserts.assertTrue;
    
public class FieldFactoryImplTest
{
    public var factory : FieldFactory;
    
    [Before]
    public function setUp():void
    {
        factory = new FieldFactoryImpl ( Type.forClass ( Cat ) );
    }
    
    [Test]
    public function testConstrator ( ) : void
    {
        var fields : Dict = factory.fields;
        
        var id   : Field = fields.get ( "id" )   as Field;
        var age  : Field = fields.get ( "age" )  as Field;
        var food : Field = fields.get ( "food" ) as Field;
        
        assertNotNull ( id );
        assertNotNull ( age );
        assertNotNull ( food );
    }
    
}

}