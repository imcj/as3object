package flexUnitTests
{
    import flash.events.SQLEvent;
    
    import me.imcj.as3object.AS3ObjectResponder;
    import me.imcj.as3object.AsyncRepository;
    import me.imcj.as3object.SQLiteAsyncRepository;
    import me.imcj.as3object.expression.eq;
    import me.imcj.as3object.fixture.Cat;
    
    import org.flexunit.asserts.assertEquals;
    import org.flexunit.async.Async;

    public class TestSQLiteAsyncRepositoryFindByName
    {
        public var repository : AsyncRepository;
        
        [Before(async,order=1)]
        public function setUp():void
        {
            repository = new SQLiteAsyncRepository ( null, Cat );
            Async.proceedOnEvent ( this, repository, SQLEvent.OPEN );
        }
        
        [After]
        public function tearDown():void
        {
        }
        
        [Before(async,order=2)]
        public function setUp2 () : void
        {
            repository.creationStatement ( Cat,
                Async.asyncResponder (
                    this,
                    new AS3ObjectResponder (
                        function ( data : Object ) : void
                        {
                            assertEquals ( "success", data );
                        }
                    ),
                    10 ),
                true );
        }
        
        [Before(async,order=3)]
        public function addFixtures ( ) : void
        {
            var cat : Cat = new Cat ( );
            cat.name = "2B";
            cat.age = 2;
            
            var responder : AddResponder = new AddResponder ( );
            repository.add ( cat, Async.asyncResponder ( this, responder, 10 ) );
        }
        
        [Test(async,order=4)]
        public function testFindByName ( ) : void
        {
            repository.find (
                eq ( "name", "2B" ),
                Async.asyncResponder (
                    this,
                    new AS3ObjectResponder (
                        function ( data : Object ) : void
                        {
                            var cats : Array = data as Array;
                            assertEquals ( cats.length, 1 );
                            assertEquals ( true, cats[0] is Cat );
                        }
                    ),
                    10
                )
            );
        }
    }
}