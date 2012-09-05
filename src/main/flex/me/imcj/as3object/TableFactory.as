package me.imcj.as3object {
import me.imcj.as3object.factory.ColumnFactory;
import me.imcj.as3object.factory.ColumnFactoryImpl;
import me.imcj.as3object.hook.HookManager;
import me.imcj.as3object.hook.impl.HookManagerImpl;

import org.as3commons.reflect.Type;

public class TableFactory
{
    public var config : Config;
    public var hook   : HookManager;
    public var columnFactory : ColumnFactory;
    
    public var tableCache : TableCache;
        
    /**
    * 由工厂创建不同方言的DDL或DML对象
    */
//        public var dds : DDLFactory;
//        public var dms : DMLFactory;
        
    public function TableFactory ( config : Config, tableCache : TableCache )
    {
        this.config = config;
        this.columnFactory = new ColumnFactoryImpl ( );
        this.tableCache = tableCache;
        this.tableCache.factory = this;
    }
    
    static public function createFactory ( ) : TableFactory
    {
        var config : Config = Config.createInMemory ( );
        var tableCache : TableCache = new TableCache ( );
        var tableFactory : TableFactory = new TableFactory ( config, tableCache );
        tableFactory.hook = HookManagerImpl.create ( config, tableFactory, tableCache );
        
        return tableFactory;
    }
    
    public function create ( param : Object ) : Table
    {
        var type : Type;
        var table : Table;
        
        if ( param is String )
            type = Type.forName ( param as String );
        else if ( param is Class )
            type = Type.forClass ( param as Class );
        else if ( param is Object )
            type = Type.forInstance ( param );
        else if ( param is Type )
            type = Type( param );
        
        table = new Table ( type, tableCache );
        table.columns = columnFactory.create ( table );
        table.ddl = new DDLImpl ( table );
        table.dml = new DMLImpl ( table );
        
        tableCache.add ( table.type.fullName, table );
        
        hook.execute ( "build_column", { "table" : table } );
        return table;
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