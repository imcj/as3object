package me.imcj.as3object
{
    public class Result extends Object
    {
        protected var _data : Object;
        protected var _lastInsertRowID : int;
        protected var _rowsAffected : int;
        
        public function Result ( data : Object )
        {
            _data = data;
        }

        public function get data():Object
        {
            return _data;
        }

        public function get lastInsertRowID():int
        {
            return _lastInsertRowID;
        }

        public function set lastInsertRowID(value:int):void
        {
            _lastInsertRowID = value;
        }

        public function get rowsAffected():int
        {
            return _rowsAffected;
        }

        public function set rowsAffected(value:int):void
        {
            _rowsAffected = value;
        }


    }
}