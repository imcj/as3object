package me.imcj.as3object
{
    public class Result extends Object
    {
        protected var _data : Object;
        
        public function Result ( data : Object )
        {
            _data = data;
        }

        public function get data():Object
        {
            return _data;
        }
    }
}