package me.imcj.as3object
{
    import flash.events.IEventDispatcher;
    
    import me.imcj.as3object.expression.Expression;
    
    import mx.collections.ArrayCollection;
    
    public interface Criteria extends IEventDispatcher
    {
        function add ( expression : Expression ) : Criteria;
        function addOrder ( order : Order ) : Criteria;
        function list ( responder : Responder ) : ArrayCollection;
        function setLimit ( min : int, max : int ) : Criteria;
        function setMaxResults ( max : int ) : Criteria;
    }
}