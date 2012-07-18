package me.imcj.as3object
{
    import flash.events.IEventDispatcher;
    
    public interface Statement extends IEventDispatcher
    {
        function get text ( ) : String;
        function set text ( value : String ) : void;
        
        function getResult ( ) : Result;
        function execute ( responder : Responder ) : void;
    }
}