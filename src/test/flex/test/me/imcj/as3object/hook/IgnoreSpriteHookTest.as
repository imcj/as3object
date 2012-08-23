package test.me.imcj.as3object.hook
{
    import me.imcj.as3object.Table;
    import me.imcj.as3object.hook.Hook;
    import me.imcj.as3object.hook.IgnoreSpriteHook;
    import me.imcj.as3object.sqlite.SQLiteTable;
    
    import org.as3commons.reflect.Type;
    
    import test.me.imcj.as3object.fixture.GameObject;

public class IgnoreSpriteHookTest
{
    public var hook  : Hook;
    public var data  : Object;
    public var table : Table;
    
    [Before]
    public function setUp ( ) : void
    {
        table = new SQLiteTable ( Type.forClass ( GameObject ) );
        data = {
            "table": table
        };
        hook  = new IgnoreSpriteHook ( );
    }
    
    [After]
    public function tearDown():void
    {
    }
    
    [Test]
    public function testHook ( ) : void
    {
        hook.execute ( data );
//        assertFalse ( table.hasField ( "accessibilityProperties" ) );
    }
}
}