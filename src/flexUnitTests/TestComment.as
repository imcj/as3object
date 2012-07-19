package flexUnitTests
{
    import me.imcj.as3object.AS3ObjectResponder;
    import me.imcj.as3object.fixture.Comment;

    public class TestComment extends TestCommentBase
    {
        [Test(async)]
        public function testComment ( ) : void
        {
            criteria.list (
                new AS3ObjectResponder (
                    function ( data : Comment ) : void
                    {
                        trace ( data );
                    }
                ) );
        }
    }
}