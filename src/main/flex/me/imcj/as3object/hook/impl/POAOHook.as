package me.imcj.as3object.hook.impl
{
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;
    
    import me.imcj.as3object.AS3Object;
    import me.imcj.as3object.AsyncRepository;
    import me.imcj.as3object.Column;
    import me.imcj.as3object.Facade;
    import me.imcj.as3object.PropertyChangedCache;
    import me.imcj.as3object.Table;
    import me.imcj.as3object.TableCache;
    import me.imcj.as3object.hook.HookManager;
    
    import mx.collections.ArrayCollection;
    import mx.events.CollectionEvent;
    import mx.events.CollectionEventKind;
    import mx.events.PropertyChangeEvent;
    
    import test.me.imcj.as3object.hook.HookAction;
    
    public class POAOHook extends HookImpl
    {
        protected var delay : ArrayCollection = new ArrayCollection ( );
        
        protected var propertyChanged : PropertyChangedCache;
        
        public var tableCache : TableCache;
        public var repository : AsyncRepository;
        
        static public var facade : Facade;
        
        public function POAOHook ( )
        {
            
        }
        
        override public function set hookManager(value:HookManager):void
        {
            propertyChanged = new PropertyChangedCache ( value.tableCache );
            
            super.hookManager = value;
        }
        
        override public function execute ( data : Object ) : HookAction
        {
            var table : Table = data['table'];
            var instance : EventDispatcher;
            
            var nothing : Boolean = false;
            
            if ( null == table )
                nothing = true;
            
            if ( null == data['instance'] )
                nothing = true;
            
            if ( ! ( data['instance'] is IEventDispatcher ) )
                nothing = true;
            
            if ( nothing )
                return HookAction.createNothing ( );
            
            if ( null == tableCache )
                tableCache = Facade.instance.cache;
            
            if ( ! facade )
                facade = Facade.instance;
            
            instance =  data['instance'] as EventDispatcher;
            instance.addEventListener ( AS3Object.SAVE,    handlerSave );
            instance.addEventListener ( PropertyChangeEvent.PROPERTY_CHANGE, handlerPorpertyChange );
            instance.addEventListener ( AS3Object.COMMIT,  handlerCommit );
            
            var column : Column;
            
            for each ( column in table.oneToManyColumns )
                collectionBind ( instance, column.name );
                
            return HookAction.createNothing ( );
        }
        
        protected function handlerPorpertyChange ( changeEvent : PropertyChangeEvent ) : void
        {
            var propertyName : String = changeEvent.property as String;
            var column : Column = tableCache.getWithObject ( changeEvent.source ).getColumn ( propertyName );
            
            if ( ! column )
                return;
            
//            if ( column.primary )
//                return;
            
            if ( column.isNotBaseDataType ( ) )
                return;
            
            propertyChanged.push ( changeEvent.source, propertyName );
        }
        
        protected function handlerCommit ( event : Event ) : void
        {
            save ( event.currentTarget );
        }
        
        protected function handlerSave ( event : Event ) : void
        {
//            if ( null == repository )
//                delay.addItem ( event.currentTarget );
//            else
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
                facade.add ( object, new POAOSaveResponder ( object ) );
            else
                facade.update ( propertyChanged.getUpdaterWithObject ( object ), object, new POAOUpdateResponder ( object ) );
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
            var changeEvent : PropertyChangeEvent;
            
            switch ( event.kind ) {
                case CollectionEventKind.ADD: {
                    for each ( object in event.items )
                        save ( object );
                    break;
                }
                case CollectionEventKind.UPDATE: {
                    handlerPorpertyChange ( PropertyChangeEvent ( event.items[0] ) );
                    break;
                }
            }
        }
    }
}