package me.imcj.as3object.responder
{
    import me.imcj.as3object.Responder;
    import me.imcj.as3object.Result;
    
    import mx.rpc.IResponder;
    
    public class ResponderInsert implements Responder
    {
        protected var _object : Object;
        protected var _responder : IResponder;
        
        public function ResponderInsert ( object : Object, responder : IResponder )
        {
            _object = object;
            _responder = responder;
        }
        
        public function result ( data : Result ) : void
        {
            if ( _object.hasOwnProperty ( "id" ) && data.lastInsertRowID )
                _object["id"] = data.lastInsertRowID;
            
            _responder.result ( _object );
        }
        
        public function fault(info:Object):void
        {
            trace ( info.message );
        }
    }
}