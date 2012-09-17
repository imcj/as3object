package test.me.imcj.as3object {
    
import flash.display.DisplayObject;
import flash.display.Sprite;

import me.imcj.as3object.TableFactory;

import org.flexunit.asserts.assertFalse;
import org.flexunit.asserts.assertTrue;
import me.imcj.as3object.Table;
    
public class TableTest
{		
    private var table:Table;
    
    [Before]
    public function setUp():void
    {
        table = TableFactory.createFactory ( ).create ( TestCat );
    }
    
    [After]
    public function tearDown():void
    {
    }
    
    [Test]
    public function testExcludeType ( ) : void
    {
        table.excludeDeclaringType ( flash.display.Sprite );
        assertFalse ( table.hasColumn ( "buttonMode" ) );
    }
    
    [Test]
    public function testExcludeProperty ( ) : void
    {
        table.excludeProperty ( "buttonMode" );
        assertFalse ( table.hasColumn ( "buttonMode" ) );
    }
    
    [Test]
    public function testIncludeType ( ) : void
    {
        table.excludeDeclaringType ( flash.display.DisplayObject );
        assertFalse ( table.hasColumn ( "width" ) );
        
        table.includeDeclaringType ( flash.display.DisplayObject );
        assertTrue ( table.hasColumn ( "width" ) );
    }
    
    [Test]
    public function testIncludeProperty ( ) : void
    {
        table.excludeProperty ( "width" );
        assertFalse ( table.hasColumn ( "width" ) );
        
        table.includeProperty ( "width" );
        assertTrue ( table.hasColumn ( "width" ) );
    }
}
}

import flash.display.Sprite;

class TestCat extends Sprite
{
    
}