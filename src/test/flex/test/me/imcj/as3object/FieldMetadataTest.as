package test.me.imcj.as3object {
    
import flash.display.Sprite;

import me.imcj.as3object.FieldMetadata;
import me.imcj.as3object.core.Dict;

import org.as3commons.reflect.Type;

public class FieldMetadataTest
{
    public var fieldMetadata : FieldMetadata;
    
    [Before]
    public function setUp():void
    {
        var fields : Dict = new Dict ( );
        
        fieldMetadata = new FieldMetadata ( Type.forClass ( TestCat ), fields );
    }
    
    [After]
    public function tearDown():void
    {
    }
    
    [Test]
    public function testExcludeType ( ) : void
    {
        fieldMetadata.excludeType ( flash.display.Sprite );
    }
    
    [Test]
    public function testExcludeProperty ( ) : void
    {
        fieldMetadata.excludeProperty ( );
    }
    
    [Test]
    public function testIncludeType ( ) : void
    {
        
    }
    
    [Test]
    public function testIncludeProperty ( ) : void
    {
        
    }
    
    [Test]
    public function testExcludeAndIncludeTogether ( ) : void
    {
        
    }
}
}

import flash.display.Sprite;

class TestCat extends Sprite
{
    
}