package me.imcj.as3object.fixture
{
    import me.imcj.as3object.AS3ObjectHierachical;
    
    public class Comment extends AS3ObjectHierachical
    {
        [Bindable]
        public var message : String;
        
        public function Comment()
        {
            super();
        }
    }
}