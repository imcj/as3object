package test.me.imcj.as3object.hook
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
        
        public function get interrupting ( ) : Boolean
        {
            if ( action == ACTION_INTERRUPTING )
                return true;
            else
                return false;
        }
        
        static public function createInterrupting ( ) : HookAction
        {
            return new HookAction ( HookAction.ACTION_INTERRUPTING );
        }
        
        static public function createNothing ( ) : HookAction
        {
            return new HookAction ( HookAction.ACTION_NOTHING );
        }
    }
}