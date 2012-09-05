package test.me.imcj.as3object.fixture
{
	public class Cat extends Animal
	{
        protected var _food : String;
        
		public function Cat()
		{
			super();
		}
        
        public function _setFood ( value : String ) : void
        {
            _food = value;
        }
        
        [Field(name="food", setter="_setFood", getter="_getFood")]
        public function _getFood ( ) : String
        {
            return _food;
        }
	}
}