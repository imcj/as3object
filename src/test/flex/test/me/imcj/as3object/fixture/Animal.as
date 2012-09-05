package test.me.imcj.as3object.fixture
{
	import flash.events.EventDispatcher;
	import flash.utils.getQualifiedClassName;

    [Bindable]
	public class Animal extends EventDispatcher
	{
        public var id   : int;
		protected var _name : String;
		protected var _age  : int;
		
		public function Animal()
		{
		}
		
		override public function toString ( ) : String
		{
			return "<" + getQualifiedClassName ( this ).split ( "::" )[1] + ": " + name + ">";
		}
        
        [Field]
        public function getAge ( ) : int
        {
            return _age;
        }
        
        public function setAge ( value : int ) : void
        {
            _age = value;
        }
        
        public function get name ( ) : String
        {
            return _name;
        }
        
        public function set name ( value : String ) : void
        {
            _name = value;
        }
	}
}