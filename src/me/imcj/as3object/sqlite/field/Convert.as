package me.imcj.as3object.sqlite.field
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import me.imcj.as3object.field.*;
	
	import mx.utils.StringUtil;

	public class Convert
	{
		static protected var mapping : Object = {
 			"String"  : "TEXT",
			"int"     : "INTEGER",
            "uint"    : "INTEGER",
			"Number"  : "REAL",
            "Date"    : "TEXT",
            "Boolean" : "INTEGER"
            
		};

		public function Convert (  )
		{
			TextField;
			IntegerField;
			RealField;
		}
		
		static public function to ( type : String, name : String ) : Field
		{

		}
	}
}