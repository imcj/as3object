package me.imcj.as3object
{
    public interface Responder
    {
        function result ( data : Object ) : void;
        function fault ( info : Object ) : void;
    }
}