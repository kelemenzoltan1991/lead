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
- Supabase Anon vagy Publishable Key (`sb_publishable_...` is jó)

Megjegyzés:
- Ha `sb_publishable_...` kulcsot adsz meg és az URL üres, a rendszer megpróbálja automatikusan kitölteni a Supabase URL-t.

Szükséges táblák:
- `users_app`
- `leads_app`

A rendszer mentéskor LocalStorage-be és (ha csatlakoztatva van) Supabase felhőbe is szinkronizál.

Hibaelhárítás:
- `Failed to fetch`: ellenőrizd, hogy a Supabase URL `https://` formátumú, az Anon Key helyes, és van internet-hozzáférés.
- Ha céges hálózatot/VPN-t használsz, lehet hogy blokkolja a Supabase végpontot.

## Lead megjelenítés
- Kompakt kártyák minden szerepkörnél
- Kattintásra nyílik a részletes szerkesztés

## Letöltés
- CSV és JSON export
- Letöltési mappa: böngésző alapértelmezett `Letöltések / Downloads`

## Dokumentáció
- Részletes specifikáció: `SYSTEM_SPEC_HU.md`

## ZIP csomag készítés
- Futtasd: `bash scripts/package_zip.sh`
- Kimenet:
  - időbélyeges ZIP: `release/lead-manager-YYYYMMDD-HHMMSS.zip`
  - aktuális ZIP: `release/lead-manager-latest.zip`

