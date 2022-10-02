-- Data are stored in one table

-- Pertanyaan 1: Jenis kendaraan Transjakarta
select distinct jenis
from `binar-sql-session-1.transjakarta_passengers.all_default`

-- Pertanyaan 2: Jenis trayek Transjakarta
select distinct trayek
from `binar-sql-session-1.transjakarta_passengers.all_default`

-- Pertanyaan 3: 5 data points dengan jumlah penumpang terbanyak
select * except (jumlah_penumpang),
        cast(replace(replace(replace(jumlah_penumpang,'.',''),',',''),'-','0') as int64) as jum_penumpang_int       -- Ubah tipe data dari string ke int
from `binar-sql-session-1.transjakarta_passengers.all_default`
order by jum_penumpang_int desc
limit 5

-- Pertanyaan 4: Trayek yang diawali ST
select distinct trayek
from `binar-sql-session-1.transjakarta_passengers.all_default`
where trayek like 'ST%'

--------------------------------------------------------------------------------------

-- Data are stored in different tables, separated by month
-- with format 2019(int(bulan)), ex: 201901 for January

-- Pertanyaan 5: Ganti BRT -> Bus Rapid Transit
select * except (jenis),
        replace(jenis,'BRT','Bus Rapid Transit') as jenis
from `binar-sql-session-1.transjakarta_passengers.2019*`            -- Use wildcard to access all tables with the same pattern

-- Pertanyaan 6: Jumlah total penumpang selama 2019
select sum(cast(replace(replace(replace(jumlah_penumpang,'.',''),',',''),'-','0') as int64)) as sum_penumpang
from `binar-sql-session-1.transjakarta_passengers.2019*`

-- Pertanyaan 7: Jumlah penumpang terbanyak untuk tiap koridor 1-13
select 
        trim(substr(trayek, 0, 10)) as trayek_clean,                -- Take first 10 string (so 'KORIDOR XX' and trim the trailing spaces for koridor 1-9)
        max(cast(replace(replace(replace(jumlah_penumpang,'.',''),',',''),'-','0') as int64)) as max_penumpang
from `binar-sql-session-1.transjakarta_passengers.2019*`
where trayek like 'KORIDOR%'
group by trayek_clean