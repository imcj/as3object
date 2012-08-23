package test.me.imcj.as3object {
import flash.display.Sprite;

import me.imcj.as3object.Table;
import me.imcj.as3object.fixture.Dog;
import me.imcj.as3object.sqlite.SQLiteTable;

import org.as3commons.reflect.Type;
import org.flexunit.asserts.assertEquals;

public class TableTest
{		
	public var table : Table;
	
	[Before]
	public function setUp():void
	{
		table = new SQLiteTable ( Type.forClass ( Sprite ) );
	}
	
	[After]
	public function tearDown():void
	{
	}
	
    [Test]
    public function testField ( ) : void
    {
        trace ( table.getField ( "y" ) );
    }
}

}