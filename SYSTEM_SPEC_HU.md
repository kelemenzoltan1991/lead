# Lead kezelő rendszer – funkcionális specifikáció (HU)

Ez a dokumentum a kért folyamatok alapján rögzíti a minimum elvárásokat egy banki lead-kezelő rendszerhez.

## 1) Szerepkörök és jogosultságok

## Lead adó
- Saját leadeket látja.
- Új leadet tud felvenni.
- Látja a lead aktuális státuszát.
- Látja, hogy a folyamat felfüggesztve van-e.
- Nem módosíthatja a banki tanácsadói belső adatokat.

## Banki tanácsadó
- Az összes leadet látja.
- A friss (még meg nem nyitott) leadek piros jelölést kapnak.
- Kizárólag banki tanácsadó módosíthatja a lead részletes mezőit és státuszát.
- A lead megnyitása után kötelezően rögzíti:
  - megkeresés megtörtént-e,
  - eredmény,
  - automatikus dátum+idő bélyeg.

## 2) Lead létrehozás (kötelező mezők)

Lead adó által rögzített mezők:
- Ügyfél neve (kötelező)
- Érdeklődési kör (kötelező)
- Telefonszám (kötelező)
- E-mail cím (opcionális)

Érdeklődési kör lista:
- Személyi kölcsön
- Lakáshitel / jelzálog
- Otthonstart
- Munkáshitel
- Számlanyitás
- Vállalkozói számlanyitás
- Vállalkozói hitel
- Babaváró
- CSOK Plusz
- Szabadfelhasználású jelzáloghitel
- Hitelkiváltás (egyhitel)
- Falusi CSOK
- Építési hitel / jelzálog

## 3) Értesítések

- Új lead rögzítésekor e-mail értesítés megy a banki tanácsadónak.
- Minden olyan lead esetén, ami nem „Folyósítás” státuszban van, a rendszer 14 naponta emlékeztető e-mailt küld a banki tanácsadónak.
- Az emlékeztető addig megy, amíg:
  - a státusz „Folyósítás” nem lesz, vagy
  - a tanácsadó be nem jelöli a „Folyamat felfüggesztve” checkboxot.
- A „Folyamat felfüggesztve” állapotot a lead adó is látja.

## 4) Banki tanácsadó által kezelhető részletes mezők

- Kinek a nevére lesz beadva a lead:
  - szöveges név vagy
  - „megegyezik a lead adóval” checkbox
- Jövedelem és annak formája
- Egyéb hitelek
- Hitelkártya / folyószámlahitel
- Mekkora hitel kell
- Mekkora futamidőre
- Mekkora törlesztő
- Munkáltatói kiküldve (igen/nem)
- Megjegyzés
- Születési dátum
- Támogatásra való alkalmasság:
  - TB jogviszony
  - Köztartozás mentesség
  - Ingatlan tulajdon
  - Gyerekek száma
- Hol vásárol, ingatlan értéke
- Önerő mértéke
- KHR státusz (pl. aktív/passzív)
- Adóstárs lesz-e

## 5) Státuszok

A státuszt a lead adó is látja.

### Jelzálog típusú folyamatnál
- Információt megkapta
- Ingatlant keres
- Adásvételi szerződésre vár
- Önerőt gyűjti
- Beadás
- Befogadás
- Hiánypótlás
- Bírálat
- Jóváhagyás
- Szerződéskötés (dátum kötelező)
- Folyósítás
- Visszalépett
- Elutasított
- Nem felelt meg

### Egyéb termékeknél
- Információt megkapta
- Nem felel meg (KO szűrés alapján)
- Lead átadva banknak
- Banki ügyintézés
- Visszalépett
- Nem felelt meg banki elutasítás miatt

## 6) Adatmodell javaslat

## `users`
- `id`
- `name`
- `email`
- `role` (`lead_giver`, `advisor`, `admin`)

## `leads`
- `id`
- `lead_giver_user_id`
- `customer_name`
- `interest_type`
- `phone`
- `email`
- `is_new` (default: true)
- `process_suspended` (default: false)
- `created_at`
- `updated_at`

## `lead_advisor_details`
- `lead_id` (FK)
- `submitted_for_name`
- `same_as_lead_giver` (bool)
- `income_type`
- `other_loans`
- `credit_card_overdraft`
- `loan_amount`
- `term_months`
- `installment_amount`
- `employer_docs_sent` (bool)
- `note`
- `birth_date`
- `tb_eligibility`
- `no_public_debt`
- `property_ownership`
- `children_count`
- `purchase_location`
- `property_value`
- `own_funds`
- `khr_status`
- `co_borrower`
- `updated_by_user_id`
- `updated_at`

## `lead_status_history`
- `id`
- `lead_id`
- `status_code`
- `status_date` (ha releváns, pl. szerződéskötés)
- `comment`
- `changed_by_user_id`
- `created_at`

## `contact_logs`
- `id`
- `lead_id`
- `contact_done` (bool)
- `result`
- `recorded_by_user_id`
- `recorded_at` (automatikus)

## 7) Kötelező üzleti szabályok

1. Lead adó csak saját leadet láthat.
2. Banki tanácsadó minden leadet láthat.
3. Új lead = piros jelölés, amíg tanácsadó meg nem nyitja.
4. Lead megnyitás után kötelező kapcsolatfelvétel-rögzítés.
5. Csak banki tanácsadó módosíthat tanácsadói mezőket.
6. Státuszváltozás auditálva legyen (ki, mikor, mire).
7. 14 napos emlékeztető csak akkor áll meg, ha „Folyósítás” vagy „Felfüggesztve”.

## 8) Minimum UI képernyők

1. Bejelentkezés
2. Lead adó dashboard (saját leadek + státusz)
3. Új lead felvitel
4. Banki tanácsadó lead lista (újak pirossal)
5. Lead részletek + banki mezők + státuszváltás
6. Kontakt napló
7. E-mail értesítés beállítások

## 9) Javasolt technikai irány (a meglévő projekt alapján)

- Frontend: React (Vite)
- Backend: Supabase (Auth, Postgres, RLS, Edge Function emailhez)
- Jogosultság: RLS policy szerepkör szerint
- Ütemezett emlékeztető: Supabase scheduled function / cron

