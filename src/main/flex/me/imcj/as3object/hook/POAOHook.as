package me.imcj.as3object.hook
{
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;
    
    import me.imcj.as3object.AS3Object;
    import me.imcj.as3object.AS3ObjectResponder;
    import me.imcj.as3object.AsyncRepository;
    import me.imcj.as3object.Facade;
    import me.imcj.as3object.PropertyChangedCache;
    import me.imcj.as3object.Table;
    import me.imcj.as3object.TableCache;
    import me.imcj.as3object.core.DictIterator;
    import me.imcj.as3object.sqlite.field.RelationField;
    
    import mx.collections.ArrayCollection;
    import mx.events.CollectionEvent;
    import mx.events.CollectionEventKind;
    import mx.events.PropertyChangeEvent;
    
    public class POAOHook implements Hook
    {
        protected var delay : ArrayCollection = new ArrayCollection ( );
        
        protected var propertyChanged : PropertyChangedCache;
        
        public var tableCache : TableCache;
        public var repository : AsyncRepository;
        
        public function POAOHook ( )
        {
            propertyChanged = new PropertyChangedCache ( );
        }
        
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
            
            if ( null == tableCache )
                tableCache = Facade.instance.cache;
            
            instance =  data['instance'] as EventDispatcher;
            instance.addEventListener ( AS3Object.SAVE,    handlerSave );
            instance.addEventListener ( AS3Object.COMMIT,  handlerCommit );
            
            var relationField : RelationField;
            var iter : DictIterator = new DictIterator ( table.collection );
            while ( iter.hasNext ) {
                relationField = RelationField ( iter.next ( ) );
                collectionBind ( instance, relationField.poaoName );
            }
        }
        
        protected function handlerCommit ( event : Event ) : void
        {
            save ( event.currentTarget );
        }
        
        protected function handlerSave ( event : Event ) : void
        {
            if ( null == repository )
                delay.addItem ( event.currentTarget );
            else
                save ( event.currentTarget );
        }
        
        protected function createRespository ( _repository : AsyncRepository ) : void
        {
            repository = _repository;
            
            var object : Object;
            if ( delay.length > 0 ) {
                for ( var i : int = 0, size : int = delay.length; i < size; i++ ) {
                    object = delay.removeItemAt ( i );
                    save ( object );
                }
            }
        }
        
        protected function save ( object : Object ) : void
        {
            var table : Table = tableCache.getWithObject ( object );
            
            if ( null == table.getPrimaryValue ( object ) )
                repository.add ( object, new POAOSaveResponder ( object ) );
            else
                repository.update ( object, new POAOUpdateResponder ( object ) );
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
                        save ( object );
                    break;
                }
                case CollectionEventKind.UPDATE: {
                    propertyChanged.push ( object, PropertyChangeEvent ( event.items[0] ).property as String );
                }
            }
        }
    }
}