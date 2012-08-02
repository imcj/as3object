package me.imcj.as3object.hook
{
    import flash.utils.Dictionary;

    public class HookManagerDefault implements HookManager
    {
        protected var hooks : Dictionary;
        
        public function HookManagerDefault()
        {
            hooks = new Dictionary ( );
        }
        
        static public function create ( ) : HookManager
        {
            var hook : HookManager = new HookManagerDefault ( );
            new InstallDefaultHooks ( hook );
            
            return hook;
        }
        
        public function execute ( name : String, data : Object ) : void
        {
            var h : Array;
            var i : int = 0;
            var size : int;
            if ( ! hooks.hasOwnProperty ( name ) )
                return;
            h = hooks [ name ];
            size = h.length;
            for ( ; i < size; i++ )
                Hook ( h[i] ).execute ( data );
        }
        
        public function add ( name : String, hook : Hook ) : void
        {
            var h : Array = new Array ( );
            if ( hooks.hasOwnProperty ( name ) )
                h = hooks [ name ];
            else
                hooks [ name ] = h = new Array ( );
            
            h[h.length] = hook;
        }
    }
}