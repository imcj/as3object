package me.imcj.as3object
{
	import as3.sql.Types;
	
	import me.imcj.as3object.core.Dict;
	import me.imcj.as3object.type.BooleanType;
	import me.imcj.as3object.type.CharacterType;
	import me.imcj.as3object.type.IntegerType;
	import me.imcj.as3object.type.Type;
	
	import org.as3commons.reflect.Type;

	public class Mapping
	{
		public var dialect : Dict;
		public var as3type : Dict;
		public var as3objectType : Dict;
        
        static protected var _instance : Mapping = new Mapping ( );
		
		public function Mapping()
		{
			dialect = new Dict ( );
			as3type = new Dict ( );
			as3objectType = new Dict ( );
			
			dialect.add(Types.BIT.toString ( ), "integer");
			dialect.add(Types.TINYINT.toString ( ), "tinyint");
			dialect.add(Types.SMALLINT.toString ( ), "smallint");
			dialect.add(Types.INTEGER.toString ( ), "integer");
			dialect.add(Types.BIGINT.toString ( ), "bigint");
			dialect.add(Types.FLOAT.toString ( ), "float");
			dialect.add(Types.REAL.toString ( ), "real");
			dialect.add(Types.DOUBLE.toString ( ), "double");
			dialect.add(Types.NUMERIC.toString ( ), "numeric");
			dialect.add(Types.DECIMAL.toString ( ), "decimal");
			dialect.add(Types.CHAR.toString ( ), "char");
			dialect.add(Types.VARCHAR.toString ( ), "varchar");
			dialect.add(Types.LONGVARCHAR.toString ( ), "longvarchar");
			dialect.add(Types.DATE.toString ( ), "date");
			dialect.add(Types.TIME.toString ( ), "time");
			dialect.add(Types.TIMESTAMP.toString ( ), "timestamp");
			dialect.add(Types.BINARY.toString ( ), "blob");
			dialect.add(Types.VARBINARY.toString ( ), "blob");
			dialect.add(Types.LONGVARBINARY.toString ( ), "blob");
			dialect.add(Types.BLOB.toString ( ), "blob");
			dialect.add(Types.CLOB.toString ( ), "clob");
			dialect.add(Types.BOOLEAN.toString ( ), "integer");
			
			
			as3type.add ( org.as3commons.reflect.Type.forClass ( int ).fullName, Types.INTEGER );
            as3type.add ( org.as3commons.reflect.Type.forClass ( uint ).fullName, Types.BIGINT );
            as3type.add ( org.as3commons.reflect.Type.forClass ( Number ).fullName, Types.REAL );
            as3type.add ( org.as3commons.reflect.Type.forClass ( Date ).fullName, Types.DATE );
            as3type.add ( org.as3commons.reflect.Type.forClass ( Boolean ).fullName, Types.DATE );
            as3type.add ( "String", Types.VARCHAR );
            
			as3objectType.add ( "String", new CharacterType ( ) );
			as3objectType.add ( org.as3commons.reflect.Type.forClass ( uint ).fullName, new IntegerType ( ) );
            as3objectType.add ( org.as3commons.reflect.Type.forClass ( int ).fullName, new IntegerType ( ) );
            as3objectType.add ( org.as3commons.reflect.Type.forClass ( Number ).fullName, new IntegerType ( ) );
            as3objectType.add ( org.as3commons.reflect.Type.forClass ( Boolean ).fullName, new BooleanType ( ) );
		}
        
        public function getColumnTypeWithType ( fullName : String ) : String
        {
            var as3typeToDialect : int = as3type.get ( fullName ) as int;
            var notDefinedMapping : Boolean = 0 == as3typeToDialect;
            if ( notDefinedMapping && fullName.indexOf ( "::" ) == -1
                && fullName != "Object"
                && fullName != "Array" )
                throw new Error ( "Not defined mapping ", fullName );
            
            var columnType : String = dialect.get ( as3typeToDialect.toString ( ) ) as String;
            if ( ! columnType )
                return dialect.get ( Types.INTEGER.toString ( ) ) as String;
            
            return columnType;
        }
        
		public function getAS3ObjectType ( fullName : String ) : me.imcj.as3object.type.Type
		{
			return as3objectType.get ( fullName ) as me.imcj.as3object.type.Type;
		}
        
        public function getAS3ObjectTypeWithInstance ( instance : Object ) : me.imcj.as3object.type.Type
        {
            return getAS3ObjectType ( org.as3commons.reflect.Type.forInstance ( instance ).fullName );
        }
        
        static public function get instance ( ) : Mapping
        {
            return _instance;
        }
	}
}