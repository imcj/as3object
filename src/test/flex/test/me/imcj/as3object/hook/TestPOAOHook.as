package test.me.imcj.as3object.hook
{
    import flash.events.Event;
    
    import me.imcj.as3object.AS3ObjectResponder;
    import me.imcj.as3object.AsyncRepository;
    import me.imcj.as3object.Config;
    import me.imcj.as3object.Facade;
    import me.imcj.as3object.Table;
    import test.me.imcj.as3object.fixture.Blog;
    import test.me.imcj.as3object.fixture.Comment;
    import me.imcj.as3object.hook.impl.POAOHook;
    import me.imcj.as3proceeding.AS3ProceedingResponder;
    import me.imcj.as3proceeding.SequenceImpl;
    import me.imcj.as3proceeding.call;
    import me.imcj.as3proceeding.squence;
    
    import mx.events.CollectionEvent;
    
    import org.flexunit.async.Async;

	[Ignore]
    public class TestPOAOHook
    {		
        public var poaoHook : POAOHook;
        public var table : Table;
        public var blog : Blog;
        public var comment : Comment;
        public var facade : Facade = Facade.instance;
        public var seq : SequenceImpl;
        
        [Before(async)]
        public function setUp():void
        {
            Facade.instance.config = Config.createInMemory ( );
            poaoHook = new POAOHook ( );
            blog  = new Blog ( );
            comment = new Comment ( );
            
            seq = squence (
                [
                    call ( facade.createTable, Blog, new AS3ProceedingResponder ( null, null ), true ),
                    call ( facade.createTable, Comment, new AS3ProceedingResponder ( null, null ), true )
                ]
            );
            Async.proceedOnEvent ( this, seq, Event.COMPLETE );
        }
        
        protected function createRepository ( repository : AsyncRepository ) : void
        {
            seq.addEventListener ( Event.COMPLETE, createTableComplete );
        }
        
        protected function createTableComplete(event:Event):void
        {
            seq.dispatchEvent ( new Event ( Event.COMPLETE ) );
        }
        
        [After]
        public function tearDown():void
        {
        }
        
        [Test(async)]
        public function testExecuteAddWithOutRelation ( ) : void
        {
            var asyncHandler : Function = Async.asyncHandler ( this, null, 10 );
            blog.addEventListener ( "PERSISTENCE_ADDED", asyncHandler );
            
            poaoHook.execute ( { "table" : table, "instance" : blog } );
            blog.dispatchEvent ( new Event ( "PERSISTENCE_ADD" ) );
        }
        
        [Test(async)]
        public function testExecuteAdd ( ) : void
        {
            blog.subject = " #1 blog";
            comment.message = "#1 message";
            
            var asyncHandler : Function = Async.asyncHandler ( this, null, 10 );
            comment.addEventListener ( "PERSISTENCE_ADDED", asyncHandler );
            
            poaoHook.execute ( { "table" : table, "instance" : blog } );
            
            trace ( blog.comments.hasEventListener(CollectionEvent.COLLECTION_CHANGE));
            blog.comments.addItem ( comment );
        }
        
        [Test(async)]
        public function testExecuteUpdate ( ) : void
        {
            var asyncHandler : Function = Async.asyncHandler ( this, null, 10 );
            blog.addEventListener ( "PERSISTENCE_UPDATED", asyncHandler );
            
            blog.subject = "#1 Title";
        }
        
        [Test(async)]
        public function testExecuteDeleteWithOutRelation ( ) : void
        {
            poaoHook.execute ( { "table" : table, "instance" : blog } );
            
            var asyncHandler : Function = Async.asyncHandler ( this, null, 10 );
            blog.addEventListener ( "PERSISTENCE_DELETED", asyncHandler );
            blog.dispatchEvent ( new Event ( "PERSISTENCE_DELETE" ) );
        }
        
        [Test]
        public function testExecuteDelete ( ) : void
        {
            poaoHook.execute ( { "table" : table, "instance" : blog } );
            
            comment.message = "#1 message";
            blog.comments.addItem ( comment );
            
            var asyncHandler : Function = Async.asyncHandler ( this, null, 10 );
            comment.addEventListener ( "PERSISTENCE_DELETED", asyncHandler );
            
            blog.comments.removeItemAt ( blog.comments.getItemIndex ( comment ) );
        }
    }
}