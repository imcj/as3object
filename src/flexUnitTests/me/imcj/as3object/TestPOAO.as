package flexUnitTests.me.imcj.as3object
{
    import flash.events.Event;
    
    import me.imcj.as3object.AS3Object;
    import me.imcj.as3object.AsyncRepository;
    import me.imcj.as3object.Config;
    import me.imcj.as3object.Facade;
    import me.imcj.as3object.Repository;
    import me.imcj.as3object.fixture.Blog;
    import me.imcj.as3object.fixture.Comment;
    import me.imcj.as3proceeding.call;
    import me.imcj.as3proceeding.responder;
    import me.imcj.as3proceeding.squence;
    
    import mx.rpc.IResponder;
    
    import org.flexunit.async.Async;

    public class TestPOAO
    {
        public var facade : Facade;
        
        [Before(async)]
        public function setUp():void
        {
            var repository : AsyncRepository;
            
            facade = Facade.instance;
            facade.useDefaultConfig ( );
            
            Async.proceedOnEvent (
                this,
                squence (
                    [
                        call ( Facade.instance.createRepository, responder ( function ( _ : AsyncRepository ) : void { repository = _; trace ( "Create repository." ); } ) ),
                        call ( function ( responder1 : IResponder ) : void { repository.creationStatement ( Blog, responder1, true ); trace ( "Create blog table." ); }, responder ( ) ),
                        call ( function ( responder2 : IResponder ) : void { repository.creationStatement ( Comment, responder2, true ); trace ( "Create comment table." ); }, responder ( ) )
                    ]
                ),
                Event.COMPLETE
            );
        }
        
        [After]
        public function tearDown():void
        {
        }
        
        [Test(async)]
        public function testPOAOAdd ( ) : void
        {
            var blog : Blog = Blog ( facade.create ( Blog, { "subject" : "First blog" } ) );
            blog.addEventListener ( AS3Object.PERSISTENCE_ADDED, Async.asyncHandler ( this, function ( event : Event, passThroughData : Object ) : void {}, 10 ) );
            blog.dispatchEvent ( new Event ( AS3Object.SAVE ) );
        }
        
        [Test(async)]
        public function testPOAOAddNoExplicitCallDispatch ( ) : void
        {
            var blog : Blog = Blog ( facade.create ( Blog, { "subject" : "First blog" } ) );
            var comment : Comment = new Comment ( );
            comment.blog = blog;
            comment.message = "#1 message";
            
            blog.comments.addItem ( comment );
        }
    }
}