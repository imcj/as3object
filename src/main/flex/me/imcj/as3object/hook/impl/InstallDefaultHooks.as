package me.imcj.as3object.hook.impl
{
    import me.imcj.as3object.hook.Hook;
    import me.imcj.as3object.hook.HookManager;
    
    import mx.core.ClassFactory;

    public class InstallDefaultHooks
    {
        protected var hookManager : HookManager;
        
        public function InstallDefaultHooks ( hookManager : HookManager )
        {
            this.hookManager = hookManager;
            var hookPOAO : Hook = newInstance ( POAOHook );
            
            hookManager.add ( HookManager.CREATE_INSTANCE,  hookPOAO );
            hookManager.add ( HookManager.REBUILD_INSTANCE, hookPOAO );
            hookManager.add ( HookManager.CREATE_COLUMN,    newInstance ( DefaultExcludeHook ) );
        }
        
        protected function newInstance ( type : Class ) : Hook
        {
            var factory : ClassFactory = new ClassFactory ( type );
            var hook : Hook = factory.newInstance ( );
            hook.hookManager = this.hookManager;
            return hook;
        }
    }
}