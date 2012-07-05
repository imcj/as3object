package flexUnitTests
{
    import flash.errors.SQLError;
    import flash.net.Responder;
    
    import me.imcj.as3object.fixture.Cat;
    import me.imcj.as3object.responder.AS3ObjectResponder;
    
    import org.flexunit.asserts.assertEquals;

    public class AddResponder extends AS3ObjectResponder
    {
        public function AddResponder ( )
        {
        }
        
        override public function result ( data : Object ) : void
        {
            var cat : Cat = Cat ( data );
            assertEquals ( 2, cat.age );
            assertEquals ( 1, cat.id  );
        }
        
        override public function fault ( info : Object ) : void
        {
            // TODO 处理错误
        }
    }
}