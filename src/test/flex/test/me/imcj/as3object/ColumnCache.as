package test.me.imcj.as3object {
    
import me.imcj.as3object.core.Dict;

public class ColumnCache extends Dict
{
    static protected var _instance : ColumnCache;
    
    public function ColumnCache()
    {
        super ( );
    }
    
    static public function get instance ( ) : ColumnCache
    {
        if ( null == _instance )
            _instance = new ColumnCache ( );
        
        return _instance;
    }
}

}