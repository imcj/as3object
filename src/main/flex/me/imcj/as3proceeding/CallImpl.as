package me.imcj.as3proceeding
{
    public class CallImpl
    {
        protected var _func : Function;
        protected var _args : Array;
        protected var _parallelResponder : AS3ProceedingResponder;
        
        public function CallImpl ( func : Function, args : Array )
        {
            _func = func;
            _args = args;
            
            var i : int = 0, size : int = args.length;
            for ( ; i < size; i++ )
                if ( args[i] is AS3ProceedingResponder )
                    _parallelResponder = args[i];
        }
        
        public function call ( ) : void
        {
            var size : int = _args.length;
            switch ( size ) {
                case 1:
                    _func ( _args[0] );
                    break;
                case 2:
                    _func ( _args[0], _args[1] );
                    break;
                case 3:
                    _func ( _args[0], _args[1], _args[2] );
                    break;
                case 4:
                    _func ( _args[0], _args[1], _args[2], _args[3] );
                    break;
                case 5:
                    _func ( _args[0], _args[1], _args[2], _args[3], _args[4] );
                    break;
                case 6:
                    _func ( _args[0], _args[1], _args[2], _args[3], _args[4], _args[5] );
                    break;
                case 7:
                    _func ( _args[0], _args[1], _args[2], _args[3], _args[4], _args[5], _args[6] );
                    break;
                case 8:
                    _func ( _args[0], _args[1], _args[2], _args[3], _args[4], _args[5], _args[6], _args[7] );
                    break;
                case 9:
                    _func ( _args[0], _args[1], _args[2], _args[3], _args[4], _args[5], _args[6], _args[7], _args[8] );
                    break;
                case 10:
                    _func ( _args[0], _args[1], _args[2], _args[3], _args[4], _args[5], _args[6], _args[7], _args[8], _args[9] );
                    break;
                case 11:
                    _func ( _args[0], _args[1], _args[2], _args[3], _args[4], _args[5], _args[6], _args[7], _args[8], _args[9], _args[10] );
                    break;
                case 12:
                    _func ( _args[0], _args[1], _args[2], _args[3], _args[4], _args[5], _args[6], _args[7], _args[8], _args[9], _args[10], _args[11] );
                    break;
            }
        }
        
        public function get args ( ) : Array
        {
            return _args;
        }
        
        public function get parallelResponder ( ) : AS3ProceedingResponder
        {
            return _parallelResponder;
        }
        
        public function addIntoResponder ( result : Function, fault : Function ) : CallImpl
        {
            _parallelResponder
                .addResult ( result )
                .addFault ( fault );
                
            return this;
        }
        
    }
}