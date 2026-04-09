# Lead CRM – egyfájlos HTML + felhő mentés

Indítás:
- Nyisd meg az `index.html` fájlt böngészőben, vagy futtasd: `npm run dev`

## Bejelentkezés
- Demo admin: `admin` / `admin123`
- Szerepkörök: `admin`, `advisor`, `lead_giver`
- Login próbálkozáskor az app automatikusan megpróbál cloud user listát frissíteni, ha helyben nem talál felhasználót.
- Cloud login során közvetlenül is ellenőriz a `users_app` táblában (`username` + `password`), kis/nagybetű-toleráns felhasználónévvel.
- Sikeres login után automatikusan fut egy cloud betöltés (ha elérhető), így az admin/advisor azonnal látja a friss adatokat.

## Admin funkciók
- Felhasználó létrehozás (név, email, felhasználónév, jelszó, jogosultság)
- Felhasználó adatmódosítás (inline szerkesztés + mentés)
- Felhasználó törlés

## Felhő adatbázis (Supabase)
> A Felhő adatbázis mezők (URL/Key, Kapcsolódás, Felhőből betöltés) csak **admin** felhasználónak látszanak.

A felületen add meg:
- Supabase URL
- Supabase Anon vagy Publishable Key (`sb_publishable_...` is jó)

Megjegyzés:
- A projekt alapból beégetett Supabase adatokkal indul:
  - URL: `https://mckusqwbatbehouwiwba.supabase.co`
  - Key: `sb_publishable_QNIwahIgtsN570YMq670dg_5ibVC-b3`
- Ha `sb_publishable_...` kulcsot adsz meg és az URL üres, a rendszer megpróbálja automatikusan kitölteni a Supabase URL-t.
- Cloud sync-hez ne fájlként (`file:///...`) nyisd meg a HTML-t, hanem futtasd: `npm run dev`.
- `file:///` módnál a cloud gombok le vannak tiltva a böngésző security-origin korlátozás miatt.

Szükséges táblák:
- `users_app`
- `leads_app`
- Táblák és demo policy létrehozás: futtasd a `supabase/sql/schema.sql` fájlt a Supabase SQL Editorban.
- Admin user seed (`admin` / `admin123`): futtasd a `supabase/sql/seed_admin.sql` fájlt.

A rendszer mentéskor LocalStorage-be és (ha csatlakoztatva van) Supabase felhőbe is szinkronizál.
Cloud mentés módja: `upsert` (nem teljes tábla törlés), így elkerülhető a 400-as `id=neq.` hiba.

Hibaelhárítás:
- `Failed to fetch`: ellenőrizd, hogy a Supabase URL `https://` formátumú, az Anon Key helyes, és van internet-hozzáférés.
- Ha céges hálózatot/VPN-t használsz, lehet hogy blokkolja a Supabase végpontot.
- `HTTP 401`: a kulcs nem az adott projekthez tartozik, vagy a `users_app` / `leads_app` policy-k nem engedik az olvasást/írást.
- `Could not find the table 'public.users_app'`: még nincs létrehozva a tábla; futtasd a `supabase/sql/schema.sql` scriptet.
- `HTTP 400` / `HTTP 409`: frissítsd a `schema.sql`-t és használd a beépített admin felületet user létrehozásra (a mentés upsert alapú).

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

### Hol tudod letölteni?
- A kész fájl itt található a projektben: `release/lead-manager-latest.zip`
- Terminálból gyors megnyitás/listázás:
  - `ls -lh release/`
  - `realpath release/lead-manager-latest.zip`

## Ha nem tudsz telepíteni semmit (céges laptop)
- Rövid útmutató: `NO_INSTALL_GUIDE_HU.md`
- Helyi, telepítés nélküli mód: `index.html` dupla katt (felhő sync nélkül)
- Felhő sync telepítés nélkül: töltsd fel a fájlt HTTPS static hostra (pl. Netlify Drop), és onnan nyisd meg.
