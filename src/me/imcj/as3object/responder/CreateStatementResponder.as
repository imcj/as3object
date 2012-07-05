package me.imcj.as3object.responder
{
    import flash.net.Responder;
    
    import mx.rpc.IResponder;
    
    public class CreateStatementResponder extends Responder
    {
        private var _responder:IResponder;
        
        public function CreateStatementResponder ( responder : IResponder )
        {
            _responder = responder;
            super ( result, status );
        }
        
        public function result ( data : Object ) : void
        {
            _responder.result ( data );
        }
        
        public function status ( info : Object ) : void
        {
            
        }
    }
}