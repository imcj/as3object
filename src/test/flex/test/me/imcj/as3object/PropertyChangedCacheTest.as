package test.me.imcj.as3object {
    
import me.imcj.as3object.PropertyChangedCache;
import me.imcj.as3object.fixture.Cat;

public class PropertyChangedCacheTest
{
    public var changed : PropertyChangedCache;
    
    [Before]
    public function setUp():void
    {
        changed = new PropertyChangedCache ( );
    }
    
    [After]
    public function tearDown():void
    {
    }
    
    [Test]
    public function testPush ( ) : void
    {
        var cat : Cat = new Cat ( );

        changed.push ( cat, "name" );
        changed.push ( cat, "age" );
    }
}

}