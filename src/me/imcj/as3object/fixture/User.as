package me.imcj.as3object.fixture
{
    import flash.events.EventDispatcher;
    
    import mx.collections.ArrayCollection;

    public class User extends EventDispatcher
    {
        [Bindable]
        public var name : String;
        
        [Bindable]
        [Declare(type="me.imcj.as3object.fixture.Blog")]
        public var blogs : ArrayCollection;
        
        public function User()
        {
        }
    }
}