package me.imcj.as3object.type
{
	public interface Type
	{
		function objectToString ( object : Object ) : String;
		function fromString ( string : String ) : Object;
	}
}