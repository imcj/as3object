package me.imcj.as3object.type
{
    import me.imcj.as3object.Column;

	public interface Type
	{
		function objectToString ( column : Column, object : Object ) : String;
	}
}