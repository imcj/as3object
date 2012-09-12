package me.imcj.as3object
{
    import flash.events.EventDispatcher;
    
    import me.imcj.as3object.hook.HookManager;
    
    public class StatementImpl extends EventDispatcher implements Statement
    {
        protected var _text:String;
        protected var _connection:Connection;
        protected var _hook : HookManager;
        
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
        
        public function get hook ( ) : HookManager
        {
            return _hook;
        }
        
        public function set hook ( value : HookManager ) : void
        {
            _hook = value;
        }
    }
}