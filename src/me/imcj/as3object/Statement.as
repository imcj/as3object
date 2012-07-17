package me.imcj.as3object
{
    import flash.events.IEventDispatcher;
    
    import mx.rpc.IResponder;
    
    public interface Statement extends IEventDispatcher
    {
        function get text ( ) : String;
        function set text ( value : String ) : void;
        
        function getResult ( ) : Result;
        function execute ( responder : IResponder ) : void;
    }
}