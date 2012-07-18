package me.imcj.as3object
{
    import flash.events.EventDispatcher;
    
    public class StatementImpl extends EventDispatcher implements Statement
    {
        protected var _text:String;
        protected var _connection:Connection;
        
        public function StatementImpl()
        {
        }
        
        public function get text():String
        {
            return _text;
        }
        
        public function set text(value:String):void
        {
            _text = text;
        }
        
        public function get connection():Connection
        {
            return _connection;
        }
        
        public function set connection(value:Connection):void
        {
            _connection = value;
        }
        
        public function getResult ( ) : Result
        {
            return null;
        }
        
        public function execute ( responder : Responder ) : void
        {
        }
    }
}