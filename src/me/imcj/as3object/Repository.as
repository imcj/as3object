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
        private var _table : Table;
        private var _connection : Connection;
        
        public function Repository ( table : Table, connection : Connection )
        {
            _table = table;
            _connection = connection;
        }
        
        public function add ( object : Object, responder : IResponder ) : Object
        {
            var table : Table = Facade.instance.getTable ( object );
            var text : String = table.insert ( object );
            var statement : Statement = _connection.createStatement ( text );
            statement.execute ( new ResponderInsert ( object, responder ) );
            
            return object;
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
            var table : Table = Facade.instance.getTable ( object );
            var text : String = table.creationStatement ( ifNotExists );
            var statement : Statement = _connection.createStatement ( text );
            statement.execute ( new ResponderCreationStatement ( responder ) );
        }
    }
}