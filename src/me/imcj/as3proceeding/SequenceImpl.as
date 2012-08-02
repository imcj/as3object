package me.imcj.as3proceeding
{
    import flash.events.Event;
    import flash.events.EventDispatcher;
    
    import mx.rpc.IResponder;

    public class SequenceImpl extends EventDispatcher
    {
        protected var _processors       : Array;
        protected var _processorsLength : int;
        protected var _processorsIndex  : int = 0;
        protected var _responders       : Array;
        protected var _listener         : int = 0;
        
        public function SequenceImpl ( processors : Array )
        {
            _processors       = processors;
            _processorsLength = _processors.length;
            
            _responders = new Array ( );
            
            call ( );
        }
        
        public function addResponder ( responder : IResponder ) : void
        {
            _responders[_responders.length] = responder;
        }
        
        protected function call ( ) : void
        {
            var i : int = _processorsIndex;
            _processorsIndex += 1;
            CallImpl ( _processors[i] )
                .addIntoResponder ( result, fault )
                .call();
        }
        
        public function isComplete ( ) : Boolean
        {
            return _processorsIndex == _processorsLength;
        }
        
        protected function step ( ) : void
        {
            if ( isComplete ( ) )
                notify ( );
            else
                call ( );
        }
        
        protected function notify ( ) : void
        {
            _processorsIndex += 1;
            
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
            
            if ( _processorsLength == _processorsIndex )
                dispatchEvent ( new Event ( Event.COMPLETE ) );
        }
        
        public function result ( data : Object ) : void
        {
            step ( );
        }
        
        public function fault ( info : Object ) : void
        {
            step ( );
        }
    }
}