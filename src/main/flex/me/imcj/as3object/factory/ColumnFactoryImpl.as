package me.imcj.as3object.factory {
    
import me.imcj.as3object.Column;
import me.imcj.as3object.Table;
import me.imcj.as3object.core.Dict;

import org.as3commons.reflect.Accessor;
import org.as3commons.reflect.Field;
import org.as3commons.reflect.Metadata;
import org.as3commons.reflect.MetadataArgument;
import org.as3commons.reflect.MetadataContainer;
import org.as3commons.reflect.Method;
import org.as3commons.reflect.Type;

public class ColumnFactoryImpl implements ColumnFactory
{
    public function create ( table : Table ) : void
    {
        var f : ColumnFactoryX = new ColumnFactoryX ( table );
    }
}

}
import me.imcj.as3object.Table;

import org.as3commons.reflect.Type;
import me.imcj.as3object.core.Dict;
import org.as3commons.reflect.Method;
import org.as3commons.reflect.Metadata;
import org.as3commons.reflect.MetadataArgument;
import org.as3commons.reflect.Accessor;
import me.imcj.as3object.Column;
import org.as3commons.reflect.MetadataContainer;

class ColumnFactoryX
{
    public var columns : Dict = new Dict ( );
    private var type:Type;
    private var table:Table;
    
    public function ColumnFactoryX ( table : Table )
    {
        this.type = table.type;
        this.table = table;
        
        var accessor : org.as3commons.reflect.Field;
        var field : me.imcj.as3object.Column;
        var method : Method;
        
        for each ( accessor in type.fields ) {
            if ( areAvailable ( accessor ) ) {
                field = createInstance ( accessor.name, accessor.type, accessor );
                if ( field ) {
                    table.addColumn ( field );
                }
            }
        }
        
        createWithMethods ( );
    }
    
    protected function createInstance ( name : String, type : Type, metadataContainer : MetadataContainer ) : me.imcj.as3object.Column
    {
        var field : me.imcj.as3object.Column= new me.imcj.as3object.Column ( name, type, metadataContainer, table );
        
        return field;
    }
    
    protected function areAvailable ( field : org.as3commons.reflect.Field ) : Boolean
    {
        var accessor : Accessor;
        if ( field is Accessor ) {
            accessor = Accessor ( field );
            if ( ! accessor.writeable || ! accessor.readable )
                return false;
        }
        
        return true;
    }
    
    protected function createWithMethods ( ) : void
    {
        var name : String;
        
        var field     : me.imcj.as3object.Column;
        var method    : Method;
        var metadata  : Metadata;
        var prefix    : String;
        var metadatas : Array;
        
        var isTwin    : Boolean;
        var isCustom  : Boolean;
        
        var setter :  MetadataArgument;
        var getter :  MetadataArgument;
        var pName  :  MetadataArgument;
        
        var getterMethod : Method;
        var setterMethod : Method
        
        for each ( method in type.methods ) {
            metadatas = method.getMetadata ( "Field" );
            if ( null == metadatas )
                continue;
            metadata = metadatas[0];
            if ( null == metadata )
                continue;
            
            prefix = method.name.substr ( 0, 3 );
            
            getter = metadata.getArgument ( "getter" );
            setter = metadata.getArgument ( "setter" );
            pName  = metadata.getArgument ( "name" );
            
            name = pName ? pName.value : method.name.substr ( 3, 1 ).toLowerCase ( ) + method.name.substr ( 4 );
            
            isCustom = getter && setter;
            
            if ( isCustom ) {
                getterMethod = type.getMethod ( getter.value );
                setterMethod = type.getMethod ( setter.value );
            } else {
                getterMethod = type.getMethod ( "get" + name.substr ( 0, 1 ).toUpperCase ( ) + name.substr ( 1 ) );
                setterMethod = type.getMethod ( "set" + name.substr ( 0, 1 ).toUpperCase ( ) + name.substr ( 1 ) );
            }
            
            if ( ! getterMethod || ! setterMethod )
                continue;
            
            field = createInstance ( name, method.returnType, method );
            
            field.getMethod = getterMethod.name;
            field.setMethod = setterMethod.name;
            
            table.addColumn ( field );
        }
    }
}