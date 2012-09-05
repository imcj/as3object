package me.imcj.as3object.hook
{
    import me.imcj.as3object.Config;
    import me.imcj.as3object.Connection;
    import me.imcj.as3object.TableCache;
    import me.imcj.as3object.TableFactory;

    public interface HookManager
    {
        function execute ( name : String, data : Object ) : void;
        function add ( name : String, hook : Hook ) : void;
        
        function get config ( ) : Config;
        function set config ( value : Config ) : void;
        
        function get tableFactory ( ) : TableFactory;
        function set tableFactory ( value : TableFactory ) : void;
        
        function get tableCache ( ) : TableCache;
        function set tableCache ( value : TableCache ) : void;
    }
}