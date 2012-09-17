package me.imcj.as3object.hook
{

    public interface Hook
    {
        function execute ( data : Object ) : HookAction;
        
        function set hookManager ( value : HookManager ) : void;
        function get hookManager ( ) : HookManager;
        
        function get priority ( ) : int;
        function set priority ( value : int ) : void;
    }
}