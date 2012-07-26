package me.imcj.as3object.persistence
{
    import flash.events.Event;
    import flash.utils.Dictionary;
    
    import me.imcj.as3object.AS3Object;
    import me.imcj.as3object.AS3ObjectResponder;
    import me.imcj.as3object.AsyncRepository;
    import me.imcj.as3object.Facade;

    public class ObjectManager
    {
        protected static var _instance:Object;
        protected var repository:AsyncRepository;
        
        public var objectPool : Dictionary = new Dictionary ( true );
        
        public function ObjectManager ( )
        {
            Facade.instance.createRepository ( null, new AS3ObjectResponder ( createRepository ) );
        }
        
        protected function createRepository ( repository : AsyncRepository ) : void
        {
            this.repository = repository;
        }
        
        public function addAS3Object ( object : AS3Object ) : void
        {
            if ( objectPool.hasOwnProperty ( object.uid ) ) {
                objectPool[object.uid] = object;
                
                object.addEventListener ( ObjectManagerEvent.SAVE, handlerSave, false, 0, true );
            }
        }
        
        protected function handlerSave ( event : ObjectManagerEvent ) : void
        {
            repository.add ( event.object, new AS3ObjectResponder ( repositoryAdded  ) );
        }
        
        protected function repositoryAdded ( object : AS3Object ) : void
        {
            object.dispatchEvent ( new ObjectManagerEvent ( ObjectManagerEvent.PERSISTENCE_ADD, object ) );
        }
        
        public function removeAS3Object ( object : AS3Object ) : void
        {
            
        }
        
        static public function get instance ( ) : ObjectManager
        {
            if ( ! _instance )
                _instance = new ObjectManager ( );
            return _instance;
        }
    }
}