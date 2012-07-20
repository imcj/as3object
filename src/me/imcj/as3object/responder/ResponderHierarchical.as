package me.imcj.as3object.responder
{
    import me.imcj.as3object.AS3ObjectField;
    import me.imcj.as3object.AS3ObjectHierachical;
    import me.imcj.as3object.Result;
    import me.imcj.as3object.Table;
    import me.imcj.as3object.sqlite.field.RelationField;
    
    import mx.controls.menuClasses.IMenuDataDescriptor;
    import mx.controls.treeClasses.ITreeDataDescriptor;
    import mx.rpc.IResponder;
    
    public class ResponderHierarchical extends ResponderSelect
    {
        var tree : Object = new Object ( );
        
        public function ResponderHierarchical(table:Table, responder:IResponder)
        {
            super(table, responder);
        }
        
        override public function result ( result : Result ) : void
        {
            var object  : Object;
            
            object = rebuild ( result.data as Array );
            
            _responder.result ( object );
        }
        
        protected function rebuild ( data : Array ) : *
        {
            var instance : Object;
            var key : String;
            var children : Object;
            var top : Object;
            var parent : Object;
            var result : Object;
            
            for ( var i : int = 0, size : int = data.length; i < size; i++ ) {
                result = data[i];
                instance = create ( result );
                if (  instance.hasOwnProperty ( "id" )  )
                    key = "id";
                else if ( instance.hasOwnProperty ( "uuid" ) )
                    key = "uuid";
                
                
                // TODO parent 替换成关系字段来判断
                if ( data[i]['parent'] ) {
                    if ( ! instance is ITreeDataDescriptor || ! instance is IMenuDataDescriptor )
                        continue;
                    
                    // FIXME 不能乱顺序
                    parent = tree[data[i]['parent']];
                    parent.addChildAt ( parent, instance, 0 );
                    
                } else
                    top = instance;
                tree[instance.id] = instance;
            }
            
            return top;
        }
        
        override protected function create ( result : Object ) : Object
        {
            var fieldName : String;
            var field : AS3ObjectField;
            var instance : Object = new _table.type.clazz ();
            
            for each ( fieldName in _table.fields.keys ) {
                field = AS3ObjectField ( _table.fields.get ( fieldName ) );
                // 重建对象
                // is hierarchical
                if ( field is RelationField ) {
                    var relation : RelationField;
                    relation = RelationField ( field );
                    if ( ! relation.relationClass is AS3ObjectHierachical )
                        continue;
                    
                    if ( result.hasOwnProperty ( field.name ) && result[field.name] > 0 ) {
                        result['parent'] = tree[result[field.name]];
                    } else
                        result['parent'] = null;
                }
                field.setPOAOValue ( instance, result );
            }
            return instance;
        }
        
        protected function findParent ( data : Array, parent : int ) : Object
        {
            var returns : Object;
            findNode ( data, function ( item : Object ) : void
            {
                if ( int ( item['parent'] ) == parent )
                    returns = item;
            } );
            
            return returns;
        }
        
        protected function findNode ( data : Array, func : Function ) : void
        {
            for ( var i : int = 0, size : int = data.length; i < size; i++ )
                func ( data[i] );
        }
    }
}