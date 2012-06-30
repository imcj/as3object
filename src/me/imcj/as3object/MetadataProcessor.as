package me.imcj.as3object
{
    import flash.utils.describeType;

    public class MetadataProcessor
    {
        public function MetadataProcessor (  )
        {
        }
        
        public function process ( type : Class ) : void
        {
            var describe : XML = describeType ( type );
        }
    }
}