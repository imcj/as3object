package test.me.imcj.as3object.fields
{
    import flash.utils.ByteArray;
    
    import me.imcj.as3object.fixture.Color;
    import me.imcj.as3object.sqlite.field.DateTimeField;
    
    import org.flexunit.asserts.assertEquals;

    public class TestDateTimeField
    {		
        public var field : DateTimeField;
        public var color : Color;
        
        [Before]
        public function setUp():void
        {
            color = new Color ( );
            field = new DateTimeField ( "created_at" );
        }
        
        [After]
        public function tearDown():void
        {
        }
        
        [Test]
        public function testDefaultValue ( ) : void
        {
            var buffer : ByteArray = new ByteArray ( );
            field.buildInsertValue ( buffer, color );
            
            buffer.position = 0;
            assertEquals ( "datetime()", buffer.readUTFBytes ( buffer.bytesAvailable ) );
        }
    }
}