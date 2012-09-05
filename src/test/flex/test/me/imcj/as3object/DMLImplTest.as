package test.me.imcj.as3object {
import flash.display.Sprite;

import me.imcj.as3object.Config;
import me.imcj.as3object.Facade;
import me.imcj.as3object.Table;
import me.imcj.as3object.TableCache;
import me.imcj.as3object.TableFactory;
import me.imcj.as3object.expression.eq;
import me.imcj.as3object.hook.HookManager;
import me.imcj.as3object.hook.impl.HookManagerImpl;

import org.flexunit.asserts.assertEquals;

import test.me.imcj.as3object.fixture.Cat;

public class DMLImplTest
{
    public var tableFactory : TableFactory;
    public var table : Table;
    
    [Before]
    public function setUp():void
    {
        var config : Config = Config.createInMemory ( );
        var tableCache : TableCache = new TableCache ( );
        tableFactory = new TableFactory ( config, tableCache );
        
        var hookManager : HookManager = HookManagerImpl.create ( config, tableFactory, tableCache );
        tableFactory.hook = hookManager;
        table = tableFactory.create ( Sprite );
    }
    
    [After]
    public function tearDown():void
    {
    }
    
    [Test]
    public function testInsert ( ) : void
    {
        var sp : Sprite = new Sprite ( );
        sp.name = "SP1";
        
        var sql : String = table.dml.insert ( [ sp ]);
        
        assertEquals ( "INSERT INTO Sprite ( y, z, width, rotation, height, name, x, alpha ) VALUES  ( '0', '0', '0', '0', '0', 'SP1', '0', '1' );",
            sql );
    }
    
    [Test]
    public function testUpdate ( ) : void
    {
        var catTable : Table = tableFactory.create ( Cat );
        var cat : Cat = new Cat ( );
        cat.id = 1;
        cat.name = "2B";
        cat.setAge ( 2 );
        
        var sql : String = catTable.dml.update ( cat, eq ( "id", 1 ) );
        assertEquals ( "UPDATE Cat SET id = '1', name = '2B', age = '2' WHERE id = 1", sql );
    }
}

}