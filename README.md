# Lead CRM – egyfájlos HTML MVP

Indítás:
- Nyisd meg az `index.html` fájlt böngészőben, vagy futtasd: `npm run dev`

## Belépés és szerepkörök

- Alap admin felhasználó:
  - felhasználónév: `admin`
  - jelszó: `admin123`
- Az admin tud felhasználókat létrehozni és jogosultságot adni (`admin`, `advisor`, `lead_giver`).
- Lead adó saját leadeket lát és új leadet rögzít.
- Tanácsadó és admin az összes leadet látja, és módosíthatja.

## Adatbázis mentés

- A demo a böngésző **LocalStorage** tárhelyére ment (`lead_manager_db_v2`).
- Ez demo adatbázis: ugyanazon a böngészőn/gépen megmarad, de nem központi szerver.

## Letöltés

- CSV és JSON export a lead listából.
- A fájlok a böngésző alapértelmezett `Letöltések / Downloads` mappájába kerülnek.

## Dokumentáció

- Részletes üzleti és funkcionális specifikáció: `SYSTEM_SPEC_HU.md`
