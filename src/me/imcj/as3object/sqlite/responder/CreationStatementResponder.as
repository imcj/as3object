package me.imcj.as3object.sqlite.responder
{
    import flash.data.SQLResult;
    import flash.errors.SQLError;
    import flash.net.Responder;
    
    import mx.rpc.IResponder;
    
    public class CreationStatementResponder extends Responder
    {
        static public const SUCCESS : String = "success";
        static public const FAILURE : String = "failure";
        
        private var _responder:IResponder;
        
        public function CreationStatementResponder ( responder : IResponder )
        {
            _responder = responder;
            
            super ( result, fault );
        }
        
        public function result ( data : SQLResult ) : void
        {
            _responder.result ( SUCCESS );
        }
        
        public function fault ( error : SQLError ) : void
        {
            _responder.fault ( FAILURE );
        }
    }
}