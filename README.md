# Rails_QuickTemplate
A Rails **API-only** starter template designed for **small teams** and
**maintainable backend development**.<br>
This template prioritizes clarity, conventions, and team scalability
over rapid prototyping.

## Requirements
- Ruby 3.4.x
- Rails 8.x
- PostgreSQL
- Docker (optional, for database)

## Quick Start

### 1. Install dependencies
```bash
bundle install
```

### 2. Prepare database
```bash
bin/rails db:prepare
```

### 3. Start server
```bash
bin/rails s
```

Server will be available at:
http://localhost:3000

## Database
This project uses PostgreSQL.

### Local setup
- PostgreSQL running on localhost:5432

### Docker (optional)
You can run PostgreSQL using Docker for better environment consistency.<br>
(See docker-compose configuration if enabled.)

Database connection settings are defined in config/database.yml.

## Project Policy
- API-only Rails application
- Designed for small team development
- Opinionated defaults to avoid bikeshedding
- Docker is optional, not required
- Deployment strategy is intentionally flexible

## Deployment
This template does not enforce a single deployment method.

Recommended options:
- Render / Fly.io (small teams)
- AWS ECS / GCP Cloud Run (production / organization use)

Choose based on your team and infrastructure requirements.