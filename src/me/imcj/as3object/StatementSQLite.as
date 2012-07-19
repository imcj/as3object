package me.imcj.as3object
{
    import flash.data.SQLResult;
    import flash.data.SQLStatement;
    import flash.errors.SQLError;
    import flash.net.Responder;

    public class StatementSQLite extends StatementImpl
    {
        protected var _statement:SQLStatement;
        
        public function StatementSQLite ( statement : SQLStatement )
        {
            _statement = statement;
            
            super ( );
        }
        
        override public function set text(value:String):void
        {
            _statement.text = value;
            super.text = value;
        }
        
        override public function execute ( responder : me.imcj.as3object.Responder ) : void
        {
            // TODO Error catch
            trace ( _text );
            _statement.execute (
                -1,
                new flash.net.Responder (
                    function ( result : SQLResult ) : void
                    {
                        var r : Result = new Result ( result.data );
                        r.lastInsertRowID = result.lastInsertRowID;
                        r.rowsAffected = result.rowsAffected;
                        
                        responder.result ( r );
                    },
                    function ( error : SQLError ) : void
                    {
                        trace ( error.message );
                    }
                )
            );
        }
    }
}