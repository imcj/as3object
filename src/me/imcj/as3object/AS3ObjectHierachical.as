package me.imcj.as3object
{
    import flash.events.EventDispatcher;
    
    import mx.collections.ArrayCollection;
    import mx.collections.ICollectionView;
    import mx.controls.treeClasses.ITreeDataDescriptor;
    
    public class AS3ObjectHierachical extends EventDispatcher implements ITreeDataDescriptor
    {
        [Bindable]
        public var id : int;
        
        [Bindable]
        public var uuid : String;
        
        private var _parent : AS3ObjectHierachical;
        private var _nodes : ArrayCollection = new ArrayCollection ();
        private var _objects : ArrayCollection = new ArrayCollection ();
        
        public function AS3ObjectHierachical()
        {
        }
        
        [Ignore]
        public function get children () : ArrayCollection
        {
            return _nodes;
        }
        
        public function get parent () : AS3ObjectHierachical
        {
            return _parent;
        }
        
        public function set parent ( value : AS3ObjectHierachical ) : void
        {
            _parent = value;
        }
        
        public function getChildren(node:Object, model:Object=null):ICollectionView
        {
            return AS3ObjectHierachical(node).children;
        }
        
        public function hasChildren(node:Object, model:Object=null):Boolean
        {
            var n : AS3ObjectHierachical = AS3ObjectHierachical(node);
            if ( ! node )
                return false;
            if ( ! n.children )
                return false;
            return AS3ObjectHierachical(node).children.length > 0 ? false : true;
        }
        
        public function isBranch(node:Object, model:Object=null):Boolean
        {
            return AS3ObjectHierachical(node).children == null ? false : true;
        }
        
        public function getData(node:Object, model:Object=null):Object
        {
            return node;
        }
        
        public function addChild ( child : AS3ObjectHierachical ) : AS3ObjectHierachical
        {
            addChildAt ( this, child, _nodes.length );
            return child;
        }
        
        public function addChildAt(parent:Object, newChild:Object, index:int, model:Object=null):Boolean
        {
            var p : AS3ObjectHierachical = AS3ObjectHierachical(parent);
            var children : ArrayCollection;
            var child : AS3ObjectHierachical = AS3ObjectHierachical ( newChild );
            if ( parent is AS3ObjectHierachical ) {
                children = ArrayCollection ( p.getChildren(parent, model) );
                child.parent = AS3ObjectHierachical ( parent ); 
                children.addItemAt ( child, index );
            }
            return true;
        }
        
        public function removeChildAt(parent:Object, child:Object, index:int, model:Object=null):Boolean
        {
            return false;
        }
    }
}