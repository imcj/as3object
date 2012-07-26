package me.imcj.as3object.fixture
{
    import me.imcj.as3object.AS3Object;
    import me.imcj.as3object.AS3ObjectCollection;
    
    public class Blog
    {
        [Bindable]
        public var subject : String;
        
        [Bindable]
        public var comments : AS3ObjectCollection;
        
        public function Blog ( )
        {
            super();
        }
    }
}