package me.imcj.as3object.hook
{
    import me.imcj.as3object.Connection;

    public interface HookManager
    {
        function execute ( name : String, data : Object ) : void;
        function add ( name : String, hook : Hook ) : void;
    }
}