# Request Processor Service

## Features
- Idempotent API using request_id
- Background job processing
- Retry mechanism
- Failure handling
- Cancellation support

## Setup
- rails db:create db:migrate
- rails s

## Endpoints
- POST /api/v1/requests
- GET /api/v1/requests/:id
- POST /api/v1/requests/:id/cancel
