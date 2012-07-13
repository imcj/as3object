package flexUnitTests
{
    import flash.data.SQLConnection;
    import flash.data.SQLResult;
    import flash.data.SQLStatement;
    import flash.errors.SQLError;
    import flash.events.SQLEvent;
    import flash.net.Responder;
    
    import org.flexunit.asserts.assertEquals;
    import org.flexunit.async.Async;

    public class TestFlashSQLite
    {		
        private var connection:SQLConnection;
        
        [Before(async,order=1)]
        public function setUp():void
        {
            connection = new SQLConnection ( );
            Async.proceedOnEvent ( this, connection, SQLEvent.OPEN );
            connection.openAsync ( null );
        }
        
        [Before(async,order=2)]
        public function setUp2 ( ) : void
        {
            var sqlStatement : SQLStatement = new SQLStatement ( );
            sqlStatement.text = "CREATE TABLE animal ( name text );";
            sqlStatement.sqlConnection = connection;
            sqlStatement.execute ( -1, Async.asyncNativeResponder (
                this,
                function ( result : SQLResult ) : void
                {
                },
                function ( error : SQLError ) : void
                {
                    trace ( error.message );
                },
                100 )
            );
        }
        
        [Before(async,order=3)]
        public function addFixtures ( ) : void
        {
            var sqlStatement : SQLStatement = new SQLStatement ( );
            sqlStatement.text = "INSERT INTO animal ( name ) VALUES ( '1' );";
            sqlStatement.sqlConnection = connection;
            
            
            sqlStatement.execute ( -1, 
                Async.asyncNativeResponder (
                    this,
                    function ( result : SQLResult ) : void
                    {
                        assertEquals(1,result.lastInsertRowID );
                    },
                    null,
                    10
                )
            );
        }
        
        [After]
        public function tearDown():void
        {
        }
        
        [Test(async,order=4)]
        public function insert () : void
        {
            var sqlStatement : SQLStatement = new SQLStatement ( );
            sqlStatement.text = "INSERT INTO animal ( name ) VALUES ( '1' );";
            sqlStatement.sqlConnection = connection;
            
            
            sqlStatement.execute ( -1, 
                Async.asyncNativeResponder (
                    this,
                    function ( result : SQLResult ) : void
                    {
                        assertEquals(2,result.lastInsertRowID );
                    },
                    null,
                    10
                )
            );
        }
        
        [Test(async,order=5)]
        public function select () : void
        {
            var sqlStatement : SQLStatement = new SQLStatement ( );
            sqlStatement.text = "SELECT * FROM animal;";
            sqlStatement.sqlConnection = connection;
            sqlStatement.execute ( -1,
                Async.asyncNativeResponder (
                    this,
                    function ( result : SQLResult ) : void
                    {
                        assertEquals(1,result.data.length);
                    },
                    null,
                    10
                )
            );
        }
    }
}