package me.imcj.as3object.field
{
	import me.imcj.as3object.Dict;

	public class FieldBuilder implements IFieldBuilder
	{
		protected var _fields:Dict;
		
		public function FieldBuilder ( fields : Dict )
		{
			_fields = fields;
		}
	}
}