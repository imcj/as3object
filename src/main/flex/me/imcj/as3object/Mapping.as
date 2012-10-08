package me.imcj.as3object
{
	import as3.sql.Types;
	
	import me.imcj.as3object.core.Dict;
	import me.imcj.as3object.type.CharacterType;
	import me.imcj.as3object.type.IntegerType;
	import me.imcj.as3object.type.Type;
	
//	import org.as3commons.reflect.Type;

	public class Mapping
	{
		public var dialect : Dict;
		public var as3type : Dict;
		public var as3objectType : Dict;
		
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
			
			
//			as3type.add ( org.as3commons.reflect.Type.forClass ( int ).name, Types.BIT );
			as3type.add ( "String", Types.CHAR );
			
			as3objectType.add ( Types.CHAR.toString ( ), CharacterType );
			as3objectType.add ( Types.INTEGER.toString ( ), IntegerType );
		}
		
		public function getAS3ObjectType ( typeCode : int ) : Type
		{
			return as3objectType.get ( typeCode.toString ( ) ) as Type;
		}
	}
}