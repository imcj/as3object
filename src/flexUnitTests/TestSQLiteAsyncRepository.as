package flexUnitTests
{
	import flash.data.SQLResult;
	import flash.errors.SQLError;
	import flash.events.Event;
	import flash.events.SQLEvent;
	import flash.net.Responder;
	
	import me.imcj.as3object.AsyncRepository;
	import me.imcj.as3object.ObjectEvent;
	import me.imcj.as3object.SQLiteAsyncRepository;
	import me.imcj.as3object.fixture.Cat;
	import me.imcj.as3object.responder.AS3ObjectResponder;
	
	import mx.rpc.IResponder;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.async.Async;

	public class TestSQLiteAsyncRepository
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
		
		[Before(order=2)]
		public function setUp2 () : void
		{
			repository.creationStatement ( Cat, null, true );
		}
		
		
		[Test(async,order=1)]
		public function testAdd ( ) : void
		{
			var cat : Cat = new Cat ( );
			cat.name = "2B";
			cat.age = 2;
            
			var responder : AddResponder = new AddResponder ( );
			repository.add ( cat, Async.asyncResponder ( this, responder, 10 ) );
		}
		
		[Test(async,order=2)]
		public function testFindAll ( ) : void
		{
			repository.findAll (
                Async.asyncResponder (
                    this,
                    new AS3ObjectResponder (
                        function ( data : Object )
                        {
                            trace ( data );
                        },
                        function ( info : Object )
                        {
                        }
                    ),
                    10
                )
            );
		}
	}
}
