
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
-- TOC entry 256 (class 1255 OID 66276)
-- Name: kategori_urunlerini_sil(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kategori_urunlerini_sil() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	DELETE FROM urun WHERE kategori_id = OLD.kategori_id;
    RETURN OLD;
END;
$$;


ALTER FUNCTION public.kategori_urunlerini_sil() OWNER TO postgres;

--
-- TOC entry 253 (class 1255 OID 58035)
-- Name: marka_urunlerini_sil(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.marka_urunlerini_sil() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	DELETE FROM urun WHERE marka_id = OLD.marka_id;
    RETURN OLD;
END;
$$;


ALTER FUNCTION public.marka_urunlerini_sil() OWNER TO postgres;

--
-- TOC entry 263 (class 1255 OID 66286)
-- Name: musteri_ekle(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.musteri_ekle() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW."musteri" = UPPER(NEW."musteri"); 
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.musteri_ekle() OWNER TO postgres;

--
-- TOC entry 257 (class 1255 OID 66281)
-- Name: musteriadii(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.musteriadii() RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE 
    musteri "musteri"%ROWTYPE;
	sonuc TEXT;
BEGIN
    sonuc := '';
	FOR musteri IN SELECT * FROM musteri LOOP
	  sonuc:=sonuc || musteri."musteri_id" || E'\t' || musteri."isim" || E'\r\n';
	  END LOOP;
    RETURN sonuc;
END;
$$;


ALTER FUNCTION public.musteriadii() OWNER TO postgres;

--
-- TOC entry 255 (class 1255 OID 41637)
-- Name: musterilistele(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.musterilistele() RETURNS TABLE("ıd" integer, isimm character varying, tel character varying, adr character varying, mail character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN QUERY
SELECT
 musteri_id,
 isim,
 telefon,
 adres,
 email
 from
 musteri;
 end;
 $$;


ALTER FUNCTION public.musterilistele() OWNER TO postgres;

--
-- TOC entry 259 (class 1255 OID 66284)
-- Name: urun_ekle(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.urun_ekle() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW."urun" = UPPER(NEW."urun"); 
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.urun_ekle() OWNER TO postgres;

--
-- TOC entry 258 (class 1255 OID 66283)
-- Name: urunadii(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.urunadii() RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE 
    urun "urun"%ROWTYPE;
	sonuc TEXT;
BEGIN
    sonuc := '';
	FOR urun IN SELECT * FROM urun LOOP
	  sonuc:=sonuc || urun."urun_id" || E'\t' || urun."urun_adi" || E'\r\n';
	  END LOOP;
    RETURN sonuc;
END;
$$;


ALTER FUNCTION public.urunadii() OWNER TO postgres;

--
-- TOC entry 254 (class 1255 OID 58046)
-- Name: urunlistele(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.urunlistele() RETURNS TABLE("ıd" integer, barkodno character varying, urunadi character varying, miktarii character varying, alisfiyat character varying, satisfiyat character varying, markaid integer, ketegoriid integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN QUERY
SELECT
 urun_id
 barkod_no,
 urun_adi,
 miktari,
 alıs_fiyat,
 satıs_fiyat,
 marka_id,
 kategori_id
 from
 urun;
 end;
 $$;


ALTER FUNCTION public.urunlistele() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 212 (class 1259 OID 41299)
-- Name: adres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.adres (
    adresid integer NOT NULL,
    il character varying(15) NOT NULL,
    "ilçe" character varying(50) NOT NULL,
    mahalle character varying(50) NOT NULL,
    cadde character varying(50) NOT NULL,
    binano integer NOT NULL,
    daireno integer NOT NULL,
    musteri_id integer NOT NULL
);


ALTER TABLE public.adres OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 41317)
-- Name: adres_adresid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.adres_adresid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.adres_adresid_seq OWNER TO postgres;

--
-- TOC entry 3520 (class 0 OID 0)
-- Dependencies: 216
-- Name: adres_adresid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.adres_adresid_seq OWNED BY public.adres.adresid;


--
-- TOC entry 228 (class 1259 OID 41474)
-- Name: adres_musteri_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.adres_musteri_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.adres_musteri_id_seq OWNER TO postgres;

--
-- TOC entry 3521 (class 0 OID 0)
-- Dependencies: 228
-- Name: adres_musteri_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.adres_musteri_id_seq OWNED BY public.adres.musteri_id;


--
-- TOC entry 236 (class 1259 OID 41544)
-- Name: iade; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.iade (
    iade_id integer NOT NULL,
    alis_tarihi timestamp without time zone,
    urun_id integer NOT NULL,
    siparis_tarihi timestamp without time zone
);


ALTER TABLE public.iade OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 41542)
-- Name: iade_iade_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.iade_iade_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.iade_iade_id_seq OWNER TO postgres;

--
-- TOC entry 3522 (class 0 OID 0)
-- Dependencies: 234
-- Name: iade_iade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.iade_iade_id_seq OWNED BY public.iade.iade_id;


--
-- TOC entry 235 (class 1259 OID 41543)
-- Name: iade_urun_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.iade_urun_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.iade_urun_id_seq OWNER TO postgres;

--
-- TOC entry 3523 (class 0 OID 0)
-- Dependencies: 235
-- Name: iade_urun_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.iade_urun_id_seq OWNED BY public.iade.urun_id;


--
-- TOC entry 240 (class 1259 OID 41573)
-- Name: kategori_marka; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kategori_marka (
    marka_id integer NOT NULL,
    kategori_id integer NOT NULL,
    kategori_ismi character varying NOT NULL
);


ALTER TABLE public.kategori_marka OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 49855)
-- Name: kategori_marka_kategori_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kategori_marka_kategori_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.kategori_marka_kategori_id_seq OWNER TO postgres;

--
-- TOC entry 3524 (class 0 OID 0)
-- Dependencies: 249
-- Name: kategori_marka_kategori_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.kategori_marka_kategori_id_seq OWNED BY public.kategori_marka.kategori_id;


--
-- TOC entry 239 (class 1259 OID 41572)
-- Name: kategori_marka_marka_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kategori_marka_marka_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.kategori_marka_marka_id_seq OWNER TO postgres;

--
-- TOC entry 3525 (class 0 OID 0)
-- Dependencies: 239
-- Name: kategori_marka_marka_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.kategori_marka_marka_id_seq OWNED BY public.kategori_marka.marka_id;


--
-- TOC entry 248 (class 1259 OID 49847)
-- Name: kategoribilgileri; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kategoribilgileri (
    kategori_id integer NOT NULL,
    kategori_ismi character varying NOT NULL
);


ALTER TABLE public.kategoribilgileri OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 49846)
-- Name: kategoribilgileri_kategori_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kategoribilgileri_kategori_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.kategoribilgileri_kategori_id_seq OWNER TO postgres;

--
-- TOC entry 3526 (class 0 OID 0)
-- Dependencies: 247
-- Name: kategoribilgileri_kategori_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.kategoribilgileri_kategori_id_seq OWNED BY public.kategoribilgileri.kategori_id;


--
-- TOC entry 213 (class 1259 OID 41302)
-- Name: kaydedilenler; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kaydedilenler (
    marka "char" NOT NULL,
    urun_id integer NOT NULL,
    kaydedilenler_id integer NOT NULL
);


ALTER TABLE public.kaydedilenler OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 66264)
-- Name: kaydedilenler_kaydedilenler_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kaydedilenler_kaydedilenler_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.kaydedilenler_kaydedilenler_id_seq OWNER TO postgres;

--
-- TOC entry 3527 (class 0 OID 0)
-- Dependencies: 252
-- Name: kaydedilenler_kaydedilenler_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.kaydedilenler_kaydedilenler_id_seq OWNED BY public.kaydedilenler.kaydedilenler_id;


--
-- TOC entry 251 (class 1259 OID 66259)
-- Name: kaydedilenler_urun_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kaydedilenler_urun_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.kaydedilenler_urun_id_seq OWNER TO postgres;

--
-- TOC entry 3528 (class 0 OID 0)
-- Dependencies: 251
-- Name: kaydedilenler_urun_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.kaydedilenler_urun_id_seq OWNED BY public.kaydedilenler.urun_id;


--
-- TOC entry 238 (class 1259 OID 41559)
-- Name: kuponlar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kuponlar (
    kupon_id integer NOT NULL
);


ALTER TABLE public.kuponlar OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 41557)
-- Name: kuponlar_kupon_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kuponlar_kupon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.kuponlar_kupon_id_seq OWNER TO postgres;

--
-- TOC entry 3529 (class 0 OID 0)
-- Dependencies: 237
-- Name: kuponlar_kupon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.kuponlar_kupon_id_seq OWNED BY public.kuponlar.kupon_id;


--
-- TOC entry 209 (class 1259 OID 33108)
-- Name: markabilgileri; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.markabilgileri (
    marka "char",
    marka_id integer NOT NULL
);


ALTER TABLE public.markabilgileri OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 41485)
-- Name: markabilgileri_marka_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.markabilgileri_marka_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.markabilgileri_marka_id_seq OWNER TO postgres;

--
-- TOC entry 3530 (class 0 OID 0)
-- Dependencies: 229
-- Name: markabilgileri_marka_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.markabilgileri_marka_id_seq OWNED BY public.markabilgileri.marka_id;


--
-- TOC entry 221 (class 1259 OID 41366)
-- Name: musteri; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.musteri (
    musteri_id integer NOT NULL,
    isim character varying(50),
    telefon character varying(11),
    adres character varying(100),
    email character varying(20)
);


ALTER TABLE public.musteri OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 41620)
-- Name: musteri_kupon; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.musteri_kupon (
    kupon_id integer NOT NULL,
    musteri_id integer NOT NULL
);


ALTER TABLE public.musteri_kupon OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 41618)
-- Name: musteri_kupon_kupon_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.musteri_kupon_kupon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.musteri_kupon_kupon_id_seq OWNER TO postgres;

--
-- TOC entry 3531 (class 0 OID 0)
-- Dependencies: 244
-- Name: musteri_kupon_kupon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.musteri_kupon_kupon_id_seq OWNED BY public.musteri_kupon.kupon_id;


--
-- TOC entry 245 (class 1259 OID 41619)
-- Name: musteri_kupon_musteri_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.musteri_kupon_musteri_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.musteri_kupon_musteri_id_seq OWNER TO postgres;

--
-- TOC entry 3532 (class 0 OID 0)
-- Dependencies: 245
-- Name: musteri_kupon_musteri_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.musteri_kupon_musteri_id_seq OWNED BY public.musteri_kupon.musteri_id;


--
-- TOC entry 220 (class 1259 OID 41365)
-- Name: musteri_musteri_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.musteri_musteri_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.musteri_musteri_id_seq OWNER TO postgres;

--
-- TOC entry 3533 (class 0 OID 0)
-- Dependencies: 220
-- Name: musteri_musteri_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.musteri_musteri_id_seq OWNED BY public.musteri.musteri_id;


--
-- TOC entry 243 (class 1259 OID 41592)
-- Name: musteri_urun; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.musteri_urun (
    musteri_id integer NOT NULL,
    urun_id integer NOT NULL
);


ALTER TABLE public.musteri_urun OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 41590)
-- Name: musteri_urun_musteri_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.musteri_urun_musteri_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.musteri_urun_musteri_id_seq OWNER TO postgres;

--
-- TOC entry 3534 (class 0 OID 0)
-- Dependencies: 241
-- Name: musteri_urun_musteri_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.musteri_urun_musteri_id_seq OWNED BY public.musteri_urun.musteri_id;


--
-- TOC entry 242 (class 1259 OID 41591)
-- Name: musteri_urun_urun_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.musteri_urun_urun_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.musteri_urun_urun_id_seq OWNER TO postgres;

--
-- TOC entry 3535 (class 0 OID 0)
-- Dependencies: 242
-- Name: musteri_urun_urun_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.musteri_urun_urun_id_seq OWNED BY public.musteri_urun.urun_id;


--
-- TOC entry 215 (class 1259 OID 41308)
-- Name: odemebilgileri; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.odemebilgileri (
    odeme_id integer NOT NULL,
    isim character varying NOT NULL,
    telefon character varying NOT NULL,
    adres character varying NOT NULL,
    email character varying,
    musteri_id integer NOT NULL
);


ALTER TABLE public.odemebilgileri OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 41461)
-- Name: odemebilgileri_musteri_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.odemebilgileri_musteri_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.odemebilgileri_musteri_id_seq OWNER TO postgres;

--
-- TOC entry 3536 (class 0 OID 0)
-- Dependencies: 227
-- Name: odemebilgileri_musteri_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.odemebilgileri_musteri_id_seq OWNED BY public.odemebilgileri.musteri_id;


--
-- TOC entry 218 (class 1259 OID 41335)
-- Name: odemebilgileri_odemeid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.odemebilgileri_odemeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.odemebilgileri_odemeid_seq OWNER TO postgres;

--
-- TOC entry 3537 (class 0 OID 0)
-- Dependencies: 218
-- Name: odemebilgileri_odemeid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.odemebilgileri_odemeid_seq OWNED BY public.odemebilgileri.odeme_id;


--
-- TOC entry 210 (class 1259 OID 41293)
-- Name: sepet; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sepet (
    sepeteid integer NOT NULL,
    isim "char" NOT NULL,
    telefon "char" NOT NULL,
    barkodno "char" NOT NULL,
    "ürün" "char" NOT NULL,
    miktari integer NOT NULL,
    satis integer NOT NULL,
    toplamfiyat integer NOT NULL,
    tarih integer NOT NULL,
    musteri_id integer NOT NULL
);


ALTER TABLE public.sepet OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 41390)
-- Name: sepet_musteri_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sepet_musteri_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sepet_musteri_id_seq OWNER TO postgres;

--
-- TOC entry 3538 (class 0 OID 0)
-- Dependencies: 223
-- Name: sepet_musteri_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sepet_musteri_id_seq OWNED BY public.sepet.musteri_id;


--
-- TOC entry 217 (class 1259 OID 41324)
-- Name: sepet_sepeteid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sepet_sepeteid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sepet_sepeteid_seq OWNER TO postgres;

--
-- TOC entry 3539 (class 0 OID 0)
-- Dependencies: 217
-- Name: sepet_sepeteid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sepet_sepeteid_seq OWNED BY public.sepet.sepeteid;


--
-- TOC entry 211 (class 1259 OID 41296)
-- Name: siparis; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.siparis (
    urun integer NOT NULL,
    adres "char" NOT NULL,
    sipariskodu "char" NOT NULL,
    tarih timestamp with time zone NOT NULL,
    adet integer NOT NULL,
    musteri_id integer NOT NULL,
    urun_id integer NOT NULL
);


ALTER TABLE public.siparis OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 41379)
-- Name: siparis_musteri_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.siparis_musteri_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.siparis_musteri_id_seq OWNER TO postgres;

--
-- TOC entry 3540 (class 0 OID 0)
-- Dependencies: 222
-- Name: siparis_musteri_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.siparis_musteri_id_seq OWNED BY public.siparis.musteri_id;


--
-- TOC entry 226 (class 1259 OID 41423)
-- Name: siparis_urun_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.siparis_urun_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.siparis_urun_id_seq OWNER TO postgres;

--
-- TOC entry 3541 (class 0 OID 0)
-- Dependencies: 226
-- Name: siparis_urun_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.siparis_urun_id_seq OWNED BY public.siparis.urun_id;


--
-- TOC entry 219 (class 1259 OID 41342)
-- Name: siparis_urun_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.siparis_urun_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.siparis_urun_seq OWNER TO postgres;

--
-- TOC entry 3542 (class 0 OID 0)
-- Dependencies: 219
-- Name: siparis_urun_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.siparis_urun_seq OWNED BY public.siparis.urun;


--
-- TOC entry 225 (class 1259 OID 41409)
-- Name: urun; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.urun (
    urun_id integer NOT NULL,
    barkod_no character varying,
    urun_adi character varying,
    miktari integer,
    "alıs_fiyat" integer,
    "satıs_fiyat" integer,
    marka_id integer NOT NULL,
    kategori_id integer NOT NULL
);


ALTER TABLE public.urun OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 49860)
-- Name: urun_kategori_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.urun_kategori_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.urun_kategori_id_seq OWNER TO postgres;

--
-- TOC entry 3543 (class 0 OID 0)
-- Dependencies: 250
-- Name: urun_kategori_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.urun_kategori_id_seq OWNED BY public.urun.kategori_id;


--
-- TOC entry 230 (class 1259 OID 41495)
-- Name: urun_marka_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.urun_marka_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.urun_marka_id_seq OWNER TO postgres;

--
-- TOC entry 3544 (class 0 OID 0)
-- Dependencies: 230
-- Name: urun_marka_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.urun_marka_id_seq OWNED BY public.urun.marka_id;


--
-- TOC entry 224 (class 1259 OID 41407)
-- Name: urun_urun_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.urun_urun_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.urun_urun_id_seq OWNER TO postgres;

--
-- TOC entry 3545 (class 0 OID 0)
-- Dependencies: 224
-- Name: urun_urun_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.urun_urun_id_seq OWNED BY public.urun.urun_id;


--
-- TOC entry 214 (class 1259 OID 41305)
-- Name: yorumlar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.yorumlar (
    yorum_id integer NOT NULL,
    yorum character varying NOT NULL,
    musteri_id integer NOT NULL,
    urun_id integer NOT NULL
);


ALTER TABLE public.yorumlar OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 41515)
-- Name: yorumlar_musteri_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.yorumlar_musteri_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.yorumlar_musteri_id_seq OWNER TO postgres;

--
-- TOC entry 3546 (class 0 OID 0)
-- Dependencies: 232
-- Name: yorumlar_musteri_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.yorumlar_musteri_id_seq OWNED BY public.yorumlar.musteri_id;


--
-- TOC entry 233 (class 1259 OID 41529)
-- Name: yorumlar_urun_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.yorumlar_urun_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.yorumlar_urun_id_seq OWNER TO postgres;

--
-- TOC entry 3547 (class 0 OID 0)
-- Dependencies: 233
-- Name: yorumlar_urun_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.yorumlar_urun_id_seq OWNED BY public.yorumlar.urun_id;


--
-- TOC entry 231 (class 1259 OID 41508)
-- Name: yorumlar_yorum_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.yorumlar_yorum_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.yorumlar_yorum_id_seq OWNER TO postgres;

--
-- TOC entry 3548 (class 0 OID 0)
-- Dependencies: 231
-- Name: yorumlar_yorum_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.yorumlar_yorum_id_seq OWNED BY public.yorumlar.yorum_id;


--
-- TOC entry 3262 (class 2604 OID 41318)
-- Name: adres adresid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adres ALTER COLUMN adresid SET DEFAULT nextval('public.adres_adresid_seq'::regclass);


--
-- TOC entry 3263 (class 2604 OID 41475)
-- Name: adres musteri_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adres ALTER COLUMN musteri_id SET DEFAULT nextval('public.adres_musteri_id_seq'::regclass);


--
-- TOC entry 3275 (class 2604 OID 41547)
-- Name: iade iade_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.iade ALTER COLUMN iade_id SET DEFAULT nextval('public.iade_iade_id_seq'::regclass);


--
-- TOC entry 3276 (class 2604 OID 41548)
-- Name: iade urun_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.iade ALTER COLUMN urun_id SET DEFAULT nextval('public.iade_urun_id_seq'::regclass);


--
-- TOC entry 3278 (class 2604 OID 41577)
-- Name: kategori_marka marka_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kategori_marka ALTER COLUMN marka_id SET DEFAULT nextval('public.kategori_marka_marka_id_seq'::regclass);


--
-- TOC entry 3279 (class 2604 OID 49856)
-- Name: kategori_marka kategori_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kategori_marka ALTER COLUMN kategori_id SET DEFAULT nextval('public.kategori_marka_kategori_id_seq'::regclass);


--
-- TOC entry 3284 (class 2604 OID 49850)
-- Name: kategoribilgileri kategori_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kategoribilgileri ALTER COLUMN kategori_id SET DEFAULT nextval('public.kategoribilgileri_kategori_id_seq'::regclass);


--
-- TOC entry 3264 (class 2604 OID 66260)
-- Name: kaydedilenler urun_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kaydedilenler ALTER COLUMN urun_id SET DEFAULT nextval('public.kaydedilenler_urun_id_seq'::regclass);


--
-- TOC entry 3265 (class 2604 OID 66265)
-- Name: kaydedilenler kaydedilenler_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kaydedilenler ALTER COLUMN kaydedilenler_id SET DEFAULT nextval('public.kaydedilenler_kaydedilenler_id_seq'::regclass);


--
-- TOC entry 3277 (class 2604 OID 41562)
-- Name: kuponlar kupon_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kuponlar ALTER COLUMN kupon_id SET DEFAULT nextval('public.kuponlar_kupon_id_seq'::regclass);


--
-- TOC entry 3256 (class 2604 OID 41486)
-- Name: markabilgileri marka_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.markabilgileri ALTER COLUMN marka_id SET DEFAULT nextval('public.markabilgileri_marka_id_seq'::regclass);


--
-- TOC entry 3271 (class 2604 OID 41369)
-- Name: musteri musteri_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.musteri ALTER COLUMN musteri_id SET DEFAULT nextval('public.musteri_musteri_id_seq'::regclass);


--
-- TOC entry 3282 (class 2604 OID 41623)
-- Name: musteri_kupon kupon_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.musteri_kupon ALTER COLUMN kupon_id SET DEFAULT nextval('public.musteri_kupon_kupon_id_seq'::regclass);


--
-- TOC entry 3283 (class 2604 OID 41624)
-- Name: musteri_kupon musteri_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.musteri_kupon ALTER COLUMN musteri_id SET DEFAULT nextval('public.musteri_kupon_musteri_id_seq'::regclass);


--
-- TOC entry 3280 (class 2604 OID 41595)
-- Name: musteri_urun musteri_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.musteri_urun ALTER COLUMN musteri_id SET DEFAULT nextval('public.musteri_urun_musteri_id_seq'::regclass);


--
-- TOC entry 3281 (class 2604 OID 41596)
-- Name: musteri_urun urun_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.musteri_urun ALTER COLUMN urun_id SET DEFAULT nextval('public.musteri_urun_urun_id_seq'::regclass);


--
-- TOC entry 3269 (class 2604 OID 41336)
-- Name: odemebilgileri odeme_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.odemebilgileri ALTER COLUMN odeme_id SET DEFAULT nextval('public.odemebilgileri_odemeid_seq'::regclass);


--
-- TOC entry 3270 (class 2604 OID 41462)
-- Name: odemebilgileri musteri_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.odemebilgileri ALTER COLUMN musteri_id SET DEFAULT nextval('public.odemebilgileri_musteri_id_seq'::regclass);


--
-- TOC entry 3257 (class 2604 OID 41325)
-- Name: sepet sepeteid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sepet ALTER COLUMN sepeteid SET DEFAULT nextval('public.sepet_sepeteid_seq'::regclass);


--
-- TOC entry 3258 (class 2604 OID 41391)
-- Name: sepet musteri_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sepet ALTER COLUMN musteri_id SET DEFAULT nextval('public.sepet_musteri_id_seq'::regclass);


--
-- TOC entry 3259 (class 2604 OID 41343)
-- Name: siparis urun; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.siparis ALTER COLUMN urun SET DEFAULT nextval('public.siparis_urun_seq'::regclass);


--
-- TOC entry 3260 (class 2604 OID 41380)
-- Name: siparis musteri_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.siparis ALTER COLUMN musteri_id SET DEFAULT nextval('public.siparis_musteri_id_seq'::regclass);


--
-- TOC entry 3261 (class 2604 OID 41424)
-- Name: siparis urun_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.siparis ALTER COLUMN urun_id SET DEFAULT nextval('public.siparis_urun_id_seq'::regclass);


--
-- TOC entry 3272 (class 2604 OID 41412)
-- Name: urun urun_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.urun ALTER COLUMN urun_id SET DEFAULT nextval('public.urun_urun_id_seq'::regclass);


--
-- TOC entry 3273 (class 2604 OID 41496)
-- Name: urun marka_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.urun ALTER COLUMN marka_id SET DEFAULT nextval('public.urun_marka_id_seq'::regclass);


--
-- TOC entry 3274 (class 2604 OID 49861)
-- Name: urun kategori_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.urun ALTER COLUMN kategori_id SET DEFAULT nextval('public.urun_kategori_id_seq'::regclass);


--
-- TOC entry 3267 (class 2604 OID 41509)
-- Name: yorumlar yorum_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yorumlar ALTER COLUMN yorum_id SET DEFAULT nextval('public.yorumlar_yorum_id_seq'::regclass);


--
-- TOC entry 3268 (class 2604 OID 41516)
-- Name: yorumlar musteri_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yorumlar ALTER COLUMN musteri_id SET DEFAULT nextval('public.yorumlar_musteri_id_seq'::regclass);


--
-- TOC entry 3266 (class 2604 OID 41530)
-- Name: yorumlar urun_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yorumlar ALTER COLUMN urun_id SET DEFAULT nextval('public.yorumlar_urun_id_seq'::regclass);


--
-- TOC entry 3474 (class 0 OID 41299)
-- Dependencies: 212
-- Data for Name: adres; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3498 (class 0 OID 41544)
-- Dependencies: 236
-- Data for Name: iade; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3502 (class 0 OID 41573)
-- Dependencies: 240
-- Data for Name: kategori_marka; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3510 (class 0 OID 49847)
-- Dependencies: 248
-- Data for Name: kategoribilgileri; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.kategoribilgileri (kategori_id, kategori_ismi) VALUES (1, 'hytg');
INSERT INTO public.kategoribilgileri (kategori_id, kategori_ismi) VALUES (2, 'gıda');
INSERT INTO public.kategoribilgileri (kategori_id, kategori_ismi) VALUES (3, 'içecek');
INSERT INTO public.kategoribilgileri (kategori_id, kategori_ismi) VALUES (4, 'içecek');
INSERT INTO public.kategoribilgileri (kategori_id, kategori_ismi) VALUES (5, 'giyim');
INSERT INTO public.kategoribilgileri (kategori_id, kategori_ismi) VALUES (6, 'resim');
INSERT INTO public.kategoribilgileri (kategori_id, kategori_ismi) VALUES (7, 'giyim');
INSERT INTO public.kategoribilgileri (kategori_id, kategori_ismi) VALUES (8, 'tadilat');
INSERT INTO public.kategoribilgileri (kategori_id, kategori_ismi) VALUES (9, 'tekstil');
INSERT INTO public.kategoribilgileri (kategori_id, kategori_ismi) VALUES (10, 'uyıku');
INSERT INTO public.kategoribilgileri (kategori_id, kategori_ismi) VALUES (11, '258252');
INSERT INTO public.kategoribilgileri (kategori_id, kategori_ismi) VALUES (12, 'kozmetik');


--
-- TOC entry 3475 (class 0 OID 41302)
-- Dependencies: 213
-- Data for Name: kaydedilenler; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3500 (class 0 OID 41559)
-- Dependencies: 238
-- Data for Name: kuponlar; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3471 (class 0 OID 33108)
-- Dependencies: 209
-- Data for Name: markabilgileri; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.markabilgileri (marka, marka_id) VALUES ('a', 2);
INSERT INTO public.markabilgileri (marka, marka_id) VALUES ('i', 1);
INSERT INTO public.markabilgileri (marka, marka_id) VALUES ('l', 3);
INSERT INTO public.markabilgileri (marka, marka_id) VALUES ('d', 4);
INSERT INTO public.markabilgileri (marka, marka_id) VALUES ('h', 5);
INSERT INTO public.markabilgileri (marka, marka_id) VALUES ('g', 6);
INSERT INTO public.markabilgileri (marka, marka_id) VALUES ('b', 7);


--
-- TOC entry 3483 (class 0 OID 41366)
-- Dependencies: 221
-- Data for Name: musteri; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.musteri (musteri_id, isim, telefon, adres, email) VALUES (2, 'hugu', '52', 'uykgbh', 't7ıykg');
INSERT INTO public.musteri (musteri_id, isim, telefon, adres, email) VALUES (2525, '', '', '', '');
INSERT INTO public.musteri (musteri_id, isim, telefon, adres, email) VALUES (511, '', '', '', '');
INSERT INTO public.musteri (musteri_id, isim, telefon, adres, email) VALUES (52, 'gnhbn', '452', 'hgm', 'jumh');
INSERT INTO public.musteri (musteri_id, isim, telefon, adres, email) VALUES (3, 'bjhh', '', '', '');
INSERT INTO public.musteri (musteri_id, isim, telefon, adres, email) VALUES (8752, 'jhgh', '566354', 'hfgvh', 'jhg');
INSERT INTO public.musteri (musteri_id, isim, telefon, adres, email) VALUES (25, 'hgng', '45', 'jnhbn', 'gjngvb');
INSERT INTO public.musteri (musteri_id, isim, telefon, adres, email) VALUES (123, 'irem', '875567', 'gyhjyjy', 'yjytjuytjt');
INSERT INTO public.musteri (musteri_id, isim, telefon, adres, email) VALUES (2212425, 'yase', '45641', 'tgtgvttvgtg', 'gtvbtgv');
INSERT INTO public.musteri (musteri_id, isim, telefon, adres, email) VALUES (5, 'hjkumhj', '87527', 'jghygnhgn', 'bgfbf');
INSERT INTO public.musteri (musteri_id, isim, telefon, adres, email) VALUES (443, 'yaseo', '68574567', 'gefrfg', 'ftre');


--
-- TOC entry 3508 (class 0 OID 41620)
-- Dependencies: 246
-- Data for Name: musteri_kupon; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3505 (class 0 OID 41592)
-- Dependencies: 243
-- Data for Name: musteri_urun; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3477 (class 0 OID 41308)
-- Dependencies: 215
-- Data for Name: odemebilgileri; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3472 (class 0 OID 41293)
-- Dependencies: 210
-- Data for Name: sepet; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3473 (class 0 OID 41296)
-- Dependencies: 211
-- Data for Name: siparis; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3487 (class 0 OID 41409)
-- Dependencies: 225
-- Data for Name: urun; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.urun (urun_id, barkod_no, urun_adi, miktari, "alıs_fiyat", "satıs_fiyat", marka_id, kategori_id) VALUES (2, 'sdfghe4wefxc', 'u2', 4520, 796, 120, 2, 1);
INSERT INTO public.urun (urun_id, barkod_no, urun_adi, miktari, "alıs_fiyat", "satıs_fiyat", marka_id, kategori_id) VALUES (3, '65126', 'jıubjk', 5, 8, 99, 2, 2);
INSERT INTO public.urun (urun_id, barkod_no, urun_adi, miktari, "alıs_fiyat", "satıs_fiyat", marka_id, kategori_id) VALUES (4, '5588', 'yasoooo', 563, 5635423, 5365, 1, 2);
INSERT INTO public.urun (urun_id, barkod_no, urun_adi, miktari, "alıs_fiyat", "satıs_fiyat", marka_id, kategori_id) VALUES (5, '542', 'uyuu', 252, 5252, 52525, 3, 1);
INSERT INTO public.urun (urun_id, barkod_no, urun_adi, miktari, "alıs_fiyat", "satıs_fiyat", marka_id, kategori_id) VALUES (8, '1362531', 'yasool', 213, 1202, 211, 7, 12);
INSERT INTO public.urun (urun_id, barkod_no, urun_adi, miktari, "alıs_fiyat", "satıs_fiyat", marka_id, kategori_id) VALUES (9, '47', 'tgtr', 35, 543, 2542, 3, 7);
INSERT INTO public.urun (urun_id, barkod_no, urun_adi, miktari, "alıs_fiyat", "satıs_fiyat", marka_id, kategori_id) VALUES (10, '355352', 'kfrnfgltk', 25254, 58285, 5876655, 4, 7);
INSERT INTO public.urun (urun_id, barkod_no, urun_adi, miktari, "alıs_fiyat", "satıs_fiyat", marka_id, kategori_id) VALUES (6, '45', 'yassooooo', 6535, 58267, 876568, 4, 6);
INSERT INTO public.urun (urun_id, barkod_no, urun_adi, miktari, "alıs_fiyat", "satıs_fiyat", marka_id, kategori_id) VALUES (1, '42', 'yaso', 541, 58741, 5874, 1, 4);


--
-- TOC entry 3476 (class 0 OID 41305)
-- Dependencies: 214
-- Data for Name: yorumlar; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3549 (class 0 OID 0)
-- Dependencies: 216
-- Name: adres_adresid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.adres_adresid_seq', 1, false);


--
-- TOC entry 3550 (class 0 OID 0)
-- Dependencies: 228
-- Name: adres_musteri_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.adres_musteri_id_seq', 1, false);


--
-- TOC entry 3551 (class 0 OID 0)
-- Dependencies: 234
-- Name: iade_iade_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.iade_iade_id_seq', 1, false);


--
-- TOC entry 3552 (class 0 OID 0)
-- Dependencies: 235
-- Name: iade_urun_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.iade_urun_id_seq', 1, false);


--
-- TOC entry 3553 (class 0 OID 0)
-- Dependencies: 249
-- Name: kategori_marka_kategori_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kategori_marka_kategori_id_seq', 1, false);


--
-- TOC entry 3554 (class 0 OID 0)
-- Dependencies: 239
-- Name: kategori_marka_marka_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kategori_marka_marka_id_seq', 1, false);


--
-- TOC entry 3555 (class 0 OID 0)
-- Dependencies: 247
-- Name: kategoribilgileri_kategori_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kategoribilgileri_kategori_id_seq', 12, true);


--
-- TOC entry 3556 (class 0 OID 0)
-- Dependencies: 252
-- Name: kaydedilenler_kaydedilenler_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kaydedilenler_kaydedilenler_id_seq', 1, false);


--
-- TOC entry 3557 (class 0 OID 0)
-- Dependencies: 251
-- Name: kaydedilenler_urun_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kaydedilenler_urun_id_seq', 1, false);


--
-- TOC entry 3558 (class 0 OID 0)
-- Dependencies: 237
-- Name: kuponlar_kupon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kuponlar_kupon_id_seq', 1, false);


--
-- TOC entry 3559 (class 0 OID 0)
-- Dependencies: 229
-- Name: markabilgileri_marka_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.markabilgileri_marka_id_seq', 7, true);


--
-- TOC entry 3560 (class 0 OID 0)
-- Dependencies: 244
-- Name: musteri_kupon_kupon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.musteri_kupon_kupon_id_seq', 1, false);


--
-- TOC entry 3561 (class 0 OID 0)
-- Dependencies: 245
-- Name: musteri_kupon_musteri_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.musteri_kupon_musteri_id_seq', 1, false);


--
-- TOC entry 3562 (class 0 OID 0)
-- Dependencies: 220
-- Name: musteri_musteri_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.musteri_musteri_id_seq', 1, false);


--
-- TOC entry 3563 (class 0 OID 0)
-- Dependencies: 241
-- Name: musteri_urun_musteri_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.musteri_urun_musteri_id_seq', 1, false);


--
-- TOC entry 3564 (class 0 OID 0)
-- Dependencies: 242
-- Name: musteri_urun_urun_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.musteri_urun_urun_id_seq', 1, false);


--
-- TOC entry 3565 (class 0 OID 0)
-- Dependencies: 227
-- Name: odemebilgileri_musteri_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.odemebilgileri_musteri_id_seq', 1, false);


--
-- TOC entry 3566 (class 0 OID 0)
-- Dependencies: 218
-- Name: odemebilgileri_odemeid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.odemebilgileri_odemeid_seq', 1, false);


--
-- TOC entry 3567 (class 0 OID 0)
-- Dependencies: 223
-- Name: sepet_musteri_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sepet_musteri_id_seq', 1, false);


--
-- TOC entry 3568 (class 0 OID 0)
-- Dependencies: 217
-- Name: sepet_sepeteid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sepet_sepeteid_seq', 1, false);


--
-- TOC entry 3569 (class 0 OID 0)
-- Dependencies: 222
-- Name: siparis_musteri_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.siparis_musteri_id_seq', 1, false);


--
-- TOC entry 3570 (class 0 OID 0)
-- Dependencies: 226
-- Name: siparis_urun_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.siparis_urun_id_seq', 1, false);


--
-- TOC entry 3571 (class 0 OID 0)
-- Dependencies: 219
-- Name: siparis_urun_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.siparis_urun_seq', 1, false);


--
-- TOC entry 3572 (class 0 OID 0)
-- Dependencies: 250
-- Name: urun_kategori_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.urun_kategori_id_seq', 1, false);


--
-- TOC entry 3573 (class 0 OID 0)
-- Dependencies: 230
-- Name: urun_marka_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.urun_marka_id_seq', 1, false);


--
-- TOC entry 3574 (class 0 OID 0)
-- Dependencies: 224
-- Name: urun_urun_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.urun_urun_id_seq', 10, true);


--
-- TOC entry 3575 (class 0 OID 0)
-- Dependencies: 232
-- Name: yorumlar_musteri_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.yorumlar_musteri_id_seq', 1, false);


--
-- TOC entry 3576 (class 0 OID 0)
-- Dependencies: 233
-- Name: yorumlar_urun_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.yorumlar_urun_id_seq', 1, false);


--
-- TOC entry 3577 (class 0 OID 0)
-- Dependencies: 231
-- Name: yorumlar_yorum_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.yorumlar_yorum_id_seq', 1, false);


--
-- TOC entry 3292 (class 2606 OID 41323)
-- Name: adres adres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adres
    ADD CONSTRAINT adres_pkey PRIMARY KEY (adresid);


--
-- TOC entry 3304 (class 2606 OID 41550)
-- Name: iade iade_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.iade
    ADD CONSTRAINT iade_pkey PRIMARY KEY (iade_id);


--
-- TOC entry 3310 (class 2606 OID 49854)
-- Name: kategoribilgileri kategoribilgileri_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kategoribilgileri
    ADD CONSTRAINT kategoribilgileri_pkey PRIMARY KEY (kategori_id);


--
-- TOC entry 3294 (class 2606 OID 66270)
-- Name: kaydedilenler kaydedilenler_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kaydedilenler
    ADD CONSTRAINT kaydedilenler_pkey PRIMARY KEY (kaydedilenler_id);


--
-- TOC entry 3306 (class 2606 OID 41565)
-- Name: kuponlar kuponlar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kuponlar
    ADD CONSTRAINT kuponlar_pkey PRIMARY KEY (kupon_id);


--
-- TOC entry 3286 (class 2606 OID 41488)
-- Name: markabilgileri markabilgileri_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.markabilgileri
    ADD CONSTRAINT markabilgileri_pkey PRIMARY KEY (marka_id);


--
-- TOC entry 3300 (class 2606 OID 41371)
-- Name: musteri musteri_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.musteri
    ADD CONSTRAINT musteri_pkey PRIMARY KEY (musteri_id);


--
-- TOC entry 3308 (class 2606 OID 41598)
-- Name: musteri_urun musteri_urun_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.musteri_urun
    ADD CONSTRAINT musteri_urun_pkey PRIMARY KEY (musteri_id, urun_id);


--
-- TOC entry 3298 (class 2606 OID 41341)
-- Name: odemebilgileri odemebilgileri_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.odemebilgileri
    ADD CONSTRAINT odemebilgileri_pkey PRIMARY KEY (odeme_id);


--
-- TOC entry 3288 (class 2606 OID 41330)
-- Name: sepet sepet_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sepet
    ADD CONSTRAINT sepet_pkey PRIMARY KEY (sepeteid);


--
-- TOC entry 3290 (class 2606 OID 41348)
-- Name: siparis siparis_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.siparis
    ADD CONSTRAINT siparis_pkey PRIMARY KEY (urun);


--
-- TOC entry 3302 (class 2606 OID 41417)
-- Name: urun urun_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.urun
    ADD CONSTRAINT urun_pkey PRIMARY KEY (urun_id);


--
-- TOC entry 3296 (class 2606 OID 41523)
-- Name: yorumlar yorumlar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yorumlar
    ADD CONSTRAINT yorumlar_pkey PRIMARY KEY (yorum_id);


--
-- TOC entry 3331 (class 2620 OID 66278)
-- Name: kategoribilgileri kategori_silinince_urun_sil; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER kategori_silinince_urun_sil BEFORE DELETE ON public.kategoribilgileri FOR EACH ROW EXECUTE FUNCTION public.kategori_urunlerini_sil();


--
-- TOC entry 3328 (class 2620 OID 66277)
-- Name: markabilgileri kategori_silinince_urun_sil; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER kategori_silinince_urun_sil BEFORE DELETE ON public.markabilgileri FOR EACH ROW EXECUTE FUNCTION public.kategori_urunlerini_sil();


--
-- TOC entry 3329 (class 2620 OID 58037)
-- Name: markabilgileri marka_silinince_urun_sil; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER marka_silinince_urun_sil BEFORE DELETE ON public.markabilgileri FOR EACH ROW EXECUTE FUNCTION public.marka_urunlerini_sil();


--
-- TOC entry 3330 (class 2620 OID 66285)
-- Name: urun urun_kontrol; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER urun_kontrol BEFORE INSERT OR UPDATE ON public.urun FOR EACH ROW EXECUTE FUNCTION public.urun_ekle();


--
-- TOC entry 3314 (class 2606 OID 41476)
-- Name: adres adres_musteri_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adres
    ADD CONSTRAINT adres_musteri_id_fkey FOREIGN KEY (musteri_id) REFERENCES public.musteri(musteri_id);


--
-- TOC entry 3321 (class 2606 OID 41551)
-- Name: iade iade_urun_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.iade
    ADD CONSTRAINT iade_urun_id_fkey FOREIGN KEY (urun_id) REFERENCES public.urun(urun_id);


--
-- TOC entry 3323 (class 2606 OID 49873)
-- Name: kategori_marka kategori_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kategori_marka
    ADD CONSTRAINT kategori_id_fk FOREIGN KEY (kategori_id) REFERENCES public.kategoribilgileri(kategori_id) NOT VALID;


--
-- TOC entry 3315 (class 2606 OID 66271)
-- Name: kaydedilenler kaydedilenlerurunfkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kaydedilenler
    ADD CONSTRAINT kaydedilenlerurunfkey FOREIGN KEY (urun_id) REFERENCES public.urun(urun_id) NOT VALID;


--
-- TOC entry 3327 (class 2606 OID 41630)
-- Name: musteri_kupon kupon_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.musteri_kupon
    ADD CONSTRAINT kupon_id FOREIGN KEY (kupon_id) REFERENCES public.kuponlar(kupon_id);


--
-- TOC entry 3322 (class 2606 OID 41585)
-- Name: kategori_marka marka_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kategori_marka
    ADD CONSTRAINT marka_id FOREIGN KEY (marka_id) REFERENCES public.markabilgileri(marka_id);


--
-- TOC entry 3316 (class 2606 OID 41524)
-- Name: yorumlar musteri_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yorumlar
    ADD CONSTRAINT musteri_id FOREIGN KEY (musteri_id) REFERENCES public.musteri(musteri_id) NOT VALID;


--
-- TOC entry 3324 (class 2606 OID 41599)
-- Name: musteri_urun musteri_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.musteri_urun
    ADD CONSTRAINT musteri_id FOREIGN KEY (musteri_id) REFERENCES public.musteri(musteri_id);


--
-- TOC entry 3326 (class 2606 OID 41625)
-- Name: musteri_kupon musteri_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.musteri_kupon
    ADD CONSTRAINT musteri_id FOREIGN KEY (musteri_id) REFERENCES public.musteri(musteri_id);


--
-- TOC entry 3318 (class 2606 OID 41463)
-- Name: odemebilgileri odemebilgileri_musteri_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.odemebilgileri
    ADD CONSTRAINT odemebilgileri_musteri_id_fkey FOREIGN KEY (musteri_id) REFERENCES public.musteri(musteri_id);


--
-- TOC entry 3311 (class 2606 OID 41392)
-- Name: sepet sepet_musteri_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sepet
    ADD CONSTRAINT sepet_musteri_id_fkey FOREIGN KEY (musteri_id) REFERENCES public.musteri(musteri_id);


--
-- TOC entry 3312 (class 2606 OID 41381)
-- Name: siparis siparis_musteri_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.siparis
    ADD CONSTRAINT siparis_musteri_id_fkey FOREIGN KEY (musteri_id) REFERENCES public.musteri(musteri_id);


--
-- TOC entry 3313 (class 2606 OID 41425)
-- Name: siparis siparis_urun_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.siparis
    ADD CONSTRAINT siparis_urun_id_fkey FOREIGN KEY (urun_id) REFERENCES public.urun(urun_id);


--
-- TOC entry 3325 (class 2606 OID 41604)
-- Name: musteri_urun urun_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.musteri_urun
    ADD CONSTRAINT urun_id FOREIGN KEY (urun_id) REFERENCES public.urun(urun_id);


--
-- TOC entry 3320 (class 2606 OID 49868)
-- Name: urun urun_kategori_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.urun
    ADD CONSTRAINT urun_kategori_id_fk FOREIGN KEY (kategori_id) REFERENCES public.kategoribilgileri(kategori_id) NOT VALID;


--
-- TOC entry 3319 (class 2606 OID 41497)
-- Name: urun urun_marka_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.urun
    ADD CONSTRAINT urun_marka_id_fkey FOREIGN KEY (marka_id) REFERENCES public.markabilgileri(marka_id);


--
-- TOC entry 3317 (class 2606 OID 41531)
-- Name: yorumlar yorumlar_urun_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yorumlar
    ADD CONSTRAINT yorumlar_urun_id_fkey FOREIGN KEY (urun_id) REFERENCES public.urun(urun_id);


-- Completed on 2021-12-20 20:11:16

--
-- PostgreSQL database dump complete
--

