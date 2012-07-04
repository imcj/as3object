package me.imcj.as3object.core
{
    public interface Iterator
    {
        /**
        * 
        * Returns true if the iteration has more elements.
        * 
        */
        function get hasNext ( ) : Boolean;
        
        /**
        * 
        * Returns the next element in the iteration.
        * 
        */
        function next ( ) : Object;
        
        /**
        * 
        * Removes from the underlying collection the last element returned by the iterator (optional operation).
        */
        function remove ( ) : Object;
    }
}