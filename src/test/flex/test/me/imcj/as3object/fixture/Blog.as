package test.me.imcj.as3object.fixture
{
    import flash.events.EventDispatcher;
    
    import me.imcj.as3object.AS3Object;
    import me.imcj.as3object.AS3ObjectCollection;
    
    import mx.collections.ArrayCollection;
    
    [Bindable]
    public class Blog extends EventDispatcher
    {
        public var id : int;
        public var uid : String;
        public var subject : String;
        public var comments : ArrayCollection;
        
        public function Blog ( )
        {
            super();
        }
    }
}