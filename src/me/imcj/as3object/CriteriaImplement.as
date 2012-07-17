package me.imcj.as3object
{
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;
    
    import me.imcj.as3object.expression.Expression;
    
    import mx.collections.ArrayCollection;
    
    public class CriteriaImplement extends EventDispatcher implements Criteria
    {
        protected var _expressions : Array = new Array ( );
        protected var _orders : Array = new Array ( );
        protected var _pool:ConnectionPool;
        protected var _type:Class;
        
        public function CriteriaImplement ( type : Class, pool : ConnectionPool, target : IEventDispatcher = null )
        {
            _type = type;
            _pool = pool;
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
        
        public function list ( responder : Responder ) : ArrayCollection
        {
            return null;
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