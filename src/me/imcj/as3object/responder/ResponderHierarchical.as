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
            var top : AS3ObjectHierachical;
            var parent : Object;
            var result : Object;
            
            for ( var i : int = 0, size : int = data.length; i < size; i++ ) {
                result = data[i];
                instance = create ( result );
                if ( 0 == i )
                    top = AS3ObjectHierachical ( instance );
//                if (  instance.hasOwnProperty ( "id" )  )
//                    key = "id";
//                else if ( instance.hasOwnProperty ( "uuid" ) )
//                    key = "uuid";
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
                    
                    var value : String = String ( result[field.name] );
                    if ( result.hasOwnProperty ( field.name ) && tree.hasOwnProperty ( value ) )
                        AS3ObjectHierachical ( tree[value] ).addChild ( AS3ObjectHierachical ( instance ) );
                }
                field.setPOAOValue ( instance, result );
            }
            tree[instance.id] = instance;
            
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