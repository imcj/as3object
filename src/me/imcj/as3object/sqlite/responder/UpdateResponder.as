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
    
    public class UpdateResponder extends Responder
    {
        protected var _object    : Object;
        protected var _responder : IResponder;
        
        public function UpdateResponder ( object : Object, responder : IResponder )
        {
            _object = object;
            _responder = responder;
            
            super ( result, fault );
        }
        
        public function fault ( info : SQLError ) : void
        {
            // TODO Update fault
        }
        
        public function result ( result : SQLResult ) : void
        {
            _responder.result ( _object );
        }
    }
}