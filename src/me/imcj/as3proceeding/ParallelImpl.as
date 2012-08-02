package me.imcj.as3proceeding
{
    import flash.events.Event;
    import flash.events.EventDispatcher;
    
    import mx.rpc.IResponder;

    public class ParallelImpl extends EventDispatcher
    {
        protected var _processors       : Array;
        protected var _processorsLength : int;
        protected var _resultCounter    : int = 0;
        protected var _faultCounter     : int = 0;
        protected var _counter          : int = 0;
        protected var _responders       : Array;
        protected var _listener         : int = 0;
        
        public function ParallelImpl ( processors : Array )
        {
            _processors       = processors;
            _processorsLength = _processors.length;
            
            _responders = new Array ( );
            
            var i : int = 0, size : int = processors.length;
            var call : CallImpl;
            for ( ; i < size; i++ ) {
                call = CallImpl ( processors[i] );
                call.parallelResponder.addResult ( result ).addFault ( fault );
                call.call ( );
            }
        }
        
        public function addResponder ( responder : IResponder ) : void
        {
            _responders[_responders.length] = responder;
        }
        
        protected function increment ( ) : void
        {
            if ( _counter < _processorsLength )
                _counter += 1;
            
            if ( _processorsLength == _counter )
                notify ( );
        }
        
        protected function notify ( ) : void
        {
            if ( _responders.length > 0 )
                for each ( var responder : IResponder in _responders )
                    responder.result ( "" );
            
            if ( _listener > 0 )
                dispatchEvent ( new Event ( Event.COMPLETE ) );
        }
        
        override public function addEventListener ( type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false ) : void
        {
            _listener += 1;
            super.addEventListener ( type, listener, useCapture, priority, useWeakReference );
            
            if ( _processorsLength == _counter )
                dispatchEvent ( new Event ( Event.COMPLETE ) );
        }
        
        public function result ( data : Object ) : void
        {
            _resultCounter += 1;
            increment ( );
        }
        
        public function fault ( info : Object ) : void
        {
            _faultCounter += 1;
            increment ( );
        }
    }
}