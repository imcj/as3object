package test.me.imcj.as3object 
{
    import me.imcj.as3object.AS3ObjectResponder;
    import me.imcj.as3object.AsyncRepository;
    import me.imcj.as3object.Config;
    import me.imcj.as3object.Criteria;
    import me.imcj.as3object.Facade;
    import me.imcj.as3object.Order;
    import me.imcj.as3object.Repository;
    import me.imcj.as3object.expression.eq;
    import me.imcj.as3object.fixture.Cat;
    
    import org.flexunit.asserts.assertEquals;
    import org.flexunit.async.Async;

    public class TestCriterial
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
        
        [Test(async,order=5)]
        public function testList ( ) : void
        {
            criteria
                .add ( eq ( "id", 1 ) )
                .addOrder ( Order.asc ( "id" ) )
                .list (
                    new AS3ObjectResponder (
                        function ( data : Array ) : void
                        {
                            assertEquals ( 1, data.length );
                        }
                    )
                );
        }
    }
}