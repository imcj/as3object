package test.me.imcj.as3object
{
    import me.imcj.as3object.Config;
    import me.imcj.as3object.Facade;
    
    import test.me.imcj.as3object.fixture.Blog;
    import test.me.imcj.as3object.fixture.Comment;

    public class DMLTest
    {
        public var facade : Facade;
        
        [Before]
        public function setUp():void
        {
            facade = Facade.instance;
            facade.config = Config.createInMemory ( );
        }
        
        [After]
        public function tearDown():void
        {
        }
        
        [Test]
        public function testInsert ( ) : void
        {
            var blog : Blog = new Blog ( );
            blog.subject = "The first.";
            
            facade.save ( blog );
        }

        [Test]
        public function testInsertBeforeSaveForeign ( ) : void
        {
            var blog : Blog = new Blog ( );
            blog.subject = "The first.";
            blog.id = 1;
            
            var comment : Comment = new Comment ( );
            comment.message = "Comment #1.";
            comment.blog = blog;
            
            facade.save ( comment );
        }
    }
}