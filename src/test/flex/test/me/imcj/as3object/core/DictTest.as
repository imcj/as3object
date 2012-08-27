package test.me.imcj.as3object.core {
import me.imcj.as3object.core.Dict;

import org.flexunit.asserts.assertFalse;
import org.flexunit.asserts.assertTrue;

public class DictTest
{
    public var dict : Dict;
    
    [Before]
    public function setUp():void
    {
        dict = new Dict ( );
        
        dict.add ( "name", "2B" );
        dict.add ( "age", 2 );
    }
    
    [After]
    public function tearDown():void
    {
    }
    
    [Test]
    public function testHasArray ( ) : void
    {
        assertTrue ( dict.hasArray ( [ "name", "age" ] ) );
        assertFalse ( dict.hasArray ( [ "name", "height" ] ) );
    }
}
}