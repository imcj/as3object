package me.imcj.as3object.sqlite
{
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import me.imcj.as3object.Table;
	import me.imcj.as3object.field.IFieldBuilder;
	import me.imcj.as3object.sqlite.field.Convert;
	
	public class SQLiteFieldBuilder implements IFieldBuilder
	{
		public function SQLiteFieldBuilder (  )
		{
		}
		
		public function generate ( type : Object ) : Array
		{
			var describe : XML = type is Class ? describeType( type ) : describeType ( getDefinitionByName ( getQualifiedClassName ( type ) ) );
			var variable : XML;
			var metadata : XML;
			var ignore   : Boolean = false;
			var objectFields : XML = <fields />;
			var objectField  : XML;
			
			var fields : Array = new Array ( );
			var name   : String;
			
			for each ( variable in describe.factory.variable ) {
				objectField = <field name={variable.@name} type={variable.@type} />;
				objectField.metadata += variable.metadata;
				objectFields.appendChild ( objectField )
			}
			
			for each ( variable in describe.factory.accessor.( @access == "readonly" || @access == "readwrite" ) ) {
				objectField = <field name={variable.@name} type={variable.@type} declaredBy={variable.@declaredBy} />;
				objectField.metadata += variable.metadata;
				objectFields.appendChild ( objectField )
			}
			
			for each ( variable in describe.factory.method ) {
				
				if ( String ( variable.@name ).substr ( 0, 3 ) != "get" )
					continue;
				
				name = String ( variable.@name ).substr ( 3 );
				
				objectField = <field name={name} type={variable.@returnType} declareBy={variable.@declareBy} />;
				objectField.metadata += variable.metadata;
				objectFields.appendChild ( objectField )
			}
			
			for each ( variable in objectFields.field ) {
				if ( hasMetadata ( "Exclude", variable.metadata ) )
					continue;
				
				fields.push ( SQLiteField.create ( variable.@name, variable.@type ) );
			}
			
			return fields;
		}
		
		protected function hasMetadata ( name : String, metadata : XMLList ) : Boolean
		{
			return metadata.( @name == name ).length () > 0 ? true : false;
		}
	}
}