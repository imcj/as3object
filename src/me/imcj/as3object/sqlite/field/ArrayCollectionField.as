package me.imcj.as3object.sqlite.field
{
    import me.imcj.as3object.sqlite.SQLiteField;
    
    public class ArrayCollectionField extends SQLiteField
    {
        protected var _domain : Object;
        
        public function ArrayCollectionField ( name : String, domain : Object )
        {
            _domain = domain;
            super ( name );
        }

        public function get domain():Object
        {
            return _domain;
        }

    }
}