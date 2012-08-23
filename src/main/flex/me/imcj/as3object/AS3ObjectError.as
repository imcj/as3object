package me.imcj.as3object
{
    public class AS3ObjectError extends Error
    {
        public function AS3ObjectError(message:*="", id:*=0)
        {
            super(message, id);
        }
    }
}