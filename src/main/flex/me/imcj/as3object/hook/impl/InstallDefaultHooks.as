package me.imcj.as3object.hook.impl
{
    import mx.core.ClassFactory;
    import me.imcj.as3object.hook.Hook;
    import me.imcj.as3object.hook.HookManager;

    public class InstallDefaultHooks
    {
        protected var hookManager : HookManager;
        
        public function InstallDefaultHooks ( hookManager : HookManager )
        {
            this.hookManager = hookManager;
            var hookPOAO : Hook = newInstance ( POAOHook );
            
            hookManager.add ( "create_instance",  hookPOAO );
            hookManager.add ( "rebuild_instance", hookPOAO );
            hookManager.add ( "build_column",     newInstance ( DefaultExcludeHook ) );
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