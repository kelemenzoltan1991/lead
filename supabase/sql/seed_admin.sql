-- Seed admin user for Lead Manager demo
-- Run this AFTER schema.sql in Supabase SQL Editor.

insert into public.users_app (id, name, email, username, password, role)
values (
  gen_random_uuid(),
  'Rendszer Admin',
  'admin@local.hu',
  'admin',
  'admin123',
  'admin'
)
on conflict (username) do update set
  name = excluded.name,
  email = excluded.email,
  password = excluded.password,
  role = excluded.role;
