package test.me.imcj.as3object {
    
import me.imcj.as3object.PropertyChangedCache;
import me.imcj.as3object.Table;
import me.imcj.as3object.TableCache;
import me.imcj.as3object.TableFactory;
import me.imcj.as3object.core.Dict;

import org.flexunit.assertThat;
import org.flexunit.asserts.assertEquals;
import org.hamcrest.collection.hasItem;
import org.hamcrest.core.allOf;
import org.hamcrest.object.equalTo;

import test.me.imcj.as3object.fixture.Cat;

public class PropertyChangedCacheTest
{
    // commit时修改和超时修改
    //单例
    public var changed : PropertyChangedCache;
    public var table : Table;
    
    [Before]
    public function setUp():void
    {
        var factory : TableFactory = TableFactory.createFactory();
        changed = new PropertyChangedCache ( factory.tableCache );
        table = factory.create(Cat);
    }
    
    [After]
    public function tearDown():void
    {
    }
    
    [Test]
    public function testPush ( ) : void
    {
        var cat : Cat = new Cat ( );
        
        cat.name = "2B";
        cat.id = 1;
        cat.setAge ( 2 );
        
        changed.push ( cat, "name" );
        changed.push ( cat, "age" );
        
        var properties : Array = changed.getChangedProperties ( table.name, table.getPrimary ( cat ) ).keys;
        assertEquals ( 2, properties.length );
    }
}

}