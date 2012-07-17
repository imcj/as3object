package me.imcj.as3object
{
    import flash.events.IEventDispatcher;
    import mx.rpc.IResponder;
    
    public interface ConnectionPool extends IEventDispatcher
    {
        function get config ( ) : Config;
        function set config ( value : Config ) : void;
        function getConnection ( responder : IResponder ) : void
    }
}