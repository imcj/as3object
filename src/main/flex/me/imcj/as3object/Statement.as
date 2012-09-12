package me.imcj.as3object
{
    import flash.events.IEventDispatcher;
    
    import me.imcj.as3object.hook.HookManager;
    
    public interface Statement extends IEventDispatcher
    {
        function get text ( ) : String;
        function set text ( value : String ) : void;
        
        function getResult ( ) : Result;
        function execute ( responder : Responder ) : void;
        
        function get hook ( ) : HookManager;
        function set hook ( value : HookManager ) : void;
    }
}