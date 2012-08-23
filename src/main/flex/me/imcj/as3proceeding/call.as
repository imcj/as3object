package me.imcj.as3proceeding
{
    public function call ( func : Function, ... args ) : CallImpl
    {
        return new CallImpl ( func, args );
    }
}