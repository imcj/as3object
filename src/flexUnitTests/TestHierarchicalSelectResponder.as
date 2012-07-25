package flexUnitTests
{
    import flash.data.SQLResult;
    
    import me.imcj.as3object.AS3ObjectResponder;
    import me.imcj.as3object.Table;
    import me.imcj.as3object.fixture.Comment;
    import me.imcj.as3object.sqlite.SQLiteHierarchicalTable;
    import me.imcj.as3object.sqlite.SQLiteTable;
    import me.imcj.as3object.sqlite.responder.HierarchicalSelectResponder;
    
    import org.as3commons.reflect.Type;
    import org.flexunit.asserts.assertEquals;

    public class TestHierarchicalSelectResponder
    {
        public var responder : HierarchicalSelectResponder;
        
        [Before]
        public function setUp():void
        {
            var table : SQLiteTable = new SQLiteHierarchicalTable ( Type.forClass ( Comment ) );
            responder = new HierarchicalSelectResponder ( table, new AS3ObjectResponder ( testResultCallback ) );
        }
        
        [After]
        public function tearDown():void
        {
        }
        
        [Test]
        public function testResult ( ) : void
        {
            var data : Array = [
                { "id" : 1, "message" : "1" },
                { "id" : 2, "parent"  : 1, "message" : "2" },
                { "id" : 3, "parent"  : 2, "message" : "3" }
            ];
            
            responder.result ( new SQLResult ( data ) );
        }
        
        public function testResultCallback ( comment : Comment ) : void
        {
            var comment1 : Comment = comment;
            var comment2 : Comment = Comment ( comment1.getChildren ( comment1 )[0] );
            var comment3 : Comment = Comment ( comment2.getChildren ( comment2 )[0] );
            
            assertEquals ( 1, comment1.id );
            assertEquals ( 2, comment2.id );
            assertEquals ( 3, comment3.id );
        }
    }
}