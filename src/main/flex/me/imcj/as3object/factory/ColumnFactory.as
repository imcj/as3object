package me.imcj.as3object.factory
{
    import me.imcj.as3object.Table;
    import me.imcj.as3object.core.Dict;
    
    import org.as3commons.reflect.Type;

    public interface ColumnFactory
    {
        function create ( table : Table ) : Dict;
    }
}