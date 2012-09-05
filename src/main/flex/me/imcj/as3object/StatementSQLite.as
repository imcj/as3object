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
            _text = value;
        }
        
        override public function execute ( responder : me.imcj.as3object.Responder ) : void
        {
            
            _statement.execute ( -1, new StatementSQLiteResponder ( this, responder ) );
        }
    }
}