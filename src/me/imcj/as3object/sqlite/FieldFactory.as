package me.imcj.as3object.sqlite
{
    import flash.utils.getDefinitionByName;
    
    import me.imcj.as3object.sqlite.field.ArrayCollectionField;
    import me.imcj.as3object.sqlite.field.IntegerField;
    import me.imcj.as3object.sqlite.field.RealField;
    import me.imcj.as3object.sqlite.field.RelationField;
    import me.imcj.as3object.sqlite.field.TextField;
    
    import mx.utils.StringUtil;
    
    import org.as3commons.reflect.Field;
    import org.as3commons.reflect.Metadata;
    import org.as3commons.reflect.MetadataArgument;
    import org.as3commons.reflect.MetadataContainer;
    import org.as3commons.reflect.Method;
    import org.as3commons.reflect.Type;

    public class FieldFactory
    {
        static protected var _instance : FieldFactory;
        
        protected var mapping : Object = {
            "String"  : "Text",
            "int"     : "Integer",
            "uint"    : "Integer",
            "Number"  : "Real",
            "Date"    : "DateTime",
            "Boolean" : "Integer",
            "mx.collections::ArrayCollection" : "ArrayCollection"
        };
        
        public function FieldFactory()
        {
        }
        
        public function createByMethod ( method : Method ) : SQLiteField
        {
            var metadata : Metadata;
            var argument : MetadataArgument;
            var name     : String;
            var field    : SQLiteField;
            
            // TODO 成对出现 get and set
            if ( method.hasMetadata ( "Field" ) )
            {
                metadata = Metadata ( method.getMetadata ( "Field" )[0] );
                
                name = method.name.substr ( 3 );
                name = name.substr ( 0, 1 ).toLowerCase ( ) + name.substring ( 1, name.length );
                
                field = _create ( name, method.returnType, MetadataContainer ( method ) );
                field.isMethod = true;
                return field;
            }
            return null;
        }
        
        
        public function createByField ( field : Field ) : SQLiteField
        {
            return _create ( field.name, field.type, MetadataContainer ( field ) );
        }
        
        protected function _create ( name : String, type : Type, metaContainer : MetadataContainer ) : SQLiteField
        {
            TextField;
            RealField;
            IntegerField;
            ArrayCollectionField;
            
            var qname      : String;
            var fieldClass : Class
            var instance   : SQLiteField;
            var type2 : String;
            
            if ( "prototype" == name )
                return null;
            
            type2 = mapping[type.fullName];
            if ( "ArrayCollection" == type2 )
                return null;
            
            if ( null == type2 ) {
//                if ( hasInterface ( type.interfaces, "mx.controls.treeClasses.ITreeDataDescriptor" ) ) {
//                    
//                }
                var relationClass : Class;
                var field : RelationField;
                try {
                    relationClass = getDefinitionByName ( type.fullName ) as Class;
                    field = new RelationField ( name );
                    field.relationClass = relationClass;
                    
                    return field;
                } catch ( error : ReferenceError ) {
                    return null;
                }
            }
            
            qname = StringUtil.substitute ( "me.imcj.as3object.sqlite.field.{0}Field", type2 );
            fieldClass = Class ( getDefinitionByName ( qname ) );
            
            switch ( type2 ) {
                case "ArrayCollection":
                    //					return new fieldClass ( name, 
                    break;
                default:
                    instance = new fieldClass ( name );
                    break;
            }
            
            return instance;
        }
        
        public function create ( any : Object ) : SQLiteField
        {
            if ( any is Method )
                return createByMethod ( Method ( any ) );
            else if ( any is Field )
                return createByField ( Field ( any ) );
            else
                return null;
        }
        
        static public function get instance ( ) : FieldFactory
        {
            if ( ! _instance )
                _instance = new FieldFactory ( );
            
            return _instance;
        }
    }
}