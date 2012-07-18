package me.imcj.as3object
{
    public interface Responder
    {
        function result ( data : Result ) : void;
        function fault ( info : Object ) : void;
    }
}