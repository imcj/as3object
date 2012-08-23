package test.me.imcj.as3proceeding
{
    import flash.events.Event;
    
    import me.imcj.as3proceeding.AS3ProceedingResponder;
    import me.imcj.as3proceeding.call;
    import me.imcj.as3proceeding.parallel;
    
    import mx.rpc.IResponder;
    
    import org.flexunit.asserts.assertTrue;
    import org.flexunit.async.Async;
    import me.imcj.as3object.AS3ObjectResponder;

    public class TestParallel
    {		
        public var testParallelStart : Number;
        public var testParallelEnd   : Number;
        
        [Before]
        public function setUp():void
        {
        }
        
        [After]
        public function tearDown():void
        {
        }

        [Test(async)]
        public function testParallel ( ) : void
        {
            var responder : IResponder  = new AS3ProceedingResponder ( null, null );
            var t1 : Timeout = new Timeout ( 10 );
            var t2 : Timeout = new Timeout ( 20 );
            
            testParallelStart = ( new Date ( ) ).time;
            
            var asyncResponder : IResponder = Async.asyncResponder ( this, new AS3ObjectResponder ( callbackTestParallel ), 10 );
            parallel (
                [
                    call ( t1.begin, responder ),
                    call ( t2.begin, responder )
                ],
                asyncResponder
            )
        }
        
        [Test(async)]
        public function testParallelWithEvent ( ) : void
        {
            var responder : IResponder  = new AS3ProceedingResponder ( null, null );
            var t1 : Timeout = new Timeout ( 10 );
            var t2 : Timeout = new Timeout ( 20 );
            
            testParallelStart = ( new Date ( ) ).time;
            
            var asyncFunction : Function = Async.asyncHandler ( this, eventTestParallel, 10 );
            parallel (
                [
                    call ( t1.begin, responder ),
                    call ( t2.begin, responder )
                ]
            ).addEventListener ( Event.COMPLETE, asyncFunction );
        }
        
        protected function eventTestParallel ( event : Event, passThroughData : Object ) : void
        {
        }
        
        protected function callbackTestParallel ( data : Object ) : void
        {
            testParallelEnd = ( new Date ( ) ).time;
            assertTrue ( testParallelEnd - testParallelStart < 30 );
        }
    }
}
import flash.events.TimerEvent;
import flash.utils.Timer;

import mx.rpc.IResponder;

class Timeout
{
    private var _timer     : Timer;
    private var _responder : IResponder;
    
    public function Timeout ( value : Number )
    {
        _timer = new Timer ( value, 1 );
        _timer.addEventListener ( TimerEvent.TIMER_COMPLETE, handlerTimerComplete );
    }
    
    protected function handlerTimerComplete ( event : TimerEvent ) : void
    {
        _responder.result ( "" );
    }
    
    public function begin ( responder : IResponder ) : void
    {
        _responder = responder;
        _timer.start ( );
    }
}