package me.imcj.as3object.fixture
{
	public class Cat extends Animal
	{
        protected var _food : String;
        
		public function Cat()
		{
			super();
		}
        
        [Field(name="food", setter="_setFood", getter="_getFood")]
        public function _setFood ( value : String ) : void
        {
            _food = value;
        }
        
        public function _getFood ( ) : String
        {
            return _food;
        }
	}
}