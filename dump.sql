--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: trig1_fonk(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trig1_fonk() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
    if new.dID in (select dID from randevu where tarih=new.tarih and new.hID=hID) then
        raise exception 'Bir doktordan bir gün içinde 1 tane randevu alabilirsiniz';
        return null;
    else 
        delete from hekim_musaitlik h
        where new.saat=h.saat and new.dID=h.doc_ID;
        return new;
    end if;
end;
$$;


ALTER FUNCTION public.trig1_fonk() OWNER TO postgres;

--
-- Name: trig2_fonk(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trig2_fonk() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
    insert into hekim_musaitlik
    values(old.dID,old.tarih,old.saat);
    return old;
end;
$$;


ALTER FUNCTION public.trig2_fonk() OWNER TO postgres;

--
-- Name: trig_fonk(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trig_fonk() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
    if new.saat in (select saat from hekim_musaitlik where doc_id=new.dID) then
        delete from hekim_musaitlik h
        where new.saat=h.saat and new.dID=h.doc_ID;
        return new;
    else 
        raise exception 'Bu randevu saati dolu';
        return null;
    end if;
end;
$$;


ALTER FUNCTION public.trig_fonk() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: hasta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hasta (
    hid integer NOT NULL,
    isim character varying(20),
    soyisim character varying(20),
    adres character varying(300),
    dtarihi date
);


ALTER TABLE public.hasta OWNER TO postgres;

--
-- Name: hekim; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hekim (
    did integer NOT NULL,
    isim character varying(20),
    soyisim character varying(20),
    uz_id integer
);


ALTER TABLE public.hekim OWNER TO postgres;

--
-- Name: hekim_musaitlik; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hekim_musaitlik (
    doc_id integer NOT NULL,
    tarih date NOT NULL,
    saat character(5) NOT NULL
);


ALTER TABLE public.hekim_musaitlik OWNER TO postgres;

--
-- Name: randevu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.randevu (
    hid integer NOT NULL,
    did integer NOT NULL,
    tarih date NOT NULL,
    saat character(5) NOT NULL,
    durum character varying(10)
);


ALTER TABLE public.randevu OWNER TO postgres;

--
-- Name: seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999
    CACHE 1;


ALTER TABLE public.seq OWNER TO postgres;

--
-- Name: teshisler; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teshisler (
    hid integer NOT NULL,
    did integer NOT NULL,
    tarihsaat timestamp without time zone NOT NULL,
    recete character varying(300),
    teshis character varying(300)
);


ALTER TABLE public.teshisler OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_name character varying(25),
    h_id integer NOT NULL,
    type "char" NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: uzmanlik; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.uzmanlik (
    uid integer NOT NULL,
    uzmanlik character varying(20)
);


ALTER TABLE public.uzmanlik OWNER TO postgres;

--
-- Name: view1; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view1 AS
 SELECT h.isim,
    h.soyisim,
    r.tarih,
    r.saat,
    h.adres,
    r.durum,
    h.hid
   FROM public.randevu r,
    public.hasta h;


ALTER TABLE public.view1 OWNER TO postgres;

--
-- Name: view2; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view2 AS
 SELECT h.isim,
    h.soyisim,
    r.tarih,
    r.saat,
    h.adres,
    r.durum,
    h.hid
   FROM public.randevu r,
    public.hasta h
  WHERE (r.hid = h.hid);


ALTER TABLE public.view2 OWNER TO postgres;

--
-- Data for Name: hasta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hasta (hid, isim, soyisim, adres, dtarihi) FROM stdin;
19	ahmet	ahmet	Tarkabaşı Mah. No3 	1985-01-01
2	Utku	Mehmetoğlu	Hürriyet Mah. 	2001-01-11
23	Mehmet	Aykın	süleymaniye 1800. sokak	1998-12-01
24	Hasan	Hüseyin	Tarlabaşı Mah. no 9	1987-06-05
25	hasan	hüseyin	Avcılar No9	1965-06-02
26	Ahmet	Kaya	Bakırköy Ruh ve Sinir hastalıkları hastanesi	1978-05-01
27	Tansel	Aytaş	Görükle Göçmen Konutları No 8 Bursa	2000-09-01
28	Yavuz Burak	Kalkan	Hürriyet Mah. Hereke Sokak no 6 kat 5 Daire 16 Bahçelievler İstanbul	2000-09-01
30	Hasan	Köroğlu	Beylikdüzü Migros Avm karşısı no 8	1998-09-01
31	Hüseyin	Köroğlu	Beylikdüzü Migros Avm karşısı no 8	1998-09-01
\.


--
-- Data for Name: hekim; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hekim (did, isim, soyisim, uz_id) FROM stdin;
1	Ömer	Coşkun	1
2	Hasan	Mezarcı	2
3	Ahmet	Haliloğlu	3
4	Abuzer	Kömürcü	4
5	Azer	Bülbül	5
6	Eren	Karadağ	6
7	Kemal	Selçuk	7
8	Ali	Veli	8
9	Onur	Mete	9
10	Lütfü Kerem	Yıldırım	10
\.


--
-- Data for Name: hekim_musaitlik; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hekim_musaitlik (doc_id, tarih, saat) FROM stdin;
1	2022-01-16	10:30
1	2022-01-16	16:30
1	2022-01-17	9:00 
1	2022-01-17	9:30 
1	2022-01-16	16:00
2	2022-01-16	10:30
2	2022-01-16	16:00
2	2022-01-16	16:30
2	2022-01-16	17:00
2	2022-01-17	9:00 
2	2022-01-17	9:30 
3	2022-01-16	10:30
4	2022-01-16	10:30
5	2022-01-16	10:30
6	2022-01-16	10:30
8	2022-01-16	10:30
9	2022-01-16	10:30
10	2022-01-16	10:30
1	2022-01-15	14:30
3	2022-01-15	14:30
7	2022-01-16	10:00
8	2022-01-15	14:00
7	2022-01-16	10:30
1	2022-01-18	12:00
\.


--
-- Data for Name: randevu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.randevu (hid, did, tarih, saat, durum) FROM stdin;
24	2	2022-01-15	15:00	aktif
2	4	2022-01-16	11:00	aktif
26	1	2022-01-16	17:00	aktif
\.


--
-- Data for Name: teshisler; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.teshisler (hid, did, tarihsaat, recete, teshis) FROM stdin;
2	1	2022-01-14 17:21:30.629049	Parol	Akut beyin travması
26	1	2022-01-14 22:24:19.950248	Anti nausea serum.	Bulantı ve Kusma
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_name, h_id, type) FROM stdin;
doktor	1	d
hasta1	17	h
hasta2	19	h
hasta	2	h
hasta3	21	h
hasta4	23	h
hasta6	24	h
hasta7	25	h
ahmet	26	h
hasta9	27	h
hasta10	28	h
hasta11	30	h
hasta12	31	h
\.


--
-- Data for Name: uzmanlik; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.uzmanlik (uid, uzmanlik) FROM stdin;
1	Pratisyen
2	Kardiyoloji
3	Ortopedi
4	Radyoloji
5	Enfeksiyon
6	Nöroloji
7	Dahiliye
8	Çocuk
9	Onkoloji
10	Göz
\.


--
-- Name: seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq', 31, true);


--
-- Name: hasta hasta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hasta
    ADD CONSTRAINT hasta_pkey PRIMARY KEY (hid);


--
-- Name: hekim_musaitlik hekim_musaitlik_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hekim_musaitlik
    ADD CONSTRAINT hekim_musaitlik_pkey PRIMARY KEY (tarih, saat, doc_id);


--
-- Name: hekim hekim_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hekim
    ADD CONSTRAINT hekim_pkey PRIMARY KEY (did);


--
-- Name: randevu randevu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.randevu
    ADD CONSTRAINT randevu_pkey PRIMARY KEY (hid, did, tarih, saat);


--
-- Name: teshisler teshisler_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teshisler
    ADD CONSTRAINT teshisler_pkey PRIMARY KEY (hid, did, tarihsaat);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (h_id);


--
-- Name: uzmanlik uzmanlik_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.uzmanlik
    ADD CONSTRAINT uzmanlik_pkey PRIMARY KEY (uid);


--
-- Name: randevu trig; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trig BEFORE INSERT ON public.randevu FOR EACH ROW EXECUTE FUNCTION public.trig_fonk();


--
-- Name: randevu trig1; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trig1 BEFORE INSERT ON public.randevu FOR EACH ROW EXECUTE FUNCTION public.trig1_fonk();


--
-- Name: randevu trig2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trig2 AFTER DELETE ON public.randevu FOR EACH ROW EXECUTE FUNCTION public.trig2_fonk();


--
-- Name: hekim_musaitlik hekim_musaitlik_doc_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hekim_musaitlik
    ADD CONSTRAINT hekim_musaitlik_doc_id_fkey FOREIGN KEY (doc_id) REFERENCES public.hekim(did);


--
-- Name: hekim hekim_uz_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hekim
    ADD CONSTRAINT hekim_uz_id_fkey FOREIGN KEY (uz_id) REFERENCES public.uzmanlik(uid);


--
-- Name: randevu randevu_did_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.randevu
    ADD CONSTRAINT randevu_did_fkey FOREIGN KEY (did) REFERENCES public.hekim(did);


--
-- Name: randevu randevu_hid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.randevu
    ADD CONSTRAINT randevu_hid_fkey FOREIGN KEY (hid) REFERENCES public.hasta(hid);


--
-- Name: teshisler teshisler_did_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teshisler
    ADD CONSTRAINT teshisler_did_fkey FOREIGN KEY (did) REFERENCES public.hekim(did);


--
-- Name: teshisler teshisler_hid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teshisler
    ADD CONSTRAINT teshisler_hid_fkey FOREIGN KEY (hid) REFERENCES public.hasta(hid);


--
-- Name: TABLE hasta; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.hasta TO hasta;
GRANT SELECT ON TABLE public.hasta TO a;
GRANT SELECT ON TABLE public.hasta TO ab;
GRANT SELECT ON TABLE public.hasta TO abq;
GRANT SELECT ON TABLE public.hasta TO abqq;
GRANT SELECT ON TABLE public.hasta TO hasta1;
GRANT SELECT ON TABLE public.hasta TO hasta2;
GRANT SELECT ON TABLE public.hasta TO hasta3;
GRANT SELECT ON TABLE public.hasta TO hasta4;
GRANT SELECT ON TABLE public.hasta TO hasta6;
GRANT SELECT ON TABLE public.hasta TO hasta7;
GRANT SELECT ON TABLE public.hasta TO ahmet;
GRANT SELECT ON TABLE public.hasta TO hasta9;
GRANT SELECT ON TABLE public.hasta TO hasta10;
GRANT SELECT ON TABLE public.hasta TO hasta11;
GRANT SELECT ON TABLE public.hasta TO hasta12;


--
-- Name: TABLE hekim; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.hekim TO hasta;
GRANT SELECT ON TABLE public.hekim TO hasta3;
GRANT SELECT ON TABLE public.hekim TO hasta4;
GRANT SELECT ON TABLE public.hekim TO hasta6;
GRANT SELECT ON TABLE public.hekim TO hasta7;
GRANT SELECT ON TABLE public.hekim TO ahmet;
GRANT SELECT ON TABLE public.hekim TO hasta9;
GRANT SELECT ON TABLE public.hekim TO hasta10;
GRANT SELECT ON TABLE public.hekim TO hasta11;
GRANT SELECT ON TABLE public.hekim TO hasta12;


--
-- Name: TABLE hekim_musaitlik; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE ON TABLE public.hekim_musaitlik TO hasta;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.hekim_musaitlik TO hasta6;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.hekim_musaitlik TO hasta7;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.hekim_musaitlik TO ahmet;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.hekim_musaitlik TO hasta9;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.hekim_musaitlik TO hasta10;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.hekim_musaitlik TO hasta11;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.hekim_musaitlik TO hasta12;


--
-- Name: TABLE randevu; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE ON TABLE public.randevu TO hasta;
GRANT SELECT ON TABLE public.randevu TO a;
GRANT SELECT ON TABLE public.randevu TO ab;
GRANT SELECT ON TABLE public.randevu TO abq;
GRANT SELECT ON TABLE public.randevu TO abqq;
GRANT SELECT ON TABLE public.randevu TO hasta1;
GRANT ALL ON TABLE public.randevu TO hasta2;
GRANT ALL ON TABLE public.randevu TO hasta3;
GRANT ALL ON TABLE public.randevu TO hasta4;
GRANT ALL ON TABLE public.randevu TO hasta6;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.randevu TO hasta7;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.randevu TO ahmet;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.randevu TO hasta9;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.randevu TO hasta10;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.randevu TO hasta11;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.randevu TO hasta12;


--
-- Name: TABLE teshisler; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.teshisler TO hasta;
GRANT SELECT ON TABLE public.teshisler TO a;
GRANT SELECT ON TABLE public.teshisler TO ab;
GRANT SELECT ON TABLE public.teshisler TO abq;
GRANT SELECT ON TABLE public.teshisler TO abqq;
GRANT SELECT ON TABLE public.teshisler TO hasta1;
GRANT SELECT ON TABLE public.teshisler TO hasta2;
GRANT SELECT ON TABLE public.teshisler TO hasta3;
GRANT SELECT ON TABLE public.teshisler TO hasta4;
GRANT SELECT ON TABLE public.teshisler TO hasta6;
GRANT SELECT ON TABLE public.teshisler TO hasta7;
GRANT SELECT ON TABLE public.teshisler TO ahmet;
GRANT SELECT ON TABLE public.teshisler TO hasta9;
GRANT SELECT ON TABLE public.teshisler TO hasta10;
GRANT SELECT ON TABLE public.teshisler TO hasta11;
GRANT SELECT ON TABLE public.teshisler TO hasta12;


--
-- Name: TABLE users; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.users TO hasta;
GRANT SELECT ON TABLE public.users TO hasta3;
GRANT SELECT ON TABLE public.users TO hasta4;
GRANT SELECT ON TABLE public.users TO hasta6;
GRANT SELECT ON TABLE public.users TO hasta7;
GRANT SELECT ON TABLE public.users TO ahmet;
GRANT SELECT ON TABLE public.users TO hasta9;
GRANT SELECT ON TABLE public.users TO hasta10;
GRANT SELECT ON TABLE public.users TO hasta11;
GRANT SELECT ON TABLE public.users TO hasta12;


--
-- Name: TABLE uzmanlik; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.uzmanlik TO hasta;
GRANT SELECT ON TABLE public.uzmanlik TO hasta3;
GRANT SELECT ON TABLE public.uzmanlik TO hasta4;
GRANT SELECT ON TABLE public.uzmanlik TO hasta6;
GRANT SELECT ON TABLE public.uzmanlik TO hasta7;
GRANT SELECT ON TABLE public.uzmanlik TO ahmet;
GRANT SELECT ON TABLE public.uzmanlik TO hasta9;
GRANT SELECT ON TABLE public.uzmanlik TO hasta10;
GRANT SELECT ON TABLE public.uzmanlik TO hasta11;
GRANT SELECT ON TABLE public.uzmanlik TO hasta12;


--
-- PostgreSQL database dump complete
--

