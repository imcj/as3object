package me.imcj.as3object
{
    import flash.events.Event;
    import flash.events.EventDispatcher;
    
    import me.imcj.as3object.expression.Expression;
    
    import mx.rpc.IResponder;
    
    public class Repository extends EventDispatcher implements AsyncRepository
    {
        private var _table:Table;
        private var _pool:ConnectionPool;
        
        public function Repository ( table : Table, pool : ConnectionPool )
        {
            _table = table;
            _pool  = pool;
            
        }
        
        public function add ( object : Object, responder : IResponder ) : Object
        {
            return null;
        }
        
        public function update(object:Object, responder:IResponder):void
        {
        }
        
        public function remove(object:Object):void
        {
        }
        
        public function find(expression:Expression, responder:IResponder):void
        {
        }
        
        public function findAll(responder:IResponder):void
        {
        }
        
        public function creationStatement(object:Object, responder:IResponder, ifNotExists:Boolean=false):void
        {
        }
    }
}