package me.imcj.as3object
{
    import flash.data.SQLConnection;
    import flash.data.SQLMode;
    import flash.data.SQLResult;
    import flash.data.SQLStatement;
    import flash.events.EventDispatcher;
    import flash.events.SQLEvent;
    import flash.filesystem.File;
    
    import me.imcj.as3object.expression.Expression;
    import me.imcj.as3object.expression.eq;
    import me.imcj.as3object.sqlite.SQLiteHierarchicalTable;
    import me.imcj.as3object.sqlite.SQLiteTable;
    import me.imcj.as3object.sqlite.responder.CreationStatementResponder;
    import me.imcj.as3object.sqlite.responder.HierarchicalSelectResponder;
    import me.imcj.as3object.sqlite.responder.InsertResponder;
    import me.imcj.as3object.sqlite.responder.SelectResponder;
    import me.imcj.as3object.sqlite.responder.UpdateResponder;
    
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
            
            if ( _table is SQLiteHierarchicalTable ) {
                if ( null == responder )
                    statement.execute ( );
                else
                    statement.execute ( -1, new HierarchicalSelectResponder ( _table, responder ) );
            }
            
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