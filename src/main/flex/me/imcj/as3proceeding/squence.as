package me.imcj.as3proceeding
{
    import mx.rpc.IResponder;

    public function squence ( execute : Array, responder : IResponder = null ) : SequenceImpl
    {
        var impl : SequenceImpl = new SequenceImpl ( execute );
        if ( responder )
            impl.addResponder ( responder );
        
        return impl;
    }
}