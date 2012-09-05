package me.imcj.as3object {
import flash.data.SQLResult;
import flash.errors.SQLError;

public class StatementSQLiteResponder extends AS3ObjectResponder
{
    private var statement:Statement;
    private var responder:Responder;
    
    function StatementSQLiteResponder ( statement : Statement, responder : Responder )
    {
        this.statement = statement;
        this.responder = responder;
        
        super ( result, fault );
    }
    
    override public function result ( result : Object ) : void
    {
        trace ( this.statement.text );
        
        var r : Result = new Result ( result.data );
        r.lastInsertRowID = result.lastInsertRowID;
        r.rowsAffected = result.rowsAffected;
        
        responder.result ( r );
    }
    
    override public function fault ( info : Object ) : void
    {
        trace ( this.statement.text );
        
        var error : SQLError = SQLError ( info );
        var as3objectError : AS3ObjectError = new AS3ObjectError ( error.details, error.detailID );
        if ( responder.fault != null )
            responder.fault ( as3objectError );
        else
            throw as3objectError;
    }
}
}