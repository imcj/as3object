package test.me.imcj.as3object.hook
{
import flash.display.Sprite;

import me.imcj.as3object.Table;
import me.imcj.as3object.TableFactory;
import me.imcj.as3object.hook.impl.DefaultExcludeHook;
import me.imcj.as3object.hook.Hook;

import org.flexunit.asserts.assertTrue;

public class DefaultExcludeHookTest
{
    public var hook  : Hook;
    public var data  : Object;
    public var table : Table;
    
    [Before]
    public function setUp ( ) : void
    {
        table = TableFactory.createFactory().create(Sprite);
        data = {
            "table": table
        };
        hook  = new DefaultExcludeHook ( );
    }
    
    [After]
    public function tearDown():void
    {
    }
    
    [Test]
    public function testHookExecute ( ) : void
    {
        hook.execute ( data );
        assertTrue ( table.hasColumn ( "x" ) );
    }
}
}