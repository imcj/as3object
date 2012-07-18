package me.imcj.as3object
{
    public class ConnectionFactoryImpl implements ConnectionFactory
    {
        
        public function create ( config : Config ) : Connection
        {
            var connection : Connection;
            
            // TODO Bug SQLite连接只能是一个
            switch ( config.DATABASE_ENGINE ) {
                case "sqlite": {
                    connection = new ConnectionSQLite ( config );
                    break;
                }
            }
            
            return connection;
        }
    }
}