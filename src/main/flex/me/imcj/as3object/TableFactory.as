package me.imcj.as3object
{
    import flash.utils.getDefinitionByName;
    import flash.utils.getQualifiedClassName;
    
    import me.imcj.as3object.hook.HookManager;
    import me.imcj.as3object.hook.HookManagerDefault;
    import me.imcj.as3object.sqlite.SQLiteHierarchicalTable;
    import me.imcj.as3object.sqlite.SQLiteTable;
    
    import org.as3commons.reflect.Type;

    public class TableFactory
    {
        public var config : Config;
        public var hook   : HookManager;
        
        public function TableFactory ( config : Config, hook : HookManager )
        {
            this.config = config;
            this.hook   = hook;
        }
        
        public function create ( type : Object ) : Table
        {
            
            var n : Type;
            var instance : Table;
            
            if ( type is String )
                n = Type.forName ( type as String );
            else if ( type is Class )
                n = Type.forClass ( type as Class );
            else if ( type is Object )
                n = Type.forInstance ( type );
            
            switch ( config.DATABASE_ENGINE )
            {
                case "sqlite":
                {
                    if ( isHierachical ( n.extendsClasses ) )
                        instance = new SQLiteHierarchicalTable ( n );
                    else
                        instance = new SQLiteTable ( n ); 
                    break;
                }
            }
            
            instance.hook = hook;
            return instance;
        }
        
        protected function isHierachical ( extendClasses : Array ) : Boolean
        {
            var extendClass : String;
            for each ( extendClass in extendClasses )
                if ( extendClass == "me.imcj.as3object::AS3ObjectHierachical" )
                    return true;
                
            return false;
        }
    }
}