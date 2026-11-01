# E-commerce REST API (Spring Boot + PostgreSQL)

## Packages
- `entity`: JPA entities and table relationships
- `repository`: Spring Data JPA repositories
- `service`: CRUD business/service methods
- `controller`: REST endpoints

## Run in IntelliJ IDEA
1. Open this folder as a Maven project.
2. Create a PostgreSQL database:
   ```sql
   CREATE DATABASE ecommerce_db;
   ```
3. Edit `src/main/resources/application.properties` and set the correct PostgreSQL username/password/port.
4. Wait for Maven dependencies to load.
5. Run `EcommerceApplication.java`.

`spring.jpa.hibernate.ddl-auto=update` creates/updates tables from entities. Use migrations and `validate` rather than `update` for production.

## REST endpoints
Each resource supports:
- `GET /api/{resource}` - list
- `GET /api/{resource}/{id}` - find one
- `POST /api/{resource}` - create
- `PUT /api/{resource}/{id}` - update
- `DELETE /api/{resource}/{id}` - delete

Resources:
- `/api/users`
- `/api/categories`
- `/api/products`
- `/api/orders`
- `/api/order-items`
- `/api/cart-items`

## Example requests

Create category (`POST http://localhost:8080/api/categories`):
```json
{
  "name": "Skincare",
  "image": "https://example.com/skincare.png"
}
```

Create product (`POST http://localhost:8080/api/products`):
```json
{
  "name": "Face Wash",
  "description": "Gentle daily cleanser",
  "price": 12.50,
  "stock": 25,
  "image": "https://example.com/face-wash.png",
  "category": { "id": 1 }
}
```

Create user (`POST http://localhost:8080/api/users`):
```json
{
  "name": "Sok Dara",
  "email": "dara@example.com",
  "password": "change-me",
  "phone": "012345678",
  "address": "Phnom Penh",
  "role": "user"
}
```

Create order (`POST http://localhost:8080/api/orders`):
```json
{
  "user": { "id": 1 },
  "totalAmount": 25.00,
  "status": "pending",
  "address": "Phnom Penh"
}
```

Create order item (`POST http://localhost:8080/api/order-items`):
```json
{
  "order": { "id": 1 },
  "product": { "id": 1 },
  "quantity": 2,
  "price": 12.50
}
```

Create cart item (`POST http://localhost:8080/api/cart-items`):
```json
{
  "cartId": 1,
  "product": { "id": 1 },
  "quantity": 1,
  "price": 12.50
}
```

## Important notes
- This starter project stores passwords as provided. Before real use, hash passwords with BCrypt and add authentication/authorization.
- The provided schema includes `cart_items.cart_id` but no `carts` table. This starter treats `cart_id` as a numeric field. For a proper cart relationship, add a `carts` table and `CartEntity`.
- The example entities use JPA-generated IDs. The schema may use `SERIAL`; PostgreSQL identity generation is compatible with normal generated-ID usage.

## Spring Security + JWT

Dependencies added: Spring Security and JJWT. Public routes:
- `POST /api/auth/register`
- `POST /api/auth/login`

All other API routes require a JWT. `/api/users/**` requires the `ADMIN` role.
Public registration always creates a `USER`; it does not accept a role from the request.

### Register
`POST http://localhost:8080/api/auth/register`
```json
{
  "name": "Sok Dara",
  "email": "dara@example.com",
  "password": "myStrongPassword123",
  "phone": "012345678",
  "address": "Phnom Penh"
}
```
The response contains `accessToken`.

### Login
`POST http://localhost:8080/api/auth/login`
```json
{
  "email": "dara@example.com",
  "password": "myStrongPassword123"
}
```

### Call a protected endpoint
In Postman, choose Authorization → Bearer Token and paste the `accessToken`, or send:
`Authorization: Bearer YOUR_ACCESS_TOKEN`

Example: `GET http://localhost:8080/api/products`

### Security notes
- Replace `security.jwt.secret` with a securely generated Base64 key of at least 32 bytes. Prefer environment variables/secrets management; do not commit production secrets.
- The included secret is for local demonstration only.
- Passwords are encoded using BCrypt in the registration endpoint.
- Create an administrator securely for admin-only endpoints; public registration cannot assign the ADMIN role.
- For production, add exception handling, rate limiting, refresh-token/revocation strategy, and migration tooling.
