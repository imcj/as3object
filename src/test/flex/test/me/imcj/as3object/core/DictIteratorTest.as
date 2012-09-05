package test.me.imcj.as3object.core
{
    
    import org.flexunit.asserts.assertEquals;
    import me.imcj.as3object.core.Dict;
    import me.imcj.as3object.core.DictIterator;

    public class DictIteratorTest
    {
        public var dict : Dict;
        public var iter : DictIterator;
        
        [Before]
        public function setUp():void
        {
            dict = new Dict ( );
            dict.add ( "one", "1" );
            dict.add ( "two", "2" );
            
            iter = new DictIterator ( dict );
        }
        
        [After]
        public function tearDown():void
        {
        }
        
        [Test]
        public function testIter ( ) : void
        {
            assertEquals ( true, iter.hasNext );
            assertEquals ( "1", iter.next ( ) );
            assertEquals ( "2", iter.next ( ) );
        }
        
    }
}