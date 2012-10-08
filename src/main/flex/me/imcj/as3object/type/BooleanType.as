package me.imcj.as3object.type
{
    import me.imcj.as3object.Column;

    public class BooleanType implements Type
    {
        public function BooleanType()
        {
        }
        
        public function objectToString(column : Column, object:Object):String
        {
            return Boolean ( object ) == true ? '1' : '0';
        }
    }
}