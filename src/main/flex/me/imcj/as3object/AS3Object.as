package me.imcj.as3object {
import flash.events.EventDispatcher;

import me.imcj.as3object.core.Dict;

public class AS3Object extends EventDispatcher
{
    static public const ADD         : String = "ADD";
    static public const ADD_SUCCESS : String = "ADD_SUCCESS";
    static public const ADD_FAULT   : String = "ADD_FAULT";
    
    static public const UPDATE         : String = "UPDATE";
    static public const UPDATE_SUCCESS : String = "UPDATE_SUCCESS";
    static public const UPDATE_FAULT   : String = "UPDATE_FAULT";
    
    static public const SAVE         : String = "SAVE";
    static public const SAVE_SUCCESS : String = "SAVE_SUCCESS";
    static public const SAVE_FAULT   : String = "SAVE_FAULT";
    
    static public const COMMIT : String = "commit";
    
    static public var fieldsMapWithType : Dict = new Dict ( );
    static public var types : Dict = new Dict ( );
    
    public function AS3Object()
    {
    }
}

}
