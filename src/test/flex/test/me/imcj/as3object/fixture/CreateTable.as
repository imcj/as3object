package test.me.imcj.as3object.fixture
{
    import com.adobe.cairngorm.task.Task;
    
    import me.imcj.as3object.AS3ObjectResponder;
    import me.imcj.as3object.Facade;
    
    public class CreateTable extends Task
    {
        private var table  : Class;
        private var facade : Facade;
        
        public function CreateTable ( table : Class, facade : Facade )
        {
            this.table = table;
            this.facade = facade;
        }
        
        override protected function performTask ( ) : void
        {
            facade
                .createTable ( table, true )
                .addResponder ( new AS3ObjectResponder (
                    function ( data : Object ) : void
                    {
                        complete ( );
                    },
                    function ( info : Object ) : void
                    {
                        fault ( info.message );
                    }
                ) );
        }
    }
}