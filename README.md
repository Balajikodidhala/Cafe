# Mysuru Coffee Bar

A static café website with an embedded table-ordering system for Mysuru Coffee Bar.

## Features

- Café homepage with menu, location, and contact information
- 3D hover effects on the hero feature and menu cards
- Table selection for Tables 1 through 8
- Menu categories, cart, and order review
- Orders sent to the counter view
- Counter PIN and order status management
- Supabase persistence with REST and local browser fallback

## Run locally

Start a local HTTP server from the project folder:

```bash
python -m http.server 8000
```

Open the website at:

- http://localhost:8000/

The ordering page is also available directly at:

- http://localhost:8000/order.html

The site should be served over HTTP instead of opened directly as a `file://` page.

## Project files

- `index.html` - Main café website with the embedded ordering experience
- `order.html` - Customer ordering and counter application
- `supabase-setup.sql` - Supabase table, policies, and realtime setup
- `README-github-pages.md` - GitHub Pages deployment notes
- `favicon.svg` - Site favicon

## Supabase setup

1. Create a Supabase project.
2. Open the Supabase SQL Editor.
3. Run the contents of `supabase-setup.sql`.
4. In `order.html`, set `SUPABASE_URL` and `SUPABASE_ANON_KEY` near the top of the script.
5. Set the `ADMIN_PIN` value for the counter view.

The browser app can use local storage when the remote Supabase connection is unavailable. For production use, review and tighten the anonymous database policies before exposing the site publicly.

## Deploy to GitHub Pages

1. Push the project to GitHub.
2. Open the repository settings.
3. Go to **Pages**.
4. Choose **Deploy from a branch**.
5. Select the `main` branch and the `/ (root)` folder.
6. Save and open the generated Pages URL.
