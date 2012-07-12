package me.imcj.as3object
{
    import flash.data.SQLConnection;
    import flash.data.SQLMode;
    import flash.data.SQLResult;
    import flash.data.SQLStatement;
    import flash.events.EventDispatcher;
    import flash.events.SQLEvent;
    import flash.filesystem.File;
    import flash.net.Responder;
    
    import me.imcj.as3object.expression.Expression;
    import me.imcj.as3object.expression.eq;
    import me.imcj.as3object.sqlite.SQLiteTable;
    
    import mx.rpc.IResponder;

	[Event(name="result", type="me.imcj.as3object.ObjectEvent")]
	[Event(name="ready",  type="me.imcj.as3object.AsyncRepositoryEvent")]
    public class SQLiteAsyncRepository extends EventDispatcher implements AsyncRepository
    {
        static protected var _connection : SQLConnection;
        static protected var _facade : Facade = Facade.instance;
        protected var _object : Object;
        protected var _table  : SQLiteTable;
        
        public function SQLiteAsyncRepository ( connection : Object, object : Object = null )
        {
            _table = SQLiteTable ( _facade.getTable ( object ) );
            
            if (  _connection )
                return;
            
            _connection = new SQLConnection ( );
            _connection.addEventListener ( SQLEvent.OPEN, handlerOpen );
            
            if ( connection is String )
                _connection.openAsync ( new File ( String ( connection ) ), SQLMode.CREATE );
            else if ( connection is File )
                _connection.openAsync ( connection, SQLMode.CREATE );
            else
                _connection.openAsync ( null, SQLMode.CREATE );
        }
        
        protected function handlerOpen(event:SQLEvent):void
        {
			_connection.removeEventListener ( SQLEvent.OPEN, handlerOpen );
			dispatchEvent ( new AsyncRepositoryEvent ( AsyncRepositoryEvent.READY ) );
        }
        
        public function add ( object : Object, responder : IResponder ) : Object
        {
            var statement : SQLStatement = new SQLStatement ( );
            var handlerInsertResult : Function = function  ( event : SQLEvent ) : void
            {
                statement.removeEventListener ( SQLEvent.RESULT, handlerInsertResult );
                
                var result : SQLResult = statement.getResult ( );
                
                if ( _object.hasOwnProperty ( "id" ) )
                    _object["id"] = result.lastInsertRowID;
                
                dispatchEvent ( new me.imcj.as3object.ObjectEvent ( me.imcj.as3object.ObjectEvent.RESULT, object ) );
            };
                
            if ( null == responder )
                statement.addEventListener ( SQLEvent.RESULT, handlerInsertResult );
            
            statement.sqlConnection = _connection;
            statement.text = SQL ( _facade.getTable ( object ) ).insert ( object );
            statement.execute ( -1, new InsertResponder ( object, responder ) );
            
            return object;
        }

        
		public function update ( object : Object, responder : IResponder ) : void
		{
            var statement : SQLStatement = new SQLStatement ( );
            var handlerInsertResult : Function = function  ( event : SQLEvent ) : void
            {
                statement.removeEventListener ( SQLEvent.RESULT, handlerInsertResult );
                
                var result : SQLResult = statement.getResult ( );
                
                dispatchEvent ( new me.imcj.as3object.ObjectEvent ( me.imcj.as3object.ObjectEvent.RESULT, object ) );
            };
            
            if ( null == responder )
                statement.addEventListener ( SQLEvent.RESULT, handlerInsertResult );
            
            var expression : Expression;
            if ( _table.primaryKey )
                expression = eq ( _table.primaryKey.name, object[_table.primaryKey.name] );
            // TODO 如果没有主键,使用其它索引代替
            statement.sqlConnection = _connection;
            statement.text = _table.update ( object, expression );
            statement.execute ( -1, new UpdateResponder ( object, responder ) );
		}
		
		public function remove ( object : Object ) : void
		{
		}
        
        public function find ( expression : Expression, responder : IResponder ) : void
        {
            var statement : SQLStatement = new SQLStatement ( );
            statement.addEventListener ( SQLEvent.RESULT, handlerFindResult );
            statement.sqlConnection = _connection;
            statement.text = _table.select ( expression );
            
            if ( null == responder )
                statement.execute ( );
            else
                statement.execute ( -1, new SelectResponder ( _table, responder ) );
            
        }
        
        protected function handlerFindResult ( event : SQLEvent ) : void
        {
            var statement : SQLStatement = SQLStatement ( event.currentTarget );
            var result    : SQLResult    = statement.getResult ( );
            
            dispatchEvent ( new me.imcj.as3object.ObjectEvent ( me.imcj.as3object.ObjectEvent.RESULT, null ) );
            statement.removeEventListener ( SQLEvent.RESULT, handlerFindResult );
        }
        
		public function findAll ( responder : IResponder ) : void
		{
            find ( null, responder );
		}
		
		public function creationStatement ( object : Object, responder : IResponder, ifNotExists : Boolean = false ) : void
		{
			var statement : SQLStatement = new SQLStatement ( );
			statement.addEventListener ( SQLEvent.RESULT, handlerCreationStatementResult );
			statement.sqlConnection = _connection;
			statement.text = SQL ( _facade.getTable ( object ) ).creationStatement ( ifNotExists );
            
            if ( responder )
			    statement.execute ( -1, new CreationStatementResponder ( responder ) );
            else
                statement.execute ( );
		}
        
        protected function handlerCreationStatementResult ( event : SQLEvent ) : void
        {
            var statement : SQLStatement = SQLStatement ( event.currentTarget );
            dispatchEvent ( new me.imcj.as3object.ObjectEvent ( me.imcj.as3object.ObjectEvent.RESULT, null ) );
            statement.removeEventListener ( SQLEvent.RESULT, handlerCreationStatementResult );
        }
	}
}
import flash.data.SQLResult;
import flash.errors.SQLError;
import flash.net.Responder;

import me.imcj.as3object.Facade;
import me.imcj.as3object.sqlite.SQLiteTable;

import mx.rpc.IResponder;

class CreationStatementResponder extends Responder
{
    static public const SUCCESS : String = "success";
    static public const FAILURE : String = "failure";
    
    private var _responder:IResponder;
    
    public function CreationStatementResponder ( responder : IResponder )
    {
        _responder = responder;
        
        super ( result, fault );
    }
    
    public function result ( data : SQLResult ) : void
    {
        _responder.result ( SUCCESS );
    }
    
    public function fault ( error : SQLError ) : void
    {
        _responder.fault ( FAILURE );
    }
}

class InsertResponder extends Responder
{
    protected var _object    : Object;
    protected var _responder : IResponder;
    
    public function InsertResponder ( object : Object, responder : IResponder )
    {
        _object = object;
        _responder = responder;
        
        super ( result, fault );
    }
    
    public function fault ( info : SQLError ) : void
    {
    }
    
    public function result ( result : SQLResult ) : void
    {
        if ( _object.hasOwnProperty ( "id" ) )
            _object["id"] = result.lastInsertRowID;
        
        _responder.result ( _object );
    }
}

class UpdateResponder extends Responder
{
    protected var _object    : Object;
    protected var _responder : IResponder;
    
    public function UpdateResponder ( object : Object, responder : IResponder )
    {
        _object = object;
        _responder = responder;
        
        super ( result, fault );
    }
    
    public function fault ( info : SQLError ) : void
    {
        // TODO Update fault
    }
    
    public function result ( result : SQLResult ) : void
    {
        _responder.result ( _object );
    }
}

class SelectResponder extends Responder
{
//    static protected var _facade : Facade = Facade.instance;
    
    private var _responder : IResponder;
    private var _table:SQLiteTable;
    
    public function SelectResponder ( table : SQLiteTable, responder : IResponder )
    {
        _table = table;
        _responder = responder;
        
        super ( result, fault );
    }
    
    public function result ( result : SQLResult ) : void
    {
        var objects : Array = new Array ( );
        var object  : Object;
        
        for each ( object in result.data ) {
            objects[objects.length] = create ( object );
        }
        
        _responder.result ( objects );
    }
    
    protected function create ( object : Object ) : Object
    {
        var field : String;
        var instance : Object = new _table.type.clazz ();
        
        for ( field in object )
            _table.fields.get ( field ).fill ( instance, object );
                
        return instance;
    }
    
    public function fault ( info : SQLError ) : void
    {
        if ( null != _responder.fault ) {
            try {
            _responder.fault ( info );
            } catch ( error : Error ) {
                _responder.result ( null );
            }
        } else
            _responder.result ( null );
    }
}