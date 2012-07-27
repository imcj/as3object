package me.imcj.as3object.hook
{
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;
    
    import me.imcj.as3object.AS3ObjectResponder;
    import me.imcj.as3object.AsyncRepository;
    import me.imcj.as3object.Facade;
    import me.imcj.as3object.Hook;
    import me.imcj.as3object.Table;
    import me.imcj.as3object.core.DictIterator;
    
    import mx.collections.ArrayCollection;
    import mx.events.CollectionEvent;
    import mx.events.CollectionEventKind;
    import mx.events.PropertyChangeEvent;
    
    public class POAOHook implements Hook
    {
        static protected var repository : AsyncRepository;
        private var delay : ArrayCollection = new ArrayCollection ( );
        
        public function execute ( data : Object ) : void
        {
            var table : Table = data['table'];
            var instance : EventDispatcher;
            
            if ( null == table )
                return;
            
            if ( null == data['instance'] )
                return;
            
            if ( ! ( data['instance'] is IEventDispatcher ) )
                return;
            
            if ( null == repository )
                Facade.instance.createRepository ( new AS3ObjectResponder ( createRespository ) );
            
            instance =  data['instance'] as EventDispatcher;
            instance.addEventListener ( PropertyChangeEvent.PROPERTY_CHANGE, bind );
            instance.addEventListener ( "PERSISTENCE_ADD", add );
            
            var property : Object;
            
            for ( var x : String in Object ( data['instance'] ) ) {
                trace ( x );
            }
            var iter : DictIterator = new DictIterator ( table.fields );
            while ( iter.hasNext ) {
                property = iter.next ( );
                if ( property is ArrayCollection )
                    collectionBind ( property as ArrayCollection );
            }
        }
        
        protected function add ( event : Event ) : void
        {
            if ( null == repository )
                delay.addItem ( event.currentTarget );
            else
                repository.add ( event.currentTarget, new AS3ObjectResponder ( persistenceAdded, persistenceAddedFault ) );
        }
        
        protected function createRespository ( _repository : AsyncRepository ) : void
        {
            repository = _repository;
            
            var object : Object;
            if ( delay.length > 0 ) {
                for ( var i : int = 0, size : int = delay.length; i < size; i++ ) {
                    object = delay.removeItemAt ( i );
                    repository.add ( object, new AS3ObjectResponder ( persistenceAdded, persistenceAddedFault ) );
                }
            }
        }
        
        protected function bind ( event : PropertyChangeEvent ) : void
        {
        }
        
        protected function collectionBind ( collection : ArrayCollection ) : void
        {
            if ( null == collection )
                collection = new ArrayCollection ( );
            
            collection.addEventListener ( CollectionEvent.COLLECTION_CHANGE, collectionChange );
        }
        
        protected function collectionChange ( event : CollectionEvent ) : void
        {
            var object : Object;
            switch ( event.kind ) {
                case CollectionEventKind.ADD: {
                    for each ( object in event.items )
                        repository.add ( object, new AS3ObjectResponder ( persistenceAdded, persistenceAddedFault ) );
                    break;
                }
            }
        }
        
        protected function persistenceAdded ( object : Object ) : void
        {
            var eventObject : EventDispatcher;
            if ( object is EventDispatcher ) {
                eventObject = EventDispatcher ( object );
                eventObject.dispatchEvent ( new Event ( "PERSISTENCE_ADDED" ) );
            }
        }
        
        protected function persistenceAddedFault ( info : Object ) : void
        {
            
        }
    }
}