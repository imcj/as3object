package test.me.imcj.as3proceeding
{
    import flash.events.Event;
    
    import me.imcj.as3proceeding.AS3ProceedingResponder;
    import me.imcj.as3proceeding.call;
    import me.imcj.as3proceeding.parallel;
    import me.imcj.as3proceeding.responder;
    import me.imcj.as3proceeding.squence;
    
    import mx.rpc.IResponder;
    
    import org.flexunit.asserts.assertTrue;
    import org.flexunit.async.Async;
    import me.imcj.as3object.AS3ObjectResponder;

    public class TestSequence
    {		
        public var testSquenceStart : Number;
        public var testSquenceEnd   : Number;
        
        public var t1 : Timeout = new Timeout ( 10 );
        public var t2 : Timeout = new Timeout ( 20 );
        
        [Before]
        public function setUp():void
        {
        }
        
        [After]
        public function tearDown():void
        {
        }

        [Test(async)]
        public function testSquence ( ) : void
        {
            testSquenceStart = ( new Date ( ) ).time;
            
            var asyncResponder : IResponder = Async.asyncResponder ( this, new AS3ObjectResponder ( callbackTestSquence ), 50 );
            squence (
                [
                    call ( t1.begin, responder ( ) ),
                    call ( t2.begin, responder ( ) )
                ],
                asyncResponder
            )
        }
        
        [Test(async)]
        public function testSquenceWithEvent ( ) : void
        {
//            var responder : IResponder  = new AS3ProceedingResponder ( null, null );
            
            testSquenceStart = ( new Date ( ) ).time;
            
            var asyncFunction : Function = Async.asyncHandler ( this, eventTestSquence, 50 );
            squence (
                [
                    call ( t1.begin, responder ( ) ),
                    call ( t2.begin, responder ( ) )
                ]
            ).addEventListener ( Event.COMPLETE, asyncFunction );
        }
        
        protected function eventTestSquence ( event : Event, passThroughData : Object ) : void
        {
            testSquenceEnd = ( new Date ( ) ).time;
            var processTime : Number = testSquenceEnd - testSquenceStart;
            assertTrue ( processTime >= t1.end + t2.end );
        }
        
        protected function callbackTestSquence ( data : Object ) : void
        {
            testSquenceEnd = ( new Date ( ) ).time;
            var processTime : Number = testSquenceEnd - testSquenceStart;
            assertTrue ( processTime >= t1.end + t2.end );
        }
        
        [Test(async)]
        public function testSquence2 ( ) : void
        {
            squence (
                [
                    call (
                        parallel,
                        [
                            call ( t1.begin, responder ( ) ),
                            call ( t2.begin, responder ( ) )
                        ],
                        responder ( )
                    ),
                    call (
                        parallel,
                        [
                            call ( new Timeout ( 10 ).begin, responder ( ) ),
                            call ( new Timeout ( 10 ).begin, responder ( ) )
                        ],
                        responder ( )
                    )
                ]
           )
            .addEventListener ( Event.COMPLETE, Async.asyncHandler ( this, null, 1000 ) );
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
    private var _value     : Number;
    
    public var start : Number;
    public var end   : Number;
    
    public function Timeout ( value : Number )
    {
        _value = value;
        _timer = new Timer ( value, 1 );
        _timer.addEventListener ( TimerEvent.TIMER_COMPLETE, handlerTimerComplete );
        
    }
    
    protected function handlerTimerComplete ( event : TimerEvent ) : void
    {
        end = ( new Date ( ) ).time - start;
        _responder.result ( "" );
    }
    
    public function begin ( responder : IResponder ) : void
    {
        trace ( _value );
        _responder = responder;
        _timer.start ( );
        start = ( new Date ( ) ).time;
    }
}