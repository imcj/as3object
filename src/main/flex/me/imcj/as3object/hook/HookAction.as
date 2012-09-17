package me.imcj.as3object.hook
{
    public class HookAction
    {
        static public const ACTION_INTERRUPTING : String = "ACTION_INTERRUPTING";
        static public const ACTION_NOTHING      : String = "ACTION_NOTHING";
        
        public var action : String;
        
        public function HookAction ( action : String )
        {
            this.action = action;
        }
        
        public function equalInterrupting ( ) : Boolean
        {
            if ( action == ACTION_INTERRUPTING )
                return true;
            else
                return false;
        }
        
        static public function interrupting ( ) : HookAction
        {
            return new HookAction ( HookAction.ACTION_INTERRUPTING );
        }
        
        static public function nothing ( ) : HookAction
        {
            return new HookAction ( HookAction.ACTION_NOTHING );
        }
    }
}