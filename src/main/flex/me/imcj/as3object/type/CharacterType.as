package me.imcj.as3object.type
{
    import me.imcj.as3object.Column;

	public class CharacterType implements Type
	{
		public function CharacterType()
		{
		}
		
		public function objectToString(column : Column, object:Object):String
		{
			return "'" + String ( object ) + "'";
		}
	}
}