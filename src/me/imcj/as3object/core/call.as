package me.imcj.as3object.core
{
    public function call ( func : Function, ... args ) : CallImpl
    {
        return new CallImpl ( func, args );
    }
}