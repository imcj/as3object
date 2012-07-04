package me.imcj.as3object.fixture
{
	import flash.utils.getQualifiedClassName;

	public class Animal
	{
        public var id   : int;
		public var name : String;
		public var age  : int;
		
		public function Animal()
		{
		}
		
		public function toString ( ) : String
		{
			return "<" + getQualifiedClassName ( this ).split ( "::" )[1] + ": " + name + ">";
		}
	}
}