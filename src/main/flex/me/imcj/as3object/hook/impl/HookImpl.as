package me.imcj.as3object.hook.impl
{
    import me.imcj.as3object.hook.Hook;
    import me.imcj.as3object.hook.HookManager;
    
    import test.me.imcj.as3object.hook.HookAction;

    public class HookImpl implements Hook
    {
        protected var _priority : int = 100;
        protected var _hookManager:HookManager;
        
        public function execute(data:Object):HookAction
        {
            throw new Error ( "This method is not implements." );
        }
        
        public function set hookManager(value:HookManager):void
        {
            _hookManager = value;
        }
        
        public function get hookManager():HookManager
        {
            return _hookManager;
        }
        
        public function get priority ( ) : int
        {
            return _priority;
        }
        
        public function set priority ( value : int ) : void
        {
            _priority = value;
        }
    }
}