## KYC Service

### Instalação

```bash
cargo install sqlx-cli --no-default-features --features postgres
```

### Inicialização do projeto

```bash
docker exec -it kyc_postgres psql -U admin -d kyc_database

```
### Criar tabela Users 

```sql
CREATE TABLE kyc_users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    identity_hash TEXT NOT NULL,
    approved BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW()
);
```
