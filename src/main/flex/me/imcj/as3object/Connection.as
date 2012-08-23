package me.imcj.as3object
{
    import flash.events.IEventDispatcher;
    
    import mx.collections.ArrayCollection;
    import mx.rpc.IResponder;
    
    /**
     *  Dispatched when an openAsync() method call's operation completes successfully.
     *
     *  @eventType me.imcj.as3object.ConnectionEvent
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    [Event(name="connect", type="me.imcj.as3object.ConnectionEvent")]
    
    public interface Connection extends IEventDispatcher
    {
        function open ( ) : void;
        function openAsync ( responder : IResponder ) : void;
        function get connected ( ) : Boolean;
        
        function createStatement ( text : String = null ) : Statement
    }
}