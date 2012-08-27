package me.imcj.as3object
{
    public class NotFoundPrimaryError extends Error
    {
        public function NotFoundPrimaryError(message:*="", id:*=0)
        {
            if ( "" == message )
                message = "Not found primary field.";
            super(message, id);
        }
    }
}