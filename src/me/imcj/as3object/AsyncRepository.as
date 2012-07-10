package me.imcj.as3object
{
	import flash.events.IEventDispatcher;
	import flash.net.Responder;
	
	import me.imcj.as3object.expression.Expression;
	
	import mx.rpc.IResponder;

	public interface AsyncRepository extends IEventDispatcher
	{
		function add ( object : Object, responder : IResponder ) : Object;
		function update ( object : Object, responder : IResponder ) : void;
		function remove ( object : Object ) : void;
		function find ( expression : Expression, responder : IResponder ) : void;
        function findAll ( responder : IResponder ) : void;
		
		function creationStatement ( object : Object, responder : IResponder, ifNotExists : Boolean = false ) : void;
	}
}