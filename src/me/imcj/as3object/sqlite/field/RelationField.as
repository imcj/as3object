package me.imcj.as3object.sqlite.field
{
    import me.imcj.as3object.fixture.Comment;
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
        
        override public function getValue(instance:Object):Object
        {
            var len : int = name.length;
            var value : int;
            var relation_name : String = name.substring ( 0, len - 3 );
            var relation : Object = instance[relation_name];
            
            if ( ! relation )
                value = 0;
            else
                if ( relation.hasOwnProperty ( "id" ) )
                    value = relation['id'];
                else
                    value = 0;
            
            // TODO if missing id use uuid
            return value;
        }
        
        override public function get name():String
        {
            return super.name + "_id";
        }
        
        override public function get type():String
        {
            return "Integer";
        }
    }
}