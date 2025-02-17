use actix_web::{web, App, HttpResponse, HttpServer, Responder};
use diesel::prelude::*;
use diesel::r2d2::{self, ConnectionManager};
use dotenv::dotenv;
use std::env;

type DbPool = r2d2::Pool<ConnectionManager<PgConnection>>;

/// Verifica a conexão com o banco de dados
async fn check_db(pool: web::Data<DbPool>) -> impl Responder {
    let conn = pool.get();

    match conn {
        Ok(_) => HttpResponse::Ok().body("Database connection is working!"),
        Err(_) => HttpResponse::InternalServerError().body("Failed to connect to database."),
    }
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    dotenv().ok();

    let database_url = env::var("DATABASE_URL").expect("DATABASE_URL not found");
    let manager = ConnectionManager::<PgConnection>::new(database_url);
    let pool = r2d2::Pool::builder()
        .build(manager)
        .expect("Failed to create pool.");

    HttpServer::new(move || {
        App::new()
            .app_data(web::Data::new(pool.clone()))
            .route(
                "/health",
                web::get().to(|| async { HttpResponse::Ok().body("KYC Service is running") }),
            )
            .route("/db-check", web::get().to(check_db)) // Testa conexão com o DB
    })
    .bind("127.0.0.1:8080")?
    .run()
    .await
}
