package test.me.imcj.as3object 
{
    import me.imcj.as3object.AS3ObjectResponder;
    import me.imcj.as3object.Config;
    import me.imcj.as3object.Connection;
    import me.imcj.as3object.ConnectionEvent;
    import me.imcj.as3object.ConnectionFactoryImpl;
    import me.imcj.as3object.ConnectionPool;
    import me.imcj.as3object.ConnectionPoolImpl;
    import me.imcj.as3object.Result;
    import me.imcj.as3object.Statement;
    
    import org.flexunit.asserts.assertTrue;
    import org.flexunit.async.Async;

    public class TestStatement
    {	
        public var config : Config;
        public var connection : Connection;
        public var pool : ConnectionPool;
        
        [Before(async)]
        public function setUp():void
        {
            config = Config.createInMemory ( );
            pool = new ConnectionPoolImpl ( config, new ConnectionFactoryImpl ( ) );
            pool.getConnection (
                Async.asyncResponder (
                    this,
                    new AS3ObjectResponder (
                        function ( _connection : Connection ) : void
                        {
                            connection = _connection;
                        }
                    ),
                    10
                )
            );
        }
        
        [After]
        public function tearDown():void
        {
        }
        
        [BeforeClass]
        public static function setUpBeforeClass():void
        {
        }
        
        [AfterClass]
        public static function tearDownAfterClass():void
        {
        }
        
        [Test]
        public function testStatement ( ) : void
        {
            var statement : Statement = connection.createStatement ( "SELECT datetime ();" );
//            statement.execute (
//                new AS3ObjectResponder (
//                    function ( data : Result ) : void
//                    {
//                        assertTrue ( String ( ( data.data as Array )[0]['datetime ()'] ).length > 1 );
//                    }
//                )
//            );
        }
    }
}