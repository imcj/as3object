package me.imcj.as3object
{
    import me.imcj.as3object.hook.HookManager;

    public class ConnectionFactoryImpl implements ConnectionFactory
    {
        private var hook:HookManager;
        
        public function ConnectionFactoryImpl ( hook : HookManager )
        {
            this.hook = hook;
        }
        
        public function create ( config : Config ) : Connection
        {
            var connection : Connection;
            
            // TODO Bug SQLite连接只能是一个
            switch ( config.DATABASE_ENGINE ) {
                case "sqlite": {
                    connection = new ConnectionSQLite ( config, hook );
                    break;
                }
            }
            
            return connection;
        }
    }
}