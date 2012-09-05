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
        var columns : Dict = table.columns;
        
        var id   : Column = columns.get ( "id" )   as Column;
        var age  : Column = columns.get ( "age" )  as Column;
        var food : Column = columns.get ( "food" ) as Column;
        
        assertNotNull ( id );
        assertNotNull ( age );
        assertNotNull ( food );
    }
    
}

}