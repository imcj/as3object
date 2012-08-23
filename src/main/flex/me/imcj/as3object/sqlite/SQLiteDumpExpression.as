package me.imcj.as3object.sqlite
{
    import flash.utils.ByteArray;
    import flash.utils.getQualifiedClassName;
    
    import me.imcj.as3object.DumpExpression;
    import me.imcj.as3object.core.ArrayIterator;
    import me.imcj.as3object.core.Iterator;
    import me.imcj.as3object.expression.AndExpression;
    import me.imcj.as3object.expression.EqualExpression;
    import me.imcj.as3object.expression.Expression;
    import me.imcj.as3object.expression.GreaterThanEqualExpression;
    import me.imcj.as3object.expression.GreaterThanExpression;
    import me.imcj.as3object.expression.InExpression;
    import me.imcj.as3object.expression.LessThanEqualExpression;
    import me.imcj.as3object.expression.LessThanExpression;
    import me.imcj.as3object.expression.LikeExpression;
    import me.imcj.as3object.expression.NotExpression;
    import me.imcj.as3object.expression.OrExpression;
    
    import mx.utils.StringUtil;

    public class SQLiteDumpExpression implements DumpExpression
    {
        protected var _expression:Expression;
        protected var _buffer:ByteArray;
        
        public function SQLiteDumpExpression ( buffer : ByteArray, expression : Expression )
        {
            _buffer = buffer;
            _expression = expression;
            
            mapToFunction ( expression ) ( _buffer, expression );
        }
        
        public function andExpression ( buffer : ByteArray, expression : AndExpression ) : void
        {
            var i : int = 0, size : int = expression.expressions.length;
            var hasNext : Boolean
            
            buffer.writeUTFBytes ( "( " );
            
            for ( ; i < size; i++ ) {
                mapToFunction ( expression.expressions[i] ) ( buffer, expression.expressions[i] );
                
                hasNext = i < ( size - 1 );
                if ( hasNext )
                    buffer.writeUTFBytes ( " AND " );
            }
            
            buffer.writeUTFBytes ( " )" );
        }
        
        public function orExpression ( buffer : ByteArray, expression : OrExpression ) : void
        {
            var i : int = 0, size : int = expression.expressions.length;
            var hasNext : Boolean
            
            buffer.writeUTFBytes ( "( " );
            
            for ( ; i < size; i++ ) {
                this [ mapToFunction ( expression.expressions[i] ) ] ( buffer, expression.expressions[i] );
                
                hasNext = i < ( size - 1 );
                if ( hasNext )
                    buffer.writeUTFBytes ( " OR" );
            }
            
            buffer.writeUTFBytes ( " )" );
        }
        
        public function equalExpression ( buffer : ByteArray, expression : EqualExpression ) : void
        {
            buffer.writeUTFBytes ( expression.left );
            buffer.writeUTFBytes ( " = " );
            buffer.writeUTFBytes ( expression.right );
        }
        
        public function notExpression ( buffer : ByteArray, expression : NotExpression ) : void
        {
            buffer.writeUTFBytes ( expression.left );
            buffer.writeUTFBytes ( " != " );
            buffer.writeUTFBytes ( expression.right );
        }
        
        public function greaterThanEqualExpression ( buffer : ByteArray, expression : GreaterThanEqualExpression ) : void
        {
            buffer.writeUTFBytes ( expression.left );
            buffer.writeUTFBytes ( " >= " );
            buffer.writeUTFBytes ( expression.right );
        }
        
        public function greaterThanExpression ( buffer : ByteArray, expression : GreaterThanExpression ) : void
        {
            buffer.writeUTFBytes ( expression.left );
            buffer.writeUTFBytes ( " > " );
            buffer.writeUTFBytes ( expression.right );
        }
        
        public function lessThanEqualExpression ( buffer : ByteArray, expression : LessThanEqualExpression ) : void
        {
            buffer.writeUTFBytes ( expression.left );
            buffer.writeUTFBytes ( " <= " );
            buffer.writeUTFBytes ( expression.right );
        }
        
        public function lessThanExpression ( buffer : ByteArray, expression : LessThanExpression ) : void
        {
            buffer.writeUTFBytes ( expression.left );
            buffer.writeUTFBytes ( " < " );
            buffer.writeUTFBytes ( expression.right );
        }
        
        public function inExpression ( buffer : ByteArray, expression : InExpression ) : void
        {
            var v : String;
            var iter : Iterator = new ArrayIterator ( expression.right );
            buffer.writeUTFBytes ( expression.left );
            buffer.writeUTFBytes ( " in ( " );
            while ( v = String ( iter.next ) ) {
                buffer.writeUTFBytes ( v );
                if ( iter.hasNext )
                    buffer.writeUTFBytes ( ", " );
            }
            
            buffer.writeUTFBytes ( " )" );
        }
        
        public function like ( buffer : ByteArray, expression : LikeExpression ) : void
        {
            buffer.writeUTFBytes ( expression.left );
            buffer.writeUTFBytes ( " like " );
            buffer.writeUTFBytes ( expression.right );
        }
        
        protected function mapToFunction ( type : Object ) : Function
        {
            var functionName : String = getQualifiedClassName ( type ).split ( "::" )[1];
            var expressionWordPosition : int = functionName.lastIndexOf ( "Expression" );
            functionName = functionName.substr ( 0, 1 ).toLocaleLowerCase ( ) + functionName.substring ( 1 );
            return this[functionName];
        }
        
        public function toString () : String
        {
            return mapToFunction ( this ) ( _buffer, this );
        }
        
        public function toByteArray ( ) : ByteArray
        {
            return _buffer;
        }
    }
}