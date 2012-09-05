package me.imcj.as3object.task {
    
import com.adobe.cairngorm.task.Task;

import me.imcj.as3object.AS3ObjectError;
import me.imcj.as3object.AS3ObjectResponder;
import me.imcj.as3object.Facade;

public class CreateTable extends Task
{
    private var facade : Facade;
    private var responder : AS3ObjectResponder;
    private var type:Class;
    private var ifNotExists:Boolean;
    
    public function CreateTable ( type : Class, ifNotExists : Boolean = true ) : void
    {
        trace ( type );
        this.type = type;
        this.ifNotExists = ifNotExists;
        facade = Facade.instance;
    }
    
    public function onResult ( data : Object ) : void
    {
        complete();
    }
    
    public function onFault ( info : Object ) : void
    {
        this.fault ( );
    }
    
    override protected function performTask():void
    {
        trace ( "execute:", this.type );
        responder = new AS3ObjectResponder ( onResult, onFault );
        facade.createTable ( this.type, responder, ifNotExists );
    }
}

}
