package test.me.imcj.as3object.hook.hookEntryPoint
{
    import me.imcj.as3object.hook.impl.HookImpl;
    
    import test.me.imcj.as3object.hook.HookAction;
    
    public class InsertHook extends HookImpl
    {
        override public function execute(data:Object) : HookAction
        {
            data['pass'] = true;
            
            return HookAction.createNothing ( );
        }
    }
}