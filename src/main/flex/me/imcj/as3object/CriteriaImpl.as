package me.imcj.as3object {
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;

import me.imcj.as3object.expression.Expression;
import me.imcj.as3object.hook.HookManager;
import me.imcj.as3object.responder.HierarchicalResponder;
import me.imcj.as3object.responder.SelectResponder;

import mx.rpc.IResponder;

public class CriteriaImpl extends EventDispatcher implements Criteria
{
    protected var _expressions : Array = new Array ( );
    protected var _orders : Array = new Array ( );
    protected var _connection:Connection;
    protected var _responder:IResponder;
    protected var table : Table;
    protected var hook : HookManager;
    
    public function CriteriaImpl ( table : Table, connection : Connection, hook : HookManager, target : IEventDispatcher = null )
    {
        this.table = table;
        _connection = connection;
        this.hook = hook;
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
        var e : Expression = _expressions.length == 0 ? null : Expression.and ( _expressions );
        var text : String = table.dml.select ( e, _orders );
        var statement : Statement = _connection.createStatement ( text );
        
        var responderCriterial : Responder;
        
        if ( table.isHierarchical ) {
            responderCriterial = new HierarchicalResponder ( table, responder, hook );
        } else {
            responderCriterial = new SelectResponder ( table, responder, hook );
        }
        
        statement.execute ( responderCriterial );
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