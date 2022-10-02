-- Challenge Chapter 1: SQL
-- Syafaatul Khayati (149368779101-598)

----------------------------------------------------------------------------------------------------------------

-- Pertanyaan 1: Jumlah total kasus aktif per provinsi
SELECT Province,
  SUM(New_Active_Cases) AS Sum_Active_Cases				-- Agregation jumlah total kasus aktif baru
FROM `binar-sql-session-1.covid19.indonesia`
WHERE Location_Level='Province'						        -- The question requires breaking down the answer to province level and there are rows/data points which record cases in country level (therefore the Province column would be null)
GROUP BY Province									                -- Agregasi berdasar provinsi
ORDER BY Sum_Active_Cases DESC;						        -- Urutkan hasil berdasar jumlah total kasus aktif baru dari besar ke kecil

-- Hasil (terdiri dari 34 baris untuk masing-masing provinsi, dengan Jawa Barat sebagai provinsi yang memiliki kasus aktif tertinggi dan Sulawesi Barat sebagai provinsi terendah):
-- Province				            Sum_Active_Cases
-- Jawa Barat			            13496
-- DKI Jakarta			            10922
-- Banten				              2558
-- Jawa Tengah			            1423
-- Jawa Timur			            1136
-- Daerah Istimewa Yogyakarta	669
-- Sumatera Utara			        664
-- Sulawesi Utara			        565
-- Bali				                474
-- Sumatera Selatan		        313
-- Kalimantan Timur		        272
-- Papua				                237
-- Lampung				              226
-- Riau				                224
-- Kalimantan Tengah		        220
-- Sumatera Barat			        204
-- Kalimantan Selatan		      153
-- Sulawesi Selatan		        153
-- Papua Barat			            137
-- Kepulauan Riau			        130
-- Kalimantan Barat		        106
-- Aceh				                103
-- Nusa Tenggara Timur		      102
-- Sulawesi Tengah			        90
-- Jambi				                77
-- Kepulauan Bangka Belitung	  73
-- Maluku				              49
-- Bengkulu				            34
-- Sulawesi Tenggara		        34
-- Gorontalo				            31
-- Kalimantan Utara		        27
-- Nusa Tenggara Barat		      15
-- Maluku Utara			          14
-- Sulawesi Barat			        6

----------------------------------------------------------------------------------------------------------------

-- Pertanyaan 2: Jumlah kematian per kode ISO
SELECT Location_ISO_Code,
  SUM(New_Deaths) AS Sum_Total_Deaths					  -- Agregasi jumlah total kematian
FROM `binar-sql-session-1.covid19.indonesia`
GROUP BY Location_ISO_Code							        -- Agregasi berdasar kode ISO lokasi
ORDER BY Sum_Total_Deaths ASC							      -- Urutkan berdasar jumlah total kematian dari kecil ke besar
LIMIT 2;										                    -- Ambil 2 hasil teratas (paling sedikit)

-- Hasil (terdiri dari 2 baris, ID-MA (Maluku) dan ID-MU (Maluku Utara):
-- Location_ISO_Code	Sum_Total_Deaths
-- ID-MA			        294
-- ID-MU			        334

----------------------------------------------------------------------------------------------------------------

-- Pertanyaan 3: Nilai rate kesembuhan tertinggi
SELECT Date,
  MAX(Case_Recovered_Rate) AS Date_Recovery_Rate	              -- Mencari nilai maksimal rate recovery
FROM `binar-sql-session-1.covid19.indonesia`
WHERE Location_Level='Country'						                      -- The question asks for the answer to be in country level
GROUP BY Date									                                  -- Agregasi berdasar tanggal
ORDER BY Date_Recovery_Rate DESC						                    -- Urutkan berdasar case recovery rate untuk tiap tanggal, dari besar ke kecil
LIMIT 1;										                                    -- Ambil hasil teratas

-- Hasil (29 Mei 2022 memiliki rate kesembuhan skala nasional paling tinggi dengan angka 0.9737 (97.37%):
-- Date		    Date_Recovery_Rate
-- 29/05/2022	0.9737

----------------------------------------------------------------------------------------------------------------

-- Pertanyaan 4: Fatality rate dan Recovery rate untuk tiap kode ISO
SELECT Location_ISO_Code, 
  (SUM(New_Deaths)/SUM(New_Cases)) AS ISO_Fatality_Rate,	      -- Agregasi metric rate untuk fatal cases: (Total deaths/Total cases)
  (SUM(New_Recovered)/SUM(New_Cases)) AS ISO_Recovery_Rate	    -- Agregasi metric rate untuk recovered cases: (Total recovered/Total cases)
FROM `binar-sql-session-1.covid19.indonesia`
GROUP BY Location_ISO_Code							                        -- Agregasi berdasar kode ISO Lokasi 
ORDER BY ISO_Fatality_Rate, ISO_Recovery_Rate ASC;			        -- Hasil diurutkan berdasar rate fatalitas dan kesembuhan secara ascending (kecil->besar)

-- Hasil (35 baris dengan rincian 34 baris menunjukkan rate tiap provinsi, dan 1 baris menunjukakn rate skala nasional):
-- Location_ISO_Code	  ISO_Fatality_Rate		  ISO_Recovery_Rate
-- ID-BT	              0.008820666417	      0.9835177836
-- ID-JK	              0.01096869748		      0.9812987708
-- ID-PA	              0.01159693152		      0.983656138
-- ID-PB	              0.01193658688		      0.9838047871
-- ID-JB	              0.01357806857		      0.9749235557
-- ID-MA	              0.01569171648		      0.9816929974
-- ID-NT	              0.01617327755		      0.9827463856
-- ID-SN	              0.01719794594		      0.9817431866
-- ID-KB	              0.01722429693		      0.9811599726
-- ID-BE	              0.01789325746		      0.9809412813
-- ID-KU	              0.01893564084		      0.9804698681
-- ID-SU	              0.02069668777		      0.9751236891
-- ID-SG	              0.02214610984		      0.9765305725
-- ID-SB	              0.02265863914		      0.9753918196
-- ID-MU	              0.0228845495		      0.9761562179
-- ID-SA	              0.02296759522		      0.9663255638
-- ID-JA	              0.02300546024		      0.9750019408
-- ID-BB	              0.0244315433		      0.9744648041
-- IDN		              0.002464869874		    0.9709079282
-- ID-NB	              0.02488481805		      0.9747013546
-- ID-SR	              0.02525479136		      0.9743606179
-- ID-YO	              0.02642806511		      0.9705894154
-- ID-KR	              0.0266354415		      0.9715305503
-- ID-KT	              0.02684782795		      0.9693732071
-- ID-KI	              0.02739490089		      0.9713037695
-- ID-BA	              0.02835803897		      0.9688007624
-- ID-ST	              0.02836380301		      0.9701631778
-- ID-RI	              0.0291651381		      0.9693674336
-- ID-KS	              0.02952809914		      0.9687228497
-- ID-GO	              0.03490789191		      0.9628700452
-- ID-SS	              0.04107155892		      0.9551205625
-- ID-AC	              0.05047913166		      0.9471819792
-- ID-JT	              0.0526076784		      0.9451563381
-- ID-JI	              0.0527517979		      0.945359697
-- ID-LA	              0.0554547261		      0.9415513016

----------------------------------------------------------------------------------------------------------------
	
-- Pertanyaan 5-1: Mulai kapan total kasus >30000
SELECT Date, Total_Cases					
FROM `binar-sql-session-1.covid19.indonesia`
WHERE Location_Level='Country' AND				    -- Ambil data point untuk tingkat indonesia  
  Total_Cases>=30000							            -- Ambil data yang memiliki jumlah total kasus >30000
ORDER BY Date ASC									            -- Urutkan berdasar tanggal dari kecil (paling awal) ke besar (paling recent)
LIMIT 1;										                  -- Hanya ambil hasil teratas (paling awal)

-- Hasil (6 Juni 2020 merupakan hari pertama jumlah total kasus menyentuh >30.000 dan tercatat memiliki total kasus sebanyak 30.514):
-- Date		    Sum_Total_Cases
-- 06/06/2020	30514

----------------------------------------------------------------------------------------------------------------

-- Pertanyaan 5-2: Banyak hari dengan total kasus >30000
SELECT COUNT(*) AS Num_Dates							    -- Hitung jumlah baris yang memenuhi kondisi di klausa WHERE
FROM `binar-sql-session-1.covid19.indonesia`
WHERE Location_Level='Country' AND				    -- Ambil data point untuk tingkat indonesia  
  Total_Cases>=30000							            -- Ambil data yang memiliki jumlah total kasus >30000;

-- Hasil (ada 833 hari yang memiliki kasus >30.000 di skala nasional):
-- Num_Dates
-- 833

