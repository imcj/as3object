package me.imcj.as3object {

public class PropertyChangeQueue
{
    public var object : Object;
    public var property : String;
    
    public function PropertyChangeQueue ( object : Object, property : String )
    {
        this.object = object;
        this.property = property;
    }
}

}