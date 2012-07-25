package flexUnitTests
{
    import me.imcj.as3object.AS3ObjectResponder;
    import me.imcj.as3object.Config;
    import me.imcj.as3object.Connection;
    import me.imcj.as3object.ConnectionEvent;
    import me.imcj.as3object.ConnectionPool;
    import me.imcj.as3object.ConnectionPoolImpl;
    import me.imcj.as3object.ConnectionSQLite;
    
    import org.flexunit.asserts.assertEquals;
    import org.flexunit.async.Async;

    public class TestConnectionSQLite
    {		
        public var config : Config;
        
        [Before]
        public function setUp():void
        {
            config = Config.createInMemory ( );
        }
        
        [After]
        public function tearDown():void
        {
        }
        
        [Test(async)]
        public function testConnectionSQLite ( ) : void
        {
            var connection : Connection = new ConnectionSQLite ( config );
            connection.openAsync ( Async.asyncResponder ( this, new AS3ObjectResponder (
                function ( data : Object ) : void
                {
                    assertEquals ( ConnectionEvent.CONNECT, ConnectionEvent ( data ).type );
                } ),
                10
            ) );
        }
    }
}