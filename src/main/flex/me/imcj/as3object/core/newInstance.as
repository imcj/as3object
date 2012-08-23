package me.imcj.as3object.core
{
    public function newInstance ( type : Class, attributes : Object ) : Object
    {
        var property : String;
        var instance : Object = new type ( );
        for ( property in attributes )
            if ( instance.hasOwnProperty ( property ) )
                instance[property] = attributes[property];
        
        return instance;
    }
}