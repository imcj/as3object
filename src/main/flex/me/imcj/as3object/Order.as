package me.imcj.as3object
{
    public class Order
    {
        static public const ASC  : String = "asc";
        static public const DESC : String = "desc";
        
        protected var _sort:String;
        protected var _propertyName:String;
        
        public function Order ( propertyName : String, sort : String )
        {
            _propertyName = propertyName;
            _sort = sort;
        }
        
        static public function asc ( propertyName : String ) : Order
        {
            return new Order ( propertyName, ASC );
        }
        
        static public function desc ( propertyName : String ) : Order
        {
            return new Order ( propertyName, DESC );
        }

        public function get propertyName():String
        {
            return _propertyName;
        }

        public function get sort():String
        {
            return _sort;
        }


    }
}