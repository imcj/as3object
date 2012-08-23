package me.imcj.as3object
{
    import flash.utils.ByteArray;

    public interface SQLField
    {
        function buildCreateTableColumnDefine ( buffer : ByteArray ) : void
        function buildInsertColumn ( buffer : ByteArray ) : void;
        function buildInsertValue ( buffer : ByteArray, object : Object ) : void;
        function buildUpdateAssign ( buffer : ByteArray, object : Object ) : void;
    }
}