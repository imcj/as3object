package me.imcj.as3object.hook
{
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;
    
    import me.imcj.as3object.AS3Object;
    import me.imcj.as3object.AS3ObjectResponder;
    import me.imcj.as3object.AsyncRepository;
    import me.imcj.as3object.Facade;
    import me.imcj.as3object.Table;
    import me.imcj.as3object.core.DictIterator;
    import me.imcj.as3object.sqlite.field.RelationField;
    
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
            instance.addEventListener ( AS3Object.SAVE, add );
            
            var relationField : RelationField;
            
            var iter : DictIterator = new DictIterator ( table.collection );
            while ( iter.hasNext ) {
                relationField = RelationField ( iter.next ( ) );
                collectionBind ( instance, relationField.poaoName );
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
        
        protected function collectionBind ( poao : Object, property : String ) : void
        {
            if ( null == poao[property] )
                poao[property] = new ArrayCollection ( );
            
            ArrayCollection ( poao[property] ).addEventListener ( CollectionEvent.COLLECTION_CHANGE, collectionChange );
        }
        
        protected function collectionChange ( event : CollectionEvent ) : void
        {
            var object : Object;
            switch ( event.kind ) {
                case CollectionEventKind.ADD: {
                    for each ( object in event.items )
                        addObject ( object );
                    break;
                }
            }
        }
        
        protected function addObject ( object : Object ) : void
        {
            if ( object.hasOwnProperty ( "id" ) )
                repository.add ( object, new AS3ObjectResponder ( persistenceAdded, persistenceAddedFault ) );
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
            trace ( info );
        }
    }
}