# Telepítés nélküli használat (céges laptophoz)

Ha nem tudsz telepíteni semmit a gépre, 2 lehetőség van.

## 1) Nincs felhő, csak helyi demo (telepítés nélkül)
1. Csomagold ki a ZIP-et.
2. Nyisd meg az `index.html` fájlt dupla kattintással.
3. Belépés: `admin` / `admin123`.
4. Ebben a módban a felhő sync le van tiltva (`file://` security korlát miatt), de a helyi működés megy.

## 2) Felhő sync telepítés nélkül
Mivel `npm run dev` nem opció a céges gépen, futtasd az appot egy online statikus hoston.

Egyszerű opciók:
- Netlify Drop (drag&drop feltöltés)
- Vercel static deploy
- GitHub Pages

Lépések röviden:
1. Töltsd fel az `index.html` fájlt egy HTTPS URL-re.
2. Nyisd meg onnan a böngészőben (nem `file://`).
3. Add meg Supabase URL + kulcs mezőket.
4. A `supabase/sql/schema.sql` + `supabase/sql/seed_admin.sql` scriptet futtasd a Supabase SQL Editorban.

