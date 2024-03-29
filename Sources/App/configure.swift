import FluentSQLite
import Redis
import Vapor

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    /// redis connection config
    try services.register(RedisProvider())

    var redisConfig = RedisClientConfig()
    redisConfig.hostname = Environment.get("REDIS_HOST") ?? "redis"
    redisConfig.port = 6379
    let redis = try RedisDatabase(config: redisConfig)
    var databases = DatabasesConfig()
    databases.add(database: redis, as: .redis)
    
    services.register(databases)

    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    // Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    // middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)
    let serverConfiure = NIOServerConfig.default(hostname: "0.0.0.0", port: 4000)
    services.register(serverConfiure)
}
