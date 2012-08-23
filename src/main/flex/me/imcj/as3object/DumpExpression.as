package me.imcj.as3object
{
    import flash.utils.ByteArray;
    
    import me.imcj.as3object.expression.AndExpression;
    import me.imcj.as3object.expression.EqualExpression;
    import me.imcj.as3object.expression.GreaterThanEqualExpression;
    import me.imcj.as3object.expression.GreaterThanExpression;
    import me.imcj.as3object.expression.InExpression;
    import me.imcj.as3object.expression.LessThanEqualExpression;
    import me.imcj.as3object.expression.LessThanExpression;
    import me.imcj.as3object.expression.LikeExpression;
    import me.imcj.as3object.expression.NotExpression;
    import me.imcj.as3object.expression.OrExpression;

    public interface DumpExpression
    {
        function andExpression ( buffer : ByteArray, expression : AndExpression ) : void;
        function orExpression ( buffer : ByteArray, expression : OrExpression ) : void;
        function equalExpression ( buffer : ByteArray, expression : EqualExpression ) : void;
        function notExpression ( buffer : ByteArray, expression : NotExpression ) : void;
        function greaterThanEqualExpression ( buffer : ByteArray, expression : GreaterThanEqualExpression ) : void;
        function greaterThanExpression ( buffer : ByteArray, expression : GreaterThanExpression ) : void;
        function lessThanEqualExpression ( buffer : ByteArray, expression : LessThanEqualExpression ) : void;
        function lessThanExpression ( buffer : ByteArray, expression : LessThanExpression ) : void;
        function inExpression ( buffer : ByteArray, expression : InExpression ) : void;
        function like ( buffer : ByteArray, expression : LikeExpression ) : void;
        
        function toString ( ) : String;
        function toByteArray ( ) : ByteArray;
    }
}