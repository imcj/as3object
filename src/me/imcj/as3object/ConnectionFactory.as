package me.imcj.as3object
{
    public interface ConnectionFactory
    {
        function create ( config : Config ) : Connection;
    }
}