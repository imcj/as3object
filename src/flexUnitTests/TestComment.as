package flexUnitTests
{
    import me.imcj.as3object.AS3ObjectResponder;
    import me.imcj.as3object.fixture.Comment;
    
    import org.flexunit.asserts.assertEquals;

    public class TestComment extends TestCommentBase
    {
        [Test(async)]
        public function testComment ( ) : void
        {
            criteria.list (
                new AS3ObjectResponder (
                    function ( comment : Comment ) : void
                    {
                        assertEquals ( 1, comment.id );
                        assertEquals ( 1, Comment ( comment.children[0] ).parent.id );
                    }
                ) );
        }
        
        [Test(async)]
        public function testAddComment ( ) : void
        {
        }
    }
}