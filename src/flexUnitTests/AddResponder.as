package flexUnitTests
{
    import me.imcj.as3object.fixture.Cat;
    import me.imcj.as3object.AS3ObjectResponder;
    
    import mx.rpc.IResponder;
    
    import org.flexunit.asserts.assertEquals;

    public class AddResponder extends AS3ObjectResponder implements IResponder
    {
        public function AddResponder (  )
        {
            super ( result, fault );
        }
        
        override public function result ( data : Object ) : void
        {
            var cat : Cat = Cat ( data );
            assertEquals ( 2, cat.getAge ( ) );
//            assertEquals ( 1, cat.id  );
        }
        
        override public function fault ( info : Object ) : void
        {
            // TODO 处理错误
        }
    }
}