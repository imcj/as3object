package me.imcj.as3object
{
    import avmplus.getQualifiedClassName;
    
    import flash.utils.Dictionary;
    
    public class TableCache extends Dictionary
    {
        public function TableCache(weakKeys:Boolean=false)
        {
            super(weakKeys);
        }
        
        public function get ( table : Object ) : Table
        {
//            if ( table is String )
            var tableName : String = getQualifiedClassName ( table );
            
            return this[tableName];
        }
    }
}