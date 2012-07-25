package me.imcj.as3object.sqlite
{
    import org.as3commons.reflect.Type;
    import me.imcj.as3object.Hierarchical;

    public class SQLiteHierarchicalTable extends SQLiteTable implements Hierarchical
    {
        public function SQLiteHierarchicalTable ( type : Type = null )
        {
            super ( type );
        }
    }
}