package me.imcj.as3object.responder
{
    import flash.net.Responder;
    
    import mx.rpc.IResponder;

    public class AS3ObjectResponder extends Responder implements IResponder
    {
        // TODO Fault和Result方法抛没有实现的异常
        public function AS3ObjectResponder ( externalResult : Function = null, externalFault = null )
        {
            if ( externalResult && externalFault )
                super ( externalResult, externalFault );
            else
                super ( result, fault );
        }
        
        public function fault ( info : Object ) : void
        {
        }
        
        public function result ( data : Object ) : void
        {
        }
    }
}