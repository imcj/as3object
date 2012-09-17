package test.me.imcj.as3object.factory {
    
import me.imcj.as3object.Column;
import me.imcj.as3object.Table;
import me.imcj.as3object.TableFactory;
import me.imcj.as3object.core.Dict;

import org.flexunit.asserts.assertNotNull;

import test.me.imcj.as3object.fixture.Cat;
    
public class ColumnFactoryImplTest
{
    public var table : Table;
    
    [Before]
    public function setUp():void
    {
        table = TableFactory.createFactory ( ).create ( Cat );
    }
    
    [Test]
    public function testConstrator ( ) : void
    {
        
        var id   : Column = table.getColumn ( "id" )   as Column;
        var age  : Column = table.getColumn ( "age" )  as Column;
        var food : Column = table.getColumn ( "food" ) as Column;
        
        assertNotNull ( id );
        assertNotNull ( age );
        assertNotNull ( food );
    }
    
}

}