package me.imcj.as3object
{
    import flash.utils.ByteArray;

    public class AS3ObjectField extends Object
    {
        protected var _name : String;
        protected var _primaryKey : Boolean;
        protected var _order : String = Order.ASC;
        protected var _autoIncrement : Boolean = false;
        protected var _disableDefaultPrimary : Boolean = false;
        protected var _disableDefaultAutoIncrement : Boolean = false;
        
        public var table : Table;
        public var isMethod : Boolean = false;
        
        public function AS3ObjectField ( name : String )
        {
            _name = name;
            super();
        }
        
        public function get name ( ) : String
        {
            return _name;
        }
        
        public function get primaryKey():Boolean
        {
            if ( "id" == _name && ! _disableDefaultPrimary )
                return true;
            return _primaryKey;
        }
        
        public function set primaryKey(value:Boolean):void
        {
            _primaryKey = value;
        }

        public function get order ( ) : String
        {
            return _order;
        }

        public function set order ( value : String ) : void
        {
            _order = value;
        }

        public function get autoIncrement ( ) : Boolean
        {
            if ( ! _disableDefaultAutoIncrement && primaryKey )
                return true;
            
            return _autoIncrement;
        }
        
        public function get type ( ) : String
        {
            throw new Error ( "Not implement the method." );
        }
        
        public function setPOAOValue ( poao : Object, data : Object ) : void
        {
            if ( isMethod )
                poao[setMethodName ( )] ( data[this.name] );
            else
                poao[_name] = data[this.name];
        }
        
        public function getPOAOValue ( poao : Object ) : Object
        {
            var methodName : String;
            if ( isMethod ) {
                methodName = getMethodName ( );
                return poao [ methodName ] ( );
            } else
                return poao [ name ];
        }
        
        protected function setMethodName ( ) : String
        {
            return "set" + _name.substr ( 0, 1 ).toUpperCase ( ) + _name.substring ( 1 );
        }
        
        protected function getMethodName ( ) : String
        {
            return "get" + _name.substr ( 0, 1 ).toUpperCase ( ) + _name.substring ( 1 );
        }
    }
}