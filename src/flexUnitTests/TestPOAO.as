package flexUnitTests
{
    import me.imcj.as3object.fixture.Blog;
    import me.imcj.as3object.fixture.Comment;

    public class TestPOAO
    {
        public var blog : Blog;
        
        [Before]
        public function setUp():void
        {
            blog = new Blog ( );
        }
        
        [After]
        public function tearDown():void
        {
        }
        
        [Test]
        public function testSave ( ) : void
        {
//            blog.save ( );
        }
        
        [Test]
        public function testComment ( ) : void
        {
            var comment : Comment = new Comment ( );
            comment.message = "#1 comment";
            
            blog.comments.addItem ( comment  );
        }
    }
}