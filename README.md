# Lead CRM – egyfájlos HTML + felhő mentés

Indítás:
- Nyisd meg az `index.html` fájlt böngészőben, vagy futtasd: `npm run dev`

## Bejelentkezés
- Demo admin: `admin` / `admin123`
- Szerepkörök: `admin`, `advisor`, `lead_giver`

## Admin funkciók
- Felhasználó létrehozás (név, email, felhasználónév, jelszó, jogosultság)
- Felhasználó adatmódosítás (inline szerkesztés + mentés)
- Felhasználó törlés

## Felhő adatbázis (Supabase)
A felületen add meg:
- Supabase URL
- Supabase Anon Key

Szükséges táblák:
- `users_app`
- `leads_app`

A rendszer mentéskor LocalStorage-be és (ha csatlakoztatva van) Supabase felhőbe is szinkronizál.

## Lead megjelenítés
- Kompakt kártyák minden szerepkörnél
- Kattintásra nyílik a részletes szerkesztés

## Letöltés
- CSV és JSON export
- Letöltési mappa: böngésző alapértelmezett `Letöltések / Downloads`

## Dokumentáció
- Részletes specifikáció: `SYSTEM_SPEC_HU.md`
