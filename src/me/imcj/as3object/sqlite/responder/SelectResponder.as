package me.imcj.as3object.sqlite.responder
{
    import flash.data.SQLResult;
    import flash.errors.SQLError;
    import flash.net.Responder;
    
    import me.imcj.as3object.Facade;
    import me.imcj.as3object.sqlite.SQLiteTable;
    
    import mx.collections.ArrayCollection;
    import mx.controls.treeClasses.DefaultDataDescriptor;
    import mx.rpc.IResponder;
    
    public class SelectResponder extends Responder
    {
        //    static protected var _facade : Facade = Facade.instance;
        
        protected var _responder : IResponder;
        protected var _table:SQLiteTable;
        
        public function SelectResponder ( table : SQLiteTable, responder : IResponder )
        {
            _table = table;
            _responder = responder;
            
            super ( result, fault );
        }
        
        public function result ( result : SQLResult ) : void
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
        
        public function fault ( info : SQLError ) : void
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