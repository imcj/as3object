package test.me.imcj.as3object.core {
import me.imcj.as3object.core.Dict;
import me.imcj.as3object.core.KeyValue;

import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertFalse;
import org.flexunit.asserts.assertTrue;

public class DictTest
{
    public var dict : Dict;
    public var dict2 : Dict;
    [Before]
    public function setUp():void
    {
        dict = new Dict ( );
        
        dict.add ( "name", "2B" );
        dict.add ( "age", 2 );
        
        dict2 = new Dict ( );
        dict.add ( "skill", "all" );
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
    
    [Test]
    public function testRemove ( ) : void
    {
        dict.remove ( "name" );
        assertFalse ( dict.has ( "name" ) );
    }
    
    [Test]
    public function testRemoveAll ( ) : void
    {
        dict.removeAll();
        assertFalse ( dict.has ( "name" ) );
    }
    
    [Test]
    public function testClone ( ) : void
    {
        var clone : Dict = dict.clone  ( );
        assertEquals ( "2B", clone.get ( "name" ) );
        assertEquals ( 2, clone.get ( "age" ) );
        assertFalse ( clone == dict );
    }
    
    [Test]
    public function testForEach ( ) : void
    {
        var count : int = 0;
        var indexer : Function = function ( value : KeyValue ) : void
        {
            count ++;
        };
        
        dict.merge ( dict2 ).forEach ( indexer );
        assertEquals ( 3, count );
    }
}
}