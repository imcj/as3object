package flexUnitTests.me.imcj.as3object.fixture
{
    import mx.collections.ArrayCollection;
    import flash.display.DisplayObject;

    public class DPIGameObject extends GameObject
    {
        [Bindable]
        public var dpi : Number;
        
        [Bindable]
        [Declare(type="flash.display.DisplayObject")]
        public var resource : ArrayCollection;
        
        
        public function DPIGameObject ( )
        {
            super ( );
        }
        
        override public function addChild ( child : DisplayObject ) : DisplayObject
        {
            resource.addItem ( child );
            return super.addChild ( child );
        }
    }
}