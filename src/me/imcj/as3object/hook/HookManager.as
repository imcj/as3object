package me.imcj.as3object.hook
{
    public interface HookManager
    {
        function execute ( name : String, data : Object ) : void;
        function add ( name : String, hook : Hook ) : void;
    }
}