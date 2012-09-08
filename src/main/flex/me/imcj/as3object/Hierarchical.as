package me.imcj.as3object
{
    import mx.controls.treeClasses.ITreeDataDescriptor;

    public interface Hierarchical extends ITreeDataDescriptor
    {
        function addChild ( child : Hierarchical ) : Hierarchical;
        
        function get parent ( ) : Hierarchical;
        function set parent ( value : Hierarchical ) : void;
    }
}