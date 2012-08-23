package me.imcj.as3proceeding
{
    import flash.net.Responder;
    
    import mx.rpc.IResponder;

    public class AS3ProceedingResponder implements IResponder
    {
        private var _resultFunction : Array;
        private var _faultFunction  : Array;
        
        public function AS3ProceedingResponder ( paramResult : Function = null, paramStatus : Function = null )
        {
            _resultFunction = new Array ( );
            _faultFunction  = new Array ( );
            
            if ( null != paramResult )
                addResult ( paramResult );
            
            if ( null != paramStatus )
                addFault  ( paramStatus );
        }
        
        public function addResult ( func : Function ) : AS3ProceedingResponder
        {
            _resultFunction[_resultFunction.length] = func;
            return this;
        }
        
        public function addFault ( func : Function ) : AS3ProceedingResponder
        {
            _faultFunction[_faultFunction.length] = func;
            return this;
        }
        
        public function result ( data : Object ) : void
        {
            var i : int = 0, size : int = _resultFunction.length;
            for ( ; i < size; i++ )
                _resultFunction[i] ( data );
        }
        
        public function fault ( info : Object ) : void
        {
            var i : int = 0, size : int = _faultFunction.length;
            for ( ; i < size; i++ )
                _faultFunction[i] ( info );
        }
    }
}