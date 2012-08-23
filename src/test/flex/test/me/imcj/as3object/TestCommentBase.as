package test.me.imcj.as3object 
{
    import me.imcj.as3object.AS3ObjectResponder;
    import me.imcj.as3object.AsyncRepository;
    import me.imcj.as3object.Config;
    import me.imcj.as3object.Criteria;
    import me.imcj.as3object.Facade;
    import me.imcj.as3object.Repository;
    import me.imcj.as3object.fixture.Cat;
    import me.imcj.as3object.fixture.Comment;
    
    import org.flexunit.async.Async;
    
    public class TestCommentBase
    {		
        public var criteria : Criteria;
        public var repository:AsyncRepository;
        public var comment : Comment;
        
        [Before(async,order=1)]
        public function setUp():void
        {
            Facade.instance.config = Config.createInMemory ( );
            Facade.instance.createCriteria (
                Comment,
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
                Comment,
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
            comment = new Comment ( );
            comment.message = "1";
            
            repository.add (
                comment,
                Async.asyncResponder (
                    this,
                    new AS3ObjectResponder (
                        function ( data : Comment ) : void
                        {
                            trace ( "comment" );
                        }
                    ),
                    10
                )
            );
        }
        
        [Before(async,order=5)]
        public function setUp5 ( ) : void
        {
            var comment2 : Comment = new Comment ( );
            comment2.message = "2";
            
            comment.addChild ( comment2 );
            
            repository.add (
                comment2,
                Async.asyncResponder (
                    this,
                    new AS3ObjectResponder (
                        function ( data : Comment ) : void
                        {
                            trace ( "comment" );
                        }
                    ),
                    10
                )
            );
        }
        
    }
}