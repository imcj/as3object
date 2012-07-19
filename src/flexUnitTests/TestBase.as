package flexUnitTests
{
    import me.imcj.as3object.AS3ObjectResponder;
    import me.imcj.as3object.AsyncRepository;
    import me.imcj.as3object.Config;
    import me.imcj.as3object.Criteria;
    import me.imcj.as3object.Facade;
    import me.imcj.as3object.fixture.Cat;
    
    import org.flexunit.async.Async;
    import me.imcj.as3object.Repository;
    
    public class TestBase
    {		
        public var criteria : Criteria;
        public var repository:AsyncRepository;
        
        [Before(async,order=1)]
        public function setUp():void
        {
            Facade.instance.config = Config.createInMemory ( );
            Facade.instance.createCriteria (
                Cat,
                Async.asyncResponder (
                    this,
                    new AS3ObjectResponder (
                        function ( _criteria : Criteria ) : void
                        {
                            criteria = _criteria;
                        }
                    ),
                    10
                )
            );
        }
        
        [Before(async,order=2)]
        public function setUp2 ( ) : void
        {
            Facade.instance.createRepository (
                Cat,
                Async.asyncResponder (
                    this,
                    new AS3ObjectResponder (
                        function ( _repository : Repository ) : void
                        {
                            repository = _repository;
                        }
                    ),
                    10
                )
            );
        }
        
        [Before(async,order=3)]
        public function setUp3 ( ) : void
        {
            repository.creationStatement (
                Cat,
                Async.asyncResponder (
                    this,
                    new AS3ObjectResponder (
                        function ( data : Object ) : void
                        {
                            trace ( "Create table" );
                        }
                    ),
                    10
                ),
                true
            );
        }
        
        [Before(async,order=4)]
        public function setUp4 ( ) : void
        {
            var cat : Cat = new Cat ( );
            cat.name = "2B";
            cat.setAge ( 2 );
            repository.add (
                cat,
                Async.asyncResponder (
                    this,
                    new AS3ObjectResponder (
                        function ( data : Cat ) : void
                        {
                            trace ( data );
                        }
                    ),
                    10
                )
            );
        }
        
    }
}