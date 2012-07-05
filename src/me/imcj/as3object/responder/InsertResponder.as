package me.imcj.as3object.responder
{
    import flash.data.SQLResult;
    import flash.errors.SQLError;
    import flash.net.Responder;
    
    import mx.rpc.IResponder;

    public class InsertResponder extends Responder
    {
        protected var _object    : Object;
        protected var _responder : IResponder;
        
        public function InsertResponder ( object : Object, responder : IResponder )
        {
            _object = object;
            _responder = responder;
            
            
            super ( result, fault );
        }
        
        public function fault ( info : SQLError ) : void
        {
        }
        
        public function result ( result : SQLResult ) : void
        {
            if ( _object.hasOwnProperty ( "id" ) )
                _object["id"] = result.lastInsertRowID;
            
            _responder.result ( _object );
        }
    }
}