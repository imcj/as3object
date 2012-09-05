package me.imcj.as3object.hook
{
    import flash.utils.Dictionary;

    public interface Hook
    {
        function execute ( data : Object ) : void;
        
        function set hookManager ( value : HookManager ) : void;
        function get hookManager ( ) : HookManager;
    }
}