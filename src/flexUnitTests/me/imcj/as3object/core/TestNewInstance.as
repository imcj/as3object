package flexUnitTests.me.imcj.as3object.core
{
    import me.imcj.as3object.core.newInstance;
    import me.imcj.as3object.fixture.Blog;
    
    import org.flexunit.asserts.assertEquals;

    public class TestNewInstance
    {		
        [Before]
        public function setUp():void
        {
        }
        
        [After]
        public function tearDown():void
        {
        }
        
        [Test]
        public function testNewInstance ( ) : void
        {
            var blog : Blog = newInstance ( Blog, { "subject" : "First blog" } ) as Blog;
            assertEquals ( "First blog", blog.subject );
        }
        
    }
}