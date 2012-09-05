package test.me.imcj.as3object {
    
import flash.display.Sprite;

import me.imcj.as3object.Config;
import me.imcj.as3object.Table;
import me.imcj.as3object.TableCache;
import me.imcj.as3object.TableFactory;
import me.imcj.as3object.hook.HookManager;
import me.imcj.as3object.hook.impl.HookManagerImpl;

import org.flexunit.asserts.assertEquals;

import test.me.imcj.as3object.fixture.Cat;

public class DDLImplTest
{
    public var table : Table;
    public var tableFactory : TableFactory
    
    [Before]
    public function setUp():void
    {
        var config : Config = Config.createInMemory( );
        tableFactory = TableFactory.createFactory ( );
        
        table = tableFactory.create( Cat );
    }
    
    [After]
    public function tearDown():void
    {
    }
    
    [Test]
    public function testCreateTable( ) : void
    {
        var sql : String = table.ddl.createTable ( true );
        assertEquals ( "CREATE TABLE IF NOT EXISTS Cat ( id Number PRIMARY KEY AUTOINCREMENT, name TEXT, age Number, food TEXT );",
            sql );
    }
    
    [Test]
    public function testCreateSpriteTable ( ) : void
    {
        assertEquals ( "CREATE TABLE IF NOT EXISTS Dog ( y REAL, z REAL, width REAL, rotation REAL, height REAL, name TEXT, x REAL, alpha REAL );",
            tableFactory.create ( Dog ).ddl.createTable ( true ) );
    }
}

}
import flash.display.Sprite;

class Dog extends Sprite
{
    
}
