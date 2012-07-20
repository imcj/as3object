package me.imcj.as3object
{
    import org.as3commons.reflect.Method;
    import org.as3commons.reflect.Field;

    public interface FieldFactory
    {
        function createByMethod ( method : Method ) : AS3ObjectField;
        function createByField ( field : Field ) : AS3ObjectField;
        function create ( any : Object ) : AS3ObjectField;
    }
}