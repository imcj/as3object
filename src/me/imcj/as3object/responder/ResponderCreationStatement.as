package me.imcj.as3object.responder
{
    import me.imcj.as3object.Responder;
    import me.imcj.as3object.Result;
    
    import mx.rpc.IResponder;

    public class ResponderCreationStatement implements Responder
    {
        protected var _responder : IResponder;
        
        public function ResponderCreationStatement ( responder : IResponder )
        {
            _responder = responder;
        }
        
        public function result ( data : Result ) : void
        {
            _responder.result ( "success" );
        }
        
        public function fault(info:Object):void
        {
            trace ( info.message );
        }
    }
}