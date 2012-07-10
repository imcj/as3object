package flexUnitTests
{
	import flash.events.SQLEvent;
	import flash.net.Responder;
	
	import me.imcj.as3object.AS3ObjectResponder;
	import me.imcj.as3object.AsyncRepository;
	import me.imcj.as3object.SQLiteAsyncRepository;
	import me.imcj.as3object.fixture.Cat;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.async.Async;

	public class TestSQLiteAsyncRepositoryUpdate
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
		public function testUpdate ( ) : void
		{
			var cat : Cat = new Cat ( );
			cat.name = "2B";
			cat.age = 1;
            cat.id = 1;
            
            repository.update (
                cat,
                Async.asyncResponder (
                    this,
                    new AS3ObjectResponder (
                        function ( data : Object ) : void
                        {
                            assertEquals ( 1, cat.age );
                        }
                    ),
                    10
                )
            );
		}
	}
}
