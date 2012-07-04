package me.imcj.as3object
{
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;

	public interface IRepository extends IEventDispatcher
	{
		function add ( object : Object ) : Object;
		function update ( object : Object ) : Object;
		function remove ( object : Object ) : void;
		function find ( ) : Array;
	}
}