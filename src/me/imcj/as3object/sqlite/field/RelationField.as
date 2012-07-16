package me.imcj.as3object.sqlite.field
{
    import me.imcj.as3object.sqlite.SQLiteField;
    
    public class RelationField extends SQLiteField
    {
        public var relationClass : Class;
        
        public function RelationField(name:String)
        {
            super(name);
        }
        
        override public function assignValue(instance:Object, data:Object):void
        {
//            instance[name] = data[name];
        }
    }
}