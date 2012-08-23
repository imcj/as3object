package me.imcj.as3proceeding
{
    public function responder ( result : Function = null, fault : Function = null ) : AS3ProceedingResponder
    {
        return new AS3ProceedingResponder ( result, fault );
    }
}