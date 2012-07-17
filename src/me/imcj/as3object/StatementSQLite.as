package me.imcj.as3object
{
    import flash.data.SQLStatement;
    import flash.net.Responder;
    
    import mx.rpc.IResponder;

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
        
        override public function execute ( responder : IResponder ) : void
        {
            _statement.execute ( -1, new flash.net.Responder ( responder.result, responder.fault ) );
        }
    }
}