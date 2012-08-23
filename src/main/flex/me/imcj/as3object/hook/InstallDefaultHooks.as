package me.imcj.as3object.hook
{
    public class InstallDefaultHooks
    {
        public function InstallDefaultHooks ( hook : HookManager )
        {
            hook.add ( "create_instance",  _ ( POAOHook ) );
            hook.add ( "rebuild_instance", _ ( POAOHook ) );
            hook.add ( "build_field",      _ ( IgnoreSpriteHook ) );
        }
        
        protected function _ ( type : Class ) : Hook
        {
            return new type ( );
        }
    }
}