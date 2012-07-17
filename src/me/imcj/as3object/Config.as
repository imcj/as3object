package me.imcj.as3object
{
    public class Config
    {
        public var DATABASE_ENGINE   : String;
        public var DATABASE_NAME     : String;
        public var DATABASE_USER     : String;
        public var DATABASE_PASSWORD : String;
        public var DATABASE_HOST     : String;
        public var DATABASE_PORT     : int;
        public var IN_MEMORY         : Boolean;
        
        public function Config()
        {
        }
        
        static public function create (
            database_engine : String, database_name : String, database_user : String,
            database_password : String, database_host : String, database_port : int ) : Config
        {
            var config : Config = new Config ( );
            config.DATABASE_ENGINE   = database_engine;
            config.DATABASE_NAME     = database_name;
            config.DATABASE_USER     = database_user;
            config.DATABASE_PASSWORD = database_password;
            config.DATABASE_HOST     = database_host;
            config.DATABASE_PORT     = database_port;
            
            return config;
        }
        
        static public function create2 ( database_engine : String, database_name : String ) : Config
        {
            return create ( database_engine, database_name, null, null, null, null );
        }
        
        static public function createInMemory ( ) : Config
        {
            var config : Config = create2 ( "sqlite", null );
            config.IN_MEMORY = true;
            
            return config;
        }
    }
}