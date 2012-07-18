package me.imcj.as3object
{
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;
    
    import me.imcj.as3object.expression.Expression;
    import me.imcj.as3object.responder.SelectResponder;
    
    import mx.rpc.IResponder;
    
    public class CriteriaImplement extends EventDispatcher implements Criteria
    {
        protected var _expressions : Array = new Array ( );
        protected var _orders : Array = new Array ( );
        protected var _connection:Connection;
        protected var _responder:IResponder;
        protected var _table : Table;
        
        public function CriteriaImplement ( table : Table, connection : Connection, target : IEventDispatcher = null )
        {
            _table = table;
            _connection = connection
            super ( target );
        }
        
        public function add ( expression : Expression ) : Criteria
        {
            _expressions[_expressions.length] = expression;
            return this;
        }
        
        public function addOrder ( order : Order ) : Criteria
        {
            _orders[_orders.length] = order;
            return this;
        }
        
        public function list ( responder : IResponder ) : void
        {
            var statement : Statement = _connection.createStatement ( _table.select ( Expression.and ( _expressions ), _orders ) );
            var selectResponder : SelectResponder = new SelectResponder ( _table, responder );
            statement.execute ( selectResponder );
        }
        
        public function setLimit ( min : int, max : int ) : Criteria
        {
            return null;
        }
        
        public function setMaxResults(max:int):Criteria
        {
            return null;
        }
    }
}