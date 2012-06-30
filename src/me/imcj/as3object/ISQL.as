package me.imcj.as3object
{
	public interface ISQL
	{
		function insert ( ... arg ) : String;
		function update ( ... arg ) : String;
		function remove ( ... arg ) : String;
		function select ( ... arg ) : String;
	}
}