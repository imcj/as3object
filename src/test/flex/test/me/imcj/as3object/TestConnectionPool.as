package test.me.imcj.as3object 
{
    import flashx.textLayout.debug.assert;
    
    import me.imcj.as3object.AS3ObjectResponder;
    import me.imcj.as3object.Config;
    import me.imcj.as3object.Connection;
    import me.imcj.as3object.ConnectionEvent;
    import me.imcj.as3object.ConnectionFactoryImpl;
    import me.imcj.as3object.ConnectionPool;
    import me.imcj.as3object.ConnectionPoolImpl;
    import me.imcj.as3object.ConnectionSQLite;
    
    import org.flexunit.asserts.assertEquals;
    import org.flexunit.asserts.assertTrue;
    import org.flexunit.async.Async;

    public class TestConnectionPool
    {		
        public var pool:ConnectionPool;
        
        [Before]
        public function setUp():void
        {
            pool = new ConnectionPoolImpl (
                Config.createInMemory ( ),
                new ConnectionFactoryImpl ( )
            );
        }
        
        [After]
        public function tearDown():void
        {
        }
        
        [Test(async)]
        public function testConnection1 ( ) : void
        {
            pool.getConnection (
                Async.asyncResponder (
                    this,
                    new AS3ObjectResponder (
                        function ( data : Connection ) : void
                        {
                            assertTrue ( data is ConnectionSQLite ); 
                        }
                    ),
                    10
                )
            );
        }
    }
}