package me.imcj.as3object
{
	import flash.events.IEventDispatcher;
	import flash.net.Responder;
	
	import me.imcj.as3object.expression.Expression;
	import me.imcj.as3object.responder.AS3ObjectResponder;
	
	import mx.rpc.IResponder;

	public interface AsyncRepository extends IEventDispatcher
	{
		function add ( object : Object, responder : IResponder ) : Object;
		function update ( object : Object ) : Object;
		function remove ( object : Object ) : void;
		function find ( expression : Expression, responder : IResponder ) : void;
        function findAll ( responder : IResponder ) : void;
		
		function creationStatement ( object : Object, responder : IResponder, ifNotExists : Boolean = false ) : void;
	}
}