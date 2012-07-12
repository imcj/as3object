package me.imcj.as3object.field
{
    import me.imcj.as3object.Order;
    import flash.utils.ByteArray;

    public class Field extends Object
    {
        protected var _name : String;
        protected var _primaryKey : Boolean;
        protected var _order : String = Order.ASC;
        protected var _autoIncrement : Boolean = false;
        protected var _disableDefaultPrimary : Boolean = false;
        protected var _disableDefaultAutoIncrement : Boolean = false;
        
        public function Field ( name : String )
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
        
        public function assignValue ( instance : Object, data : Object ) : void
        {
            throw new Error ( "Not implement the method." );
        }
        
        public function buildCreateTableColumnDefine ( buffer : ByteArray ) : void
        {
            throw new Error ( "Not implement the method." );
        }
        
        public function buildInsertColumn ( buffer : ByteArray ) : void
        {
            throw new Error ( "Not implement the method." );
        }
        
        public function buildInsertValue ( buffer : ByteArray ) : void
        {
            throw new Error ( "Not implement the method." );
        }
        
        public function buildUpdateAssign ( buffer : ByteArray ) : void
        {
            throw new Error ( "Not implement the method." );
        }
    }
}