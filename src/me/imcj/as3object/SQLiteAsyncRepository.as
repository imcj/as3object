package me.imcj.as3object
{
    import flash.data.SQLConnection;
    import flash.data.SQLMode;
    import flash.data.SQLResult;
    import flash.data.SQLStatement;
    import flash.events.SQLEvent;
    import flash.filesystem.File;

	[Event(name="open", type="flash.events.SQLEvent")]
	[Event(name="result", type="me.imcj.as3object.ObjectEvent")]
    public class SQLiteAsyncRepository extends Repository implements AsyncRepository
    {
        static protected var _connection : SQLConnection;
        static protected var _facade : Facade = Facade.instance;
        protected var _object : Object;
        
        public function SQLiteAsyncRepository ( connection : Object )
        {
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
			dispatchEvent ( event );
        }
        
        public function add ( object : Object ) : Object
        {
            _object = object;
            
            var statement : SQLStatement = new SQLStatement ( );
            statement.addEventListener ( SQLEvent.RESULT, handlerResult );
            statement.sqlConnection = _connection;
            statement.text = _facade.getTable ( object ).insert ( object );
            statement.execute ( );
            
            return object;
        }
        
        protected function handlerResult ( event : SQLEvent ) : void
        {
			if ( ! _object )
				return;
			
            var statment : SQLStatement = SQLStatement ( event.currentTarget );
            var result   : SQLResult    = statment.getResult ( );
            if ( _object.hasOwnProperty ( "id" ) )
                _object["id"] = result.lastInsertRowID;
			
			dispatchEvent ( new me.imcj.as3object.ObjectEvent ( me.imcj.as3object.ObjectEvent.RESULT, _object ) );
        }
        
		public function update ( object : Object ) : Object
		{
			return object;
		}
		
		public function remove ( object : Object ) : void
		{
		}
        
        public function find ( ) : Array
        {
            return null;
        }
		
		public function findAll ( ) : Array
		{
			return null;
		}
		
		public function creationStatement ( object : Object ) : void
		{
			var statement : SQLStatement = new SQLStatement ( );
			statement.addEventListener ( SQLEvent.RESULT, handlerResult );
			statement.sqlConnection = _connection;
			statement.text = _facade.getTable ( object ).creationStatement ( );
			statement.execute ( );
		}
	}
}