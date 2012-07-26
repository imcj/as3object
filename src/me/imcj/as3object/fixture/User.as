package me.imcj.as3object.fixture
{
    import flash.events.EventDispatcher;

    public class User extends EventDispatcher
    {
        [Bindable]
        public var name : String;
        
        public function User()
        {
        }
    }
}