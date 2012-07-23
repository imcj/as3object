package me.imcj.as3object.sqlite
{
    import flash.utils.getDefinitionByName;
    
    import me.imcj.as3object.AS3ObjectField;
    import me.imcj.as3object.FieldFactory;
    import me.imcj.as3object.Table;
    import me.imcj.as3object.sqlite.field.ArrayCollectionField;
    import me.imcj.as3object.sqlite.field.DateTimeField;
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

    public class FieldFactorySQLite implements FieldFactory
    {
        protected var mapping : Object = {
            "String"  : "Text",
            "int"     : "Integer",
            "uint"    : "Integer",
            "Number"  : "Real",
            "Date"    : "DateTime",
            "Boolean" : "Integer",
            "mx.collections::ArrayCollection" : "ArrayCollection"
        };
        
        protected var _table:Table;
        
        public function FieldFactorySQLite ( table : Table )
        {
            _table = table;
        }
        
        public function createByMethod ( method : Method ) : AS3ObjectField
        {
            var metadata : Metadata;
            var argument : MetadataArgument;
            var name     : String;
            var field    : AS3ObjectField;
            
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
        
        
        public function createByField ( field : Field ) : AS3ObjectField
        {
            return _create ( field.name, field.type, MetadataContainer ( field ) );
        }
        
        protected function _create ( name : String, type : Type, metaContainer : MetadataContainer ) : AS3ObjectField
        {
            TextField;
            RealField;
            IntegerField;
            ArrayCollectionField;
            DateTimeField;
            
            var qname      : String;
            var fieldClass : Class
            var instance   : AS3ObjectField;
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
                    field.table = _table;
                    
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
            
            instance.table = _table;
            return instance;
        }
        
        public function create ( any : Object ) : AS3ObjectField
        {
            if ( any is Method )
                return createByMethod ( Method ( any ) );
            else if ( any is Field )
                return createByField ( Field ( any ) );
            else
                return null;
        }
    }
}