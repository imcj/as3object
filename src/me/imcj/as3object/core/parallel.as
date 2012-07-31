package me.imcj.as3object.core
{
    import mx.rpc.IResponder;

    public function parallel ( execute : Array, responder : IResponder = null ) : ParallelImpl
    {
        var impl : ParallelImpl = new ParallelImpl ( execute );
        
        if ( responder )
            impl.addResponder ( responder );
        
        return impl;
    }
}