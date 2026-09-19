-- Run this in Supabase: Dashboard → SQL Editor → New query → paste → Run

create table if not exists public.orders (
  id uuid primary key default gen_random_uuid(),
  table_number text not null,
  items jsonb not null,
  total numeric not null,
  status text not null default 'new', -- 'new' | 'preparing' | 'served'
  created_at timestamptz not null default now()
);

-- This app has no login for customers or staff, so every row is open
-- to anyone with the link. Fine for an in-house ordering pad; if you
-- later add real customer/staff accounts, tighten these policies.
alter table public.orders enable row level security;

create policy "Anyone can insert orders" on public.orders
  for insert to anon with check (true);

create policy "Anyone can read orders" on public.orders
  for select to anon using (true);

create policy "Anyone can update orders" on public.orders
  for update to anon using (true) with check (true);

create policy "Anyone can delete orders" on public.orders
  for delete to anon using (true);

-- Lets the counter screen see new orders instantly instead of only on refresh
alter publication supabase_realtime add table public.orders;
