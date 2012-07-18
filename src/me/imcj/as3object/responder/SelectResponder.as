package me.imcj.as3object.responder
{
    import me.imcj.as3object.Responder;
    import me.imcj.as3object.Result;
    import me.imcj.as3object.Table;
    
    import mx.rpc.IResponder;

    
    public class SelectResponder implements Responder
    {
        
        protected var _responder : IResponder;
        protected var _table : Table;
        
        public function SelectResponder ( table : Table, responder : IResponder )
        {
            _table = table;
            _responder = responder;
        }
        
        public function result ( result : Result ) : void
        {
            var objects : Array = new Array ( );
            var object  : Object;
            
            for each ( object in result.data ) {
                objects[objects.length] = create ( object );
            }
            
            _responder.result ( objects );
        }
        
        protected function create ( object : Object ) : Object
        {
            var field : String;
            var instance : Object = new _table.type.clazz ();
            
            for ( field in object )
                _table.fields.get ( field ).assignValue ( instance, object );
            
            return instance;
        }
        
        public function fault ( info : Object ) : void
        {
            if ( null != _responder.fault ) {
                try {
                    _responder.fault ( info );
                } catch ( error : Error ) {
                    _responder.result ( null );
                }
            } else
                _responder.result ( null );
        }
    }
}