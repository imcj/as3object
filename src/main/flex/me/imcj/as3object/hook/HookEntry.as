package me.imcj.as3object.hook
{
    public class HookEntry
    {
        static public const CREATE_INSTANCE  : String = "CREATE_INSTANCE";
        static public const REBUILD_INSTANCE : String = "REBUILD_INSTANCE";
        static public const CREATE_COLUMN    : String = "CREATE_COLUMN";
        
        static public const ADD         : String = "ADD";
        static public const ADD_SUCCESS : String = "ADD_SUCCESS";
        static public const ADD_FAULT   : String = "ADD_FAULT";
        
        static public const UPDATE         : String = "UPDATE";
        static public const UPDATE_SUCCESS : String = "UPDATE_SUCCESS";
        static public const UPDATE_FAULT   : String = "UPDATE_FAULT";
        
        static public const SAVE         : String = "SAVE";
        static public const SAVE_SUCCESS : String = "SAVE_SUCCESS";
        static public const SAVE_FAULT   : String = "SAVE_FAULT";
    }
}