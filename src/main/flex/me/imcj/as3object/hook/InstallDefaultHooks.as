package me.imcj.as3object.hook
{
    import mx.core.ClassFactory;

    public class InstallDefaultHooks
    {
        public function InstallDefaultHooks ( hook : HookManager )
        {
            var hookPOAO : Hook = newInstance ( POAOHook );
            
            hook.add ( "create_instance",  hookPOAO );
            hook.add ( "rebuild_instance", hookPOAO );
            hook.add ( "build_field",      newInstance ( DefaultExcludeHook ) );
        }
        
        protected function newInstance ( type : Class ) : Hook
        {
            var factory : ClassFactory = new ClassFactory ( type );
            return factory.newInstance ( );
        }
    }
}