package me.imcj.as3object
{
    import flash.net.Responder;
    
    import mx.rpc.IResponder;
    
    import org.as3commons.reflect.Type;

    public class AS3ObjectResponder extends Responder implements IResponder
    {
        protected var _fault  : Function;
        protected var _result : Function;
        
        public function AS3ObjectResponder ( result : Function, fault : Function = null )
        {
            _result = result;
            _fault  = fault;
        
            super ( result, fault );
        }
        
        public function result ( data : Object ) : void
        {
            _result ( data );
        }
        
        public function fault ( info : Object ) : void
        {
            try {
                _fault ( info );
            } catch ( error : TypeError ) {
                trace ( error.message );
            }
        }
    }
}