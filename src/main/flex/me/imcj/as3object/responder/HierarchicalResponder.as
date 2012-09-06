package me.imcj.as3object.responder
{
    import me.imcj.as3object.AS3ObjectHierachical;
    import me.imcj.as3object.Column;
    import me.imcj.as3object.Result;
    import me.imcj.as3object.Table;
    import me.imcj.as3object.core.Iterator;
    import me.imcj.as3object.hook.HookManager;
    
    import mx.rpc.IResponder;
    
    public class HierarchicalResponder extends SelectResponder
    {
        public var tree : Object = new Object ( );
        
        public function HierarchicalResponder ( table : Table, responder : IResponder, hook : HookManager )
        {
            super ( table, responder, hook );
        }
        
        override public function result ( result : Result ) : void
        {
            var object  : Object;
            object = rebuild ( result.data as Array );
            responder.result ( object );
        }
        
        protected function rebuild ( data : Array ) : *
        {
            var instance : Object;
            var key : String;
            var children : Object;
            var top : AS3ObjectHierachical;
            var parent : Object;
            var result : Object;
            
            if ( ! data )
                return null;
            
            for ( var i : int = 0, size : int = data.length; i < size; i++ ) {
                result = data[i];
                instance = create ( result );
                
                hook.execute ( "rebuild_instance", { "instance" : instance, "table" : table } );
                
                if ( 0 == i )
                    top = AS3ObjectHierachical ( instance );
//                if (  instance.hasOwnProperty ( "id" )  )
//                    key = "id";
//                else if ( instance.hasOwnProperty ( "uuid" ) )
//                    key = "uuid";
            }
            
            return top;
        }
        
        protected function create ( result : Object ) : Object
        {
            var instance : Object = table.createInstance ( result  );
            tree[table.getPrimaryValue ( instance )] = instance;
            
            var parent : int;
            if ( result.hasOwnProperty ( 'parent_id' ) )
                if ( result['parent_id'] )
                    parent = result['parent_id'] as int;
            
            if ( parent > 0 ) {
                if ( tree.hasOwnProperty ( parent ) )
                    AS3ObjectHierachical ( tree[parent] ).addChild ( instance as AS3ObjectHierachical );
            }
            return instance;
        }
    }
}