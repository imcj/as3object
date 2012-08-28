package me.imcj.as3object
{
    import flash.events.Event;
    import flash.events.EventDispatcher;
    
    import me.imcj.as3object.expression.Expression;
    import me.imcj.as3object.responder.ResponderCreationStatement;
    import me.imcj.as3object.responder.ResponderInsert;
    import me.imcj.as3object.sqlite.responder.CreationStatementResponder;
    
    import mx.rpc.IResponder;
    
    public class Repository extends EventDispatcher implements AsyncRepository
    {
        private var _connection : Connection;
        protected var cache : TableCache;
        
        public function Repository ( connection : Connection, cache : TableCache )
        {
            this.cache = cache;
            _connection = connection;
        }
        
        public function add ( object : Object, responder : IResponder ) : Object
        {
            var text : String = cache.getWithObject ( object ).insert ( object );
            var statement : Statement = _connection.createStatement ( text );
            statement.execute ( new ResponderInsert ( object, responder ) );
            
            return object;
        }
        
        public function update(object:Object, responder:IResponder):void
        {
            var table : Table = Facade.instance.cache.getWithObject ( object );
            var expression : Expression;
            var primary : String = table.primaryKey.name;
            
            if ( primary )
                expression = Expression.eq ( primary, primary );
                
            var text : String = table.update ( object, expression );
            var statement : Statement = _connection.createStatement ( text );
            statement.execute ( new ResponderInsert ( object, responder ) );
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
            var text : String = cache.getWithObject ( object ).createTable ( ifNotExists );
            var statement : Statement = _connection.createStatement ( text );
            statement.execute ( new ResponderCreationStatement ( responder ) );
        }
    }
}