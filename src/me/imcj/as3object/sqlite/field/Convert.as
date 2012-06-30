package me.imcj.as3object.sqlite.field
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import me.imcj.as3object.field.*;
	
	import mx.utils.StringUtil;

	public class Convert
	{
		static protected var mapping : Object = {
			"String" : "TextField",
			"int"    : "IntegerField",
			"number" : "NumberField"
		}
		public function Convert (  )
		{
			TextField;
			IntegerField;
			NumberField;
		}
		
		static public function to ( type : String, name : String ) : Field
		{
			var qname : String = StringUtil.substitute ( "me.imcj.as3object.sqlite.field::{0}", mapping[type] );
			trace ( getQualifiedClassName ( new TextField ( "name" ) ) );
			
			return new ( getDefinitionByName ( qname ) ) ( name ) ;
		}
	}
}