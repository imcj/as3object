package me.imcj.as3object.type {
    import me.imcj.as3object.Column;

public class IntegerType implements Type
{
	public function IntegerType()
	{
	}
	
	public function objectToString ( column : Column, object : Object ) : String
	{
        if ( column.primary && int ( object ) == 0 )
            return 'NULL';
        
        return new String ( object );
	}
}

}