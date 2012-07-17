package flexUnitTests
{
    import me.imcj.as3object.AS3ObjectResponder;
    import me.imcj.as3object.Config;
    import me.imcj.as3object.Criteria;
    import me.imcj.as3object.Facade;
    import me.imcj.as3object.Order;
    import me.imcj.as3object.expression.eq;
    import me.imcj.as3object.fixture.Cat;
    
    import mx.collections.ArrayCollection;
    
    import org.flexunit.asserts.assertEquals;

    public class TestCriterial
    {
        public var criteria : Criteria;
        
        [Before]
        public function setUp():void
        {
            Facade.instance.config = Config.createInMemory ( );
            criteria = Facade.instance.createCriteria ( Cat );
        }
        
        [Test]
        public function testList ( ) : void
        {
            criteria
                .add ( eq ( "id", 1 ) )
                .addOrder ( Order.asc ( "id" ) )
                .list (
                    new AS3ObjectResponder (
                        function ( data : ArrayCollection ) : void
                        {
                            assertEquals ( 1, data.length );
                        }
                    )
                );
        }
    }
}