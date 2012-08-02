package me.imcj.as3object
{
    import flash.events.EventDispatcher;
    import me.imcj.as3object.persistence.ObjectManager;
    import me.imcj.as3object.persistence.ObjectManagerEvent;
    
    import mx.utils.UIDUtil;

    [Event(name="save", type="me.imcj.as3object.persistence.ObjectManagerEvent")]
    [Event(name="persistenceAdd", type="me.imcj.as3object.persistence.ObjectManagerEvent")]
    public class AS3Object extends EventDispatcher
    {
        static public const PERSISTENCE_ADD   : String = "PERSISTENCE_ADD";
        static public const PERSISTENCE_ADDED : String = "PERSISTENCE_ADDED";
        static public const SAVE              : String = "save";
        
        protected var _uid : String;
        
        public function AS3Object()
        {
            _uid = UIDUtil.createUID ( );
            
//            var manager : ObjectManager = ObjectManager.instance;
//            manager.addAS3Object ( this );
        }
        
        public function get uid ( ) : String
        {
            return _uid;
        }
        
        public function save ( ) : void
        {
            dispatchEvent ( new ObjectManagerEvent ( ObjectManagerEvent.SAVE, this ) );
        }
    }
}
