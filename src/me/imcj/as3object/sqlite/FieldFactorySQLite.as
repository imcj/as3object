package me.imcj.as3object.sqlite
{
    import flash.utils.getDefinitionByName;
    
    import me.imcj.as3object.AS3ObjectField;
    import me.imcj.as3object.FieldFactory;
    import me.imcj.as3object.Table;
    import me.imcj.as3object.sqlite.field.DateTimeField;
    import me.imcj.as3object.sqlite.field.IntegerField;
    import me.imcj.as3object.sqlite.field.RealField;
    import me.imcj.as3object.sqlite.field.RelationField;
    import me.imcj.as3object.sqlite.field.StringField;
    import me.imcj.as3object.sqlite.field.TextField;
    import me.imcj.as3object.sqlite.field.intField;
    
    import mx.utils.StringUtil;
    
    import org.as3commons.reflect.Accessor;
    import org.as3commons.reflect.Field;
    import org.as3commons.reflect.Metadata;
    import org.as3commons.reflect.MetadataArgument;
    import org.as3commons.reflect.MetadataContainer;
    import org.as3commons.reflect.Method;
    import org.as3commons.reflect.Type;

    public class FieldFactorySQLite implements FieldFactory
    {
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
            DateTimeField;
            StringField;
            intField;
            
            var qname      : String;
            var fieldClass : Class
            var instance   : AS3ObjectField;
            
            if ( "prototype" == name )
                return null;
            
            qname = StringUtil.substitute ( "me.imcj.as3object.sqlite.field.{0}Field", type.name );
            
            try {
                fieldClass = Class ( getDefinitionByName ( qname ) );
                
            } catch ( error : ReferenceError ) {
                try {
                    fieldClass = RelationField;
                } catch ( error : ReferenceError ) {
                    return null;
                }
            }
            
            instance = new fieldClass ( name );
            
            
            if ( instance is RelationField ) {
                RelationField ( instance ).relationClass = type.clazz;
            }
            
            switch ( type.name ) {
                case "ArrayCollection": {
                    _table.collection.add ( name, instance );
                    return null;
                    break;
                }
                default:
                    break;
            }
            
            instance.table = _table;
            instance.metadataContainer = metaContainer; 
            return instance;
        }
        
        public function create ( ) : void
        {
            var type : Type = _table.type;
            var field : org.as3commons.reflect.Field;
            var sqliteField : me.imcj.as3object.AS3ObjectField;
            var method : Method;
            
            for each ( field in type.fields ) {
                if ( filterField ( field ) ) {
                    sqliteField = createByField ( field );
                    if ( sqliteField )
                        _table.fields.add ( sqliteField.name, sqliteField );
                }
            }
            
            for each ( method in type.methods ) {
                if ( method.hasMetadata ( "Field" ) )
                    if ( type.getMethod ( getSetMethodName ( method.name ) ) )
                        if ( ( sqliteField = createByMethod ( method ) ) )
                            _table.fields.add ( sqliteField.name, sqliteField );
            }
        }
        
        protected function getSetMethodName ( name : String ) : String
        {
            if ( "get" == name.substr ( 0, 3 ) )
                return "set" + name.substr ( 3 );
            return null;
        }
        
        protected function filterField ( field : org.as3commons.reflect.Field ) : org.as3commons.reflect.Field
        {
            var accessor : Accessor;
            if ( field is Accessor ) {
                accessor = Accessor ( field );
                if ( ! accessor.writeable || ! accessor.readable )
                    return null;
            }
            
            if ( field.hasMetadata ( "Ignore" ) )
                return null;
            
            return field;
        }
    }
}