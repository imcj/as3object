package test.me.imcj.as3object.responder 
{
    import me.imcj.as3object.AS3ObjectResponder;
    import me.imcj.as3object.Result;
    import me.imcj.as3object.Table;
    import me.imcj.as3object.TableFactory;
    import me.imcj.as3object.responder.HierarchicalResponder;
    
    import org.flexunit.asserts.assertEquals;
    
    import test.me.imcj.as3object.fixture.Comment;

	[Ignore]
    public class HierarchicalSelectResponderTest
    {
        public var responder : HierarchicalResponder;
        
        [Before]
        public function setUp():void
        {
            var tableFactory : TableFactory = TableFactory.createFactory ( ); 
            var table : Table = tableFactory.create ( Comment );
            responder = new HierarchicalResponder ( table, new AS3ObjectResponder ( testResultCallback ), tableFactory.hook );
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
            
            responder.result ( new Result ( data ) );
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