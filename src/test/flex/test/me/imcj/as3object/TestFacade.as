package test.me.imcj.as3object
{
    import me.imcj.as3object.AS3ObjectResponder;
    import me.imcj.as3object.AsyncRepository;
    import me.imcj.as3object.Facade;
    import me.imcj.as3object.Table;
    import me.imcj.as3object.fixture.Cat;

    public class TestFacade
    {
        public var facade : Facade;
        
        [Before]
        public function setUp():void
        {
            facade = Facade.instance;            
        }
        
        [After]
        public function tearDown():void
        {
        }
        
        [Test]
        public function testGetTable
        {
            var table : Table = facade.getTable ( new Cat ( ) );
            trace ( table );
        }
        
        [Test(async)]
        public function TestCreateRepository ( ) : void
        {
            facade.createRepository (
                new AS3ObjectResponder (
                    function ( repository : AsyncRepository ) : void
                    {
                        facade.createRepository (
                            new AS3ObjectResponder (
                                function ( repository2 : AsyncRepository ) : void
                                {
                                    trace ( "2" );
                                }
                            )
                        );
                    }
                )
            );
        }
    }
}