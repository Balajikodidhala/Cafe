# Mysuru Coffee Bar

Mysuru Coffee Bar is a browser-based cafe ordering website. Customers choose
their table, select food and drinks, review their cart, and place an order
directly from the website. Staff can open the counter view to monitor and
update incoming orders.

The project is intentionally simple: it is a static HTML/CSS/JavaScript site
with no build step and no Node.js requirement.

## Live repository

GitHub: <https://github.com/Balajikodidhala/Cafe>

## What the website includes

### Customer experience

- Cafe homepage with hero section, menu highlights, location, and contact details
- Embedded ordering experience on the homepage
- Direct ordering page at `order.html`
- Table selection from Table 1 through Table 8
- Menu categories for coffee, tea, snacks, starters, rice and mains, and beverages
- Add and remove controls for cart items
- Order total and order review before submission
- Order confirmation with the selected table and current status

### Counter experience

- Counter view protected by a PIN prompt
- Active and served order tabs
- Incoming orders grouped by table
- Order status flow: `new` -> `preparing` -> `served`
- Clear action for served orders
- Realtime updates when Supabase Realtime is available
- Polling fallback so the counter can still refresh orders reliably

## User flow

1. Open the website.
2. Select one of the eight tables.
3. Click **Start ordering**.
4. Browse a menu category and add items to the cart.
5. Open **Review order** and check the total.
6. Click **Place order**.
7. The order appears in the counter view with status `new`.

Staff can select **Counter**, enter the configured PIN, and move each order
through the preparation and served statuses.

## Run locally

From the project folder, start a local HTTP server:

```bash
python -m http.server 8000
```

Open the main website:

```text
http://localhost:8000/
```

Open the ordering page directly when needed:

```text
http://localhost:8000/order.html
```

The site should be served over HTTP. Opening the files directly with a
`file://` URL can prevent browser networking and database features from
working correctly.

## Project structure

| File | Purpose |
| --- | --- |
| `index.html` | Main cafe website and embedded ordering experience |
| `order.html` | Customer ordering app and staff counter view |
| `supabase-setup.sql` | Database table, permissions, and realtime setup |
| `favicon.svg` | Browser tab icon |
| `README-github-pages.md` | Earlier GitHub Pages notes |
| `files.zip` | Project archive |

## Supabase setup

The order app stores orders in a Supabase `public.orders` table. To configure
your own project:

1. Create a project at <https://supabase.com>.
2. Open **SQL Editor** in the Supabase dashboard.
3. Paste and run the contents of `supabase-setup.sql`.
4. Open `order.html`.
5. Set `SUPABASE_URL` to your project URL.
6. Set `SUPABASE_ANON_KEY` to your public anon key.
7. Change `ADMIN_PIN` to the PIN staff should use.

The configuration constants are near the top of the script in `order.html`:

```js
const SUPABASE_URL = "YOUR_SUPABASE_PROJECT_URL";
const SUPABASE_ANON_KEY = "YOUR_SUPABASE_ANON_KEY";
const ADMIN_PIN = "YOUR_COUNTER_PIN";
```

The application first tries the Supabase JavaScript client, then a REST
request, and finally local browser storage if the remote service is
unavailable. Local storage is useful for development, but it does not share
orders between different devices.

## Database model

The `orders` table contains:

| Column | Type | Description |
| --- | --- | --- |
| `id` | UUID | Unique order identifier |
| `table_number` | text | Selected table number from 1 to 8 |
| `items` | JSONB | Ordered menu items, prices, and quantities |
| `total` | numeric | Total order amount |
| `status` | text | `new`, `preparing`, or `served` |
| `created_at` | timestamp | Order creation time |

## Deploy with GitHub Pages

1. Push the project to GitHub.
2. Open the repository **Settings** page.
3. Select **Pages** in the sidebar.
4. Under **Build and deployment**, choose **Deploy from a branch**.
5. Select branch `main` and folder `/ (root)`.
6. Click **Save** and wait for GitHub Pages to publish the site.

The generated address will look like:

```text
https://balajikodidhala.github.io/Cafe/
```

## Security notes

This project is designed for an in-house cafe ordering pad, not a
high-security public ordering platform. The SQL setup currently permits
anonymous clients to insert, read, update, and delete orders so the customer
and counter screens can communicate without accounts.

Before using the project publicly:

- Restrict database policies to the operations the app actually needs.
- Move staff authentication from a client-side PIN to real authentication.
- Avoid exposing sensitive service-role keys in browser code.
- Add rate limits and server-side validation for order data.

## Editing the menu

Menu items are defined in the `MENU` array inside `order.html`. Each item has
an ID, category, name, description, and price:

```js
{
  id: "fil-coffee",
  cat: "Coffee",
  name: "Filter Coffee",
  desc: "Classic decoction, frothed steel tumbler",
  price: 30
}
```

After changing the menu, refresh the local server page. No build or dependency
installation is required.
