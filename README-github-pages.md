# Hosting the MCB order page on GitHub Pages

This is a single static `index.html` — no build step, no Node, no Lovable. It talks directly to Supabase from the browser.

## 1. Set up Supabase (same as before)
If you haven't already:
1. Create a free project at supabase.com.
2. In the Supabase dashboard: **SQL Editor → New query** → paste the contents of `supabase-setup.sql` → **Run**.
3. Go to **Project Settings → API** and copy your **Project URL** and **anon public key**.

## 2. Fill in your config
Open `index.html` and edit the three lines near the top of the `<script>` tag:
```js
const SUPABASE_URL = "YOUR_SUPABASE_PROJECT_URL";
const SUPABASE_ANON_KEY = "YOUR_SUPABASE_ANON_KEY";
const ADMIN_PIN = "3097";
```
Paste in your real Supabase URL and anon key, and set whatever PIN the counter should use.

## 3. Push to GitHub
```bash
mkdir mcb-order && cd mcb-order
git init
# put index.html in this folder
git add index.html
git commit -m "MCB table ordering"
git branch -M main
git remote add origin https://github.com/<your-username>/<your-repo>.git
git push -u origin main
```

## 4. Turn on GitHub Pages
1. On GitHub, open your repo → **Settings → Pages**.
2. Under **Build and deployment**, set **Source** to "Deploy from a branch".
3. Branch: `main`, folder: `/ (root)` → **Save**.
4. GitHub gives you a URL like `https://<your-username>.github.io/<your-repo>/` — that's live in a minute or two.

## 5. Link it from your existing site
Add a button or link to that URL from mysuru-coffee-glow.lovable.app (e.g. next to the menu section), or point a subdomain at it later if you want a nicer URL.

## Try it
- Open the GitHub Pages URL on one phone, enter a table number, place an order.
- Open it on another device, tap **Counter**, enter the PIN, and the order should show up within a few seconds.

## Notes
- The anon key is meant to be public — it's safe to ship in client-side code, as long as your Supabase Row Level Security policies (from `supabase-setup.sql`) only allow what you intend. Right now that's "anyone can read/write orders," which is fine for an in-house ordering pad but worth tightening later if you add real accounts.
- The PIN is a light deterrent, not real security.
- Edit the `MENU` array directly in `index.html` to change items or prices — no rebuild needed, just refresh.
