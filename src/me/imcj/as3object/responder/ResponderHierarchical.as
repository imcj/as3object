package me.imcj.as3object.responder
{
    import me.imcj.as3object.Result;
    import me.imcj.as3object.Table;
    
    import mx.controls.menuClasses.IMenuDataDescriptor;
    import mx.controls.treeClasses.ITreeDataDescriptor;
    import mx.rpc.IResponder;
    
    public class ResponderHierarchical extends ResponderSelect
    {
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
            var tree : Object = new Object ( );
            var key : String;
            var children : Object;
            var top : Object;
            var parent : Object;
            
            for ( var i : int = 0, size : int = data.length; i < size; i++ ) {
                instance = create ( data[i] );
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