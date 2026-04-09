-- Demo schema for single-file Lead Manager
-- Run this in Supabase SQL Editor before using cloud sync.

create extension if not exists pgcrypto;

create table if not exists public.users_app (
  id uuid primary key,
  name text not null,
  email text,
  username text not null unique,
  password text not null,
  role text not null check (role in ('admin','advisor','lead_giver')),
  created_at timestamptz not null default now()
);

create table if not exists public.leads_app (
  id uuid primary key,
  customer_name text not null,
  phone text not null,
  email text,
  interest text not null,
  lead_giver_id uuid,
  lead_giver_name text,
  created_at text,
  is_new boolean default true,
  process_suspended boolean default false,
  contact_done boolean default false,
  contact_result text,
  contact_recorded_at text,
  status text,
  status_date text,
  advisor_data jsonb default '{}'::jsonb
);

alter table public.users_app enable row level security;
alter table public.leads_app enable row level security;

-- Demo policy (open access for anon/publishable key)
-- IMPORTANT: productionban ezt szigorítani kell!
drop policy if exists users_app_open_access on public.users_app;
create policy users_app_open_access on public.users_app
  for all
  to anon, authenticated
  using (true)
  with check (true);

drop policy if exists leads_app_open_access on public.leads_app;
create policy leads_app_open_access on public.leads_app
  for all
  to anon, authenticated
  using (true)
  with check (true);
