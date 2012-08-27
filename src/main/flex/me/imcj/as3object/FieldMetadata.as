package me.imcj.as3object
{
    import me.imcj.as3object.core.Dict;
    
    import org.as3commons.reflect.Type;

    public class FieldMetadata
    {
        private var fields:Dict;
        private var type:Type;
        
        public function FieldMetadata ( type : Type, fields : Dict )
        {
            this.type = type;
            this.fields = fields;
        }
        
        public function excludeType ( type : Class ) : void
        {
            
        }
        
        public function excludeProperty ( property : String ) : void
        {
            excludeField ( property );
        }
        
        public function excludeField ( field : String ) : void
        {
        }
        
        public function includeType ( type : Class ) : void
        {
            
        }
        
        public function includeProperty ( property : String ) : void
        {
            excludeField ( property );
        }
        
        public function includeField ( field : String ) : void
        {
            
        }
        
        public function commit ( ) : void
        {
            
        }
    }
}