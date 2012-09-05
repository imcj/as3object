package test.me.imcj.as3object {

import com.adobe.cairngorm.task.SequenceTask;
import com.adobe.cairngorm.task.Task;
import com.adobe.cairngorm.task.TaskEvent;

import flash.events.Event;

import me.imcj.as3object.AS3Object;
import me.imcj.as3object.AsyncRepository;
import me.imcj.as3object.Facade;
import me.imcj.as3object.task.CreateTable;
import me.imcj.as3proceeding.call;
import me.imcj.as3proceeding.responder;
import me.imcj.as3proceeding.squence;

import mx.rpc.IResponder;

import org.flexunit.asserts.assertTrue;
import org.flexunit.async.Async;

import test.me.imcj.as3object.fixture.Blog;
import test.me.imcj.as3object.fixture.Comment;

public class POAOTest
{
    public var facade : Facade;
    
    [Before(async)]
    public function setUp():void
    {
        var repository : AsyncRepository;
        facade = Facade.instance;
        facade.useDefaultConfig ( );
        
        var task : SequenceTask = new SequenceTask ( );
        task.addChild ( new CreateTable ( Blog ) );
        task.addChild ( new CreateTable ( Comment ) );
        task.start ( );
        
        Async.proceedOnEvent ( this, task, TaskEvent.TASK_COMPLETE );
    }
    
    [After]
    public function tearDown():void
    {
    }
    
    [Test(async)]
    public function testPOAOAdd ( ) : void
    {
        var blog : Blog = Blog ( facade.create ( Blog, { "subject" : "First blog" } ) );
        blog.addEventListener ( AS3Object.ADD_SUCCESS, Async.asyncHandler ( this, function ( event : Event, passThroughData : Object ) : void { assertTrue ( blog.id > 0 ); }, 10 ) );
        blog.dispatchEvent ( new Event ( AS3Object.SAVE ) );
    }
    
    [Test(async)]
    public function testPOAOAddNoExplicitCallDispatch ( ) : void
    {
        var blog : Blog = Blog ( facade.create ( Blog, { "subject" : "First blog" } ) );
        var comment : Comment = Comment ( facade.create ( Comment, { "blog" : blog, "message" : "#1 Message" } ) );
        
        blog.comments.addItem ( comment );
        
        comment.addEventListener (
            AS3Object.ADD_SUCCESS,
            Async.asyncHandler (
                this,
                function ( event : Event, passThroughData : Object ) : void
                {
                    assertTrue ( comment.id > 0 );
                },
                10 ) );
    }
    
    [Test(async)]
    public function testUpdate ( ) : void
    {
        var blog : Blog = Blog ( facade.create ( Blog, { "subject" : "First blog" } ) );
        var comment : Comment = Comment ( facade.create ( Comment, { "blog" : blog, "message" : "#1 Message", "id" : 1 } ) );
        
//        blog.comments.addItem ( comment );
        comment.message = "#1 message modified.";
        comment.dispatchEvent ( new Event ( AS3Object.COMMIT ) );
        
        comment.addEventListener (
            AS3Object.UPDATE_SUCCESS,
            Async.asyncHandler (
                this,
                function ( event : Event, passThroughData : Object ) : void
                {
                },
                10 ) );
    }
}
}