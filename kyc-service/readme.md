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

### Criar tabela no KYV 

```shell
mkdir -p migrations
diesel setup
diesel migration generate create_kyc_table

```

### Abra o arquivo migrations/YYYYMMDDHHMMSS_create_kyc_table/up.sql e adicione:

```shell
CREATE TABLE kyc_entries (
    id SERIAL PRIMARY KEY,
    user_email TEXT NOT NULL UNIQUE,
    identity_hash TEXT NOT NULL,
    status TEXT NOT NULL CHECK (status IN ('pending', 'approved', 'rejected')),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

```

### Abra migrations/YYYYMMDDHHMMSS_create_kyc_table/down.sql e adicione:

```sql
DROP TABLE kyc_entries;
```

### Execute as migrações

```shell
diesel migration run
```


