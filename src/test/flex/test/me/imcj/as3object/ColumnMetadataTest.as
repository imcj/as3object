package test.me.imcj.as3object {
    
import flash.display.DisplayObject;
import flash.display.Sprite;

import me.imcj.as3object.ColumnMetadata;
import me.imcj.as3object.Table;
import me.imcj.as3object.TableFactory;
import me.imcj.as3object.core.Dict;

import org.as3commons.reflect.Type;
import org.flexunit.asserts.assertFalse;
import org.flexunit.asserts.assertTrue;

public class ColumnMetadataTest
{
    public var fieldMetadata : ColumnMetadata;
    public var table : Table;
    public var columns : Dict;
    
    [Before]
    public function setUp():void
    {
        table = TableFactory.createFactory ( ).create ( TestCat );
        columns = table.columns;
        
        fieldMetadata = new ColumnMetadata ( table.type, table.columns );
    }
    
    [After]
    public function tearDown():void
    {
        fieldMetadata.clear ( );
    }
     
    [Test]
    public function testExcludeType ( ) : void
    {
        fieldMetadata.excludeDeclaringType ( flash.display.Sprite );
        assertFalse ( columns.has ( "buttonMode" ) );
        fieldMetadata.clear ( );
    }
    
    [Test]
    public function testExcludeProperty ( ) : void
    {
        fieldMetadata.excludeProperty ( "buttonMode" );
        assertFalse ( columns.has ( "buttonMode" ) );
        fieldMetadata.clear ( );
    }
    
    [Test]
    public function testIncludeType ( ) : void
    {
        fieldMetadata.excludeDeclaringType ( flash.display.DisplayObject );
        assertFalse ( columns.has ( "width" ) );
        
        fieldMetadata.includeDeclaringType ( flash.display.DisplayObject );
        assertTrue ( columns.has ( "width" ) );
    }
    
    [Test]
    public function testIncludeProperty ( ) : void
    {
        fieldMetadata.excludeProperty ( "width" );
        assertFalse ( columns.has ( "width" ) );
        
        fieldMetadata.includeProperty ( "width" );
        assertTrue ( columns.has ( "width" ) );
    }
}
}

import flash.display.Sprite;

class TestCat extends Sprite
{
    
}