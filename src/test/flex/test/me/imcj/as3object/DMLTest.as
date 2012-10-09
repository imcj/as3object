package test.me.imcj.as3object
{
    import com.adobe.cairngorm.task.SequenceTask;
    import com.adobe.cairngorm.task.TaskEvent;
    
    import me.imcj.as3object.AS3ObjectResponder;
    import me.imcj.as3object.Config;
    import me.imcj.as3object.Facade;
    
    import mx.rpc.IResponder;
    
    import org.flexunit.asserts.assertEquals;
    import org.flexunit.async.Async;
    
    import test.me.imcj.as3object.fixture.Blog;
    import test.me.imcj.as3object.fixture.Comment;
    import test.me.imcj.as3object.fixture.CreateTable;

    public class DMLTest
    {
        public var facade : Facade;
        
        [Before(async)]
        public function setUp():void
        {
            facade = Facade.instance;
            facade.config = Config.createInMemory ( );
            
            var seq : SequenceTask = new SequenceTask ( );
            seq.addChild ( new CreateTable ( Blog, facade ) );
            seq.addChild ( new CreateTable ( Comment, facade ) );
            
            Async.proceedOnEvent ( this, seq, TaskEvent.TASK_COMPLETE );
            seq.start ( );
        }
        
        [After]
        public function tearDown():void
        {
        }
        
        [Test(async)]
        public function testInsert ( ) : void
        {
            var blog : Blog = new Blog ( );
            blog.subject = "The first.";
            
            var asyncResponder : IResponder = Async.asyncResponder (
                this,
                new AS3ObjectResponder (
                    function ( blog : Blog ) : void
                    {
                        assertEquals ( 1, blog.id );
                    }
                ),
                100 );
            
            facade
                .save ( blog )
                .addResponder ( asyncResponder );
        }

        [Test(async)]
        public function testInsert2 ( ) : void
        {
            var blog : Blog = new Blog ( );
            blog.subject = "The first.";
            blog.id = 1;
            
            var comment : Comment = new Comment ( );
            comment.message = "Comment #1.";
            comment.blog = blog;
            
            var asyncResponder : IResponder = Async.asyncResponder (
                this,
                new AS3ObjectResponder (
                    function ( comment2 : Comment ) : void
                    {
                        assertEquals ( 1, comment2.id );
                    }
                ),
                100 );
            
            facade
                .save ( comment )
                .addResponder ( asyncResponder );
        }
    }
}