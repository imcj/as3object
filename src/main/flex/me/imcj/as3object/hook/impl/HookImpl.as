package me.imcj.as3object.hook.impl
{
    import me.imcj.as3object.hook.Hook;
    import me.imcj.as3object.hook.HookManager;

    public class HookImpl implements Hook
    {
        protected var _hookManager:HookManager;
        
        public function execute(data:Object):void
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
    }
}