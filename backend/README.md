# OKOK Mobile Backend

Express.js backend using text files as a database.

## Tech

- Node.js + Express
- Text file storage (`data/*.txt` with JSON content)

## Run

```bash
cd backend
npm install
npm run dev
```

Server starts on `http://localhost:4000` by default.

## Data Files

- `data/users.txt`
- `data/sessions.txt`
- `data/products.txt`

## API

### Health

- `GET /health`

### Auth

- `POST /api/auth/register`
- `POST /api/auth/login`
- `GET /api/auth/me` (Bearer token)
- `POST /api/auth/logout` (Bearer token)

Register/Login request body example:

```json
{
  "fullName": "Keo Sovannarith",
  "email": "keosovannarith@gmail.com",
  "password": "12345678",
  "phone": "012345678"
}
```

### Products

- `GET /api/products`
- `GET /api/products/:id`

Supported query params for `GET /api/products`:

- `search`
- `category`
- `brand`
- `minPrice`
- `maxPrice`
- `sort=price_asc|price_desc`
- `page`
- `limit`

### Profile

- `GET /api/profile` (Bearer token)
- `PUT /api/profile` (Bearer token)

Update profile body example:

```json
{
  "fullName": "Keo S.",
  "phone": "098887766",
  "avatarUrl": "https://cdn.example.com/avatar.jpg"
}
```
