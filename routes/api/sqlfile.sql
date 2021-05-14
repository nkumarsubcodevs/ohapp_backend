--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.21
-- Dumped by pg_dump version 9.5.19

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: Options; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Options" (
    title character varying(250),
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    question_id bigint,
    id integer NOT NULL
);


ALTER TABLE public."Options" OWNER TO postgres;

--
-- Name: Options_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Options_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Options_id_seq" OWNER TO postgres;

--
-- Name: Options_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Options_id_seq" OWNED BY public."Options".id;


--
-- Name: chat_attachments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chat_attachments (
    id bigint NOT NULL,
    chat_id bigint,
    original_file_name character varying(100),
    unique_file_name character varying(100),
    status smallint,
    create_time timestamp without time zone,
    update_time timestamp without time zone
);


ALTER TABLE public.chat_attachments OWNER TO postgres;

--
-- Name: chat_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.chat_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.chat_attachments_id_seq OWNER TO postgres;

--
-- Name: chat_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.chat_attachments_id_seq OWNED BY public.chat_attachments.id;


--
-- Name: chat_messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chat_messages (
    id bigint NOT NULL,
    goal_id bigint,
    sender_id bigint,
    receiver_id bigint,
    message text,
    chat_status_id bigint,
    create_time timestamp without time zone,
    update_time timestamp without time zone
);


ALTER TABLE public.chat_messages OWNER TO postgres;

--
-- Name: chat_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.chat_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.chat_messages_id_seq OWNER TO postgres;

--
-- Name: chat_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.chat_messages_id_seq OWNED BY public.chat_messages.id;


--
-- Name: chat_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chat_status (
    id bigint NOT NULL,
    status character varying(100),
    create_time timestamp without time zone,
    update_time timestamp without time zone
);


ALTER TABLE public.chat_status OWNER TO postgres;

--
-- Name: chat_status_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.chat_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.chat_status_id_seq OWNER TO postgres;

--
-- Name: chat_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.chat_status_id_seq OWNED BY public.chat_status.id;


--
-- Name: completion_goals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.completion_goals (
    id integer NOT NULL,
    user_id bigint,
    goal_id bigint,
    partner_mapping_id bigint,
    "didYouConnectLastNight" boolean,
    "WhoInitiative" boolean,
    create_time timestamp without time zone,
    update_time timestamp without time zone
);


ALTER TABLE public.completion_goals OWNER TO postgres;

--
-- Name: completion_goals_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.completion_goals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.completion_goals_id_seq OWNER TO postgres;

--
-- Name: completion_goals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.completion_goals_id_seq OWNED BY public.completion_goals.id;


--
-- Name: contact_us; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contact_us (
    id integer NOT NULL,
    feedback_details text,
    user_id bigint,
    create_time timestamp without time zone,
    update_time timestamp without time zone
);


ALTER TABLE public.contact_us OWNER TO postgres;

--
-- Name: contact_us_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contact_us_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contact_us_id_seq OWNER TO postgres;

--
-- Name: contact_us_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contact_us_id_seq OWNED BY public.contact_us.id;


--
-- Name: goal_notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.goal_notifications (
    id bigint NOT NULL,
    goal_id bigint,
    user_id bigint,
    device_id text,
    notification_id text,
    parent_notification_id bigint,
    answer text,
    status smallint,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    stage bigint DEFAULT 1
);


ALTER TABLE public.goal_notifications OWNER TO postgres;

--
-- Name: goal_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.goal_notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.goal_notifications_id_seq OWNER TO postgres;

--
-- Name: goal_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.goal_notifications_id_seq OWNED BY public.goal_notifications.id;


--
-- Name: goal_setting_answers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.goal_setting_answers (
    id bigint NOT NULL,
    question_id bigint,
    answer text,
    status smallint,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    user_id bigint,
    custom_answer text
);


ALTER TABLE public.goal_setting_answers OWNER TO postgres;

--
-- Name: goal_setting_answers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.goal_setting_answers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.goal_setting_answers_id_seq OWNER TO postgres;

--
-- Name: goal_setting_answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.goal_setting_answers_id_seq OWNED BY public.goal_setting_answers.id;


--
-- Name: goal_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.goal_settings (
    id bigint NOT NULL,
    question_descripation character varying(500),
    status smallint,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    question_title character(500),
    iscustom character(500)
);


ALTER TABLE public.goal_settings OWNER TO postgres;

--
-- Name: goal_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.goal_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.goal_settings_id_seq OWNER TO postgres;

--
-- Name: goal_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.goal_settings_id_seq OWNED BY public.goal_settings.id;


--
-- Name: info_messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.info_messages (
    id integer NOT NULL,
    title character varying(200),
    description text,
    status bigint,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    key character varying(100),
    screen character varying(100)
);


ALTER TABLE public.info_messages OWNER TO postgres;

--
-- Name: info_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.info_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.info_messages_id_seq OWNER TO postgres;

--
-- Name: info_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.info_messages_id_seq OWNED BY public.info_messages.id;


--
-- Name: monthly_goals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.monthly_goals (
    id bigint NOT NULL,
    partner_mapping_id bigint,
    user_id bigint,
    goal_identifier character varying(150),
    month_start character varying(50),
    month_end character varying(50),
    connect_number character varying(50),
    initiator_count character varying(50),
    percentage character varying(50),
    complete_count character varying(50),
    complete_percentage character varying(50),
    status smallint,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    intimate_time character varying(50),
    intimate_request_time character varying(50),
    intimate_account_time character varying(50),
    initiator_count1 character varying(50),
    contribution2 bigint DEFAULT 0 NOT NULL,
    contribution1 bigint DEFAULT 0 NOT NULL,
    hours character varying(200)
);


ALTER TABLE public.monthly_goals OWNER TO postgres;

--
-- Name: monthly_goals_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.monthly_goals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.monthly_goals_id_seq OWNER TO postgres;

--
-- Name: monthly_goals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.monthly_goals_id_seq OWNED BY public.monthly_goals.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications (
    id bigint NOT NULL,
    question character varying(500),
    status smallint,
    create_time timestamp without time zone,
    update_time timestamp without time zone
);


ALTER TABLE public.notifications OWNER TO postgres;

--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notifications_id_seq OWNER TO postgres;

--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: pages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pages (
    id bigint NOT NULL,
    title character varying(250),
    description text,
    status smallint,
    create_time timestamp without time zone,
    update_time timestamp without time zone
);


ALTER TABLE public.pages OWNER TO postgres;

--
-- Name: pages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pages_id_seq OWNER TO postgres;

--
-- Name: pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pages_id_seq OWNED BY public.pages.id;


--
-- Name: partner_mappings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.partner_mappings (
    id bigint NOT NULL,
    partner_one_id bigint,
    partner_two_id bigint,
    status smallint,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    uniqe_id character varying(100)
);


ALTER TABLE public.partner_mappings OWNER TO postgres;

--
-- Name: partner_mappings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.partner_mappings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.partner_mappings_id_seq OWNER TO postgres;

--
-- Name: partner_mappings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.partner_mappings_id_seq OWNED BY public.partner_mappings.id;


--
-- Name: quickies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quickies (
    id integer NOT NULL,
    user_id bigint,
    partner_mapping_id bigint,
    partner_response boolean,
    "when" character varying(200),
    "where" character varying(200),
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    partner1_intrest boolean,
    partner2_intrest boolean,
    partner1_answer1 boolean,
    partner1_answer2 boolean,
    partner2_answer1 boolean,
    partner2_answer2 boolean,
    contribution bigint
);


ALTER TABLE public.quickies OWNER TO postgres;

--
-- Name: quickies_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.quickies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.quickies_id_seq OWNER TO postgres;

--
-- Name: quickies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.quickies_id_seq OWNED BY public.quickies.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    role_title character varying(100),
    status smallint,
    create_time timestamp without time zone,
    update_time timestamp without time zone
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_id_seq OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: subscripations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subscripations (
    id integer NOT NULL,
    user_id bigint,
    partner_mapping_id bigint,
    purchase_plan_id text,
    amount bigint,
    device_name character varying(200),
    subscripation_plan character varying(200),
    receipt text,
    status bigint,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    expiry_date timestamp without time zone
);


ALTER TABLE public.subscripations OWNER TO postgres;

--
-- Name: subscripations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subscripations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subscripations_id_seq OWNER TO postgres;

--
-- Name: subscripations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subscripations_id_seq OWNED BY public.subscripations.id;


--
-- Name: unavailabilities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.unavailabilities (
    id integer NOT NULL,
    user_id bigint,
    unavailability_start timestamp without time zone,
    unavailability_end timestamp without time zone,
    status smallint,
    create_time timestamp without time zone,
    update_time timestamp without time zone
);


ALTER TABLE public.unavailabilities OWNER TO postgres;

--
-- Name: unavailabilities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.unavailabilities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.unavailabilities_id_seq OWNER TO postgres;

--
-- Name: unavailabilities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.unavailabilities_id_seq OWNED BY public.unavailabilities.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    role_id bigint NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    gender character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    password character varying(100) NOT NULL,
    profile_image character varying(100),
    face_id character varying(250),
    touch_id character varying(250),
    access_token character varying(150),
    unique_code character varying(150),
    notification_mute_status smallint,
    notification_mute_end timestamp without time zone,
    status smallint NOT NULL,
    create_time timestamp without time zone NOT NULL,
    update_time timestamp without time zone NOT NULL,
    fcmid character varying(250),
    stage smallint DEFAULT 1,
    device_name character varying(100),
    receipt text,
    expiry_time timestamp without time zone,
    notification_mute_start timestamp without time zone
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Options" ALTER COLUMN id SET DEFAULT nextval('public."Options_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_attachments ALTER COLUMN id SET DEFAULT nextval('public.chat_attachments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_messages ALTER COLUMN id SET DEFAULT nextval('public.chat_messages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_status ALTER COLUMN id SET DEFAULT nextval('public.chat_status_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.completion_goals ALTER COLUMN id SET DEFAULT nextval('public.completion_goals_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_us ALTER COLUMN id SET DEFAULT nextval('public.contact_us_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goal_notifications ALTER COLUMN id SET DEFAULT nextval('public.goal_notifications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goal_setting_answers ALTER COLUMN id SET DEFAULT nextval('public.goal_setting_answers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goal_settings ALTER COLUMN id SET DEFAULT nextval('public.goal_settings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.info_messages ALTER COLUMN id SET DEFAULT nextval('public.info_messages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.monthly_goals ALTER COLUMN id SET DEFAULT nextval('public.monthly_goals_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pages ALTER COLUMN id SET DEFAULT nextval('public.pages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partner_mappings ALTER COLUMN id SET DEFAULT nextval('public.partner_mappings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quickies ALTER COLUMN id SET DEFAULT nextval('public.quickies_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscripations ALTER COLUMN id SET DEFAULT nextval('public.subscripations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unavailabilities ALTER COLUMN id SET DEFAULT nextval('public.unavailabilities_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: Options; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Options" (title, create_time, update_time, question_id, id) FROM stdin;
Cuddling	2020-05-22 06:22:31	2020-05-22 06:22:31	17	143
Showering together	2020-05-22 06:22:31	2020-05-22 06:22:31	17	144
Pillow-talk	2020-05-22 06:22:31	2020-05-22 06:22:31	17	145
Woman on top	2020-05-22 05:58:04	2020-05-22 05:58:04	8	28
 Man on top	2020-05-22 05:58:04	2020-05-22 05:58:04	8	29
Rear entry	2020-05-22 05:58:04	2020-05-22 05:58:04	8	30
Side by side	2020-05-22 05:58:04	2020-05-22 05:58:04	8	31
Standing	2020-05-22 05:58:04	2020-05-22 05:58:04	8	32
Kneeling	2020-05-22 05:58:04	2020-05-22 05:58:04	8	33
Seated	2020-05-22 05:58:04	2020-05-22 05:58:04	8	34
Mirror	2020-05-22 06:04:05	2020-05-22 06:04:05	9	48
Blindfold	2020-05-22 06:04:05	2020-05-22 06:04:05	9	49
Lubrication	2020-05-22 06:04:05	2020-05-22 06:04:05	9	50
Kissing	2020-05-22 06:04:30	2020-05-22 06:04:30	7	51
Petting 	2020-05-22 06:04:30	2020-05-22 06:04:30	7	52
Massage	2020-05-22 06:04:30	2020-05-22 06:04:30	7	53
Massage with oil	2020-05-22 06:04:30	2020-05-22 06:04:30	7	54
Verbal	2020-05-22 06:04:30	2020-05-22 06:04:30	7	55
Oral	2020-05-22 06:04:30	2020-05-22 06:04:30	7	56
Candles Low	2020-05-22 06:20:19	2020-05-22 06:20:19	16	128
 lighting	2020-05-22 06:20:19	2020-05-22 06:20:19	16	129
Completely dark	2020-05-22 06:20:19	2020-05-22 06:20:19	16	131
5 minutes	2020-05-22 06:20:36	2020-05-22 06:20:36	15	132
15 minutes	2020-05-22 06:20:36	2020-05-22 06:20:36	15	133
30 minutes	2020-05-22 06:20:36	2020-05-22 06:20:36	15	134
Not important	2020-05-22 06:10:02	2020-05-22 06:10:02	11	71
Important	2020-05-22 06:10:02	2020-05-22 06:10:02	11	72
Very important!	2020-05-22 06:10:02	2020-05-22 06:10:02	11	73
60 minutes	2020-05-22 06:20:36	2020-05-22 06:20:36	15	135
\.


--
-- Name: Options_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Options_id_seq"', 152, true);


--
-- Data for Name: chat_attachments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.chat_attachments (id, chat_id, original_file_name, unique_file_name, status, create_time, update_time) FROM stdin;
\.


--
-- Name: chat_attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.chat_attachments_id_seq', 1, false);


--
-- Data for Name: chat_messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.chat_messages (id, goal_id, sender_id, receiver_id, message, chat_status_id, create_time, update_time) FROM stdin;
649	11	24	25	c2RzYWRhYWRhZHNh	1	2020-02-11 23:34:39	2020-02-11 23:34:39
650	11	24	25	YWFkc2Fkc2FzYWRhZGFz	1	2020-02-11 23:34:53	2020-02-11 23:34:53
651	11	24	25	ZHNhYWRhZGFzZHNh	1	2020-02-11 23:39:13	2020-02-11 23:39:13
652	11	24	25	ZHNhZGFkc2Fkc2Fkc2E=	1	2020-02-11 23:44:35	2020-02-11 23:44:35
653	11	24	25	c2Rmc2Zkcw==	1	2020-02-11 23:44:40	2020-02-11 23:44:40
654	11	24	25	c2RzYWRhYWRhYQ==	1	2020-02-11 23:44:45	2020-02-11 23:44:45
655	11	24	25	YXNkYXNkc2FzYWQ=	1	2020-02-11 23:44:50	2020-02-11 23:44:50
656	11	24	25	c2FkYWFkYXNkc2Fhc2FzZHNhcw==	1	2020-02-11 23:44:57	2020-02-11 23:44:57
657	11	24	25	ZXF3ZWVld3Fld3Fld3E=	1	2020-02-11 23:45:46	2020-02-11 23:45:46
658	11	24	25	c2FzZHNhZGRzZGE=	1	2020-02-11 23:45:52	2020-02-11 23:45:52
659	11	25	24	YXNkc2FkYWRhc2Rh	1	2020-02-11 23:46:39	2020-02-11 23:46:39
660	11	25	24	c3Nkc2RzYWRzYWRzYXM=	1	2020-02-11 23:46:59	2020-02-11 23:46:59
661	11	25	24	cWVxd3FxcXdld3Fld3Fld3E=	1	2020-02-11 23:47:12	2020-02-11 23:47:12
662	11	25	24	c2Fkc2FhYXNzYWRh	1	2020-02-11 23:47:22	2020-02-11 23:47:22
663	11	24	25	ZGFkc2FkYWRhYXNkYQ==	1	2020-02-11 23:56:44	2020-02-11 23:56:44
664	11	24	25	YXNkYXNhYWFkYWRhc2Rhc2RzYQ==	1	2020-02-11 23:57:01	2020-02-11 23:57:01
665	11	24	25	c2FkYWFkYWRhc2RhZHNh	1	2020-02-11 23:57:29	2020-02-11 23:57:29
666	11	24	25	ZGFkYXNhc2FzYQ==	1	2020-02-12 00:06:49	2020-02-12 00:06:49
667	11	24	25	YWRhc2FkYWRhZGFzZGFkc2E=	1	2020-02-12 00:07:25	2020-02-12 00:07:25
668	11	24	25	ZGFkZGFzZGFkYXM=	1	2020-02-12 00:17:41	2020-02-12 00:17:41
669	11	24	25	YWRhYWRhZGFzZHNhZHNh	1	2020-02-12 00:18:49	2020-02-12 00:18:49
670	11	34	35	ZHNhZGFhZGFhc2RhZHNhZGRhZHNhcw==	1	2020-02-12 00:19:04	2020-02-12 00:19:04
671	11	24	25	ZGFzZHNhYWRzYWRzYQ==	1	2020-02-12 00:19:14	2020-02-12 00:19:14
672	11	24	25	ZGFkc2Rhc2RhZGFz	1	2020-02-12 00:21:00	2020-02-12 00:21:00
673	11	24	25	c2FkYWFkYXNhcw==	1	2020-02-12 00:21:49	2020-02-12 00:21:49
674	11	24	25	ZGFzZGFzZGFzZGE=	1	2020-02-12 00:28:11	2020-02-12 00:28:11
675	11	24	25	ZGRhYXNkYXNkYQ==	1	2020-02-12 00:28:43	2020-02-12 00:28:43
676	11	25	24	ZGFhZGFkc2Fkc2Fkc2E=	1	2020-02-12 00:29:01	2020-02-12 00:29:01
\.


--
-- Name: chat_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.chat_messages_id_seq', 1, false);


--
-- Data for Name: chat_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.chat_status (id, status, create_time, update_time) FROM stdin;
1	NEW	2020-01-14 00:00:00	2020-01-14 00:00:00
2	READ	2020-01-14 00:00:00	2020-01-14 00:00:00
3	UNREAD	2020-01-14 00:00:00	2020-01-14 00:00:00
4	DELETE	2020-01-14 00:00:00	2020-01-14 00:00:00
\.


--
-- Name: chat_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.chat_status_id_seq', 1, false);


--
-- Data for Name: completion_goals; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.completion_goals (id, user_id, goal_id, partner_mapping_id, "didYouConnectLastNight", "WhoInitiative", create_time, update_time) FROM stdin;
1	51	162	226	t	t	2020-05-16 08:22:43	2020-05-16 08:22:43
2	52	162	226	t	f	2020-05-16 08:22:52	2020-05-16 08:22:52
3	267	221	258	t	t	2020-05-20 11:15:17	2020-05-20 11:15:17
4	268	221	258	t	f	2020-05-20 11:18:41	2020-05-20 11:18:41
5	267	221	258	t	t	2020-05-20 11:19:37	2020-05-20 11:19:37
6	327	328	414	t	f	2020-05-29 06:48:44	2020-05-29 06:48:44
7	327	328	414	t	f	2020-05-29 06:51:00	2020-05-29 06:51:00
8	327	328	414	t	f	2020-05-29 06:51:16	2020-05-29 06:51:16
9	327	328	414	t	f	2020-05-29 06:51:18	2020-05-29 06:51:18
10	327	328	414	t	f	2020-05-29 06:51:41	2020-05-29 06:51:41
11	328	328	414	t	t	2020-05-29 06:52:11	2020-05-29 06:52:11
12	330	353	453	t	t	2020-06-02 06:32:05	2020-06-02 06:32:05
13	311	347	448	t	f	2020-06-03 06:32:27	2020-06-03 06:32:27
14	311	347	448	t	f	2020-06-03 10:51:14	2020-06-03 10:51:14
15	311	347	448	t	f	2020-06-03 10:51:21	2020-06-03 10:51:21
16	311	347	448	t	f	2020-06-03 10:59:00	2020-06-03 10:59:00
17	311	347	448	t	f	2020-06-03 10:59:47	2020-06-03 10:59:47
18	311	347	448	t	f	2020-06-03 10:59:56	2020-06-03 10:59:56
19	311	347	448	t	f	2020-06-03 11:00:14	2020-06-03 11:00:14
20	311	347	448	t	f	2020-06-03 11:00:38	2020-06-03 11:00:38
21	311	347	448	t	f	2020-06-03 11:00:52	2020-06-03 11:00:52
22	311	347	448	t	f	2020-06-03 11:05:13	2020-06-03 11:05:13
23	311	347	449	t	t	2020-06-03 11:06:05	2020-06-03 11:06:05
24	311	347	448	t	f	2020-06-03 11:06:21	2020-06-03 11:06:21
25	311	347	449	t	t	2020-06-03 11:06:23	2020-06-03 11:06:23
26	312	347	449	t	f	2020-06-03 11:07:20	2020-06-03 11:07:20
27	312	347	448	t	t	2020-06-03 11:07:23	2020-06-03 11:07:23
28	312	347	449	t	f	2020-06-03 11:10:19	2020-06-03 11:10:19
29	312	347	448	t	t	2020-06-03 11:10:26	2020-06-03 11:10:26
30	312	347	449	t	f	2020-06-03 11:36:30	2020-06-03 11:36:30
31	312	347	449	t	f	2020-06-03 11:36:53	2020-06-03 11:36:53
32	312	347	449	t	f	2020-06-03 11:37:10	2020-06-03 11:37:10
33	312	347	449	t	f	2020-06-03 11:37:15	2020-06-03 11:37:15
34	312	347	449	t	f	2020-06-03 11:37:30	2020-06-03 11:37:30
35	312	372	449	t	f	2020-06-03 11:54:01	2020-06-03 11:54:01
36	312	372	449	t	f	2020-06-03 11:54:09	2020-06-03 11:54:09
37	312	372	449	t	f	2020-06-03 11:54:15	2020-06-03 11:54:15
38	312	374	448	t	t	2020-06-03 12:00:09	2020-06-03 12:00:09
39	312	374	449	t	f	2020-06-03 12:00:20	2020-06-03 12:00:20
40	312	374	448	t	t	2020-06-03 12:00:23	2020-06-03 12:00:23
41	312	375	448	t	t	2020-06-03 12:02:07	2020-06-03 12:02:07
42	312	375	449	t	f	2020-06-03 12:02:08	2020-06-03 12:02:08
43	51	355	226	t	t	2020-06-03 12:05:44	2020-06-03 12:05:44
44	312	377	448	t	t	2020-06-03 12:09:44	2020-06-03 12:09:44
45	312	377	449	t	f	2020-06-03 12:09:48	2020-06-03 12:09:48
46	312	378	449	t	f	2020-06-03 12:19:35	2020-06-03 12:19:35
47	312	378	449	t	f	2020-06-03 12:25:21	2020-06-03 12:25:21
48	312	378	449	t	f	2020-06-03 12:25:30	2020-06-03 12:25:30
49	312	378	449	t	f	2020-06-03 12:25:37	2020-06-03 12:25:37
50	312	378	449	t	f	2020-06-03 12:25:53	2020-06-03 12:25:53
51	312	384	449	t	f	2020-06-03 12:37:32	2020-06-03 12:37:32
52	312	384	448	t	t	2020-06-03 12:37:34	2020-06-03 12:37:34
53	312	387	448	t	t	2020-06-03 12:40:04	2020-06-03 12:40:04
54	312	387	449	t	f	2020-06-03 12:40:05	2020-06-03 12:40:05
55	312	387	449	t	f	2020-06-03 12:40:16	2020-06-03 12:40:16
56	312	389	449	t	f	2020-06-03 12:43:20	2020-06-03 12:43:20
57	312	389	448	t	t	2020-06-03 12:43:22	2020-06-03 12:43:22
58	312	389	449	t	f	2020-06-03 12:43:52	2020-06-03 12:43:52
59	312	390	449	t	f	2020-06-03 12:47:14	2020-06-03 12:47:14
60	312	390	448	t	t	2020-06-03 12:47:14	2020-06-03 12:47:14
61	312	395	448	t	t	2020-06-03 12:54:02	2020-06-03 12:54:02
62	312	395	449	t	f	2020-06-03 12:54:08	2020-06-03 12:54:08
63	312	396	449	t	f	2020-06-03 12:57:45	2020-06-03 12:57:45
64	312	396	448	t	t	2020-06-03 01:02:57	2020-06-03 01:02:57
65	335	419	493	t	f	2020-06-03 01:50:36	2020-06-03 01:50:36
66	334	419	492	t	f	2020-06-03 01:50:40	2020-06-03 01:50:40
67	335	419	493	t	f	2020-06-03 01:50:51	2020-06-03 01:50:51
68	335	420	493	t	f	2020-06-03 01:51:37	2020-06-03 01:51:37
69	335	421	493	t	f	2020-06-03 01:53:16	2020-06-03 01:53:16
70	334	421	492	t	f	2020-06-03 01:53:23	2020-06-03 01:53:23
71	335	421	493	t	f	2020-06-03 01:53:34	2020-06-03 01:53:34
72	334	425	497	t	f	2020-06-05 10:05:59	2020-06-05 10:05:59
73	335	425	496	t	f	2020-06-05 10:06:04	2020-06-05 10:06:04
74	334	427	499	t	f	2020-06-05 10:29:22	2020-06-05 10:29:22
75	334	427	499	t	f	2020-06-05 10:29:27	2020-06-05 10:29:27
76	337	423	494	t	t	2020-06-06 07:35:29	2020-06-06 07:35:29
77	337	423	494	t	t	2020-06-06 07:35:46	2020-06-06 07:35:46
78	337	423	494	t	t	2020-06-07 01:30:58	2020-06-07 01:30:58
79	364	459	529	t	f	2020-06-25 11:46:40	2020-06-25 11:46:40
80	357	459	529	t	t	2020-06-26 12:27:00	2020-06-26 12:27:00
\.


--
-- Name: completion_goals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.completion_goals_id_seq', 80, true);


--
-- Data for Name: contact_us; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contact_us (id, feedback_details, user_id, create_time, update_time) FROM stdin;
1	IT's good looking and usefull App	52	2020-05-14 11:44:29	2020-05-14 11:44:29
2	Hhjji	230	2020-05-14 01:11:29	2020-05-14 01:11:29
3	Vuvjbbk	236	2020-05-14 04:49:31	2020-05-14 04:49:31
4	Hhjj	234	2020-05-14 04:49:34	2020-05-14 04:49:34
5	Sjdjccjcjdjjcccfncccxdjdjjxjx	281	2020-05-22 08:29:25	2020-05-22 08:29:25
6	Etehehy	291	2020-05-22 09:23:17	2020-05-22 09:23:17
7	     	257	2020-05-23 04:17:25	2020-05-23 04:17:25
8	Happy to help 	289	2020-05-25 01:13:56	2020-05-25 01:13:56
10	Jangal gangal 	317	2020-05-27 05:16:44	2020-05-27 05:16:44
11	Ggdfxgg	341	2020-06-15 09:11:46	2020-06-15 09:11:46
12	Ghhjk	342	2020-06-19 11:46:33	2020-06-19 11:46:33
13	Vfgjghj	362	2020-06-19 12:07:33	2020-06-19 12:07:33
\.


--
-- Name: contact_us_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contact_us_id_seq', 13, true);


--
-- Data for Name: goal_notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.goal_notifications (id, goal_id, user_id, device_id, notification_id, parent_notification_id, answer, status, create_time, update_time, stage) FROM stdin;
1107	115	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589336820027441%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:27:00	2020-05-13 02:27:00	1
1108	115	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589336820027275%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:27:00	2020-05-13 02:27:00	1
1109	115	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589336880024134%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:28:00	2020-05-13 02:28:00	1
1110	115	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589336880027630%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:28:00	2020-05-13 02:28:00	1
1111	115	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589336940025815%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:29:00	2020-05-13 02:29:00	1
1112	115	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589336940026164%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:29:00	2020-05-13 02:29:00	1
1113	115	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337000028962%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:30:00	2020-05-13 02:30:00	1
1114	115	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337000028767%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:30:00	2020-05-13 02:30:00	1
1115	115	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337060028562%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:31:00	2020-05-13 02:31:00	1
1116	115	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337060026786%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:31:00	2020-05-13 02:31:00	1
1117	115	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337120026401%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:32:00	2020-05-13 02:32:00	1
1118	115	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337120017926%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:32:00	2020-05-13 02:32:00	1
1119	115	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337180018580%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:33:00	2020-05-13 02:33:00	1
1120	115	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337180037662%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:33:00	2020-05-13 02:33:00	1
1121	115	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337240026049%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:34:00	2020-05-13 02:34:00	1
1122	115	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337240027544%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:34:00	2020-05-13 02:34:00	1
1123	115	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337300027804%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:35:00	2020-05-13 02:35:00	1
1124	115	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337300027097%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:35:00	2020-05-13 02:35:00	1
1125	115	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337360026210%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:36:00	2020-05-13 02:36:00	1
1126	115	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337360023137%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:36:00	2020-05-13 02:36:00	1
1127	115	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337420026771%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:37:00	2020-05-13 02:37:00	1
1128	115	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337420017351%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:37:00	2020-05-13 02:37:00	1
1129	115	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337480027809%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:38:00	2020-05-13 02:38:00	1
1130	115	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337480028526%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:38:00	2020-05-13 02:38:00	1
1131	115	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337540017614%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:39:00	2020-05-13 02:39:00	1
1132	115	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337540018183%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:39:00	2020-05-13 02:39:00	1
1133	115	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337600027656%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:40:00	2020-05-13 02:40:00	1
1134	115	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337600026346%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:40:00	2020-05-13 02:40:00	1
1136	115	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337660023805%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:41:00	2020-05-13 02:41:00	1
1135	115	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337660024759%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:41:00	2020-05-13 02:41:00	1
1137	115	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337720028911%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:42:00	2020-05-13 02:42:00	1
1138	115	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337720031088%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:42:00	2020-05-13 02:42:00	1
1139	115	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337780024885%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:43:00	2020-05-13 02:43:00	1
1140	115	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337780023459%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:43:00	2020-05-13 02:43:00	1
1141	115	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337840020026%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:44:00	2020-05-13 02:44:00	1
1142	115	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337840027467%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:44:00	2020-05-13 02:44:00	1
1143	115	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337900029848%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:45:00	2020-05-13 02:45:00	1
1144	115	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337900028983%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:45:00	2020-05-13 02:45:00	1
1146	115	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337960038889%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:46:00	2020-05-13 02:46:00	1
1147	118	193	cj2rVhFpQm-FEYuxrQlsjj:APA91bFurpLXORS4AkD-f4PtHfjdh9hFVHIcP8Es9Npb5C8F67ussqAnAzM_SENk9mOUGVbC2dk-9cLXwUKbgCgpiqpsv_beA9iRhL0UjKoeXjhTK4701JxLcpRYBZ-1yRmZUcMpF5iW	0:1589390400046836%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 05:20:00	2020-05-13 05:20:00	1
1148	118	193	cj2rVhFpQm-FEYuxrQlsjj:APA91bFurpLXORS4AkD-f4PtHfjdh9hFVHIcP8Es9Npb5C8F67ussqAnAzM_SENk9mOUGVbC2dk-9cLXwUKbgCgpiqpsv_beA9iRhL0UjKoeXjhTK4701JxLcpRYBZ-1yRmZUcMpF5iW	0:1589390400046487%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 05:20:00	2020-05-13 05:20:00	1
1149	117	189	cj2rVhFpQm-FEYuxrQlsjj:APA91bFurpLXORS4AkD-f4PtHfjdh9hFVHIcP8Es9Npb5C8F67ussqAnAzM_SENk9mOUGVbC2dk-9cLXwUKbgCgpiqpsv_beA9iRhL0UjKoeXjhTK4701JxLcpRYBZ-1yRmZUcMpF5iW	0:1589393700038639%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 06:15:00	2020-05-13 06:15:00	1
1150	117	189	cj2rVhFpQm-FEYuxrQlsjj:APA91bFurpLXORS4AkD-f4PtHfjdh9hFVHIcP8Es9Npb5C8F67ussqAnAzM_SENk9mOUGVbC2dk-9cLXwUKbgCgpiqpsv_beA9iRhL0UjKoeXjhTK4701JxLcpRYBZ-1yRmZUcMpF5iW	0:1589393700038159%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 06:15:00	2020-05-13 06:15:00	1
1151	119	198	cj2rVhFpQm-FEYuxrQlsjj:APA91bFurpLXORS4AkD-f4PtHfjdh9hFVHIcP8Es9Npb5C8F67ussqAnAzM_SENk9mOUGVbC2dk-9cLXwUKbgCgpiqpsv_beA9iRhL0UjKoeXjhTK4701JxLcpRYBZ-1yRmZUcMpF5iW	0:1589396400025918%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 07:00:00	2020-05-13 07:00:00	1
1152	119	198	cj2rVhFpQm-FEYuxrQlsjj:APA91bFurpLXORS4AkD-f4PtHfjdh9hFVHIcP8Es9Npb5C8F67ussqAnAzM_SENk9mOUGVbC2dk-9cLXwUKbgCgpiqpsv_beA9iRhL0UjKoeXjhTK4701JxLcpRYBZ-1yRmZUcMpF5iW	0:1589396400026477%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 07:00:00	2020-05-13 07:00:00	1
1153	137	243	dZaJSAmH9kUos4Obpy4s6r:APA91bFGDk879XNaOBI3IOewjW_-w9uGIfsrBu6x-plMUkYQSMI06X6MScw7f3eQTpcuX_Bte3aF7a7Lp7fo1Dj2GgGVdUZM0gltbQftFIWqJbVbuWyQWDhsVVAX7wIofbQtzt-W7lFH	1589482800041107	\N	\N	1	2020-05-14 07:00:00	2020-05-14 07:00:00	1
1154	137	243	dZaJSAmH9kUos4Obpy4s6r:APA91bFGDk879XNaOBI3IOewjW_-w9uGIfsrBu6x-plMUkYQSMI06X6MScw7f3eQTpcuX_Bte3aF7a7Lp7fo1Dj2GgGVdUZM0gltbQftFIWqJbVbuWyQWDhsVVAX7wIofbQtzt-W7lFH	1589482800041630	\N	\N	1	2020-05-14 07:00:00	2020-05-14 07:00:00	1
1145	115	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337960034215%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:46:00	2020-05-16 09:50:01	2
1155	178	249	fcvNsIWoTbWpeCBkGc5DAr:APA91bGsNmsVTOP4gbx4JEZXgAhbI4A0DighXLkBGiHJK0D4pNTVCJuIwIxICHzi8EBURCAHTdSTlAXp8FOjohXAkOZqBrnpYu65uN10V-6RgUebrWq7N8rnoW3RyEbOi9C9N5LQ4CN7	0:1589870820087688%0d63f7200d63f720	\N	\N	1	2020-05-19 06:47:00	2020-05-19 06:47:00	1
1156	178	254	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589870820093017%fc0c01eafc0c01ea	\N	\N	1	2020-05-19 06:47:00	2020-05-19 06:47:00	1
1157	178	249	fcvNsIWoTbWpeCBkGc5DAr:APA91bGsNmsVTOP4gbx4JEZXgAhbI4A0DighXLkBGiHJK0D4pNTVCJuIwIxICHzi8EBURCAHTdSTlAXp8FOjohXAkOZqBrnpYu65uN10V-6RgUebrWq7N8rnoW3RyEbOi9C9N5LQ4CN7	0:1589870880040372%0d63f7200d63f720	\N	\N	1	2020-05-19 06:48:00	2020-05-19 06:48:00	1
1158	178	254	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589870880058460%fc0c01eafc0c01ea	\N	\N	1	2020-05-19 06:48:00	2020-05-19 06:48:00	1
1159	196	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589878904131974%fc0c01eafc0c01ea	\N	\N	1	2020-05-19 09:01:44	2020-05-19 09:01:44	1
1160	196	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589878904131440%fc0c01eafc0c01ea	\N	\N	1	2020-05-19 09:01:44	2020-05-19 09:01:44	1
1161	196	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589878905094348%fc0c01eafc0c01ea	\N	\N	1	2020-05-19 09:01:45	2020-05-19 09:01:45	1
1162	196	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589878905102971%fc0c01eafc0c01ea	\N	\N	1	2020-05-19 09:01:45	2020-05-19 09:01:45	1
1163	196	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589878906091428%fc0c01eafc0c01ea	\N	\N	1	2020-05-19 09:01:46	2020-05-19 09:01:46	1
1169	196	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589878909089480%fc0c01eafc0c01ea	\N	\N	1	2020-05-19 09:01:49	2020-05-19 09:01:49	1
1164	196	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589878906090279%fc0c01eafc0c01ea	\N	\N	1	2020-05-19 09:01:46	2020-05-19 09:01:46	1
1165	196	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589878907090381%fc0c01eafc0c01ea	\N	\N	1	2020-05-19 09:01:47	2020-05-19 09:01:47	1
1166	196	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589878907097770%fc0c01eafc0c01ea	\N	\N	1	2020-05-19 09:01:47	2020-05-19 09:01:47	1
1167	196	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589878908080406%fc0c01eafc0c01ea	\N	\N	1	2020-05-19 09:01:48	2020-05-19 09:01:48	1
1168	196	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589878908090906%fc0c01eafc0c01ea	\N	\N	1	2020-05-19 09:01:48	2020-05-19 09:01:48	1
1170	196	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589878909092743%fc0c01eafc0c01ea	\N	\N	1	2020-05-19 09:01:49	2020-05-19 09:01:49	1
1173	217	264	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589895000070957%fc0c01eafc0c01ea	\N	\N	1	2020-05-19 01:30:00	2020-05-19 01:30:00	1
1174	217	261	dD4NeqvoQEOiuge1wkTj5v:APA91bFEGUhEoWidTlD4Zo2aQPbQtAL-gpJP_beak4jOxNPX153941SUAlTEXgS7q6H8rdv_AmGf-Zx7sfEb1XFzHyEl9kMWenXyE7DkCQUYlfK9aECZLt-LxiMSptnoCc05MZlMRYE7	0:1589895000068380%0d63f7200d63f720	\N	\N	1	2020-05-19 01:30:00	2020-05-19 01:30:00	1
1175	218	264	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589895300026803%fc0c01eafc0c01ea	\N	\N	1	2020-05-19 01:35:00	2020-05-19 01:35:00	1
1176	218	261	cvTEtFXUTZek_GYwOnxHLt:APA91bE1aIwv-WJUyzAb9LIOdkpEQZkFZ_CxYbIs9g_RzSt2klkOhXS6Tmd2rbTmRfOOXtM8Sia1O0zmC91DxntA7Si1Tn1a9MUsIXsGx8GbBTfRG5aY9OuhCBbs1YEAByjZ_ZMpOFq-	0:1589895300031639%0d63f7200d63f720	\N	\N	1	2020-05-19 01:35:00	2020-05-19 01:35:00	1
1177	219	264	dD4NeqvoQEOiuge1wkTj5v:APA91bFEGUhEoWidTlD4Zo2aQPbQtAL-gpJP_beak4jOxNPX153941SUAlTEXgS7q6H8rdv_AmGf-Zx7sfEb1XFzHyEl9kMWenXyE7DkCQUYlfK9aECZLt-LxiMSptnoCc05MZlMRYE7	0:1589895600062101%0d63f7200d63f720	\N	\N	1	2020-05-19 01:40:00	2020-05-19 01:40:00	1
1178	219	261	cvTEtFXUTZek_GYwOnxHLt:APA91bE1aIwv-WJUyzAb9LIOdkpEQZkFZ_CxYbIs9g_RzSt2klkOhXS6Tmd2rbTmRfOOXtM8Sia1O0zmC91DxntA7Si1Tn1a9MUsIXsGx8GbBTfRG5aY9OuhCBbs1YEAByjZ_ZMpOFq-	0:1589895600069958%0d63f7200d63f720	\N	\N	1	2020-05-19 01:40:00	2020-05-19 01:40:00	1
1186	221	267	cvTEtFXUTZek_GYwOnxHLt:APA91bE1aIwv-WJUyzAb9LIOdkpEQZkFZ_CxYbIs9g_RzSt2klkOhXS6Tmd2rbTmRfOOXtM8Sia1O0zmC91DxntA7Si1Tn1a9MUsIXsGx8GbBTfRG5aY9OuhCBbs1YEAByjZ_ZMpOFq-	0:1589962200118856%0d63f7200d63f720	\N	\N	1	2020-05-20 08:10:00	2020-05-20 08:10:00	1
1180	220	264	dD4NeqvoQEOiuge1wkTj5v:APA91bFEGUhEoWidTlD4Zo2aQPbQtAL-gpJP_beak4jOxNPX153941SUAlTEXgS7q6H8rdv_AmGf-Zx7sfEb1XFzHyEl9kMWenXyE7DkCQUYlfK9aECZLt-LxiMSptnoCc05MZlMRYE7	0:1589895900027655%0d63f7200d63f720	\N	\N	1	2020-05-19 01:45:00	2020-05-22 05:50:25	3
1185	221	268	fcvNsIWoTbWpeCBkGc5DAr:APA91bGsNmsVTOP4gbx4JEZXgAhbI4A0DighXLkBGiHJK0D4pNTVCJuIwIxICHzi8EBURCAHTdSTlAXp8FOjohXAkOZqBrnpYu65uN10V-6RgUebrWq7N8rnoW3RyEbOi9C9N5LQ4CN7	0:1589962200040010%0d63f7200d63f720	\N	\N	1	2020-05-20 08:10:00	2020-05-20 08:10:05	2
1181	221	268	fcvNsIWoTbWpeCBkGc5DAr:APA91bGsNmsVTOP4gbx4JEZXgAhbI4A0DighXLkBGiHJK0D4pNTVCJuIwIxICHzi8EBURCAHTdSTlAXp8FOjohXAkOZqBrnpYu65uN10V-6RgUebrWq7N8rnoW3RyEbOi9C9N5LQ4CN7	0:1589957100044384%0d63f7200d63f720	\N	\N	1	2020-05-20 06:45:00	2020-05-20 06:45:00	1
1188	221	267	fcvNsIWoTbWpeCBkGc5DAr:APA91bGsNmsVTOP4gbx4JEZXgAhbI4A0DighXLkBGiHJK0D4pNTVCJuIwIxICHzi8EBURCAHTdSTlAXp8FOjohXAkOZqBrnpYu65uN10V-6RgUebrWq7N8rnoW3RyEbOi9C9N5LQ4CN7	0:1589962500031894%0d63f7200d63f720	\N	\N	1	2020-05-20 08:15:00	2020-05-20 08:15:00	1
1182	221	267	cvTEtFXUTZek_GYwOnxHLt:APA91bE1aIwv-WJUyzAb9LIOdkpEQZkFZ_CxYbIs9g_RzSt2klkOhXS6Tmd2rbTmRfOOXtM8Sia1O0zmC91DxntA7Si1Tn1a9MUsIXsGx8GbBTfRG5aY9OuhCBbs1YEAByjZ_ZMpOFq-	0:1589957100039476%0d63f7200d63f720	\N	\N	1	2020-05-20 06:45:00	2020-05-20 06:50:50	2
1187	221	268	cvTEtFXUTZek_GYwOnxHLt:APA91bE1aIwv-WJUyzAb9LIOdkpEQZkFZ_CxYbIs9g_RzSt2klkOhXS6Tmd2rbTmRfOOXtM8Sia1O0zmC91DxntA7Si1Tn1a9MUsIXsGx8GbBTfRG5aY9OuhCBbs1YEAByjZ_ZMpOFq-	0:1589962500024433%0d63f7200d63f720	\N	\N	1	2020-05-20 08:15:00	2020-05-20 08:15:08	2
1171	202	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589883780279389%fc0c01eafc0c01ea	\N	\N	1	2020-05-19 10:23:00	2020-05-20 06:56:04	3
1172	202	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589883780325756%fc0c01eafc0c01ea	\N	\N	1	2020-05-19 10:23:00	2020-05-20 06:56:04	3
1184	208	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589960100082607%fc0c01eafc0c01ea	\N	\N	1	2020-05-20 07:35:00	2020-05-20 07:35:00	1
1190	221	268	cvTEtFXUTZek_GYwOnxHLt:APA91bE1aIwv-WJUyzAb9LIOdkpEQZkFZ_CxYbIs9g_RzSt2klkOhXS6Tmd2rbTmRfOOXtM8Sia1O0zmC91DxntA7Si1Tn1a9MUsIXsGx8GbBTfRG5aY9OuhCBbs1YEAByjZ_ZMpOFq-	0:1589962800026783%0d63f7200d63f720	\N	\N	1	2020-05-20 08:20:00	2020-05-20 09:53:40	3
1189	221	267	fcvNsIWoTbWpeCBkGc5DAr:APA91bGsNmsVTOP4gbx4JEZXgAhbI4A0DighXLkBGiHJK0D4pNTVCJuIwIxICHzi8EBURCAHTdSTlAXp8FOjohXAkOZqBrnpYu65uN10V-6RgUebrWq7N8rnoW3RyEbOi9C9N5LQ4CN7	0:1589962800023928%0d63f7200d63f720	\N	\N	1	2020-05-20 08:20:00	2020-05-20 09:53:40	3
1179	220	261	cvTEtFXUTZek_GYwOnxHLt:APA91bE1aIwv-WJUyzAb9LIOdkpEQZkFZ_CxYbIs9g_RzSt2klkOhXS6Tmd2rbTmRfOOXtM8Sia1O0zmC91DxntA7Si1Tn1a9MUsIXsGx8GbBTfRG5aY9OuhCBbs1YEAByjZ_ZMpOFq-	0:1589895900035666%0d63f7200d63f720	\N	\N	1	2020-05-19 01:45:00	2020-05-22 05:50:25	3
1201	220	261	cdniu6qW_U4ZgZVcdnnrwj:APA91bG1RM0W0sV9904coiivZXc3hUjndH-uKQ6rXIuvcubu2oS779T_j-NRSdcTdZ7yR7fDW0ACkqzJBicex2lEI7Ma0HwiIRzwT3-FxACGk3VFOUCYDuUWpMZ43VbNonedR7re8Meo	0:1590129600073450%0d63f7200d63f720	\N	\N	1	2020-05-22 06:40:00	2020-05-22 07:02:05	3
1196	222	257	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1590103800083220	\N	\N	1	2020-05-21 11:30:00	2020-05-22 03:17:50	3
1195	222	266	dArFeGuzw0OKqERpGgwJ8i:APA91bEe0KbgzFSBSyZ3JyGIZeUBG0w2sJeeydChA-4d0cCxL-IXucEocZVcgGfUK7_u3EulXFivEuuC3I0oJKBTQvuxFGU-z5b2Wm_WmSrFvKn83xGrBd9AiFQSZyFf4OHLAeBMK1CM	1590103800089043	\N	\N	1	2020-05-21 11:30:00	2020-05-22 03:17:50	3
1198	222	266	dArFeGuzw0OKqERpGgwJ8i:APA91bEe0KbgzFSBSyZ3JyGIZeUBG0w2sJeeydChA-4d0cCxL-IXucEocZVcgGfUK7_u3EulXFivEuuC3I0oJKBTQvuxFGU-z5b2Wm_WmSrFvKn83xGrBd9AiFQSZyFf4OHLAeBMK1CM	1590103800088841	\N	\N	1	2020-05-21 11:30:00	2020-05-22 03:22:07	3
1197	222	257	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1590103800083736	\N	\N	1	2020-05-21 11:30:00	2020-05-22 03:22:07	3
1200	222	257	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1590103800083489	\N	\N	1	2020-05-21 11:30:00	2020-05-22 03:27:23	3
1199	222	266	dArFeGuzw0OKqERpGgwJ8i:APA91bEe0KbgzFSBSyZ3JyGIZeUBG0w2sJeeydChA-4d0cCxL-IXucEocZVcgGfUK7_u3EulXFivEuuC3I0oJKBTQvuxFGU-z5b2Wm_WmSrFvKn83xGrBd9AiFQSZyFf4OHLAeBMK1CM	1590103800089998	\N	\N	1	2020-05-21 11:30:00	2020-05-22 03:27:23	3
1202	220	261	cdniu6qW_U4ZgZVcdnnrwj:APA91bG1RM0W0sV9904coiivZXc3hUjndH-uKQ6rXIuvcubu2oS779T_j-NRSdcTdZ7yR7fDW0ACkqzJBicex2lEI7Ma0HwiIRzwT3-FxACGk3VFOUCYDuUWpMZ43VbNonedR7re8Meo	0:1590129600073355%0d63f7200d63f720	\N	\N	1	2020-05-22 06:40:00	2020-05-22 06:40:00	1
1192	221	267	fcvNsIWoTbWpeCBkGc5DAr:APA91bGsNmsVTOP4gbx4JEZXgAhbI4A0DighXLkBGiHJK0D4pNTVCJuIwIxICHzi8EBURCAHTdSTlAXp8FOjohXAkOZqBrnpYu65uN10V-6RgUebrWq7N8rnoW3RyEbOi9C9N5LQ4CN7	0:1589968800040972%0d63f7200d63f720	\N	\N	1	2020-05-20 10:00:00	2020-05-20 11:19:18	3
1191	221	268	cvTEtFXUTZek_GYwOnxHLt:APA91bE1aIwv-WJUyzAb9LIOdkpEQZkFZ_CxYbIs9g_RzSt2klkOhXS6Tmd2rbTmRfOOXtM8Sia1O0zmC91DxntA7Si1Tn1a9MUsIXsGx8GbBTfRG5aY9OuhCBbs1YEAByjZ_ZMpOFq-	0:1589968800039326%0d63f7200d63f720	\N	\N	1	2020-05-20 10:00:00	2020-05-20 11:19:18	3
1193	234	126	cjbUl3ws50qivDvjEBc6Jf:APA91bHmC30c-TV7QVTEPpkqLfYr-SgeEyLPxCC2tNT4HVz_UQ5_RIFfQfyKIgjL60aThvMMIqJtgqVL685mDOGBHJS1KTW56K4wFclr46NW7JMjz6Kn-7KVhVwzwUK9Mub1Uu_MNq7N	1590087600109676	\N	\N	1	2020-05-21 07:00:00	2020-05-21 07:00:00	1
1194	234	275	cEt9nI1WukDIpzxV0HGzgT:APA91bE1Kp6wZKSwXqBJ58uc0bTzZmBbQ0CoUnsSM6t42kk1RhTgsY089e45HP-xAKxOGLp93SrxUxgzmyhy73aqQ69LI4hfPvsVqGSMHj-tXcJJ0UhPPreS0EzMutQbXRjrnUhlRYLc	1590087600111055	\N	\N	1	2020-05-21 07:00:00	2020-05-21 07:00:00	1
1203	220	261	cdniu6qW_U4ZgZVcdnnrwj:APA91bG1RM0W0sV9904coiivZXc3hUjndH-uKQ6rXIuvcubu2oS779T_j-NRSdcTdZ7yR7fDW0ACkqzJBicex2lEI7Ma0HwiIRzwT3-FxACGk3VFOUCYDuUWpMZ43VbNonedR7re8Meo	0:1590129600073150%0d63f7200d63f720	\N	\N	1	2020-05-22 06:40:00	2020-05-22 06:40:00	1
1204	220	261	cdniu6qW_U4ZgZVcdnnrwj:APA91bG1RM0W0sV9904coiivZXc3hUjndH-uKQ6rXIuvcubu2oS779T_j-NRSdcTdZ7yR7fDW0ACkqzJBicex2lEI7Ma0HwiIRzwT3-FxACGk3VFOUCYDuUWpMZ43VbNonedR7re8Meo	0:1590129600073446%0d63f7200d63f720	\N	\N	1	2020-05-22 06:40:00	2020-05-22 06:40:00	1
1205	220	261	cdniu6qW_U4ZgZVcdnnrwj:APA91bG1RM0W0sV9904coiivZXc3hUjndH-uKQ6rXIuvcubu2oS779T_j-NRSdcTdZ7yR7fDW0ACkqzJBicex2lEI7Ma0HwiIRzwT3-FxACGk3VFOUCYDuUWpMZ43VbNonedR7re8Meo	0:1590129600073642%0d63f7200d63f720	\N	\N	1	2020-05-22 06:40:00	2020-05-22 06:40:00	1
1206	220	261	cdniu6qW_U4ZgZVcdnnrwj:APA91bG1RM0W0sV9904coiivZXc3hUjndH-uKQ6rXIuvcubu2oS779T_j-NRSdcTdZ7yR7fDW0ACkqzJBicex2lEI7Ma0HwiIRzwT3-FxACGk3VFOUCYDuUWpMZ43VbNonedR7re8Meo	0:1590129600074461%0d63f7200d63f720	\N	\N	1	2020-05-22 06:40:00	2020-05-22 06:40:00	1
1207	220	261	cdniu6qW_U4ZgZVcdnnrwj:APA91bG1RM0W0sV9904coiivZXc3hUjndH-uKQ6rXIuvcubu2oS779T_j-NRSdcTdZ7yR7fDW0ACkqzJBicex2lEI7Ma0HwiIRzwT3-FxACGk3VFOUCYDuUWpMZ43VbNonedR7re8Meo	0:1590129600073855%0d63f7200d63f720	\N	\N	1	2020-05-22 06:40:00	2020-05-22 06:40:00	1
1208	220	261	cdniu6qW_U4ZgZVcdnnrwj:APA91bG1RM0W0sV9904coiivZXc3hUjndH-uKQ6rXIuvcubu2oS779T_j-NRSdcTdZ7yR7fDW0ACkqzJBicex2lEI7Ma0HwiIRzwT3-FxACGk3VFOUCYDuUWpMZ43VbNonedR7re8Meo	0:1590129600074173%0d63f7200d63f720	\N	\N	1	2020-05-22 06:40:00	2020-05-22 06:40:00	1
1218	220	264	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1590129600070992%fc0c01eafc0c01ea	\N	\N	1	2020-05-22 06:40:00	2020-05-22 06:40:00	1
1213	220	264	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1590129600068061%fc0c01eafc0c01ea	\N	\N	1	2020-05-22 06:40:00	2020-05-22 07:02:05	3
1209	220	261	cdniu6qW_U4ZgZVcdnnrwj:APA91bG1RM0W0sV9904coiivZXc3hUjndH-uKQ6rXIuvcubu2oS779T_j-NRSdcTdZ7yR7fDW0ACkqzJBicex2lEI7Ma0HwiIRzwT3-FxACGk3VFOUCYDuUWpMZ43VbNonedR7re8Meo	0:1590129600074521%0d63f7200d63f720	\N	\N	1	2020-05-22 06:40:00	2020-05-22 06:40:00	1
1214	220	264	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1590129600067606%fc0c01eafc0c01ea	\N	\N	1	2020-05-22 06:40:00	2020-05-22 06:40:00	1
1219	220	264	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1590129600069775%fc0c01eafc0c01ea	\N	\N	1	2020-05-22 06:40:00	2020-05-22 06:40:00	1
1210	220	261	cdniu6qW_U4ZgZVcdnnrwj:APA91bG1RM0W0sV9904coiivZXc3hUjndH-uKQ6rXIuvcubu2oS779T_j-NRSdcTdZ7yR7fDW0ACkqzJBicex2lEI7Ma0HwiIRzwT3-FxACGk3VFOUCYDuUWpMZ43VbNonedR7re8Meo	0:1590129600074172%0d63f7200d63f720	\N	\N	1	2020-05-22 06:40:00	2020-05-22 06:40:00	1
1215	220	264	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1590129600067620%fc0c01eafc0c01ea	\N	\N	1	2020-05-22 06:40:00	2020-05-22 06:40:00	1
1220	220	264	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1590129600071779%fc0c01eafc0c01ea	\N	\N	1	2020-05-22 06:40:00	2020-05-22 06:40:00	1
1211	220	264	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1590129600069290%fc0c01eafc0c01ea	\N	\N	1	2020-05-22 06:40:00	2020-05-22 06:40:00	1
1216	220	264	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1590129600069960%fc0c01eafc0c01ea	\N	\N	1	2020-05-22 06:40:00	2020-05-22 06:40:00	1
1212	220	264	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1590129600067721%fc0c01eafc0c01ea	\N	\N	1	2020-05-22 06:40:00	2020-05-22 06:40:00	1
1217	220	264	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1590129600069979%fc0c01eafc0c01ea	\N	\N	1	2020-05-22 06:40:00	2020-05-22 06:40:00	1
1221	273	311	cdniu6qW_U4ZgZVcdnnrwj:APA91bG1RM0W0sV9904coiivZXc3hUjndH-uKQ6rXIuvcubu2oS779T_j-NRSdcTdZ7yR7fDW0ACkqzJBicex2lEI7Ma0HwiIRzwT3-FxACGk3VFOUCYDuUWpMZ43VbNonedR7re8Meo	0:1590426000094582%0d63f7200d63f720	\N	\N	1	2020-05-25 05:00:00	2020-05-25 05:00:00	1
1240	342	311	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1591005300067589%0d63f7200d63f720	\N	\N	1	2020-06-01 09:55:00	2020-06-01 09:55:00	1
1241	341	311	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1591005300067673%0d63f7200d63f720	\N	\N	1	2020-06-01 09:55:00	2020-06-01 09:55:00	1
1242	341	312	f8XPbzFsRtCdU5qOmfxm5T:APA91bHWWCXx5CUsvvPRTtSL3kOXtxSwKTwo_Wi_9XcCYpiB1sfN9cJ1GN9ZDSyDXGZV2nmQbAYzDmkZutHF6da29_jGX8KvE_LOAtsvliOAQOsNcNbFqvOtY7kGnZh3sOxv0-n7nBQ4	0:1591005300060571%0d63f7200d63f720	\N	\N	1	2020-06-01 09:55:00	2020-06-01 09:55:31	2
1183	208	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589960100081953%fc0c01eafc0c01ea	\N	\N	1	2020-05-20 07:35:00	2020-05-26 03:52:01	2
1222	303	312	ck7vgGLF7UOajo7SDoRsqa:APA91bHskk_kh2C1YyjgQhdUDDZLB4ECA4lGPhyahoM5ZAEO4GnfjRmCczNiQmkDAB4ZSia8cQqtMj92wgcd1_FDzNEgN6tCk7MdzaW-DO9JGmHrdKBglHOWNiCrCsrenzTa2XDos3GG	0:1590598800098199%0d63f7200d63f720	\N	\N	1	2020-05-27 05:00:00	2020-05-27 05:00:00	1
1223	303	311	ck7vgGLF7UOajo7SDoRsqa:APA91bHskk_kh2C1YyjgQhdUDDZLB4ECA4lGPhyahoM5ZAEO4GnfjRmCczNiQmkDAB4ZSia8cQqtMj92wgcd1_FDzNEgN6tCk7MdzaW-DO9JGmHrdKBglHOWNiCrCsrenzTa2XDos3GG	0:1590598800098503%0d63f7200d63f720	\N	\N	1	2020-05-27 05:00:00	2020-05-27 05:00:00	1
1224	306	312	e07TyMeXT_GqMwE8tuFECo:APA91bEzzTUyRRFG5mPA99fcZ6M30vr2GVmf3mUbvPRIkkE6-B2sfbn9GQG44rPcj4ZpRQ85GJArFMrOoGFYi98njPtjICtisBgf43tymMYR3PtPFvUmKp66k6JKx-FnU61P8DnTl5AJ	0:1590598800110463%0d63f7200d63f720	\N	\N	1	2020-05-27 05:00:00	2020-05-27 05:00:00	1
1225	304	312	e07TyMeXT_GqMwE8tuFECo:APA91bEzzTUyRRFG5mPA99fcZ6M30vr2GVmf3mUbvPRIkkE6-B2sfbn9GQG44rPcj4ZpRQ85GJArFMrOoGFYi98njPtjICtisBgf43tymMYR3PtPFvUmKp66k6JKx-FnU61P8DnTl5AJ	0:1590598800110975%0d63f7200d63f720	\N	\N	1	2020-05-27 05:00:00	2020-05-27 05:00:00	1
1226	323	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1590742860114009%fc0c01eafc0c01ea	\N	\N	1	2020-05-29 09:01:00	2020-05-29 09:01:00	1
1227	323	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1590742860114961%fc0c01eafc0c01ea	\N	\N	1	2020-05-29 09:01:00	2020-05-29 09:01:00	1
1228	324	311	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1590745500155851%0d63f7200d63f720	\N	\N	1	2020-05-29 09:45:00	2020-05-29 09:45:00	1
1229	324	312	f-EApn08SQO7VRip3xt0-H:APA91bEknfIfd1EQtzNAGm8nAEkuVVtlaBrQdTyj3rXKf-n_L4f3iQbkUHEBGOXECny0jLMftDajySlnBSjS65U7xec3KhOwyfnbvIaZcX8Y05RWBV6SnKxxBLjrFM6E-2-myRQrc7ab	0:1590745500152616%0d63f7200d63f720	\N	\N	1	2020-05-29 09:45:00	2020-05-29 09:45:00	1
1230	325	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1590746940057355%fc0c01eafc0c01ea	\N	\N	1	2020-05-29 10:09:00	2020-05-29 10:09:00	1
1231	325	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1590746940053442%fc0c01eafc0c01ea	\N	\N	1	2020-05-29 10:09:00	2020-05-29 10:09:00	1
1232	326	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1590747060043908%fc0c01eafc0c01ea	\N	\N	1	2020-05-29 10:11:00	2020-05-29 10:11:00	1
1233	326	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1590747060043716%fc0c01eafc0c01ea	\N	\N	1	2020-05-29 10:11:00	2020-05-29 10:11:00	1
1235	328	327	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1590747600128689%0d63f7200d63f720	\N	\N	1	2020-05-29 10:20:00	2020-05-29 10:20:00	1
1234	328	328	f-EApn08SQO7VRip3xt0-H:APA91bEknfIfd1EQtzNAGm8nAEkuVVtlaBrQdTyj3rXKf-n_L4f3iQbkUHEBGOXECny0jLMftDajySlnBSjS65U7xec3KhOwyfnbvIaZcX8Y05RWBV6SnKxxBLjrFM6E-2-myRQrc7ab	0:1590747600117917%0d63f7200d63f720	\N	\N	1	2020-05-29 10:20:00	2020-05-29 10:20:06	2
1236	336	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1590994500057980%fc0c01eafc0c01ea	\N	\N	1	2020-06-01 06:55:00	2020-06-01 06:55:00	1
1237	336	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1590994500058262%fc0c01eafc0c01ea	\N	\N	1	2020-06-01 06:55:00	2020-06-01 06:55:00	1
1239	337	311	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1591001700072522%0d63f7200d63f720	\N	\N	1	2020-06-01 08:55:00	2020-06-01 08:55:00	1
1238	337	312	f8XPbzFsRtCdU5qOmfxm5T:APA91bHWWCXx5CUsvvPRTtSL3kOXtxSwKTwo_Wi_9XcCYpiB1sfN9cJ1GN9ZDSyDXGZV2nmQbAYzDmkZutHF6da29_jGX8KvE_LOAtsvliOAQOsNcNbFqvOtY7kGnZh3sOxv0-n7nBQ4	0:1591001700039204%0d63f7200d63f720	\N	\N	1	2020-06-01 08:55:00	2020-06-01 08:55:24	2
1243	342	312	f8XPbzFsRtCdU5qOmfxm5T:APA91bHWWCXx5CUsvvPRTtSL3kOXtxSwKTwo_Wi_9XcCYpiB1sfN9cJ1GN9ZDSyDXGZV2nmQbAYzDmkZutHF6da29_jGX8KvE_LOAtsvliOAQOsNcNbFqvOtY7kGnZh3sOxv0-n7nBQ4	0:1591005300060987%0d63f7200d63f720	\N	\N	1	2020-06-01 09:55:00	2020-06-01 09:55:00	1
1244	343	311	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1591005900042363%0d63f7200d63f720	\N	\N	1	2020-06-01 10:05:00	2020-06-01 10:05:00	1
1245	343	312	f8XPbzFsRtCdU5qOmfxm5T:APA91bHWWCXx5CUsvvPRTtSL3kOXtxSwKTwo_Wi_9XcCYpiB1sfN9cJ1GN9ZDSyDXGZV2nmQbAYzDmkZutHF6da29_jGX8KvE_LOAtsvliOAQOsNcNbFqvOtY7kGnZh3sOxv0-n7nBQ4	0:1591005900035432%0d63f7200d63f720	\N	\N	1	2020-06-01 10:05:00	2020-06-01 10:05:03	2
1246	328	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1591008840078522%fc0c01eafc0c01ea	\N	\N	1	2020-06-01 10:54:00	2020-06-01 10:54:00	1
1247	328	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1591008840254843%fc0c01eafc0c01ea	\N	\N	1	2020-06-01 10:54:00	2020-06-01 10:54:00	1
1248	328	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1591009500139685%fc0c01eafc0c01ea	\N	\N	1	2020-06-01 11:05:00	2020-06-01 11:05:00	1
1249	328	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1591009500139189%fc0c01eafc0c01ea	\N	\N	1	2020-06-01 11:05:00	2020-06-01 11:05:00	1
1251	343	311	ezkb5h6RR_a55bzGCDltVE:APA91bHE9VaDOMfachqpPiUDsIgbEtBX1dLsCk4lYowwmclahenYEWyQX-qq-OkNhEN9Nzqbrj4MTwPGfWSPr162a0DRG8WldBQKQ7taBGiHt66abqE9leEE6PexLvDvSkObIsTOuatM	0:1591010700114227%0d63f7200d63f720	\N	\N	1	2020-06-01 11:25:00	2020-06-01 11:25:00	1
1262	346	311	f8XPbzFsRtCdU5qOmfxm5T:APA91bHWWCXx5CUsvvPRTtSL3kOXtxSwKTwo_Wi_9XcCYpiB1sfN9cJ1GN9ZDSyDXGZV2nmQbAYzDmkZutHF6da29_jGX8KvE_LOAtsvliOAQOsNcNbFqvOtY7kGnZh3sOxv0-n7nBQ4	0:1591014000099499%0d63f7200d63f720	\N	\N	1	2020-06-01 12:20:00	2020-06-01 12:20:09	2
1250	343	311	ezkb5h6RR_a55bzGCDltVE:APA91bHE9VaDOMfachqpPiUDsIgbEtBX1dLsCk4lYowwmclahenYEWyQX-qq-OkNhEN9Nzqbrj4MTwPGfWSPr162a0DRG8WldBQKQ7taBGiHt66abqE9leEE6PexLvDvSkObIsTOuatM	0:1591010700103028%0d63f7200d63f720	\N	\N	1	2020-06-01 11:25:00	2020-06-01 11:25:00	2
1252	343	312	f8XPbzFsRtCdU5qOmfxm5T:APA91bHWWCXx5CUsvvPRTtSL3kOXtxSwKTwo_Wi_9XcCYpiB1sfN9cJ1GN9ZDSyDXGZV2nmQbAYzDmkZutHF6da29_jGX8KvE_LOAtsvliOAQOsNcNbFqvOtY7kGnZh3sOxv0-n7nBQ4	0:1591010700113889%0d63f7200d63f720	\N	\N	1	2020-06-01 11:25:00	2020-06-01 11:25:01	2
1253	343	312	f8XPbzFsRtCdU5qOmfxm5T:APA91bHWWCXx5CUsvvPRTtSL3kOXtxSwKTwo_Wi_9XcCYpiB1sfN9cJ1GN9ZDSyDXGZV2nmQbAYzDmkZutHF6da29_jGX8KvE_LOAtsvliOAQOsNcNbFqvOtY7kGnZh3sOxv0-n7nBQ4	0:1591010700113051%0d63f7200d63f720	\N	\N	1	2020-06-01 11:25:00	2020-06-01 11:25:01	2
1254	346	312	ezkb5h6RR_a55bzGCDltVE:APA91bHE9VaDOMfachqpPiUDsIgbEtBX1dLsCk4lYowwmclahenYEWyQX-qq-OkNhEN9Nzqbrj4MTwPGfWSPr162a0DRG8WldBQKQ7taBGiHt66abqE9leEE6PexLvDvSkObIsTOuatM	0:1591012800050949%0d63f7200d63f720	\N	\N	1	2020-06-01 12:00:00	2020-06-01 12:00:00	1
1255	346	311	f8XPbzFsRtCdU5qOmfxm5T:APA91bHWWCXx5CUsvvPRTtSL3kOXtxSwKTwo_Wi_9XcCYpiB1sfN9cJ1GN9ZDSyDXGZV2nmQbAYzDmkZutHF6da29_jGX8KvE_LOAtsvliOAQOsNcNbFqvOtY7kGnZh3sOxv0-n7nBQ4	0:1591012800050938%0d63f7200d63f720	\N	\N	1	2020-06-01 12:00:00	2020-06-01 12:00:00	1
1256	343	311	f8XPbzFsRtCdU5qOmfxm5T:APA91bHWWCXx5CUsvvPRTtSL3kOXtxSwKTwo_Wi_9XcCYpiB1sfN9cJ1GN9ZDSyDXGZV2nmQbAYzDmkZutHF6da29_jGX8KvE_LOAtsvliOAQOsNcNbFqvOtY7kGnZh3sOxv0-n7nBQ4	0:1591013100044207%0d63f7200d63f720	\N	\N	1	2020-06-01 12:05:00	2020-06-01 12:05:00	1
1257	343	312	ezkb5h6RR_a55bzGCDltVE:APA91bHE9VaDOMfachqpPiUDsIgbEtBX1dLsCk4lYowwmclahenYEWyQX-qq-OkNhEN9Nzqbrj4MTwPGfWSPr162a0DRG8WldBQKQ7taBGiHt66abqE9leEE6PexLvDvSkObIsTOuatM	0:1591013100055971%0d63f7200d63f720	\N	\N	1	2020-06-01 12:05:00	2020-06-01 12:05:00	2
1259	346	311	f8XPbzFsRtCdU5qOmfxm5T:APA91bHWWCXx5CUsvvPRTtSL3kOXtxSwKTwo_Wi_9XcCYpiB1sfN9cJ1GN9ZDSyDXGZV2nmQbAYzDmkZutHF6da29_jGX8KvE_LOAtsvliOAQOsNcNbFqvOtY7kGnZh3sOxv0-n7nBQ4	0:1591013400063327%0d63f7200d63f720	\N	\N	1	2020-06-01 12:10:00	2020-06-01 12:10:00	1
1258	346	312	ezkb5h6RR_a55bzGCDltVE:APA91bHE9VaDOMfachqpPiUDsIgbEtBX1dLsCk4lYowwmclahenYEWyQX-qq-OkNhEN9Nzqbrj4MTwPGfWSPr162a0DRG8WldBQKQ7taBGiHt66abqE9leEE6PexLvDvSkObIsTOuatM	0:1591013400065494%0d63f7200d63f720	\N	\N	1	2020-06-01 12:10:00	2020-06-01 12:10:04	2
1260	346	312	ezkb5h6RR_a55bzGCDltVE:APA91bHE9VaDOMfachqpPiUDsIgbEtBX1dLsCk4lYowwmclahenYEWyQX-qq-OkNhEN9Nzqbrj4MTwPGfWSPr162a0DRG8WldBQKQ7taBGiHt66abqE9leEE6PexLvDvSkObIsTOuatM	0:1591013700040951%0d63f7200d63f720	\N	\N	1	2020-06-01 12:15:00	2020-06-01 12:15:00	1
1261	346	311	f8XPbzFsRtCdU5qOmfxm5T:APA91bHWWCXx5CUsvvPRTtSL3kOXtxSwKTwo_Wi_9XcCYpiB1sfN9cJ1GN9ZDSyDXGZV2nmQbAYzDmkZutHF6da29_jGX8KvE_LOAtsvliOAQOsNcNbFqvOtY7kGnZh3sOxv0-n7nBQ4	0:1591013700043226%0d63f7200d63f720	\N	\N	1	2020-06-01 12:15:00	2020-06-01 12:15:15	2
1263	346	312	ezkb5h6RR_a55bzGCDltVE:APA91bHE9VaDOMfachqpPiUDsIgbEtBX1dLsCk4lYowwmclahenYEWyQX-qq-OkNhEN9Nzqbrj4MTwPGfWSPr162a0DRG8WldBQKQ7taBGiHt66abqE9leEE6PexLvDvSkObIsTOuatM	0:1591014000093596%0d63f7200d63f720	\N	\N	1	2020-06-01 12:20:00	2020-06-01 12:20:00	1
1265	346	312	ezkb5h6RR_a55bzGCDltVE:APA91bHE9VaDOMfachqpPiUDsIgbEtBX1dLsCk4lYowwmclahenYEWyQX-qq-OkNhEN9Nzqbrj4MTwPGfWSPr162a0DRG8WldBQKQ7taBGiHt66abqE9leEE6PexLvDvSkObIsTOuatM	0:1591014300063617%0d63f7200d63f720	\N	\N	1	2020-06-01 12:25:00	2020-06-01 12:25:00	1
1264	346	311	f8XPbzFsRtCdU5qOmfxm5T:APA91bHWWCXx5CUsvvPRTtSL3kOXtxSwKTwo_Wi_9XcCYpiB1sfN9cJ1GN9ZDSyDXGZV2nmQbAYzDmkZutHF6da29_jGX8KvE_LOAtsvliOAQOsNcNbFqvOtY7kGnZh3sOxv0-n7nBQ4	0:1591014300062368%0d63f7200d63f720	\N	\N	1	2020-06-01 12:25:00	2020-06-01 12:25:44	2
1267	346	311	f8XPbzFsRtCdU5qOmfxm5T:APA91bHWWCXx5CUsvvPRTtSL3kOXtxSwKTwo_Wi_9XcCYpiB1sfN9cJ1GN9ZDSyDXGZV2nmQbAYzDmkZutHF6da29_jGX8KvE_LOAtsvliOAQOsNcNbFqvOtY7kGnZh3sOxv0-n7nBQ4	0:1591015200103949%0d63f7200d63f720	\N	\N	1	2020-06-01 12:40:00	2020-06-01 12:40:00	1
1270	347	311	f8XPbzFsRtCdU5qOmfxm5T:APA91bHWWCXx5CUsvvPRTtSL3kOXtxSwKTwo_Wi_9XcCYpiB1sfN9cJ1GN9ZDSyDXGZV2nmQbAYzDmkZutHF6da29_jGX8KvE_LOAtsvliOAQOsNcNbFqvOtY7kGnZh3sOxv0-n7nBQ4	0:1591018500048296%0d63f7200d63f720	\N	\N	1	2020-06-01 01:35:00	2020-06-01 01:35:00	1
1268	347	311	f8XPbzFsRtCdU5qOmfxm5T:APA91bHWWCXx5CUsvvPRTtSL3kOXtxSwKTwo_Wi_9XcCYpiB1sfN9cJ1GN9ZDSyDXGZV2nmQbAYzDmkZutHF6da29_jGX8KvE_LOAtsvliOAQOsNcNbFqvOtY7kGnZh3sOxv0-n7nBQ4	0:1591018200055830%0d63f7200d63f720	\N	\N	1	2020-06-01 01:30:00	2020-06-01 01:30:00	1
1269	347	312	ezkb5h6RR_a55bzGCDltVE:APA91bHE9VaDOMfachqpPiUDsIgbEtBX1dLsCk4lYowwmclahenYEWyQX-qq-OkNhEN9Nzqbrj4MTwPGfWSPr162a0DRG8WldBQKQ7taBGiHt66abqE9leEE6PexLvDvSkObIsTOuatM	0:1591018200047755%0d63f7200d63f720	\N	\N	1	2020-06-01 01:30:00	2020-06-01 01:30:00	1
1271	347	312	ezkb5h6RR_a55bzGCDltVE:APA91bHE9VaDOMfachqpPiUDsIgbEtBX1dLsCk4lYowwmclahenYEWyQX-qq-OkNhEN9Nzqbrj4MTwPGfWSPr162a0DRG8WldBQKQ7taBGiHt66abqE9leEE6PexLvDvSkObIsTOuatM	0:1591018500053553%0d63f7200d63f720	\N	\N	1	2020-06-01 01:35:00	2020-06-01 01:35:00	1
1272	347	311	f8XPbzFsRtCdU5qOmfxm5T:APA91bHWWCXx5CUsvvPRTtSL3kOXtxSwKTwo_Wi_9XcCYpiB1sfN9cJ1GN9ZDSyDXGZV2nmQbAYzDmkZutHF6da29_jGX8KvE_LOAtsvliOAQOsNcNbFqvOtY7kGnZh3sOxv0-n7nBQ4	0:1591018800057057%0d63f7200d63f720	\N	\N	1	2020-06-01 01:40:00	2020-06-01 01:40:00	1
1273	347	312	ezkb5h6RR_a55bzGCDltVE:APA91bHE9VaDOMfachqpPiUDsIgbEtBX1dLsCk4lYowwmclahenYEWyQX-qq-OkNhEN9Nzqbrj4MTwPGfWSPr162a0DRG8WldBQKQ7taBGiHt66abqE9leEE6PexLvDvSkObIsTOuatM	0:1591018800111665%0d63f7200d63f720	\N	\N	1	2020-06-01 01:40:00	2020-06-01 01:40:00	1
1293	353	332	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591089600068568%0d63f7200d63f720	\N	\N	1	2020-06-02 09:20:00	2020-06-02 09:21:14	2
1274	347	311	f8XPbzFsRtCdU5qOmfxm5T:APA91bHWWCXx5CUsvvPRTtSL3kOXtxSwKTwo_Wi_9XcCYpiB1sfN9cJ1GN9ZDSyDXGZV2nmQbAYzDmkZutHF6da29_jGX8KvE_LOAtsvliOAQOsNcNbFqvOtY7kGnZh3sOxv0-n7nBQ4	0:1591019100045980%0d63f7200d63f720	\N	\N	1	2020-06-01 01:45:00	2020-06-01 01:45:00	1
1275	347	312	f8XPbzFsRtCdU5qOmfxm5T:APA91bHWWCXx5CUsvvPRTtSL3kOXtxSwKTwo_Wi_9XcCYpiB1sfN9cJ1GN9ZDSyDXGZV2nmQbAYzDmkZutHF6da29_jGX8KvE_LOAtsvliOAQOsNcNbFqvOtY7kGnZh3sOxv0-n7nBQ4	0:1591019100044706%0d63f7200d63f720	\N	\N	1	2020-06-01 01:45:00	2020-06-01 01:45:00	1
1276	347	312	ezkb5h6RR_a55bzGCDltVE:APA91bHE9VaDOMfachqpPiUDsIgbEtBX1dLsCk4lYowwmclahenYEWyQX-qq-OkNhEN9Nzqbrj4MTwPGfWSPr162a0DRG8WldBQKQ7taBGiHt66abqE9leEE6PexLvDvSkObIsTOuatM	0:1591019400055199%0d63f7200d63f720	\N	\N	1	2020-06-01 01:50:00	2020-06-01 01:50:00	1
1277	347	311	f8XPbzFsRtCdU5qOmfxm5T:APA91bHWWCXx5CUsvvPRTtSL3kOXtxSwKTwo_Wi_9XcCYpiB1sfN9cJ1GN9ZDSyDXGZV2nmQbAYzDmkZutHF6da29_jGX8KvE_LOAtsvliOAQOsNcNbFqvOtY7kGnZh3sOxv0-n7nBQ4	0:1591019400056148%0d63f7200d63f720	\N	\N	1	2020-06-01 01:50:00	2020-06-01 01:50:00	1
1266	346	312	ezkb5h6RR_a55bzGCDltVE:APA91bHE9VaDOMfachqpPiUDsIgbEtBX1dLsCk4lYowwmclahenYEWyQX-qq-OkNhEN9Nzqbrj4MTwPGfWSPr162a0DRG8WldBQKQ7taBGiHt66abqE9leEE6PexLvDvSkObIsTOuatM	0:1591015200048126%0d63f7200d63f720	\N	\N	1	2020-06-01 12:40:00	2020-06-01 01:50:08	2
1278	349	332	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591084800058544%0d63f7200d63f720	\N	\N	1	2020-06-02 08:00:00	2020-06-02 08:00:00	1
1279	349	330	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1591084800073403%fc0c01eafc0c01ea	\N	\N	1	2020-06-02 08:00:00	2020-06-02 08:00:00	1
1280	350	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1591085400045984%fc0c01eafc0c01ea	\N	\N	1	2020-06-02 08:10:00	2020-06-02 08:10:00	1
1281	350	51	ccUDYp7RSeqXWLkRfh5q6K:APA91bE5W3_iumjGvPMXYh2W2mYJDGuhLSX_uTtMADVu5xLWsr_RjPgxaNOqTqhMB_SzMGflWRTGH5roNo0wwZf_9rWsOVRDzh1L9jNXVsIHaoycVh7GCdhdn7nBKq2rdLqHMYiXevBE	0:1591085400097798%0d63f7200d63f720	\N	\N	1	2020-06-02 08:10:00	2020-06-02 08:10:00	1
1282	322	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1591086060100860%fc0c01eafc0c01ea	\N	\N	1	2020-06-02 08:21:00	2020-06-02 08:21:00	1
1283	322	51	ccUDYp7RSeqXWLkRfh5q6K:APA91bE5W3_iumjGvPMXYh2W2mYJDGuhLSX_uTtMADVu5xLWsr_RjPgxaNOqTqhMB_SzMGflWRTGH5roNo0wwZf_9rWsOVRDzh1L9jNXVsIHaoycVh7GCdhdn7nBKq2rdLqHMYiXevBE	0:1591086060116805%0d63f7200d63f720	\N	\N	1	2020-06-02 08:21:00	2020-06-02 08:21:00	1
1285	322	326	e0QNplpoSBa5EK0OT6KC1z:APA91bGwvxaCF9PZBPUlyy156CW6m4giu3u1FYn05IgpoNBr6hehqIyjeoxsjZmp8iX0VPd4Nmw9ThtRtGWVmyRrbBeUI24-mMTQv7yw7kyUVavvJB4HtNCU8MjE_hL9kg4rfjP9-Qsz	0:1591086900070390%0d63f7200d63f720	\N	\N	1	2020-06-02 08:35:00	2020-06-02 08:35:00	1
1286	322	325	cpp9j3VaIUIFsCH2gXQmtj:APA91bE60XmothOYDJzjWbf712eWHEm26kc6a-KOqBnrDNuDNat2_vvFSlWSapU4v5WRBwfZJdRGuh3Lvge_wv8aNJtXKtPSyFSypG5Wlv5YtRnJBHH_Z-uzwXOwF-4r6Sb1WE_RIiuH	1591086900060045	\N	\N	1	2020-06-02 08:35:00	2020-06-02 08:35:00	1
1287	322	325	cpp9j3VaIUIFsCH2gXQmtj:APA91bE60XmothOYDJzjWbf712eWHEm26kc6a-KOqBnrDNuDNat2_vvFSlWSapU4v5WRBwfZJdRGuh3Lvge_wv8aNJtXKtPSyFSypG5Wlv5YtRnJBHH_Z-uzwXOwF-4r6Sb1WE_RIiuH	1591086900060868	\N	\N	1	2020-06-02 08:35:00	2020-06-02 08:35:00	1
1284	322	326	e0QNplpoSBa5EK0OT6KC1z:APA91bGwvxaCF9PZBPUlyy156CW6m4giu3u1FYn05IgpoNBr6hehqIyjeoxsjZmp8iX0VPd4Nmw9ThtRtGWVmyRrbBeUI24-mMTQv7yw7kyUVavvJB4HtNCU8MjE_hL9kg4rfjP9-Qsz	0:1591086900071652%0d63f7200d63f720	\N	\N	1	2020-06-02 08:35:00	2020-06-02 08:36:20	2
1288	322	326	e0QNplpoSBa5EK0OT6KC1z:APA91bGwvxaCF9PZBPUlyy156CW6m4giu3u1FYn05IgpoNBr6hehqIyjeoxsjZmp8iX0VPd4Nmw9ThtRtGWVmyRrbBeUI24-mMTQv7yw7kyUVavvJB4HtNCU8MjE_hL9kg4rfjP9-Qsz	0:1591087200041586%0d63f7200d63f720	\N	\N	1	2020-06-02 08:40:00	2020-06-02 08:40:00	1
1289	322	325	cpp9j3VaIUIFsCH2gXQmtj:APA91bE60XmothOYDJzjWbf712eWHEm26kc6a-KOqBnrDNuDNat2_vvFSlWSapU4v5WRBwfZJdRGuh3Lvge_wv8aNJtXKtPSyFSypG5Wlv5YtRnJBHH_Z-uzwXOwF-4r6Sb1WE_RIiuH	1591087200047825	\N	\N	1	2020-06-02 08:40:00	2020-06-02 08:40:00	1
1290	351	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1591087980102539%fc0c01eafc0c01ea	\N	\N	1	2020-06-02 08:53:00	2020-06-02 08:53:00	1
1291	355	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1591089060069754%fc0c01eafc0c01ea	\N	\N	1	2020-06-02 09:11:00	2020-06-02 09:11:00	1
1292	354	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1591089600063176%fc0c01eafc0c01ea	\N	\N	1	2020-06-02 09:20:00	2020-06-02 09:20:00	1
1294	353	330	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591089600077247	\N	\N	1	2020-06-02 09:20:00	2020-06-02 09:20:00	1
1296	353	330	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591153800068092	\N	\N	1	2020-06-03 03:10:00	2020-06-03 03:10:00	1
1295	353	332	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591153800061679%0d63f7200d63f720	\N	\N	1	2020-06-03 03:10:00	2020-06-03 03:10:31	2
1297	353	332	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591156500040871%0d63f7200d63f720	\N	\N	1	2020-06-03 03:55:00	2020-06-03 03:55:00	1
1298	353	330	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591156500039038	\N	\N	1	2020-06-03 03:55:00	2020-06-03 03:55:05	2
1299	356	332	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591158600049893%0d63f7200d63f720	\N	\N	1	2020-06-03 04:30:00	2020-06-03 04:30:00	1
1300	356	330	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591158600050111	\N	\N	1	2020-06-03 04:30:00	2020-06-03 04:30:22	2
1301	357	332	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591162200064836%0d63f7200d63f720	\N	\N	1	2020-06-03 05:30:00	2020-06-03 05:30:00	1
1302	357	330	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591162200065759	\N	\N	1	2020-06-03 05:30:00	2020-06-03 05:30:00	1
1303	360	332	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591164600100903%0d63f7200d63f720	\N	\N	1	2020-06-03 06:10:00	2020-06-03 06:10:00	1
1304	360	330	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591164600099768	\N	\N	1	2020-06-03 06:10:00	2020-06-03 06:12:16	2
1306	361	330	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591167300046561	\N	\N	1	2020-06-03 06:55:00	2020-06-03 06:55:00	1
1305	361	332	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591167300120725%0d63f7200d63f720	\N	\N	1	2020-06-03 06:55:00	2020-06-03 06:55:20	2
1307	362	332	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591168800048114%0d63f7200d63f720	\N	\N	1	2020-06-03 07:20:00	2020-06-03 07:20:00	1
1308	362	330	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591168800051460	\N	\N	1	2020-06-03 07:20:00	2020-06-03 07:20:18	2
1309	347	311	e7Ufb4lLQYWy1MupwYXU3e:APA91bEPkV_yX_82OTYb-D_YTFzJ7cjaUt1-IudepvJXkNbGNkCL-1yUFHywZxNa68_lYuuJiQALw4q5ApyQoKpIo6jj9TrLGPiuRjPniZIYmuwjpMxqF7glv3Wi3E82mcP81q0wSP-9	0:1591169100047655%0d63f7200d63f720	\N	\N	1	2020-06-03 07:25:00	2020-06-03 07:25:00	1
1310	347	312	d2W2FTY4TyOIM2p7u4Gg3N:APA91bHXyFLxWnSqzjxl5e1ecBCCUux_DMs-hUFgLlhB6hrgkERNmM03HVAQKn2c95X1eJM70pFvq__twAKONM4MJcEkUSX24qeV2zK288_y2r0Fdm10nRzOmBSiC8uBla9iiimPSA6o	0:1591169100045810%0d63f7200d63f720	\N	\N	1	2020-06-03 07:25:00	2020-06-03 07:25:04	2
1311	363	332	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591170900043043%0d63f7200d63f720	\N	\N	1	2020-06-03 07:55:00	2020-06-03 07:55:00	1
1312	363	330	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591170900034576	\N	\N	1	2020-06-03 07:55:00	2020-06-03 08:00:25	2
1313	364	332	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591173000081150%0d63f7200d63f720	\N	\N	1	2020-06-03 08:30:00	2020-06-03 08:30:00	1
1314	364	330	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591173000080782	\N	\N	1	2020-06-03 08:30:00	2020-06-03 08:30:06	2
1316	347	311	e7Ufb4lLQYWy1MupwYXU3e:APA91bEPkV_yX_82OTYb-D_YTFzJ7cjaUt1-IudepvJXkNbGNkCL-1yUFHywZxNa68_lYuuJiQALw4q5ApyQoKpIo6jj9TrLGPiuRjPniZIYmuwjpMxqF7glv3Wi3E82mcP81q0wSP-9	0:1591174800054308%0d63f7200d63f720	\N	\N	1	2020-06-03 09:00:00	2020-06-03 09:00:00	1
1317	365	332	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591174800068808%0d63f7200d63f720	\N	\N	1	2020-06-03 09:00:00	2020-06-03 09:00:00	1
1318	365	330	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591174800066267	\N	\N	1	2020-06-03 09:00:00	2020-06-03 09:00:16	2
1315	347	312	d2W2FTY4TyOIM2p7u4Gg3N:APA91bHXyFLxWnSqzjxl5e1ecBCCUux_DMs-hUFgLlhB6hrgkERNmM03HVAQKn2c95X1eJM70pFvq__twAKONM4MJcEkUSX24qeV2zK288_y2r0Fdm10nRzOmBSiC8uBla9iiimPSA6o	0:1591174800062836%0d63f7200d63f720	\N	\N	1	2020-06-03 09:00:00	2020-06-03 09:00:49	2
1319	366	332	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591175400048728%0d63f7200d63f720	\N	\N	1	2020-06-03 09:10:00	2020-06-03 09:10:00	1
1320	366	330	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591175400057991	\N	\N	1	2020-06-03 09:10:00	2020-06-03 09:10:10	2
1321	367	332	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591176900040155%0d63f7200d63f720	\N	\N	1	2020-06-03 09:35:00	2020-06-03 09:35:00	1
1322	367	330	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591176900044896	\N	\N	1	2020-06-03 09:35:00	2020-06-03 09:35:21	2
1323	368	332	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591177800084972%0d63f7200d63f720	\N	\N	1	2020-06-03 09:50:00	2020-06-03 09:50:00	1
1325	385	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1591187220087410%fc0c01eafc0c01ea	\N	\N	1	2020-06-03 12:27:00	2020-06-03 12:27:00	1
1326	385	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1591187220094701%fc0c01eafc0c01ea	\N	\N	1	2020-06-03 12:27:00	2020-06-03 12:27:00	1
1327	418	332	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591196400077997%0d63f7200d63f720	\N	\N	1	2020-06-03 03:00:00	2020-06-03 03:00:00	1
1328	418	330	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591196400075604	\N	\N	1	2020-06-03 03:00:00	2020-06-03 03:00:00	1
1329	418	332	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591197900041961%0d63f7200d63f720	\N	\N	1	2020-06-03 03:25:00	2020-06-03 03:25:00	1
1330	418	330	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591197900047402	\N	\N	1	2020-06-03 03:25:00	2020-06-03 03:25:00	1
1344	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591269000092512	\N	\N	1	2020-06-04 11:10:00	2020-06-04 11:10:06	2
1331	418	332	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591198800039357%0d63f7200d63f720	\N	\N	1	2020-06-03 03:40:00	2020-06-03 03:40:00	1
1332	418	330	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591198800033756	\N	\N	1	2020-06-03 03:40:00	2020-06-03 03:40:00	1
1324	368	330	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591177800074174	\N	\N	1	2020-06-03 09:50:00	2020-06-03 03:40:11	2
1333	418	332	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591245900056669%0d63f7200d63f720	\N	\N	1	2020-06-04 04:45:00	2020-06-04 04:45:00	1
1334	418	330	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591245900171973	\N	\N	1	2020-06-04 04:45:00	2020-06-04 04:45:46	2
1335	418	332	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591259100069962%0d63f7200d63f720	\N	\N	1	2020-06-04 08:25:00	2020-06-04 08:25:00	1
1336	418	330	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591259100077878	\N	\N	1	2020-06-04 08:25:00	2020-06-04 08:25:38	2
1337	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591261200039047%0d63f7200d63f720	\N	\N	1	2020-06-04 09:00:00	2020-06-04 09:00:00	1
1338	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591261200056765	\N	\N	1	2020-06-04 09:00:00	2020-06-04 09:00:33	2
1339	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591262100051628%0d63f7200d63f720	\N	\N	1	2020-06-04 09:15:00	2020-06-04 09:15:00	1
1340	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591262100041960	\N	\N	1	2020-06-04 09:15:00	2020-06-04 09:16:07	2
1341	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591267500090834%0d63f7200d63f720	\N	\N	1	2020-06-04 10:45:00	2020-06-04 10:45:00	1
1342	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591267500107451	\N	\N	1	2020-06-04 10:45:00	2020-06-04 10:45:32	2
1343	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591269000090543%0d63f7200d63f720	\N	\N	1	2020-06-04 11:10:00	2020-06-04 11:10:00	1
1345	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591271700043869%0d63f7200d63f720	\N	\N	1	2020-06-04 11:55:00	2020-06-04 11:55:00	1
1346	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591271700044047	\N	\N	1	2020-06-04 11:55:00	2020-06-04 11:55:15	2
1348	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591330800143096	\N	\N	1	2020-06-05 04:20:00	2020-06-05 04:20:00	1
1347	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591330800110544%0d63f7200d63f720	\N	\N	1	2020-06-05 04:20:00	2020-06-05 04:20:15	2
1350	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591332300041146	\N	\N	1	2020-06-05 04:45:00	2020-06-05 04:45:00	1
1349	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591332300044728%0d63f7200d63f720	\N	\N	1	2020-06-05 04:45:00	2020-06-05 04:45:08	2
1352	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591449300042856	\N	\N	1	2020-06-06 01:15:00	2020-06-06 01:15:00	1
1351	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591449300043157%0d63f7200d63f720	\N	\N	1	2020-06-06 01:15:00	2020-06-06 01:15:09	2
1353	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591449600053766%0d63f7200d63f720	\N	\N	1	2020-06-06 01:20:00	2020-06-06 01:20:00	1
1354	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591449600049114	\N	\N	1	2020-06-06 01:20:00	2020-06-06 01:20:07	2
1355	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591535700085825%0d63f7200d63f720	\N	\N	1	2020-06-07 01:15:00	2020-06-07 01:15:00	1
1356	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591535700079641	\N	\N	1	2020-06-07 01:15:00	2020-06-07 01:15:00	1
1357	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591536000067016%0d63f7200d63f720	\N	\N	1	2020-06-07 01:20:00	2020-06-07 01:20:00	1
1358	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591536000074300	\N	\N	1	2020-06-07 01:20:00	2020-06-07 01:20:00	1
1359	431	340	e0QNplpoSBa5EK0OT6KC1z:APA91bGwvxaCF9PZBPUlyy156CW6m4giu3u1FYn05IgpoNBr6hehqIyjeoxsjZmp8iX0VPd4Nmw9ThtRtGWVmyRrbBeUI24-mMTQv7yw7kyUVavvJB4HtNCU8MjE_hL9kg4rfjP9-Qsz	0:1591600200059674%0d63f7200d63f720	\N	\N	1	2020-06-08 07:10:00	2020-06-08 07:10:00	1
1360	431	339	cBGUBvLg3UkCvIyOVaEWgE:APA91bGd17wyo3qilgVfI6KCFWlCBS8DvqnW8en68TCPtgvAb8nLKVCQobnovbWL2aX76zwFYoCXomycf3b8RwzIASz-UJLRVLY337twfgU-GB6eHXgWwHqQs-z8ogGWnhtznrbpn4tM	1591600200066165	\N	\N	1	2020-06-08 07:10:00	2020-06-08 07:10:33	2
1361	431	340	e0QNplpoSBa5EK0OT6KC1z:APA91bGwvxaCF9PZBPUlyy156CW6m4giu3u1FYn05IgpoNBr6hehqIyjeoxsjZmp8iX0VPd4Nmw9ThtRtGWVmyRrbBeUI24-mMTQv7yw7kyUVavvJB4HtNCU8MjE_hL9kg4rfjP9-Qsz	0:1591617300103068%0d63f7200d63f720	\N	\N	1	2020-06-08 11:55:00	2020-06-08 11:55:00	1
1362	431	339	cBGUBvLg3UkCvIyOVaEWgE:APA91bGd17wyo3qilgVfI6KCFWlCBS8DvqnW8en68TCPtgvAb8nLKVCQobnovbWL2aX76zwFYoCXomycf3b8RwzIASz-UJLRVLY337twfgU-GB6eHXgWwHqQs-z8ogGWnhtznrbpn4tM	1591617300100082	\N	\N	1	2020-06-08 11:55:00	2020-06-08 11:55:21	2
1363	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591675800038528%0d63f7200d63f720	\N	\N	1	2020-06-09 04:10:00	2020-06-09 04:10:00	1
1364	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591675800039320	\N	\N	1	2020-06-09 04:10:00	2020-06-09 04:13:16	2
1366	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591677300043328	\N	\N	1	2020-06-09 04:35:00	2020-06-09 04:35:00	1
1365	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591677300042993%0d63f7200d63f720	\N	\N	1	2020-06-09 04:35:00	2020-06-09 04:35:45	2
1367	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591679100034981%0d63f7200d63f720	\N	\N	1	2020-06-09 05:05:00	2020-06-09 05:05:00	1
1368	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591679100020792	\N	\N	1	2020-06-09 05:05:00	2020-06-09 05:05:10	2
1369	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591679700037339%0d63f7200d63f720	\N	\N	1	2020-06-09 05:15:00	2020-06-09 05:15:00	1
1370	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591679700033974	\N	\N	1	2020-06-09 05:15:00	2020-06-09 05:15:16	2
1372	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591680000034830	\N	\N	1	2020-06-09 05:20:00	2020-06-09 05:20:00	1
1371	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591680000035996%0d63f7200d63f720	\N	\N	1	2020-06-09 05:20:00	2020-06-09 05:20:13	2
1373	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591682100037841%0d63f7200d63f720	\N	\N	1	2020-06-09 05:55:00	2020-06-09 05:55:00	1
1374	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591682100039896	\N	\N	1	2020-06-09 05:55:00	2020-06-09 05:56:02	2
1375	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591685400039056%0d63f7200d63f720	\N	\N	1	2020-06-09 06:50:00	2020-06-09 06:50:00	1
1376	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591685400041772	\N	\N	1	2020-06-09 06:50:00	2020-06-09 06:50:06	2
1377	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591686900078550%0d63f7200d63f720	\N	\N	1	2020-06-09 07:15:00	2020-06-09 07:15:00	1
1378	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591686900076890	\N	\N	1	2020-06-09 07:15:00	2020-06-09 07:15:12	2
1379	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591689000045676%0d63f7200d63f720	\N	\N	1	2020-06-09 07:50:00	2020-06-09 07:50:00	1
1380	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591689000055546	\N	\N	1	2020-06-09 07:50:00	2020-06-09 07:50:04	2
1381	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591691100037935%0d63f7200d63f720	\N	\N	1	2020-06-09 08:25:00	2020-06-09 08:25:00	1
1382	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591691100038785	\N	\N	1	2020-06-09 08:25:00	2020-06-09 08:25:32	2
1383	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591693500099616%0d63f7200d63f720	\N	\N	1	2020-06-09 09:05:00	2020-06-09 09:05:00	1
1384	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591693500089175	\N	\N	1	2020-06-09 09:05:00	2020-06-09 09:07:13	2
1385	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591695000052580%0d63f7200d63f720	\N	\N	1	2020-06-09 09:30:00	2020-06-09 09:30:00	1
1386	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591695000054710	\N	\N	1	2020-06-09 09:30:00	2020-06-09 09:38:28	2
1387	431	340	e0QNplpoSBa5EK0OT6KC1z:APA91bGwvxaCF9PZBPUlyy156CW6m4giu3u1FYn05IgpoNBr6hehqIyjeoxsjZmp8iX0VPd4Nmw9ThtRtGWVmyRrbBeUI24-mMTQv7yw7kyUVavvJB4HtNCU8MjE_hL9kg4rfjP9-Qsz	0:1591695600044875%0d63f7200d63f720	\N	\N	1	2020-06-09 09:40:00	2020-06-09 09:40:00	1
1388	431	339	cBGUBvLg3UkCvIyOVaEWgE:APA91bGd17wyo3qilgVfI6KCFWlCBS8DvqnW8en68TCPtgvAb8nLKVCQobnovbWL2aX76zwFYoCXomycf3b8RwzIASz-UJLRVLY337twfgU-GB6eHXgWwHqQs-z8ogGWnhtznrbpn4tM	1591695600046431	\N	\N	1	2020-06-09 09:40:00	2020-06-09 09:40:27	2
1389	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591695900041095%0d63f7200d63f720	\N	\N	1	2020-06-09 09:45:00	2020-06-09 09:45:00	1
1390	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591695900040563	\N	\N	1	2020-06-09 09:45:00	2020-06-09 09:45:23	2
1391	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591700100085486%0d63f7200d63f720	\N	\N	1	2020-06-09 10:55:00	2020-06-09 10:55:00	1
1392	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591700100086612	\N	\N	1	2020-06-09 10:55:00	2020-06-09 10:55:49	2
1393	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591700700032506%0d63f7200d63f720	\N	\N	1	2020-06-09 11:05:00	2020-06-09 11:05:00	1
1394	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591700700039162	\N	\N	1	2020-06-09 11:05:00	2020-06-09 11:05:46	2
1395	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591701900079939%0d63f7200d63f720	\N	\N	1	2020-06-09 11:25:00	2020-06-09 11:25:00	1
1396	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591701900079712	\N	\N	1	2020-06-09 11:25:00	2020-06-09 11:25:15	2
1398	433	343	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1591704300075549%0d63f7200d63f720	\N	\N	1	2020-06-09 12:05:00	2020-06-09 12:05:00	1
1397	433	344	eK_CqKB0RNeS9Toz5d6hE3:APA91bG3UC3oNH4v7BDElUB4sYsY9KnMZH9sc1ARWMNcDKGSP4pOoGRv3Dk3ESZyvlIOFeK0UUi0Ld7XlC_RNEQzxJZbyiQAbWcV52SDPKOiusP4yoEoyqv2XO3cpat-m-oEiVMbTLe3	0:1591704300063927%0d63f7200d63f720	\N	\N	1	2020-06-09 12:05:00	2020-06-09 12:05:04	2
1399	433	344	eK_CqKB0RNeS9Toz5d6hE3:APA91bG3UC3oNH4v7BDElUB4sYsY9KnMZH9sc1ARWMNcDKGSP4pOoGRv3Dk3ESZyvlIOFeK0UUi0Ld7XlC_RNEQzxJZbyiQAbWcV52SDPKOiusP4yoEoyqv2XO3cpat-m-oEiVMbTLe3	0:1591704600043711%0d63f7200d63f720	\N	\N	1	2020-06-09 12:10:00	2020-06-09 12:10:00	1
1400	433	343	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1591704600064556%0d63f7200d63f720	\N	\N	1	2020-06-09 12:10:00	2020-06-09 12:10:00	1
1401	434	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591775100033402%0d63f7200d63f720	\N	\N	1	2020-06-10 07:45:00	2020-06-10 07:45:00	1
1402	434	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591775100167751	\N	\N	1	2020-06-10 07:45:00	2020-06-10 07:45:24	2
1403	435	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1591783800038049%0d63f7200d63f720	\N	\N	1	2020-06-10 10:10:00	2020-06-10 10:10:00	1
1404	435	346	dqit6SbKSv2ydQuZ_HZKTW:APA91bHDcNFhYvuRMvIO3ZyfYCDpBkKZYdVoa3o4xONGHRoyfWbZxrLVF_H2cyXF9R_0ErI7R3G7ajnqWHP4OH17lxluT_BfbHKUdOYSdHbWgHuHPaq1pO3ZHZKoNrjbfIXdkMaGe3Wx	0:1591783800047813%0d63f7200d63f720	\N	\N	1	2020-06-10 10:10:00	2020-06-10 10:10:00	1
1405	437	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591785900071269%0d63f7200d63f720	\N	\N	1	2020-06-10 10:45:00	2020-06-10 10:45:00	1
1406	436	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591785900071733%0d63f7200d63f720	\N	\N	1	2020-06-10 10:45:00	2020-06-10 10:45:00	1
1407	436	347	cRMrnS4URYae4CvKjB9MDG:APA91bGea05G86vu_lYbGvnlgQfxWxdkJT7c7UjCJ-AMMBPiIYDm9WcdqdpqPuqQvx5N4lLnBRec1TZDOlo-YvGVk64zApODbRaHxT9apoURMD1RFELOo35mDkWwPxN6YZakMA4yhflJ	0:1591785900071919%0d63f7200d63f720	\N	\N	1	2020-06-10 10:45:00	2020-06-10 10:45:00	1
1408	437	347	cRMrnS4URYae4CvKjB9MDG:APA91bGea05G86vu_lYbGvnlgQfxWxdkJT7c7UjCJ-AMMBPiIYDm9WcdqdpqPuqQvx5N4lLnBRec1TZDOlo-YvGVk64zApODbRaHxT9apoURMD1RFELOo35mDkWwPxN6YZakMA4yhflJ	0:1591785900070390%0d63f7200d63f720	\N	\N	1	2020-06-10 10:45:00	2020-06-10 10:45:00	1
1409	435	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1591786800042665%0d63f7200d63f720	\N	\N	1	2020-06-10 11:00:00	2020-06-10 11:00:00	1
1410	435	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1591786800048036%0d63f7200d63f720	\N	\N	1	2020-06-10 11:00:00	2020-06-10 11:00:00	1
1411	435	346	dqit6SbKSv2ydQuZ_HZKTW:APA91bHDcNFhYvuRMvIO3ZyfYCDpBkKZYdVoa3o4xONGHRoyfWbZxrLVF_H2cyXF9R_0ErI7R3G7ajnqWHP4OH17lxluT_BfbHKUdOYSdHbWgHuHPaq1pO3ZHZKoNrjbfIXdkMaGe3Wx	0:1591786800042648%0d63f7200d63f720	\N	\N	1	2020-06-10 11:00:00	2020-06-10 11:00:00	1
1412	435	346	dqit6SbKSv2ydQuZ_HZKTW:APA91bHDcNFhYvuRMvIO3ZyfYCDpBkKZYdVoa3o4xONGHRoyfWbZxrLVF_H2cyXF9R_0ErI7R3G7ajnqWHP4OH17lxluT_BfbHKUdOYSdHbWgHuHPaq1pO3ZHZKoNrjbfIXdkMaGe3Wx	0:1591786800051328%0d63f7200d63f720	\N	\N	1	2020-06-10 11:00:00	2020-06-10 11:00:00	1
1413	435	346	dqit6SbKSv2ydQuZ_HZKTW:APA91bHDcNFhYvuRMvIO3ZyfYCDpBkKZYdVoa3o4xONGHRoyfWbZxrLVF_H2cyXF9R_0ErI7R3G7ajnqWHP4OH17lxluT_BfbHKUdOYSdHbWgHuHPaq1pO3ZHZKoNrjbfIXdkMaGe3Wx	0:1591787100092685%0d63f7200d63f720	\N	\N	1	2020-06-10 11:05:00	2020-06-10 11:05:00	1
1414	435	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1591787100092071%0d63f7200d63f720	\N	\N	1	2020-06-10 11:05:00	2020-06-10 11:05:00	1
1415	435	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1591787100090945%0d63f7200d63f720	\N	\N	1	2020-06-10 11:05:00	2020-06-10 11:05:00	1
1416	435	346	dqit6SbKSv2ydQuZ_HZKTW:APA91bHDcNFhYvuRMvIO3ZyfYCDpBkKZYdVoa3o4xONGHRoyfWbZxrLVF_H2cyXF9R_0ErI7R3G7ajnqWHP4OH17lxluT_BfbHKUdOYSdHbWgHuHPaq1pO3ZHZKoNrjbfIXdkMaGe3Wx	0:1591787100092050%0d63f7200d63f720	\N	\N	1	2020-06-10 11:05:00	2020-06-10 11:05:00	1
1417	438	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1591787700091979%0d63f7200d63f720	\N	\N	1	2020-06-10 11:15:00	2020-06-10 11:15:00	1
1418	438	346	dqit6SbKSv2ydQuZ_HZKTW:APA91bHDcNFhYvuRMvIO3ZyfYCDpBkKZYdVoa3o4xONGHRoyfWbZxrLVF_H2cyXF9R_0ErI7R3G7ajnqWHP4OH17lxluT_BfbHKUdOYSdHbWgHuHPaq1pO3ZHZKoNrjbfIXdkMaGe3Wx	0:1591787700091820%0d63f7200d63f720	\N	\N	1	2020-06-10 11:15:00	2020-06-10 11:15:00	1
1419	438	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1591788000026970%0d63f7200d63f720	\N	\N	1	2020-06-10 11:20:00	2020-06-10 11:20:00	1
1420	438	346	dqit6SbKSv2ydQuZ_HZKTW:APA91bHDcNFhYvuRMvIO3ZyfYCDpBkKZYdVoa3o4xONGHRoyfWbZxrLVF_H2cyXF9R_0ErI7R3G7ajnqWHP4OH17lxluT_BfbHKUdOYSdHbWgHuHPaq1pO3ZHZKoNrjbfIXdkMaGe3Wx	0:1591788000042987%0d63f7200d63f720	\N	\N	1	2020-06-10 11:20:00	2020-06-10 11:20:00	1
1421	439	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591788300045865%0d63f7200d63f720	\N	\N	1	2020-06-10 11:25:00	2020-06-10 11:25:00	1
1422	439	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591788300034444	\N	\N	1	2020-06-10 11:25:00	2020-06-10 11:25:07	2
1423	438	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1591791600105690%0d63f7200d63f720	\N	\N	1	2020-06-10 12:20:00	2020-06-10 12:20:00	1
1424	438	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1591791600096251%0d63f7200d63f720	\N	\N	1	2020-06-10 12:20:00	2020-06-10 12:20:00	1
1425	438	346	dqit6SbKSv2ydQuZ_HZKTW:APA91bHDcNFhYvuRMvIO3ZyfYCDpBkKZYdVoa3o4xONGHRoyfWbZxrLVF_H2cyXF9R_0ErI7R3G7ajnqWHP4OH17lxluT_BfbHKUdOYSdHbWgHuHPaq1pO3ZHZKoNrjbfIXdkMaGe3Wx	0:1591791600102312%0d63f7200d63f720	\N	\N	1	2020-06-10 12:20:00	2020-06-10 12:20:00	1
1426	438	346	dqit6SbKSv2ydQuZ_HZKTW:APA91bHDcNFhYvuRMvIO3ZyfYCDpBkKZYdVoa3o4xONGHRoyfWbZxrLVF_H2cyXF9R_0ErI7R3G7ajnqWHP4OH17lxluT_BfbHKUdOYSdHbWgHuHPaq1pO3ZHZKoNrjbfIXdkMaGe3Wx	0:1591791600105453%0d63f7200d63f720	\N	\N	1	2020-06-10 12:20:00	2020-06-10 12:20:00	1
1427	441	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1591791900081185%0d63f7200d63f720	\N	\N	1	2020-06-10 12:25:00	2020-06-10 12:25:00	1
1428	441	346	dqit6SbKSv2ydQuZ_HZKTW:APA91bHDcNFhYvuRMvIO3ZyfYCDpBkKZYdVoa3o4xONGHRoyfWbZxrLVF_H2cyXF9R_0ErI7R3G7ajnqWHP4OH17lxluT_BfbHKUdOYSdHbWgHuHPaq1pO3ZHZKoNrjbfIXdkMaGe3Wx	0:1591791900072652%0d63f7200d63f720	\N	\N	1	2020-06-10 12:25:00	2020-06-10 12:25:00	1
1429	442	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1591792200085754%0d63f7200d63f720	\N	\N	1	2020-06-10 12:30:00	2020-06-10 12:30:00	1
1430	442	346	dqit6SbKSv2ydQuZ_HZKTW:APA91bHDcNFhYvuRMvIO3ZyfYCDpBkKZYdVoa3o4xONGHRoyfWbZxrLVF_H2cyXF9R_0ErI7R3G7ajnqWHP4OH17lxluT_BfbHKUdOYSdHbWgHuHPaq1pO3ZHZKoNrjbfIXdkMaGe3Wx	0:1591792200090349%0d63f7200d63f720	\N	\N	1	2020-06-10 12:30:00	2020-06-10 12:30:00	1
1431	443	348	czIDQJQfS02amsfu51wV9I:APA91bEg7ShlMZ3R7kTVlUQ4sqvdMQOUMORtcvzqHHhX9do_lZRL5sA7zKxmKxh5zDrn9OzpcL2e7c0O7gILl1c_D43Kibr6oAEPSM17yrsvwAOeqPCmX6SvMb9oq_EEazh5miKVwz93	0:1591867800035787%0d63f7200d63f720	\N	\N	1	2020-06-11 09:30:00	2020-06-11 09:30:00	1
1432	443	349	fpSEAjWv_UPIvorM68LiIk:APA91bHd2bHbqDzVAJVVdA67FX691drzvMLALOVWk1A3kgolanTYNfntzGPPGXHwUqqQ2PGqcnybp-J8mjBVTri4ICPfEya3P1S6N5ETUJn3aEtC8GOQ7uDLEri2gyr5of0mbiVO3QB6	1591867800063451	\N	\N	1	2020-06-11 09:30:00	2020-06-11 09:53:31	2
1433	444	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1591873500078125%0d63f7200d63f720	\N	\N	1	2020-06-11 11:05:00	2020-06-11 11:05:00	1
1434	444	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1591873800063130%0d63f7200d63f720	\N	\N	1	2020-06-11 11:10:00	2020-06-11 11:10:00	1
1435	444	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1591874100045128%0d63f7200d63f720	\N	\N	1	2020-06-11 11:15:00	2020-06-11 11:15:00	1
1436	445	358	czIDQJQfS02amsfu51wV9I:APA91bEg7ShlMZ3R7kTVlUQ4sqvdMQOUMORtcvzqHHhX9do_lZRL5sA7zKxmKxh5zDrn9OzpcL2e7c0O7gILl1c_D43Kibr6oAEPSM17yrsvwAOeqPCmX6SvMb9oq_EEazh5miKVwz93	0:1591959900057955%0d63f7200d63f720	\N	\N	1	2020-06-12 11:05:00	2020-06-12 11:05:00	1
1437	445	357	fpSEAjWv_UPIvorM68LiIk:APA91bHd2bHbqDzVAJVVdA67FX691drzvMLALOVWk1A3kgolanTYNfntzGPPGXHwUqqQ2PGqcnybp-J8mjBVTri4ICPfEya3P1S6N5ETUJn3aEtC8GOQ7uDLEri2gyr5of0mbiVO3QB6	1591959900081382	\N	\N	1	2020-06-12 11:05:00	2020-06-12 11:52:06	2
1438	445	358	czIDQJQfS02amsfu51wV9I:APA91bEg7ShlMZ3R7kTVlUQ4sqvdMQOUMORtcvzqHHhX9do_lZRL5sA7zKxmKxh5zDrn9OzpcL2e7c0O7gILl1c_D43Kibr6oAEPSM17yrsvwAOeqPCmX6SvMb9oq_EEazh5miKVwz93	0:1592046300106997%0d63f7200d63f720	\N	\N	1	2020-06-13 11:05:00	2020-06-13 11:05:00	1
1439	445	357	fpSEAjWv_UPIvorM68LiIk:APA91bHd2bHbqDzVAJVVdA67FX691drzvMLALOVWk1A3kgolanTYNfntzGPPGXHwUqqQ2PGqcnybp-J8mjBVTri4ICPfEya3P1S6N5ETUJn3aEtC8GOQ7uDLEri2gyr5of0mbiVO3QB6	1592046300114953	\N	\N	1	2020-06-13 11:05:00	2020-06-13 11:05:00	1
1440	445	358	czIDQJQfS02amsfu51wV9I:APA91bEg7ShlMZ3R7kTVlUQ4sqvdMQOUMORtcvzqHHhX9do_lZRL5sA7zKxmKxh5zDrn9OzpcL2e7c0O7gILl1c_D43Kibr6oAEPSM17yrsvwAOeqPCmX6SvMb9oq_EEazh5miKVwz93	0:1592132700056857%0d63f7200d63f720	\N	\N	1	2020-06-14 11:05:00	2020-06-14 11:05:00	1
1441	445	357	fpSEAjWv_UPIvorM68LiIk:APA91bHd2bHbqDzVAJVVdA67FX691drzvMLALOVWk1A3kgolanTYNfntzGPPGXHwUqqQ2PGqcnybp-J8mjBVTri4ICPfEya3P1S6N5ETUJn3aEtC8GOQ7uDLEri2gyr5of0mbiVO3QB6	1592132700067764	\N	\N	1	2020-06-14 11:05:00	2020-06-14 11:05:00	1
1442	446	341	eiFDCgUMcUG3tahht3wqKi:APA91bGCOvn2-ATnTtcCArRwbsL9epdqJcczSk3OHE9yn2FgazQyFW_c5xq9-x7FuPxvbkT2z965wv3ZqsI0oeJUXc4EzYMl_qEH3D_Vxtni-QFN5M9-s2SaFjEOeImiisOKLusZkBuB	0:1592211900113218%0d63f7200d63f720	\N	\N	1	2020-06-15 09:05:00	2020-06-15 09:05:00	1
1443	446	342	dy9t-1JMwU1OpkbUW_mkda:APA91bF6QcXQywhZHkK-8mC7NgNr7MZoyL_lMq6gk8km9VU2oTp-WbQ6d4ZTu9g7jF8RiPT5TFPeROaGKApX__xueXJ2rhBE5RqQ52k38CRhG4eaKnnwKHnn3MV1TjdmRjzAFt8YXVdp	1592211900087229	\N	\N	1	2020-06-15 09:05:00	2020-06-15 09:05:04	2
1444	445	358	czIDQJQfS02amsfu51wV9I:APA91bEg7ShlMZ3R7kTVlUQ4sqvdMQOUMORtcvzqHHhX9do_lZRL5sA7zKxmKxh5zDrn9OzpcL2e7c0O7gILl1c_D43Kibr6oAEPSM17yrsvwAOeqPCmX6SvMb9oq_EEazh5miKVwz93	0:1592219100052457%0d63f7200d63f720	\N	\N	1	2020-06-15 11:05:00	2020-06-15 11:05:00	1
1445	445	357	fpSEAjWv_UPIvorM68LiIk:APA91bHd2bHbqDzVAJVVdA67FX691drzvMLALOVWk1A3kgolanTYNfntzGPPGXHwUqqQ2PGqcnybp-J8mjBVTri4ICPfEya3P1S6N5ETUJn3aEtC8GOQ7uDLEri2gyr5of0mbiVO3QB6	1592219100063987	\N	\N	1	2020-06-15 11:05:00	2020-06-15 11:05:00	1
1446	446	341	eiFDCgUMcUG3tahht3wqKi:APA91bGCOvn2-ATnTtcCArRwbsL9epdqJcczSk3OHE9yn2FgazQyFW_c5xq9-x7FuPxvbkT2z965wv3ZqsI0oeJUXc4EzYMl_qEH3D_Vxtni-QFN5M9-s2SaFjEOeImiisOKLusZkBuB	0:1592298300085711%0d63f7200d63f720	\N	\N	1	2020-06-16 09:05:00	2020-06-16 09:05:00	1
1447	446	342	dy9t-1JMwU1OpkbUW_mkda:APA91bF6QcXQywhZHkK-8mC7NgNr7MZoyL_lMq6gk8km9VU2oTp-WbQ6d4ZTu9g7jF8RiPT5TFPeROaGKApX__xueXJ2rhBE5RqQ52k38CRhG4eaKnnwKHnn3MV1TjdmRjzAFt8YXVdp	1592298300053997	\N	\N	1	2020-06-16 09:05:00	2020-06-16 09:05:00	1
1448	447	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1592302500081326%0d63f7200d63f720	\N	\N	1	2020-06-16 10:15:00	2020-06-16 10:15:00	1
1449	448	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1592302800096544%0d63f7200d63f720	\N	\N	1	2020-06-16 10:20:00	2020-06-16 10:20:00	1
1450	450	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1592304000087092%0d63f7200d63f720	\N	\N	1	2020-06-16 10:40:00	2020-06-16 10:40:00	1
1451	451	346	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1592304600097944%0d63f7200d63f720	\N	\N	1	2020-06-16 10:50:00	2020-06-16 10:50:00	1
1452	451	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1592304600098574%0d63f7200d63f720	\N	\N	1	2020-06-16 10:50:00	2020-06-16 10:50:00	1
1453	452	346	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1592305200088708%0d63f7200d63f720	\N	\N	1	2020-06-16 11:00:00	2020-06-16 11:00:00	1
1454	452	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1592305200087022%0d63f7200d63f720	\N	\N	1	2020-06-16 11:00:00	2020-06-16 11:00:00	1
1455	453	346	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1592305500083953%0d63f7200d63f720	\N	\N	1	2020-06-16 11:05:00	2020-06-16 11:05:00	1
1456	453	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1592305500082858%0d63f7200d63f720	\N	\N	1	2020-06-16 11:05:00	2020-06-16 11:05:00	1
1457	454	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1592305800077210%0d63f7200d63f720	\N	\N	1	2020-06-16 11:10:00	2020-06-16 11:10:00	1
1458	454	346	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1592305800079614%0d63f7200d63f720	\N	\N	1	2020-06-16 11:10:00	2020-06-16 11:10:00	1
1459	454	346	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1592306100050245%0d63f7200d63f720	\N	\N	1	2020-06-16 11:15:00	2020-06-16 11:15:00	1
1460	454	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1592306100052829%0d63f7200d63f720	\N	\N	1	2020-06-16 11:15:00	2020-06-16 11:15:00	1
1461	455	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1592310600091235%0d63f7200d63f720	\N	\N	1	2020-06-16 12:30:00	2020-06-16 12:30:00	1
1462	455	346	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1592310600091836%0d63f7200d63f720	\N	\N	1	2020-06-16 12:30:00	2020-06-16 12:30:00	1
1463	457	346	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1592367300080772%0d63f7200d63f720	\N	\N	1	2020-06-17 04:15:00	2020-06-17 04:15:00	1
1464	457	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1592367300080166%0d63f7200d63f720	\N	\N	1	2020-06-17 04:15:00	2020-06-17 04:15:07	2
1465	457	346	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1592453700079242%0d63f7200d63f720	\N	\N	1	2020-06-18 04:15:00	2020-06-18 04:15:00	1
1466	457	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1592453700079011%0d63f7200d63f720	\N	\N	1	2020-06-18 04:15:00	2020-06-18 04:15:00	1
1467	457	346	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1592540100074571%0d63f7200d63f720	\N	\N	1	2020-06-19 04:15:00	2020-06-19 04:15:00	1
1468	457	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1592540100076978%0d63f7200d63f720	\N	\N	1	2020-06-19 04:15:00	2020-06-19 04:15:00	1
1469	458	363	fiDOYDYpT-CLit1BzaUlq5:APA91bFY6DOambwxzTKIeLEOWXLxo-8UbdyOYk7tfv4U27Ut78kSSkNMHgRshG5X0YTq7vU80O45Fg0zQdjA7TiRBncQikiwDOyNI3vY82Y38hb6I-9xrumyRVvciYp02eqq0CWAIWUF	0:1592569200053769%0d63f7200d63f720	\N	\N	1	2020-06-19 12:20:00	2020-06-19 12:20:00	1
1470	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1592569200054379%0d63f7200d63f720	\N	\N	1	2020-06-19 12:20:00	2020-06-19 12:20:00	1
1471	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1592655600099834%0d63f7200d63f720	\N	\N	1	2020-06-20 12:20:00	2020-06-20 12:20:00	1
1472	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1592742000077832%0d63f7200d63f720	\N	\N	1	2020-06-21 12:20:00	2020-06-21 12:20:00	1
1473	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1592828400080328%0d63f7200d63f720	\N	\N	1	2020-06-22 12:20:00	2020-06-22 12:20:00	1
1474	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1592914800066048%0d63f7200d63f720	\N	\N	1	2020-06-23 12:20:00	2020-06-23 12:20:00	1
1475	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1593001200086578%0d63f7200d63f720	\N	\N	1	2020-06-24 12:20:00	2020-06-24 12:20:00	1
1476	459	364	cjbUl3ws50qivDvjEBc6Jf:APA91bHmC30c-TV7QVTEPpkqLfYr-SgeEyLPxCC2tNT4HVz_UQ5_RIFfQfyKIgjL60aThvMMIqJtgqVL685mDOGBHJS1KTW56K4wFclr46NW7JMjz6Kn-7KVhVwzwUK9Mub1Uu_MNq7N	1593032400103846	\N	\N	1	2020-06-24 09:00:00	2020-06-24 09:00:00	1
1477	459	357	cm0zU4n030Bap7ZrOuWzlZ:APA91bEZfHPON2x1rmvE7qLmXp449qt2GGqJpwQtrjMGFXbjD3dzzfc9B88FmjV-wKXQc-7NTNehoxMCl_RX3AZp01ZcPIL68mMqBESFhd8D-TTfMve3T9IyhL3ma9Lvqmt8ctFF6N3Y	1593032400094238	\N	\N	1	2020-06-24 09:00:00	2020-06-24 09:00:00	1
1478	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1593087600126619%0d63f7200d63f720	\N	\N	1	2020-06-25 12:20:00	2020-06-25 12:20:00	1
1479	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1593174000068841%0d63f7200d63f720	\N	\N	1	2020-06-26 12:20:00	2020-06-26 12:20:00	1
1480	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1593260400052703%0d63f7200d63f720	\N	\N	1	2020-06-27 12:20:00	2020-06-27 12:20:00	1
1481	459	357	cm0zU4n030Bap7ZrOuWzlZ:APA91bEZfHPON2x1rmvE7qLmXp449qt2GGqJpwQtrjMGFXbjD3dzzfc9B88FmjV-wKXQc-7NTNehoxMCl_RX3AZp01ZcPIL68mMqBESFhd8D-TTfMve3T9IyhL3ma9Lvqmt8ctFF6N3Y	1593291600078318	\N	\N	1	2020-06-27 09:00:00	2020-06-27 09:00:00	1
1482	459	364	cjbUl3ws50qivDvjEBc6Jf:APA91bHmC30c-TV7QVTEPpkqLfYr-SgeEyLPxCC2tNT4HVz_UQ5_RIFfQfyKIgjL60aThvMMIqJtgqVL685mDOGBHJS1KTW56K4wFclr46NW7JMjz6Kn-7KVhVwzwUK9Mub1Uu_MNq7N	1593291600083529	\N	\N	1	2020-06-27 09:00:00	2020-06-27 09:10:38	2
1483	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1593346800058509%0d63f7200d63f720	\N	\N	1	2020-06-28 12:20:00	2020-06-28 12:20:00	1
1484	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1593433200071186%0d63f7200d63f720	\N	\N	1	2020-06-29 12:20:00	2020-06-29 12:20:00	1
1485	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1593519600074491%0d63f7200d63f720	\N	\N	1	2020-06-30 12:20:00	2020-06-30 12:20:00	1
1486	459	357	cm0zU4n030Bap7ZrOuWzlZ:APA91bEZfHPON2x1rmvE7qLmXp449qt2GGqJpwQtrjMGFXbjD3dzzfc9B88FmjV-wKXQc-7NTNehoxMCl_RX3AZp01ZcPIL68mMqBESFhd8D-TTfMve3T9IyhL3ma9Lvqmt8ctFF6N3Y	1593550800059259	\N	\N	1	2020-06-30 09:00:00	2020-06-30 09:00:00	1
1487	459	364	cjbUl3ws50qivDvjEBc6Jf:APA91bHmC30c-TV7QVTEPpkqLfYr-SgeEyLPxCC2tNT4HVz_UQ5_RIFfQfyKIgjL60aThvMMIqJtgqVL685mDOGBHJS1KTW56K4wFclr46NW7JMjz6Kn-7KVhVwzwUK9Mub1Uu_MNq7N	1593550800073311	\N	\N	1	2020-06-30 09:00:00	2020-06-30 09:18:08	2
1488	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1593606000075924%0d63f7200d63f720	\N	\N	1	2020-07-01 12:20:00	2020-07-01 12:20:00	1
1489	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1593692400101500%0d63f7200d63f720	\N	\N	1	2020-07-02 12:20:00	2020-07-02 12:20:00	1
1490	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1593778800068196%0d63f7200d63f720	\N	\N	1	2020-07-03 12:20:00	2020-07-03 12:20:00	1
1491	459	357	cm0zU4n030Bap7ZrOuWzlZ:APA91bEZfHPON2x1rmvE7qLmXp449qt2GGqJpwQtrjMGFXbjD3dzzfc9B88FmjV-wKXQc-7NTNehoxMCl_RX3AZp01ZcPIL68mMqBESFhd8D-TTfMve3T9IyhL3ma9Lvqmt8ctFF6N3Y	1593810000064637	\N	\N	1	2020-07-03 09:00:00	2020-07-03 09:00:00	1
1492	459	364	cjbUl3ws50qivDvjEBc6Jf:APA91bHmC30c-TV7QVTEPpkqLfYr-SgeEyLPxCC2tNT4HVz_UQ5_RIFfQfyKIgjL60aThvMMIqJtgqVL685mDOGBHJS1KTW56K4wFclr46NW7JMjz6Kn-7KVhVwzwUK9Mub1Uu_MNq7N	1593810000115833	\N	\N	1	2020-07-03 09:00:00	2020-07-03 09:00:00	1
1493	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1593865200089680%0d63f7200d63f720	\N	\N	1	2020-07-04 12:20:00	2020-07-04 12:20:00	1
1494	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1593951600068742%0d63f7200d63f720	\N	\N	1	2020-07-05 12:20:00	2020-07-05 12:20:00	1
1495	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1594038000061614%0d63f7200d63f720	\N	\N	1	2020-07-06 12:20:00	2020-07-06 12:20:00	1
1496	459	364	cjbUl3ws50qivDvjEBc6Jf:APA91bHmC30c-TV7QVTEPpkqLfYr-SgeEyLPxCC2tNT4HVz_UQ5_RIFfQfyKIgjL60aThvMMIqJtgqVL685mDOGBHJS1KTW56K4wFclr46NW7JMjz6Kn-7KVhVwzwUK9Mub1Uu_MNq7N	1594069200083668	\N	\N	1	2020-07-06 09:00:00	2020-07-06 09:00:00	1
1497	459	357	cm0zU4n030Bap7ZrOuWzlZ:APA91bEZfHPON2x1rmvE7qLmXp449qt2GGqJpwQtrjMGFXbjD3dzzfc9B88FmjV-wKXQc-7NTNehoxMCl_RX3AZp01ZcPIL68mMqBESFhd8D-TTfMve3T9IyhL3ma9Lvqmt8ctFF6N3Y	1594069200075286	\N	\N	1	2020-07-06 09:00:00	2020-07-06 09:00:00	1
1498	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1594124400074451%0d63f7200d63f720	\N	\N	1	2020-07-07 12:20:00	2020-07-07 12:20:00	1
1499	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1594210800366324%0d63f7200d63f720	\N	\N	1	2020-07-08 12:20:00	2020-07-08 12:20:00	1
1500	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1594297200047379%0d63f7200d63f720	\N	\N	1	2020-07-09 12:20:00	2020-07-09 12:20:00	1
1501	459	364	cjbUl3ws50qivDvjEBc6Jf:APA91bHmC30c-TV7QVTEPpkqLfYr-SgeEyLPxCC2tNT4HVz_UQ5_RIFfQfyKIgjL60aThvMMIqJtgqVL685mDOGBHJS1KTW56K4wFclr46NW7JMjz6Kn-7KVhVwzwUK9Mub1Uu_MNq7N	1594328400065355	\N	\N	1	2020-07-09 09:00:00	2020-07-09 09:00:00	1
1502	459	357	cm0zU4n030Bap7ZrOuWzlZ:APA91bEZfHPON2x1rmvE7qLmXp449qt2GGqJpwQtrjMGFXbjD3dzzfc9B88FmjV-wKXQc-7NTNehoxMCl_RX3AZp01ZcPIL68mMqBESFhd8D-TTfMve3T9IyhL3ma9Lvqmt8ctFF6N3Y	1594328400061510	\N	\N	1	2020-07-09 09:00:00	2020-07-09 09:00:00	1
1503	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1594383600063580%0d63f7200d63f720	\N	\N	1	2020-07-10 12:20:00	2020-07-10 12:20:00	1
1504	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1594470000070383%0d63f7200d63f720	\N	\N	1	2020-07-11 12:20:00	2020-07-11 12:20:00	1
1505	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1594556400089027%0d63f7200d63f720	\N	\N	1	2020-07-12 12:20:00	2020-07-12 12:20:00	1
1506	459	357	cm0zU4n030Bap7ZrOuWzlZ:APA91bEZfHPON2x1rmvE7qLmXp449qt2GGqJpwQtrjMGFXbjD3dzzfc9B88FmjV-wKXQc-7NTNehoxMCl_RX3AZp01ZcPIL68mMqBESFhd8D-TTfMve3T9IyhL3ma9Lvqmt8ctFF6N3Y	1594587600055205	\N	\N	1	2020-07-12 09:00:00	2020-07-12 09:00:00	1
1507	459	364	cjbUl3ws50qivDvjEBc6Jf:APA91bHmC30c-TV7QVTEPpkqLfYr-SgeEyLPxCC2tNT4HVz_UQ5_RIFfQfyKIgjL60aThvMMIqJtgqVL685mDOGBHJS1KTW56K4wFclr46NW7JMjz6Kn-7KVhVwzwUK9Mub1Uu_MNq7N	1594587600058311	\N	\N	1	2020-07-12 09:00:00	2020-07-12 09:00:00	1
1508	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1594642800109713%0d63f7200d63f720	\N	\N	1	2020-07-13 12:20:00	2020-07-13 12:20:00	1
1509	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1594729200073293%0d63f7200d63f720	\N	\N	1	2020-07-14 12:20:00	2020-07-14 12:20:00	1
1510	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1594815600054464%0d63f7200d63f720	\N	\N	1	2020-07-15 12:20:00	2020-07-15 12:20:00	1
1511	459	364	cjbUl3ws50qivDvjEBc6Jf:APA91bHmC30c-TV7QVTEPpkqLfYr-SgeEyLPxCC2tNT4HVz_UQ5_RIFfQfyKIgjL60aThvMMIqJtgqVL685mDOGBHJS1KTW56K4wFclr46NW7JMjz6Kn-7KVhVwzwUK9Mub1Uu_MNq7N	1594846800076388	\N	\N	1	2020-07-15 09:00:00	2020-07-15 09:00:00	1
1512	459	357	cm0zU4n030Bap7ZrOuWzlZ:APA91bEZfHPON2x1rmvE7qLmXp449qt2GGqJpwQtrjMGFXbjD3dzzfc9B88FmjV-wKXQc-7NTNehoxMCl_RX3AZp01ZcPIL68mMqBESFhd8D-TTfMve3T9IyhL3ma9Lvqmt8ctFF6N3Y	1594846800070642	\N	\N	1	2020-07-15 09:00:00	2020-07-15 09:00:00	1
1513	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1594902000074192%0d63f7200d63f720	\N	\N	1	2020-07-16 12:20:00	2020-07-16 12:20:00	1
1514	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1594988400092971%0d63f7200d63f720	\N	\N	1	2020-07-17 12:20:00	2020-07-17 12:20:00	1
1515	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1595074800080933%0d63f7200d63f720	\N	\N	1	2020-07-18 12:20:00	2020-07-18 12:20:00	1
1516	460	368	cUE-KgjcoUsNlt2fJRwSu0:APA91bGSdysYVm8yjOCTzk5ItyueQpFhimAsVXG8P2zCoAnzNCZqP4aSzA_c_5-AAJ6qN7NIsEmIDWV8WJbsTVc1-8HMoXdIEeeH1qcCpwyVmjm2jVg5M-rD3KJNE0VOPjDgDyGC5QmO	1595250000067721	\N	\N	1	2020-07-20 01:00:00	2020-07-20 01:00:00	1
1517	460	366	c4q-8mzhJ00npVjO21QbvX:APA91bGHIb-Nn_h2EpeEtl77Kfc-qbBUqRFBsJ8K8hhk5Dcfq-pfP3EZT1MbPtiLuRevs_r-AYjnNjZ3dZ-uappdoZWq8Jwu8Y2e73E7P6mKQjdciGgL08wT0LwDAMiEVuJCGnpXASak	1595250000090972	\N	\N	1	2020-07-20 01:00:00	2020-07-20 01:00:00	1
1518	460	368	cUE-KgjcoUsNlt2fJRwSu0:APA91bGSdysYVm8yjOCTzk5ItyueQpFhimAsVXG8P2zCoAnzNCZqP4aSzA_c_5-AAJ6qN7NIsEmIDWV8WJbsTVc1-8HMoXdIEeeH1qcCpwyVmjm2jVg5M-rD3KJNE0VOPjDgDyGC5QmO	1595595600085841	\N	\N	1	2020-07-24 01:00:00	2020-07-24 01:00:00	1
1519	460	366	c4q-8mzhJ00npVjO21QbvX:APA91bGHIb-Nn_h2EpeEtl77Kfc-qbBUqRFBsJ8K8hhk5Dcfq-pfP3EZT1MbPtiLuRevs_r-AYjnNjZ3dZ-uappdoZWq8Jwu8Y2e73E7P6mKQjdciGgL08wT0LwDAMiEVuJCGnpXASak	1595595600109985	\N	\N	1	2020-07-24 01:00:00	2020-07-24 01:00:00	1
\.


--
-- Name: goal_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.goal_notifications_id_seq', 1519, true);


--
-- Data for Name: goal_setting_answers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.goal_setting_answers (id, question_id, answer, status, create_time, update_time, user_id, custom_answer) FROM stdin;
57	12	Option1, option2, option3	1	2020-05-27 02:13:32	2020-05-27 02:13:32	29	\N
58	12	Option3, option1	1	2020-05-27 02:13:32	2020-05-27 02:13:32	29	Hello i good morning 
59	15	Option3, option1	1	2020-05-27 02:13:32	2020-05-27 02:13:32	29	\N
\.


--
-- Name: goal_setting_answers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.goal_setting_answers_id_seq', 59, true);


--
-- Data for Name: goal_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.goal_settings (id, question_descripation, status, create_time, update_time, question_title, iscustom) FROM stdin;
10	Choose all that apply.	1	2020-05-22 06:05:01	2020-05-22 06:05:01	Game                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                	true                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
11	Choose all that apply.	1	2020-05-22 06:09:10	2020-05-22 06:09:10	Partner orgasm                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      	true                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
12	Choose all that apply.	1	2020-05-22 06:10:58	2020-05-22 06:10:58	Seduction                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           	true                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
13	Choose all that apply.	1	2020-05-22 06:12:28	2020-05-22 06:12:28	Spontaneity                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         	true                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
7	Choose all that apply.	1	2020-05-22 05:54:22	2020-05-22 05:54:22	Foreplay                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            	true                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
8	Choose all that apply.	1	2020-05-22 05:58:04	2020-05-22 05:58:04	Positions                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           	true                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
9	Choose all that apply.	1	2020-05-22 06:03:10	2020-05-22 06:03:10	Props                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               	true                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
14	Choose all that apply.	1	2020-05-22 06:14:05	2020-05-22 06:14:05	Creative                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            	true                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
15	Choose all that apply.	1	2020-05-22 06:16:12	2020-05-22 06:16:12	Length of encounter                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 	true                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
16	Choose all that apply.	1	2020-05-22 06:17:48	2020-05-22 06:17:48	Lighting                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            	true                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
17	Choose all that apply.	1	2020-05-22 06:19:45	2020-05-22 06:19:45	Post-sex                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            	true                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
18	Choose all that apply.	1	2020-05-22 06:21:20	2020-05-22 06:21:20	Helpful Reminders!                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  	true                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
\.


--
-- Name: goal_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.goal_settings_id_seq', 21, true);


--
-- Data for Name: info_messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.info_messages (id, title, description, status, create_time, update_time, key, screen) FROM stdin;
2	Intimacy Initiation	How are prefers to have intimacy initiated can be a very personal thing. Don't worry! You'll define what your preference are in a subsequent step.Add some privacy language here.	1	2020-05-22 11:40:25	2020-05-22 06:26:07	intimate_info	\N
3	Accountability	How are prefers to have intimacy initiated can be a very personal thing. Don't worry! You'll define what your preference are in a subsequent step.\r\nAdd some privacy language here.	1	2020-05-22 11:44:30	2020-05-23 11:00:30	account_info	\N
4	Intimacy Request 	How are prefers to have intimacy initiated can be a very personal thing.\r\n\r\nDon't worry!\r\nYou'll define what your preference are in a subsequent step. \r\nAdd some privacy language here.	1	2020-05-22 11:44:38	2020-05-23 11:00:56	request_info	\N
6	Intimacy Initiation	How are prefers to have intimacy initiated can be a very personal thing. Don't worry! You'll define what your preference are in a subsequent step.Add some privacy language here.	1	2020-05-22 02:50:40	2020-05-23 11:03:12	contact_info	\N
\.


--
-- Name: info_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.info_messages_id_seq', 6, true);


--
-- Data for Name: monthly_goals; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.monthly_goals (id, partner_mapping_id, user_id, goal_identifier, month_start, month_end, connect_number, initiator_count, percentage, complete_count, complete_percentage, status, create_time, update_time, intimate_time, intimate_request_time, intimate_account_time, initiator_count1, contribution2, contribution1, hours) FROM stdin;
33	60	61	1587123044542	2020-04-17	2020-05-17	15	12	80	0	0	1	2020-04-16 23:30:44	2020-04-16 23:30:44	\N	\N	\N	\N	0	0	\N
34	60	60	1587123044542	2020-04-17	2020-05-17	15	3	20	0	0	1	2020-04-16 23:30:44	2020-04-16 23:30:44	\N	\N	\N	\N	0	0	\N
35	60	61	1587123089818	2020-04-17	2020-05-17	15	12	80	0	0	1	2020-04-16 23:31:29	2020-04-16 23:31:29	\N	\N	\N	\N	0	0	\N
36	60	60	1587123089818	2020-04-17	2020-05-17	15	3	20	0	0	1	2020-04-16 23:31:29	2020-04-16 23:31:29	\N	\N	\N	\N	0	0	\N
37	60	61	1587123091005	2020-04-17	2020-05-17	15	12	80	0	0	1	2020-04-16 23:31:30	2020-04-16 23:31:30	\N	\N	\N	\N	0	0	\N
38	60	60	1587123091005	2020-04-17	2020-05-17	15	3	20	0	0	1	2020-04-16 23:31:30	2020-04-16 23:31:30	\N	\N	\N	\N	0	0	\N
39	60	61	1587123093457	2020-04-17	2020-05-17	15	12	80	0	0	1	2020-04-16 23:31:32	2020-04-16 23:31:32	\N	\N	\N	\N	0	0	\N
40	60	60	1587123093457	2020-04-17	2020-05-17	15	3	20	0	0	1	2020-04-16 23:31:32	2020-04-16 23:31:32	\N	\N	\N	\N	0	0	\N
7	15	30	1588762676458	2020-05-06	2020-06-05	10	50	\N	0	0	1	2020-05-06 10:57:55	2020-05-06 10:57:55	05:00 AM	06:00 AM	10:00 AM	50	0	0	\N
8	15	31	1588762676458	2020-05-06	2020-06-05	10	\N	\N	0	0	1	2020-05-06 10:57:55	2020-05-06 10:57:55	05:00 AM	06:00 AM	10:00 AM	50	0	0	\N
9	15	30	1588762758782	2020-05-06	2020-06-05	10	35	\N	0	0	1	2020-05-06 10:59:18	2020-05-06 10:59:18	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
10	15	31	1588762758782	2020-05-06	2020-06-05	10	\N	\N	0	0	1	2020-05-06 10:59:18	2020-05-06 10:59:18	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
11	19	34	1588766884747	2020-05-06	2020-06-05	23	66	\N	0	0	1	2020-05-06 12:08:04	2020-05-06 12:08:04	09:00 PM	05:00 PM	10:00 PM	34	0	0	\N
12	19	35	1588766884747	2020-05-06	2020-06-05	23	\N	\N	0	0	1	2020-05-06 12:08:04	2020-05-06 12:08:04	09:00 PM	05:00 PM	10:00 PM	34	0	0	\N
13	37	57	1588767277515	2020-05-06	2020-06-05	12	58	\N	0	0	1	2020-05-06 12:14:36	2020-05-06 12:14:36	10:00 AM	12:00 AM	05:00 PM	42	0	0	\N
14	37	58	1588767277515	2020-05-06	2020-06-05	12	\N	\N	0	0	1	2020-05-06 12:14:36	2020-05-06 12:14:36	10:00 AM	12:00 AM	05:00 PM	42	0	0	\N
15	39	59	1588767708309	2020-05-06	2020-06-05	21	65	\N	0	0	1	2020-05-06 12:21:47	2020-05-06 12:21:47	05:00 PM	06:00 PM	04:00 PM	35	0	0	\N
16	39	62	1588767708309	2020-05-06	2020-06-05	21	\N	\N	0	0	1	2020-05-06 12:21:47	2020-05-06 12:21:47	05:00 PM	06:00 PM	04:00 PM	35	0	0	\N
17	43	66	1588768631994	2020-05-06	2020-06-05	9	49	\N	0	0	1	2020-05-06 12:37:11	2020-05-06 12:37:11	09:00 PM	05:00 PM	10:00 PM	51	0	0	\N
18	43	65	1588768631994	2020-05-06	2020-06-05	9	\N	\N	0	0	1	2020-05-06 12:37:11	2020-05-06 12:37:11	09:00 PM	05:00 PM	10:00 PM	51	0	0	\N
23	45	70	1588769568600	2020-05-06	2020-06-05	8	35	\N	0	0	1	2020-05-06 12:52:47	2020-05-06 12:52:47	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
24	45	69	1588769568600	2020-05-06	2020-06-05	8	\N	\N	0	0	1	2020-05-06 12:52:47	2020-05-06 12:52:47	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
25	49	81	1588770775279	2020-05-06	2020-06-05	10	35	\N	0	0	1	2020-05-06 01:12:55	2020-05-06 01:12:55	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
26	49	80	1588770775279	2020-05-06	2020-06-05	10	\N	\N	0	0	1	2020-05-06 01:12:55	2020-05-06 01:12:55	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
27	53	84	1588771180357	2020-05-06	2020-06-05	10	35	\N	0	0	1	2020-05-06 01:19:39	2020-05-06 01:19:39	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
28	53	85	1588771180357	2020-05-06	2020-06-05	10	\N	\N	0	0	1	2020-05-06 01:19:39	2020-05-06 01:19:39	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
29	55	87	1588771440023	2020-05-06	2020-06-05	7	35	\N	0	0	1	2020-05-06 01:23:59	2020-05-06 01:23:59	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
30	55	86	1588771440023	2020-05-06	2020-06-05	7	\N	\N	0	0	1	2020-05-06 01:23:59	2020-05-06 01:23:59	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
31	57	89	1588771991516	2020-05-06	2020-06-05	10	35	\N	0	0	1	2020-05-06 01:33:11	2020-05-06 01:33:11	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
32	57	88	1588771991516	2020-05-06	2020-06-05	10	\N	\N	0	0	1	2020-05-06 01:33:11	2020-05-06 01:33:11	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
41	64	99	1588850714716	2020-05-07	2020-06-06	2	10	\N	0	0	1	2020-05-07 11:25:13	2020-05-07 11:25:13	10	08:20	20	2	0	0	\N
42	64	98	1588850714716	2020-05-07	2020-06-06	2	10	\N	0	0	1	2020-05-07 11:25:13	2020-05-07 11:25:13	10	08:20	20	2	0	0	\N
43	69	103	1588856304584	2020-05-07	2020-06-06	40	35	\N	0	0	1	2020-05-07 12:58:24	2020-05-07 12:58:24	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
44	69	102	1588856304584	2020-05-07	2020-06-06	40	35	\N	0	0	1	2020-05-07 12:58:24	2020-05-07 12:58:24	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
45	71	105	1588856569322	2020-05-07	2020-06-06	42	44	\N	0	0	1	2020-05-07 01:02:48	2020-05-07 01:02:48	09:00 PM	05:00 PM	10:00 PM	56	0	0	\N
46	71	104	1588856569322	2020-05-07	2020-06-06	42	44	\N	0	0	1	2020-05-07 01:02:48	2020-05-07 01:02:48	09:00 PM	05:00 PM	10:00 PM	56	0	0	\N
47	73	107	1588859887716	2020-05-07	2020-06-06	20	51	\N	0	0	1	2020-05-07 01:58:07	2020-05-07 01:58:07	01:00 AM	04:00 AM	08:00 AM	49	0	0	\N
48	73	109	1588859887716	2020-05-07	2020-06-06	20	51	\N	0	0	1	2020-05-07 01:58:07	2020-05-07 01:58:07	01:00 AM	04:00 AM	08:00 AM	49	0	0	\N
49	75	113	1588862816435	2020-05-07	2020-06-06	19	51	\N	0	0	1	2020-05-07 02:46:55	2020-05-07 02:46:55	09:00 PM	05:00 PM	10:00 PM	49	0	0	\N
50	75	114	1588862816435	2020-05-07	2020-06-06	19	51	\N	0	0	1	2020-05-07 02:46:55	2020-05-07 02:46:55	09:00 PM	05:00 PM	10:00 PM	49	0	0	\N
51	77	116	1588863557009	2020-05-07	2020-06-06	18	35	\N	0	0	1	2020-05-07 02:59:16	2020-05-07 02:59:16	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
52	77	117	1588863557009	2020-05-07	2020-06-06	18	35	\N	0	0	1	2020-05-07 02:59:16	2020-05-07 02:59:16	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
53	79	119	1588864606106	2020-05-07	2020-06-06	16	35	\N	0	0	1	2020-05-07 03:16:45	2020-05-07 03:16:45	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
54	79	118	1588864606106	2020-05-07	2020-06-06	16	35	\N	0	0	1	2020-05-07 03:16:45	2020-05-07 03:16:45	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
55	81	121	1588865303489	2020-05-07	2020-06-06	18	35	\N	0	0	1	2020-05-07 03:28:23	2020-05-07 03:28:23	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
56	81	120	1588865303489	2020-05-07	2020-06-06	18	35	\N	0	0	1	2020-05-07 03:28:23	2020-05-07 03:28:23	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
57	83	122	1588865407608	2020-05-07	2020-06-06	15	47	\N	0	0	1	2020-05-07 03:30:06	2020-05-07 03:30:06	09:00 PM	05:00 PM	10:00 PM	53	0	0	\N
58	83	123	1588865407608	2020-05-07	2020-06-06	15	47	\N	0	0	1	2020-05-07 03:30:06	2020-05-07 03:30:06	09:00 PM	05:00 PM	10:00 PM	53	0	0	\N
59	85	125	1588868526157	2020-05-07	2020-06-06	10	65	\N	0	0	1	2020-05-07 04:22:05	2020-05-07 04:22:05	11:00 PM	10:00 PM	10:00 AM	35	0	0	\N
60	85	124	1588868526157	2020-05-07	2020-06-06	10	65	\N	0	0	1	2020-05-07 04:22:05	2020-05-07 04:22:05	11:00 PM	10:00 PM	10:00 AM	35	0	0	\N
61	84	124	1588868884024	2020-05-07	2020-06-06	15	59	\N	0	0	1	2020-05-07 04:28:03	2020-05-07 04:28:03	05:00 PM	05:00 PM	07:00 AM	41	0	0	\N
62	84	125	1588868884024	2020-05-07	2020-06-06	15	59	\N	0	0	1	2020-05-07 04:28:03	2020-05-07 04:28:03	05:00 PM	05:00 PM	07:00 AM	41	0	0	\N
63	89	131	1588875433060	2020-05-07	2020-06-06	21	76	\N	0	0	1	2020-05-07 06:17:12	2020-05-07 06:17:12	09:00 PM	05:00 PM	10:00 PM	24	0	0	\N
64	89	132	1588875433060	2020-05-07	2020-06-06	21	76	\N	0	0	1	2020-05-07 06:17:12	2020-05-07 06:17:12	09:00 PM	05:00 PM	10:00 PM	24	0	0	\N
65	93	136	1588919493182	2020-05-08	2020-06-07	10	48	\N	0	0	1	2020-05-08 06:31:32	2020-05-08 06:31:32	09:00 PM	05:00 PM	10:00 PM	52	0	0	\N
66	93	135	1588919493182	2020-05-08	2020-06-07	10	48	\N	0	0	1	2020-05-08 06:31:32	2020-05-08 06:31:32	09:00 PM	05:00 PM	10:00 PM	52	0	0	\N
67	95	137	1588919897362	2020-05-08	2020-06-07	16	52	\N	0	0	1	2020-05-08 06:38:16	2020-05-08 06:38:16	09:00 PM	05:00 PM	10:00 PM	48	0	0	\N
68	95	138	1588919897362	2020-05-08	2020-06-07	16	52	\N	0	0	1	2020-05-08 06:38:16	2020-05-08 06:38:16	09:00 PM	05:00 PM	10:00 PM	48	0	0	\N
69	97	139	1588922080345	2020-05-08	2020-06-07	14	44	\N	0	0	1	2020-05-08 07:14:40	2020-05-08 07:14:40	09:00 PM	05:00 PM	10:00 PM	56	0	0	\N
70	97	141	1588922080345	2020-05-08	2020-06-07	14	44	\N	0	0	1	2020-05-08 07:14:40	2020-05-08 07:14:40	09:00 PM	05:00 PM	10:00 PM	56	0	0	\N
71	65	98	1588929099810	2020-05-08	2020-06-07	20	15	\N	0	0	1	2020-05-08 09:11:39	2020-05-08 09:11:39	10	08:20	20	2	0	0	\N
72	65	99	1588929099810	2020-05-08	2020-06-07	20	2	\N	0	0	1	2020-05-08 09:11:39	2020-05-08 09:11:39	10	08:20	20	15	0	0	\N
73	99	142	1588935823041	2020-05-08	2020-06-07	18	56	\N	0	0	1	2020-05-08 11:03:42	2020-05-08 11:03:42	09:00 PM	05:00 PM	10:00 PM	44	0	0	\N
74	99	140	1588935823041	2020-05-08	2020-06-07	18	44	\N	0	0	1	2020-05-08 11:03:42	2020-05-08 11:03:42	09:00 PM	05:00 PM	10:00 PM	56	0	0	\N
75	101	143	1588936540732	2020-05-08	2020-06-07	25	53	\N	0	0	1	2020-05-08 11:15:40	2020-05-08 11:15:40	09:00 PM	05:00 PM	10:00 PM	47	0	0	\N
76	101	144	1588936540732	2020-05-08	2020-06-07	25	47	\N	0	0	1	2020-05-08 11:15:40	2020-05-08 11:15:40	09:00 PM	05:00 PM	10:00 PM	53	0	0	\N
77	102	146	1588942533023	2020-05-08	2020-06-07	15	37	\N	0	0	1	2020-05-08 12:55:32	2020-05-08 12:55:32	06:00 AM	05:00 PM	10:00 PM	63	0	0	\N
78	102	145	1588942533023	2020-05-08	2020-06-07	15	63	\N	0	0	1	2020-05-08 12:55:32	2020-05-08 12:55:32	06:00 AM	05:00 PM	10:00 PM	37	0	0	\N
79	105	147	1588943060564	2020-05-08	2020-06-07	11	53	\N	0	0	1	2020-05-08 01:04:20	2020-05-08 01:04:20	09:00 PM	05:00 PM	10:00 PM	47	0	0	\N
80	105	148	1588943060564	2020-05-08	2020-06-07	11	47	\N	0	0	1	2020-05-08 01:04:20	2020-05-08 01:04:20	09:00 PM	05:00 PM	10:00 PM	53	0	0	\N
81	65	98	1588943621532	2020-05-08	2020-06-07	20	15	\N	0	0	1	2020-05-08 01:13:40	2020-05-08 01:13:40	10	08:20	20	2	0	0	\N
82	65	99	1588943621532	2020-05-08	2020-06-07	20	2	\N	0	0	1	2020-05-08 01:13:40	2020-05-08 01:13:40	10	08:20	20	15	0	0	\N
83	109	151	1588944931160	2020-05-08	2020-06-07	25	51	\N	0	0	1	2020-05-08 01:35:30	2020-05-08 01:35:30	09:00 PM	05:00 PM	10:00 PM	49	0	0	\N
84	109	152	1588944931160	2020-05-08	2020-06-07	25	49	\N	0	0	1	2020-05-08 01:35:30	2020-05-08 01:35:30	09:00 PM	05:00 PM	10:00 PM	51	0	0	\N
85	111	154	1588945141210	2020-05-08	2020-06-07	11	45	\N	0	0	1	2020-05-08 01:39:00	2020-05-08 01:39:00	09:00 PM	05:00 PM	10:00 PM	55	0	0	\N
86	111	153	1588945141210	2020-05-08	2020-06-07	11	55	\N	0	0	1	2020-05-08 01:39:00	2020-05-08 01:39:00	09:00 PM	05:00 PM	10:00 PM	45	0	0	\N
87	113	156	1588945377053	2020-05-08	2020-06-07	18	48	\N	0	0	1	2020-05-08 01:42:56	2020-05-08 01:42:56	09:00 PM	05:00 PM	10:00 PM	52	0	0	\N
88	113	155	1588945377053	2020-05-08	2020-06-07	18	52	\N	0	0	1	2020-05-08 01:42:56	2020-05-08 01:42:56	09:00 PM	05:00 PM	10:00 PM	48	0	0	\N
89	115	158	1588947955349	2020-05-08	2020-06-07	23	52	\N	0	0	1	2020-05-08 02:25:54	2020-05-08 02:25:54	09:00 PM	05:00 PM	10:00 PM	48	0	0	\N
90	115	157	1588947955349	2020-05-08	2020-06-07	23	48	\N	0	0	1	2020-05-08 02:25:54	2020-05-08 02:25:54	09:00 PM	05:00 PM	10:00 PM	52	0	0	\N
91	119	159	1589015211875	2020-05-09	2020-06-08	16	46	\N	0	0	1	2020-05-09 09:06:50	2020-05-09 09:06:50	09:00 PM	05:00 PM	10:00 PM	54	0	0	\N
92	119	160	1589015211875	2020-05-09	2020-06-08	16	54	\N	0	0	1	2020-05-09 09:06:50	2020-05-09 09:06:50	09:00 PM	05:00 PM	10:00 PM	46	0	0	\N
93	121	161	1589015559204	2020-05-09	2020-06-08	2	10	\N	0	0	1	2020-05-09 09:12:38	2020-05-09 09:12:38	10	08:20	20	2	0	0	\N
94	121	162	1589015559204	2020-05-09	2020-06-08	2	2	\N	0	0	1	2020-05-09 09:12:38	2020-05-09 09:12:38	10	08:20	20	10	0	0	\N
95	122	164	1589019290852	2020-05-09	2020-06-08	15	35	\N	0	0	1	2020-05-09 10:14:50	2020-05-09 10:14:50	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
96	122	163	1589019290852	2020-05-09	2020-06-08	15	65	\N	0	0	1	2020-05-09 10:14:50	2020-05-09 10:14:50	09:00 PM	05:00 PM	10:00 PM	35	0	0	\N
97	125	165	1589019610153	2020-05-09	2020-06-08	12	35	\N	0	0	1	2020-05-09 10:20:09	2020-05-09 10:20:09	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
98	125	166	1589019610153	2020-05-09	2020-06-08	12	65	\N	0	0	1	2020-05-09 10:20:09	2020-05-09 10:20:09	09:00 PM	05:00 PM	10:00 PM	35	0	0	\N
99	126	168	1589020273591	2020-05-09	2020-06-08	15	35	\N	0	0	1	2020-05-09 10:31:13	2020-05-09 10:31:13	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
100	126	167	1589020273591	2020-05-09	2020-06-08	15	65	\N	0	0	1	2020-05-09 10:31:13	2020-05-09 10:31:13	09:00 PM	05:00 PM	10:00 PM	35	0	0	\N
101	128	170	1589020464290	2020-05-09	2020-06-08	36	61	\N	0	0	1	2020-05-09 10:34:23	2020-05-09 10:34:23	09:00 PM	05:00 PM	10:00 PM	39	0	0	\N
102	128	169	1589020464290	2020-05-09	2020-06-08	36	39	\N	0	0	1	2020-05-09 10:34:23	2020-05-09 10:34:23	09:00 PM	05:00 PM	10:00 PM	61	0	0	\N
107	114	157	1589025188878	2020-05-09	2020-06-08	20	15	\N	0	0	1	2020-05-09 11:53:08	2020-05-09 11:53:08	10	08:20	20	2	0	0	\N
108	114	158	1589025188878	2020-05-09	2020-06-08	20	2	\N	0	0	1	2020-05-09 11:53:08	2020-05-09 11:53:08	10	08:20	20	15	0	0	\N
109	114	157	1589025923611	2020-05-09	2020-06-08	20	15	\N	0	0	1	2020-05-09 12:05:23	2020-05-09 12:05:23	10	08:20	20	2	0	0	\N
110	114	158	1589025923611	2020-05-09	2020-06-08	20	2	\N	0	0	1	2020-05-09 12:05:23	2020-05-09 12:05:23	10	08:20	20	15	0	0	\N
117	131	183	1589377201419	2020-05-13	2020-06-12	25	51	\N	0	0	1	2020-05-13 01:40:00	2020-05-13 01:40:00	12:15 PM	06:15 PM	10:20 PM	49	0	0	\N
119	139	197	1589379676927	2020-05-13	2020-06-12	28	55	\N	0	0	1	2020-05-13 02:21:15	2020-05-13 02:21:15	09:10 PM	07:00 PM	10:30 PM	45	0	0	\N
120	147	206	1589432020238	2020-05-14	2020-06-13	58	55	\N	0	0	1	2020-05-14 04:53:39	2020-05-14 04:53:39	09:00 PM	05:00 PM	10:00 PM	45	0	0	\N
121	153	213	1589437755550	2020-05-14	2020-06-13	25	54	\N	0	0	1	2020-05-14 06:29:15	2020-05-14 06:29:15	09:20 PM	09:00 PM	12:20 PM	46	0	0	\N
122	155	215	1589437958710	2020-05-14	2020-06-13	45	53	\N	0	0	1	2020-05-14 06:32:38	2020-05-14 06:32:38	09:00 PM	05:00 PM	10:00 PM	47	0	0	\N
118	135	216	1589378268132	2020-05-13	2020-06-12	25	10	\N	0	0	1	2020-05-13 01:57:47	2020-05-14 06:53:32	10	10:22 AM	02:20 PM	5	0	0	\N
123	157	217	1589445995333	2020-05-14	2020-06-13	56	58	\N	0	0	1	2020-05-14 08:46:34	2020-05-14 08:46:34	09:00 PM	08:00 PM	10:00 PM	42	0	0	\N
125	156	218	1589449161432	2020-05-14	2020-06-13	56	58	\N	0	0	1	2020-05-14 09:39:20	2020-05-14 09:39:20	09:00 PM	08:00 PM	10:00 PM	42	0	0	\N
126	156	218	1589449229803	2020-05-14	2020-06-13	56	58	\N	0	0	1	2020-05-14 09:40:29	2020-05-14 09:40:29	09:00 PM	08:00 PM	10:00 PM	42	0	0	\N
139	184	247	1589480937349	2020-05-14	2020-06-13	10	68	\N	0	0	1	2020-05-14 06:28:57	2020-05-14 06:28:57	09:00 PM	05:00 PM	10:00 PM	32	0	0	\N
441	510	345	1591791747455	2020-06-10	2020-07-10	30	35	\N	0	0	1	2020-06-10 12:22:26	2020-06-10 12:22:57	03:30 PM	12:25 PM	04:30 PM	65	0	0	28:05
438	511	346	1591787654833	2020-06-10	2020-07-10	30	35	\N	0	0	1	2020-06-10 11:14:14	2020-06-10 12:27:19	03:30 PM	11:20 AM	04:30 PM	65	0	0	29:10
372	448	311	1591185034170	2020-06-03	2020-07-03	3	65	\N	3	0	1	2020-06-03 11:50:33	2020-06-03 11:53:49	03:30 PM	11:30 AM	04:30 PM	35	0	3	\N
390	449	312	1591188251875	2020-06-03	2020-07-03	2	65	\N	2	0	1	2020-06-03 12:44:11	2020-06-03 12:46:58	03:30 PM	11:30 AM	04:30 PM	35	1	1	\N
378	449	311	1591186765238	2020-06-03	2020-07-03	5	35	\N	5	0	1	2020-06-03 12:19:25	2020-06-03 12:19:25	03:30 PM	11:30 AM	04:30 PM	65	0	5	\N
165	235	256	1589806862067	2020-05-18	2020-06-17	45	35	\N	0	0	1	2020-05-18 01:01:01	2020-05-18 01:01:01	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
374	449	311	1591185570944	2020-06-03	2020-07-03	3	35	\N	3	0	1	2020-06-03 11:59:30	2020-06-03 11:59:30	03:30 PM	11:30 AM	04:30 PM	65	2	1	\N
376	449	311	1591185758886	2020-06-03	2020-07-03	3	35	\N	0	0	1	2020-06-03 12:02:38	2020-06-03 12:02:38	03:30 PM	11:30 AM	04:30 PM	65	0	0	\N
450	510	345	1592303717919	2020-06-12	2020-07-12	30	35	\N	0	0	1	2020-06-16 10:35:17	2020-06-16 10:40:18	03:30 PM	10:45 AM	04:30 PM	65	0	0	29:45
347	449	311	1591018072300	2020-06-01	2020-07-01	4	35	\N	5	0	1	2020-06-01 01:27:51	2020-06-03 11:36:13	03:30 PM	09:00 AM	04:30 PM	65	4	18	\N
386	449	311	1591187898274	2020-06-03	2020-07-03	3	35	\N	0	0	1	2020-06-03 12:38:17	2020-06-03 12:38:17	03:30 PM	11:30 AM	04:30 PM	65	0	0	\N
392	449	311	1591188463358	2020-06-03	2020-07-03	4	35	\N	0	0	1	2020-06-03 12:47:42	2020-06-03 12:47:42	03:30 PM	11:30 AM	04:30 PM	65	0	0	\N
388	448	312	1591188030247	2020-06-03	2020-07-03	5	35	\N	0	0	1	2020-06-03 12:40:30	2020-06-03 12:40:30	03:30 PM	11:30 AM	04:30 PM	65	0	0	\N
309	11	29	1590638604942	2020-05-28	2020-06-27	20	15	\N	0	0	1	2020-05-28 04:03:24	2020-05-28 04:03:24	10	04:26 PM	09:45 AM	2	0	0	\N
311	388	323	1590638652840	2020-05-28	2020-06-27	20	15	\N	0	0	1	2020-05-28 04:04:11	2020-05-28 04:04:11	10	09:35 AM	09:45 AM	2	0	0	\N
444	510	345	1591873251047	2020-06-15	2020-07-11	30	35	\N	0	0	1	2020-06-11 11:00:50	2020-06-11 11:12:01	04:30 PM	11:15 AM	04:30 PM	65	0	0	29:15
395	449	311	1591188816455	2020-06-03	2020-07-03	2	35	\N	2	0	1	2020-06-03 12:53:36	2020-06-03 12:53:36	03:30 PM	11:30 AM	04:30 PM	65	1	1	\N
447	510	345	1592302257581	2020-06-12	2020-07-12	30	35	\N	0	0	1	2020-06-16 10:10:56	2020-06-16 10:10:56	03:30 PM	10:15 AM	04:30 PM	65	0	0	30:15
396	449	311	1591188883447	2020-06-03	2020-07-03	2	35	\N	2	0	1	2020-06-03 12:54:42	2020-06-03 12:57:29	03:30 PM	11:30 AM	04:30 PM	65	1	1	\N
435	511	346	1591783628219	2020-06-10	2020-07-10	30	47	\N	0	0	1	2020-06-10 10:07:07	2020-06-10 11:11:55	03:30 PM	11:10 AM	04:30 PM	53	0	0	29:20
456	510	345	1592312148167	2020-06-16	2020-07-16	30	35	\N	0	0	1	2020-06-16 12:55:47	2020-06-17 04:00:53	03:30 PM	04:05 AM	05:30 PM	65	0	0	37:25
397	448	312	1591189423083	2020-06-03	2020-07-03	4	35	\N	0	0	1	2020-06-03 01:03:42	2020-06-03 01:03:42	03:30 PM	11:30 AM	04:30 PM	65	0	0	\N
398	449	311	1591189429564	2020-06-03	2020-07-03	5	35	\N	0	0	1	2020-06-03 01:03:48	2020-06-03 01:03:48	03:30 PM	11:30 AM	04:30 PM	65	0	0	\N
399	449	311	1591189442593	2020-06-03	2020-07-03	5	35	\N	0	0	1	2020-06-03 01:04:02	2020-06-03 01:04:02	03:30 PM	11:30 AM	04:30 PM	65	0	0	\N
339	432	319	1591003092923	2020-06-01	2020-07-01	10	35	\N	0	0	1	2020-06-01 09:18:12	2020-06-01 09:18:12	09:35 AM	09:35 AM	09:35 AM	65	0	0	\N
439	517	336	1591788136425	2020-06-10	2020-07-10	30	35	\N	0	0	1	2020-06-10 11:22:15	2020-06-10 11:22:15	11:25 AM	11:25 AM	07:30 PM	65	0	0	8:05
442	510	345	1591792080450	2020-06-10	2020-07-10	30	35	\N	0	0	1	2020-06-10 12:27:59	2020-06-10 12:28:56	03:30 PM	12:30 PM	04:30 PM	65	0	0	28:00
373	449	311	1591185275763	2020-06-03	2020-07-03	5	35	\N	0	0	1	2020-06-03 11:54:34	2020-06-03 11:54:34	03:30 PM	11:30 AM	04:30 PM	65	0	0	\N
375	449	311	1591185683046	2020-06-03	2020-07-03	2	35	\N	2	0	1	2020-06-03 12:01:22	2020-06-03 12:01:22	03:30 PM	11:30 AM	04:30 PM	65	1	1	\N
310	388	323	1590638632690	2020-05-28	2020-06-27	20	15	\N	0	0	1	2020-05-28 04:03:51	2020-05-28 04:03:51	10	04:26 PM	09:45 AM	2	0	0	\N
312	388	323	1590641423361	2020-05-28	2020-06-27	10	56	\N	0	0	1	2020-05-28 04:50:23	2020-05-28 04:50:23	09:00 PM	05:00 PM	10:00 PM	44	0	0	\N
377	449	311	1591186165785	2020-06-03	2020-07-03	2	35	\N	2	0	1	2020-06-03 12:09:25	2020-06-03 12:09:25	03:30 PM	11:30 AM	04:30 PM	65	1	1	\N
384	448	312	1591187214897	2020-06-03	2020-07-03	2	35	\N	2	0	1	2020-06-03 12:26:54	2020-06-03 12:26:54	03:30 PM	11:30 AM	04:30 PM	65	1	1	\N
387	449	311	1591187977770	2020-06-03	2020-07-03	3	35	\N	3	0	1	2020-06-03 12:39:37	2020-06-03 12:39:48	03:30 PM	11:30 AM	04:30 PM	65	1	2	\N
389	448	312	1591188154705	2020-06-03	2020-07-03	3	35	\N	3	0	1	2020-06-03 12:42:34	2020-06-03 12:42:34	03:30 PM	11:30 AM	04:30 PM	65	2	1	\N
457	510	345	1592367030080	2020-06-15	2020-07-15	30	35	\N	0	0	1	2020-06-17 04:10:29	2020-06-17 04:10:29	03:30 PM	04:15 AM	04:30 PM	65	0	0	36:15
460	532	368	1594957156238	2020-07-17	2020-08-16	7	66	\N	0	0	1	2020-07-17 03:39:15	2020-07-17 03:39:15	02:00 PM	01:00 PM	03:00 PM	34	0	0	26:00
272	323	301	1590411669467	2020-05-25	2020-06-24	768	35	\N	0	0	1	2020-05-25 01:01:09	2020-05-25 01:01:09	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
235	266	278	1590121129678	2020-05-22	2020-06-21	19	54	\N	0	0	1	2020-05-22 04:18:49	2020-05-22 04:21:04	02:00 PM	09:00 PM	12:00 PM	46	0	0	\N
263	310	307	1590368824523	2020-05-25	2020-06-24	20	49	\N	0	0	1	2020-05-25 01:07:04	2020-05-25 01:08:56	09:00 PM	05:00 PM	10:00 PM	51	0	0	\N
264	307	261	1590387189788	2020-05-25	2020-06-24	41	35	\N	0	0	1	2020-05-25 06:13:09	2020-05-25 06:13:09	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
268	262	268	1590402118011	2020-05-25	2020-06-24	35	35	\N	0	0	1	2020-05-25 10:21:57	2020-05-25 10:21:57	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
400	449	311	1591189467028	2020-06-03	2020-07-03	5	35	\N	0	0	1	2020-06-03 01:04:26	2020-06-03 01:04:26	03:30 PM	11:30 AM	04:30 PM	65	0	0	\N
401	448	312	1591189487486	2020-06-03	2020-07-03	3	35	\N	0	0	1	2020-06-03 01:04:47	2020-06-03 01:04:47	03:30 PM	11:30 AM	04:30 PM	65	0	0	\N
402	449	311	1591189513066	2020-06-03	2020-07-03	6	35	\N	0	0	1	2020-06-03 01:05:12	2020-06-03 01:05:12	03:30 PM	11:30 AM	04:30 PM	65	0	0	\N
403	449	311	1591189548644	2020-06-03	2020-07-03	6	35	\N	0	0	1	2020-06-03 01:05:48	2020-06-03 01:05:48	03:30 PM	11:30 AM	04:30 PM	65	0	0	\N
404	449	311	1591190030366	2020-06-03	2020-07-03	9	35	\N	0	0	1	2020-06-03 01:13:50	2020-06-03 01:13:50	03:30 PM	11:30 AM	04:30 PM	65	0	0	\N
405	449	311	1591190109895	2020-06-03	2020-07-03	57	35	\N	0	0	1	2020-06-03 01:15:09	2020-06-03 01:15:09	03:30 PM	11:30 AM	04:30 PM	65	0	0	\N
406	448	312	1591190178035	2020-06-03	2020-07-03	6	35	\N	0	0	1	2020-06-03 01:16:17	2020-06-03 01:16:17	03:30 PM	11:30 AM	04:30 PM	65	0	0	\N
407	449	311	1591190251408	2020-06-03	2020-07-03	9	35	\N	0	0	1	2020-06-03 01:17:31	2020-06-03 01:17:31	03:30 PM	11:30 AM	04:30 PM	65	0	0	\N
408	449	311	1591190395174	2020-06-03	2020-07-03	20	15	\N	0	0	1	2020-06-03 01:19:54	2020-06-03 01:19:54	10	11:31 AM	09:45 AM	2	0	0	\N
412	449	311	1591190957299	2020-06-03	2020-07-03	20	15	\N	0	0	1	2020-06-03 01:29:17	2020-06-03 01:29:17	10	11:31 AM	09:45 AM	2	0	0	\N
413	449	311	1591190966875	2020-06-03	2020-07-03	20	15	\N	0	0	1	2020-06-03 01:29:26	2020-06-03 01:29:26	10	11:31 AM	09:45 AM	2	0	0	\N
414	449	311	1591190968094	2020-06-03	2020-07-03	20	15	\N	0	0	1	2020-06-03 01:29:27	2020-06-03 01:29:27	10	11:31 AM	09:45 AM	2	0	0	\N
458	527	363	1592567727628	2020-06-19	2020-07-19	30	36	\N	0	0	1	2020-06-19 11:55:26	2020-06-19 12:06:25	03:30 PM	12:20 PM	05:00 PM	64	0	0	28:40
443	521	349	1591864748715	2020-06-11	2020-07-11	30	47	\N	0	0	1	2020-06-11 08:39:08	2020-06-12 10:49:53	03:30 PM	09:30 AM	07:30 PM	53	0	0	10:00
455	510	345	1592310557891	2020-06-12	2020-07-12	30	35	\N	0	0	1	2020-06-16 12:29:17	2020-06-16 12:29:17	03:30 PM	12:30 PM	04:30 PM	65	0	0	28:00
322	409	326	1590739962095	2020-05-29	2020-06-28	20	21	\N	0	0	1	2020-05-29 08:12:41	2020-06-04 02:10:55	10:00 AM	08:40 AM	02:20 PM	79	0	0	\N
432	505	335	1591702189929	2020-06-09	2020-07-09	3	35	\N	0	0	1	2020-06-09 11:29:49	2020-06-09 11:40:52	03:30 PM	11:50 AM	04:30 PM	65	0	0	28:40
446	525	342	1592211735777	2020-06-15	2020-07-15	30	44	\N	0	0	1	2020-06-15 09:02:15	2020-06-19 11:48:17	03:30 PM	09:20 AM	04:30 PM	56	0	0	31:10
433	507	343	1591703411802	2020-06-09	2020-07-09	30	35	\N	0	0	1	2020-06-09 11:50:11	2020-06-09 12:00:21	03:30 PM	12:10 PM	04:30 PM	65	0	0	28:20
431	503	339	1591599900652	2020-06-08	2020-07-08	30	35	\N	0	0	1	2020-06-08 07:05:00	2020-06-09 09:38:59	03:30 PM	09:40 AM	07:30 PM	65	0	0	9:50
\.


--
-- Name: monthly_goals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.monthly_goals_id_seq', 461, true);


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications (id, question, status, create_time, update_time) FROM stdin;
\.


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notifications_id_seq', 1, false);


--
-- Data for Name: pages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pages (id, title, description, status, create_time, update_time) FROM stdin;
4	Where can I get some?	There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.	1	2020-01-14 00:00:00	2020-01-14 00:00:00
1	What is Lorem Ipsum?	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.	0	2020-01-14 00:00:00	2020-01-14 00:00:00
3	Where does it come from?	Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.	0	2020-01-14 00:00:00	2020-05-14 07:08:30
2	Why do we use it?	It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).	0	2020-01-14 00:00:00	2020-05-19 10:25:22
\.


--
-- Name: pages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pages_id_seq', 4, true);


--
-- Data for Name: partner_mappings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.partner_mappings (id, partner_one_id, partner_two_id, status, create_time, update_time, uniqe_id) FROM stdin;
14	60	61	1	2020-04-16 22:53:16	2020-04-16 22:53:16	\N
14	60	61	1	2020-04-16 22:53:16	2020-04-16 22:53:16	\N
1	5	8	1	2020-05-05 06:53:05	2020-05-05 06:53:05	\N
2	8	5	1	2020-05-05 06:58:04	2020-05-05 06:58:04	\N
5	22	4	1	2020-05-05 07:19:42	2020-05-05 07:19:42	\N
6	4	22	1	2020-05-05 07:20:57	2020-05-05 07:20:57	\N
7	27	22	1	2020-05-05 07:24:24	2020-05-05 07:24:24	\N
8	23	22	1	2020-05-05 07:24:47	2020-05-05 07:24:47	\N
9	27	23	1	2020-05-05 07:25:04	2020-05-05 07:25:04	\N
10	23	27	1	2020-05-05 07:25:43	2020-05-05 07:25:43	\N
11	29	27	1	2020-05-05 07:28:23	2020-05-05 07:28:23	\N
12	29	28	1	2020-05-05 07:28:35	2020-05-05 07:28:35	\N
13	28	29	1	2020-05-05 07:29:41	2020-05-05 07:29:41	\N
14	31	30	1	2020-05-05 07:30:58	2020-05-05 07:30:58	\N
15	30	31	1	2020-05-05 07:31:47	2020-05-05 07:31:47	\N
16	32	33	1	2020-05-05 09:24:41	2020-05-05 09:24:41	\N
17	33	32	1	2020-05-05 09:25:42	2020-05-05 09:25:42	\N
18	35	34	1	2020-05-05 09:41:52	2020-05-05 09:41:52	\N
19	34	35	1	2020-05-05 09:42:18	2020-05-05 09:42:18	\N
20	36	37	1	2020-05-05 09:45:42	2020-05-05 09:45:42	\N
21	37	36	1	2020-05-05 09:46:10	2020-05-05 09:46:10	\N
22	38	39	1	2020-05-05 09:48:53	2020-05-05 09:48:53	\N
23	39	38	1	2020-05-05 09:49:04	2020-05-05 09:49:04	\N
24	40	41	1	2020-05-05 10:14:08	2020-05-05 10:14:08	\N
25	41	40	1	2020-05-05 10:14:29	2020-05-05 10:14:29	\N
26	42	43	1	2020-05-05 10:49:37	2020-05-05 10:49:37	\N
27	43	42	1	2020-05-05 10:49:47	2020-05-05 10:49:47	\N
28	45	44	1	2020-05-05 12:14:16	2020-05-05 12:14:16	\N
29	44	45	1	2020-05-05 12:14:35	2020-05-05 12:14:35	\N
30	46	47	1	2020-05-05 12:16:56	2020-05-05 12:16:56	\N
31	47	46	1	2020-05-05 12:17:19	2020-05-05 12:17:19	\N
32	49	48	1	2020-05-05 12:31:44	2020-05-05 12:31:44	\N
33	48	49	1	2020-05-05 12:32:13	2020-05-05 12:32:13	\N
34	50	54	1	2020-05-05 01:04:00	2020-05-05 01:04:00	\N
35	54	50	1	2020-05-05 01:04:08	2020-05-05 01:04:08	\N
36	58	57	1	2020-05-06 12:13:43	2020-05-06 12:13:43	\N
37	57	58	1	2020-05-06 12:13:53	2020-05-06 12:13:53	\N
38	62	59	1	2020-05-06 12:21:06	2020-05-06 12:21:06	\N
39	59	62	1	2020-05-06 12:21:15	2020-05-06 12:21:15	\N
40	64	63	1	2020-05-06 12:32:53	2020-05-06 12:32:53	\N
41	63	64	1	2020-05-06 12:33:01	2020-05-06 12:33:01	\N
42	65	66	1	2020-05-06 12:36:42	2020-05-06 12:36:42	\N
43	66	65	1	2020-05-06 12:36:49	2020-05-06 12:36:49	\N
44	69	70	1	2020-05-06 12:49:14	2020-05-06 12:49:14	\N
45	70	69	1	2020-05-06 12:49:25	2020-05-06 12:49:25	\N
46	71	72	1	2020-05-06 01:00:57	2020-05-06 01:00:57	\N
47	72	71	1	2020-05-06 01:01:31	2020-05-06 01:01:31	\N
48	80	81	1	2020-05-06 01:11:44	2020-05-06 01:11:44	\N
49	81	80	1	2020-05-06 01:11:57	2020-05-06 01:11:57	\N
50	82	83	1	2020-05-06 01:15:39	2020-05-06 01:15:39	\N
51	83	82	1	2020-05-06 01:15:46	2020-05-06 01:15:46	\N
52	85	84	1	2020-05-06 01:19:07	2020-05-06 01:19:07	\N
53	84	85	1	2020-05-06 01:19:18	2020-05-06 01:19:18	\N
54	86	87	1	2020-05-06 01:23:24	2020-05-06 01:23:24	\N
55	87	86	1	2020-05-06 01:23:39	2020-05-06 01:23:39	\N
56	88	89	1	2020-05-06 01:32:25	2020-05-06 01:32:25	\N
57	89	88	1	2020-05-06 01:32:32	2020-05-06 01:32:32	\N
58	91	90	1	2020-05-06 01:35:50	2020-05-06 01:35:50	\N
59	90	91	1	2020-05-06 01:36:02	2020-05-06 01:36:02	\N
60	92	93	1	2020-05-06 01:38:29	2020-05-06 01:38:29	\N
61	93	92	1	2020-05-06 01:38:35	2020-05-06 01:38:35	\N
62	94	95	1	2020-05-06 01:40:44	2020-05-06 01:40:44	\N
63	95	94	1	2020-05-06 01:40:49	2020-05-06 01:40:49	\N
64	99	98	1	2020-05-07 09:51:24	2020-05-07 09:51:24	\N
65	98	99	1	2020-05-07 09:51:48	2020-05-07 09:51:48	\N
66	101	100	1	2020-05-07 10:42:06	2020-05-07 10:42:06	\N
67	100	101	1	2020-05-07 10:42:11	2020-05-07 10:42:11	\N
68	102	103	1	2020-05-07 12:50:34	2020-05-07 12:50:34	\N
69	103	102	1	2020-05-07 12:50:40	2020-05-07 12:50:40	\N
70	104	105	1	2020-05-07 01:02:22	2020-05-07 01:02:22	\N
71	105	104	1	2020-05-07 01:02:27	2020-05-07 01:02:27	\N
72	109	107	1	2020-05-07 01:55:13	2020-05-07 01:55:13	\N
73	107	109	1	2020-05-07 01:55:28	2020-05-07 01:55:28	\N
74	114	113	1	2020-05-07 02:46:15	2020-05-07 02:46:15	\N
75	113	114	1	2020-05-07 02:46:41	2020-05-07 02:46:41	\N
76	117	116	1	2020-05-07 02:59:00	2020-05-07 02:59:00	\N
77	116	117	1	2020-05-07 02:59:06	2020-05-07 02:59:06	\N
78	118	119	1	2020-05-07 03:16:19	2020-05-07 03:16:19	\N
79	119	118	1	2020-05-07 03:16:25	2020-05-07 03:16:25	\N
80	120	121	1	2020-05-07 03:27:45	2020-05-07 03:27:45	\N
81	121	120	1	2020-05-07 03:27:57	2020-05-07 03:27:57	\N
82	123	122	1	2020-05-07 03:29:46	2020-05-07 03:29:46	\N
83	122	123	1	2020-05-07 03:29:53	2020-05-07 03:29:53	\N
84	124	125	1	2020-05-07 04:20:03	2020-05-07 04:20:03	\N
85	125	124	1	2020-05-07 04:20:26	2020-05-07 04:20:26	\N
86	130	128	1	2020-05-07 06:03:09	2020-05-07 06:03:09	\N
87	128	130	1	2020-05-07 06:03:47	2020-05-07 06:03:47	\N
88	132	131	1	2020-05-07 06:16:09	2020-05-07 06:16:09	\N
89	131	132	1	2020-05-07 06:16:46	2020-05-07 06:16:46	\N
90	133	134	1	2020-05-08 05:47:31	2020-05-08 05:47:31	\N
91	134	133	1	2020-05-08 05:47:46	2020-05-08 05:47:46	\N
92	135	136	1	2020-05-08 06:31:02	2020-05-08 06:31:02	\N
93	136	135	1	2020-05-08 06:31:08	2020-05-08 06:31:08	\N
94	138	137	1	2020-05-08 06:37:54	2020-05-08 06:37:54	\N
95	137	138	1	2020-05-08 06:38:00	2020-05-08 06:38:00	\N
96	141	139	1	2020-05-08 07:14:05	2020-05-08 07:14:05	\N
97	139	141	1	2020-05-08 07:14:10	2020-05-08 07:14:10	\N
98	140	142	1	2020-05-08 11:01:26	2020-05-08 11:01:26	\N
99	142	140	1	2020-05-08 11:01:37	2020-05-08 11:01:37	\N
100	144	143	1	2020-05-08 11:13:01	2020-05-08 11:13:01	\N
101	143	144	1	2020-05-08 11:13:09	2020-05-08 11:13:09	\N
102	146	145	1	2020-05-08 12:53:31	2020-05-08 12:53:31	\N
103	145	146	1	2020-05-08 12:53:56	2020-05-08 12:53:56	\N
104	148	147	1	2020-05-08 01:03:52	2020-05-08 01:03:52	\N
105	147	148	1	2020-05-08 01:04:01	2020-05-08 01:04:01	\N
106	150	149	1	2020-05-08 01:26:25	2020-05-08 01:26:25	\N
107	149	150	1	2020-05-08 01:26:36	2020-05-08 01:26:36	\N
108	152	151	1	2020-05-08 01:34:05	2020-05-08 01:34:05	\N
109	151	152	1	2020-05-08 01:34:17	2020-05-08 01:34:17	\N
110	153	154	1	2020-05-08 01:38:11	2020-05-08 01:38:11	\N
111	154	153	1	2020-05-08 01:38:22	2020-05-08 01:38:22	\N
112	155	156	1	2020-05-08 01:42:03	2020-05-08 01:42:03	\N
113	156	155	1	2020-05-08 01:42:10	2020-05-08 01:42:10	\N
114	157	158	1	2020-05-08 02:22:47	2020-05-08 02:22:47	\N
115	158	157	1	2020-05-08 02:23:25	2020-05-08 02:23:25	\N
517	336	337	1	2020-06-10 11:21:30	2020-06-10 11:21:30	PbQ2dZWy4QZCy5VjmHXeSwO1yLJmMu
516	337	336	1	2020-06-10 11:21:21	2020-06-10 11:21:21	PbQ2dZWy4QZCy5VjmHXeSwO1yLJmMu
118	160	159	1	2020-05-09 09:06:20	2020-05-09 09:06:20	\N
119	159	160	1	2020-05-09 09:06:25	2020-05-09 09:06:25	\N
120	162	161	1	2020-05-09 09:09:28	2020-05-09 09:09:28	\N
121	161	162	1	2020-05-09 09:09:35	2020-05-09 09:09:35	\N
122	164	163	1	2020-05-09 10:08:06	2020-05-09 10:08:06	\N
123	163	164	1	2020-05-09 10:08:40	2020-05-09 10:08:40	\N
124	166	165	1	2020-05-09 10:17:47	2020-05-09 10:17:47	\N
125	165	166	1	2020-05-09 10:18:05	2020-05-09 10:18:05	\N
126	168	167	1	2020-05-09 10:29:44	2020-05-09 10:29:44	\N
127	167	168	1	2020-05-09 10:30:02	2020-05-09 10:30:02	\N
128	170	169	1	2020-05-09 10:33:40	2020-05-09 10:33:40	\N
129	169	170	1	2020-05-09 10:33:48	2020-05-09 10:33:48	\N
130	189	183	1	2020-05-13 01:39:16	2020-05-13 01:39:16	\N
131	183	189	1	2020-05-13 01:39:21	2020-05-13 01:39:21	\N
132	191	190	1	2020-05-13 01:52:10	2020-05-13 01:52:10	\N
133	190	191	1	2020-05-13 01:52:22	2020-05-13 01:52:22	\N
134	193	192	1	2020-05-13 01:57:04	2020-05-13 01:57:04	\N
135	192	193	1	2020-05-13 01:57:10	2020-05-13 01:57:10	\N
136	196	195	1	2020-05-13 02:16:41	2020-05-13 02:16:41	\N
137	195	196	1	2020-05-13 02:17:11	2020-05-13 02:17:11	\N
138	198	197	1	2020-05-13 02:20:15	2020-05-13 02:20:15	\N
139	197	198	1	2020-05-13 02:20:22	2020-05-13 02:20:22	\N
140	200	199	1	2020-05-14 04:20:59	2020-05-14 04:20:59	\N
141	199	200	1	2020-05-14 04:21:17	2020-05-14 04:21:17	\N
142	202	201	1	2020-05-14 04:25:17	2020-05-14 04:25:17	\N
143	201	202	1	2020-05-14 04:25:34	2020-05-14 04:25:34	\N
144	204	203	1	2020-05-14 04:28:51	2020-05-14 04:28:51	\N
145	203	204	1	2020-05-14 04:29:05	2020-05-14 04:29:05	\N
146	205	206	1	2020-05-14 04:52:54	2020-05-14 04:52:54	\N
147	206	205	1	2020-05-14 04:53:00	2020-05-14 04:53:00	\N
148	208	209	1	2020-05-14 05:16:45	2020-05-14 05:16:45	\N
149	209	208	1	2020-05-14 05:16:52	2020-05-14 05:16:52	\N
150	211	210	1	2020-05-14 05:19:55	2020-05-14 05:19:55	\N
151	210	211	1	2020-05-14 05:20:05	2020-05-14 05:20:05	\N
152	214	213	1	2020-05-14 06:28:26	2020-05-14 06:28:26	\N
153	213	214	1	2020-05-14 06:28:32	2020-05-14 06:28:32	\N
154	216	215	1	2020-05-14 06:32:12	2020-05-14 06:32:12	\N
155	215	216	1	2020-05-14 06:32:20	2020-05-14 06:32:20	\N
156	218	217	1	2020-05-14 08:46:03	2020-05-14 08:46:03	\N
157	217	218	1	2020-05-14 08:46:09	2020-05-14 08:46:09	\N
262	268	267	1	2020-05-21 07:14:30	2020-05-21 07:14:30	\N
263	267	268	1	2020-05-21 07:14:35	2020-05-21 07:14:35	\N
266	278	280	1	2020-05-22 04:16:21	2020-05-22 04:16:21	\N
267	280	278	1	2020-05-22 04:18:20	2020-05-22 04:18:20	\N
432	319	320	1	2020-06-01 09:17:29	2020-06-01 09:17:29	j4XPrwBWFXS0HvCa45xbL4AEF5LOl6
433	320	319	1	2020-06-01 09:17:37	2020-06-01 09:17:37	j4XPrwBWFXS0HvCa45xbL4AEF5LOl6
180	244	240	1	2020-05-14 06:08:34	2020-05-14 06:08:34	\N
181	240	244	1	2020-05-14 06:08:41	2020-05-14 06:08:41	\N
184	247	246	1	2020-05-14 06:27:41	2020-05-14 06:27:41	\N
185	246	247	1	2020-05-14 06:27:52	2020-05-14 06:27:52	\N
448	312	311	1	2020-06-01 01:26:47	2020-06-01 01:26:47	jPGR5aNjlDVAM8OeCX8D7xXhcZ58Re
449	311	312	1	2020-06-01 01:27:16	2020-06-01 01:27:16	jPGR5aNjlDVAM8OeCX8D7xXhcZ58Re
306	264	261	1	2020-05-23 10:32:05	2020-05-23 10:32:05	\N
307	261	264	1	2020-05-23 10:32:14	2020-05-23 10:32:14	\N
310	307	289	1	2020-05-25 01:05:31	2020-05-25 01:05:31	\N
311	289	307	1	2020-05-25 01:06:29	2020-05-25 01:06:29	\N
388	323	324	1	2020-05-28 03:58:01	2020-05-28 03:58:01	MlFgzOyUvTRcj931x88nFMEg2wl9g7
389	324	323	1	2020-05-28 03:58:20	2020-05-28 03:58:20	MlFgzOyUvTRcj931x88nFMEg2wl9g7
234	255	256	1	2020-05-18 01:00:46	2020-05-18 01:00:46	\N
235	256	255	1	2020-05-18 01:00:51	2020-05-18 01:00:51	\N
322	302	301	1	2020-05-25 01:00:44	2020-05-25 01:00:44	UVmhcodU11juMlMWqMwiogfH5SJ4s3
323	301	302	1	2020-05-25 01:00:54	2020-05-25 01:00:54	UVmhcodU11juMlMWqMwiogfH5SJ4s3
242	254	249	1	2020-05-19 12:53:01	2020-05-19 12:53:01	\N
243	249	254	1	2020-05-19 12:53:05	2020-05-19 12:53:05	\N
409	325	326	1	2020-05-29 08:11:05	2020-05-29 08:11:05	UuYFszHp4wAJ9yDEFVPKuCCxJfFB02
410	326	325	1	2020-05-29 08:11:35	2020-05-29 08:11:35	UuYFszHp4wAJ9yDEFVPKuCCxJfFB02
414	328	327	1	2020-05-29 10:16:42	2020-05-29 10:16:42	WYmCL6Zf6oyNHd81LCIufctJ78MiMB
415	327	328	1	2020-05-29 10:17:03	2020-05-29 10:17:03	WYmCL6Zf6oyNHd81LCIufctJ78MiMB
500	126	275	1	2020-06-05 04:51:12	2020-06-05 04:51:12	p0sB584b4YIDHDDSq7PdwarIoXDaVE
501	275	126	1	2020-06-05 04:51:26	2020-06-05 04:51:26	p0sB584b4YIDHDDSq7PdwarIoXDaVE
502	340	339	1	2020-06-08 07:03:47	2020-06-08 07:03:47	DCgIYik24PBONO08M9gPkF19m585z8
503	339	340	1	2020-06-08 07:03:54	2020-06-08 07:03:54	DCgIYik24PBONO08M9gPkF19m585z8
504	334	335	1	2020-06-09 11:29:08	2020-06-09 11:29:08	UWvEbo0wjgQtdVMqUJyXJXXT9nPIaj
505	335	334	1	2020-06-09 11:29:16	2020-06-09 11:29:16	UWvEbo0wjgQtdVMqUJyXJXXT9nPIaj
506	344	343	1	2020-06-09 11:49:41	2020-06-09 11:49:41	XQPEcnXewoTb0nnCXWzyVsn5YCVw86
507	343	344	1	2020-06-09 11:49:48	2020-06-09 11:49:48	XQPEcnXewoTb0nnCXWzyVsn5YCVw86
510	345	346	1	2020-06-10 10:06:13	2020-06-10 10:06:13	grVxm0nYGHjTC3tJ2wjVoApd0ltkBi
511	346	345	1	2020-06-10 10:06:25	2020-06-10 10:06:25	grVxm0nYGHjTC3tJ2wjVoApd0ltkBi
520	349	348	1	2020-06-11 08:38:19	2020-06-11 08:38:19	OlEKtVfgZf0oqbavMMyPdMlno1rVIB
521	348	349	1	2020-06-11 08:38:20	2020-06-11 08:38:20	OlEKtVfgZf0oqbavMMyPdMlno1rVIB
524	342	341	1	2020-06-15 09:01:15	2020-06-15 09:01:15	uIzVYL1vieZiYEPKUJy1CSbHm6WEqA
525	341	342	1	2020-06-15 09:01:28	2020-06-15 09:01:28	uIzVYL1vieZiYEPKUJy1CSbHm6WEqA
526	363	362	1	2020-06-19 11:54:45	2020-06-19 11:54:45	ARA6Pc71FJcppjieMUDx91OvJNainf
527	362	363	1	2020-06-19 11:55:01	2020-06-19 11:55:01	ARA6Pc71FJcppjieMUDx91OvJNainf
530	366	127	1	2020-07-14 04:13:21	2020-07-14 04:13:21	\N
531	366	367	1	2020-07-14 04:19:59	2020-07-14 04:19:59	\N
532	368	366	1	2020-07-17 03:36:24	2020-07-17 03:36:24	lZIYrQBL6poQ3jZvaMTGLmRo5h9gMy
\.


--
-- Name: partner_mappings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.partner_mappings_id_seq', 532, true);


--
-- Data for Name: quickies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quickies (id, user_id, partner_mapping_id, partner_response, "when", "where", create_time, update_time, partner1_intrest, partner2_intrest, partner1_answer1, partner1_answer2, partner2_answer1, partner2_answer2, contribution) FROM stdin;
58	249	224	\N	10:00 AM	xhchchfh	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
43	249	225	t	10:25 AM	Dfgbdigigjvibic	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
3	249	224	\N	10:00 AM	Szdfdf	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
4	249	224	\N	10:00 AM	Szdfdf	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
5	249	224	\N	10:00 AM		2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
6	249	224	\N	10:00 AM		2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
7	249	224	\N	10:00 AM		2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
8	249	224	\N	10:00 AM		2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
9	249	224	\N	10:00 AM		2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
10	249	224	\N	10:00 AM		2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
12	254	225	\N	10:00 AM	Asdfsadas	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
13	254	225	\N	10:00 AM	Sdfdsfdsf	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
14	254	225	\N	10:00 AM	Sdasdasd	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
15	254	225	\N	10:00 AM	Jkhnjkhn	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
16	254	225	\N	10:00 AM	Dszfszf	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
17	254	225	\N	10:00 AM	Dszfszf	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
18	254	225	\N	10:00 AM	Gsg	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
19	254	225	\N	10:00 AM	Dzgvdxgv	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
20	254	225	\N	10:00 AM	Sfazfzf	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
21	254	225	\N	10:00 AM	Dgsxg	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
22	254	225	\N	10:00 AM	Szfszfzf	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
23	254	225	\N	10:00 AM	Asfasfa	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
24	254	225	\N	10:00 AM	Sgdsgdxg	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
25	254	225	\N	10:00 AM	Sdegsdzg	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
26	254	225	\N	10:00 AM	Asfasf	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
27	254	225	\N	10:00 AM	Sfgsfg	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
28	254	225	\N	10:00 AM	Dszfsdgsdg	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
29	254	225	\N	10:00 AM	Sgsdg	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
30	254	225	\N	10:00 AM	Sfsf	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
31	254	225	\N	10:00 AM	Fszfs	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
32	254	225	\N	10:00 AM	Zdzfszf	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
33	254	225	\N	08:10 PM	Sdfgsfgdsgdsgs	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
34	51	226	\N	Master Room	10:12 PM	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
35	254	225	\N	10:00 AM	Esdxgsdg	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
36	254	225	\N	10:00 AM	Dgdfgd	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
2	51	226	t	Master	12:29 PM	2020-05-16 08:23:34	2020-05-28 12:12:33	t	\N	\N	\N	\N	\N	\N
59	249	224	\N	10:00 AM	hjcjgjv	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
60	249	224	\N	10:00 AM	xhfhfjv	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
61	249	224	\N	10:00 AM	chfhjgj	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
62	249	224	\N	10:00 AM	xhfhfjvj	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
63	249	224	\N	10:00 AM	hfjgj	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
44	249	225	t	10:00 AM	Dgdghjjk	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
45	249	225	t	10:20 AM	Fgdfg	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
38	254	225	\N	10:00 AM	Dfghdfcgd	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
64	249	224	\N	10:00 AM	chfjv	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
65	249	224	\N	10:00 AM	hfjgjgjgj	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
66	249	224	\N	10:00 AM	chfjgjv	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
77	254	224	f	10:00 AM	gugjg	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
39	254	225	\N	10:00 AM	Sdgdsxg	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
41	254	225	\N	10:00 AM	Fhbcd	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
42	254	225	\N	10:00 AM	Sgdg	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
67	249	224	\N	10:00 AM	hgjvjv	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
68	249	224	\N	10:00 AM	jgjvjv	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
46	249	225	t	10:05 AM	Vjbkkbmnlnln	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
47	249	224	\N	10:00 AM	Scacac	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
48	249	224	\N	10:00 AM	Dbsbsvs	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
49	249	224	\N	10:00 AM	Dzbsbbsbsbsbsbdndndndndndndndndn	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
50	254	225	\N	10:00 AM	xhchggjihi	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
51	254	224	f	10:00 AM	Sbwbsbs	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
69	254	225	\N	10:00 AM	jvuvu	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
70	249	224	\N	10:00 AM	ghhjkk	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
71	249	224	\N	10:00 AM	gugugu	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
52	254	224	t	10:15 AM	Rhrhehehxjgjgjgjvjgjgugjgjg	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
72	249	224	f	10:00 AM	uguvjbjb	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
53	254	224	t	10:00 AM	xfhfhfu	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
73	249	224	f	10:00 AM	ugyugjg	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
54	254	224	f	10:00 AM	fhjfhf	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
55	249	224	\N	10:00 AM	chfhfjfj	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
56	249	224	\N	10:00 AM	fhfhfjf	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
57	249	224	\N	10:00 AM	vcchg	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
74	51	226	\N	Master Room	10:12 PM	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
78	249	224	\N	10:00 AM	jgjgjg	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
37	51	225	f	Master	10:12 PM	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
75	249	224	\N	10:00 AM	Hsjjs	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
76	249	225	f	10:00 AM	Bsjjs	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
79	254	224	f	10:00 AM	gugug	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
80	254	224	f	10:00 AM	gigjbih	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
81	249	224	\N	10:00 AM	gugugjg	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
82	249	225	f	10:00 AM	Jxjjs	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
83	254	225	\N	10:00 AM	Jxjjs	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
84	249	225	f	10:00 AM	Igvjb	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
85	249	225	t	10:00 AM	Igvjb	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
86	249	225	t	10:00 AM	Igvjb	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
87	249	225	f	10:00 AM	Igvjb	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
88	249	225	f	10:00 AM	Hsjjs	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
89	249	225	t	10:00 AM	Hsjjs	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
1	268	226	t	Master	10:12 PM	2020-05-15 02:03:35	2020-05-20 09:36:44	\N	\N	\N	\N	\N	\N	\N
11	254	225	\N	10:00 AM	Asasfaf	2020-05-16 08:23:34	2020-05-29 11:54:42	\N	\N	\N	\N	t	t	\N
40	52	225	t	10:11 AM	03:50 AM	2020-05-16 08:23:34	2020-06-04 09:51:11	\N	\N	\N	\N	\N	\N	\N
90	249	225	t	10:00 AM	Hsjjsvjvkbi	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
91	249	225	f	10:00 AM	Hsjjsvjvkbi	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
92	249	225	f	10:00 AM	Jdjdk	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
93	255	233	f	10:00 AM	Hjgjg	2020-05-18 10:16:20	2020-05-18 10:16:20	\N	\N	\N	\N	\N	\N	\N
94	256	234	f	03:25 AM	Hsjjs	2020-05-18 01:14:03	2020-05-18 01:14:03	\N	\N	\N	\N	\N	\N	\N
95	256	234	t	03:25 AM	Hsjjs	2020-05-18 01:14:03	2020-05-18 01:14:03	\N	\N	\N	\N	\N	\N	\N
96	256	234	t	07:25 AM	Hsjjsvjvkbk	2020-05-18 01:14:03	2020-05-18 01:14:03	\N	\N	\N	\N	\N	\N	\N
97	256	234	f	07:25 AM	Hsjjsvjvkbkjvvjv	2020-05-18 01:14:03	2020-05-18 01:14:03	\N	\N	\N	\N	\N	\N	\N
98	256	234	f	01:25 AM	Hsjjsvjvkbkjvvjv	2020-05-18 01:14:03	2020-05-18 01:14:03	\N	\N	\N	\N	\N	\N	\N
99	256	234	f	01:25 AM	Hsjjsvjvkbkjvvjv	2020-05-18 01:14:03	2020-05-18 01:14:03	\N	\N	\N	\N	\N	\N	\N
100	256	234	t	05:25 AM	Hsjjsvjv	2020-05-18 01:14:03	2020-05-18 01:14:03	\N	\N	\N	\N	\N	\N	\N
101	256	234	t	05:25 AM	Hsjjsvjv	2020-05-18 01:14:03	2020-05-18 01:14:03	\N	\N	\N	\N	\N	\N	\N
102	256	234	t	05:25 AM	Hsjjsvjv	2020-05-18 01:14:03	2020-05-18 01:14:03	\N	\N	\N	\N	\N	\N	\N
103	256	234	t	07:25 AM	Hsjjsvjv	2020-05-18 01:14:03	2020-05-18 01:14:03	\N	\N	\N	\N	\N	\N	\N
104	256	234	f	04:25 AM	Hsjjsvjv	2020-05-18 01:14:03	2020-05-18 01:14:03	\N	\N	\N	\N	\N	\N	\N
105	255	234	\N	08:25 AM	Hsjjsvjv	2020-05-18 01:14:03	2020-05-18 01:14:03	\N	\N	\N	\N	\N	\N	\N
106	264	255	\N	Master Room	10:12 PM	2020-05-20 05:26:05	2020-05-20 05:26:05	\N	\N	\N	\N	\N	\N	\N
107	52	227	\N	Master Room	10:12 PM	2020-05-20 06:52:10	2020-05-20 06:52:10	\N	\N	\N	\N	\N	\N	\N
108	267	259	f	10:00 AM	Hsjjs	2020-05-20 07:32:36	2020-05-20 07:32:36	\N	\N	\N	\N	\N	\N	\N
109	268	258	t	03:25 AM	ygygug	2020-05-20 09:36:44	2020-05-20 09:36:44	\N	\N	\N	\N	\N	\N	\N
110	267	259	t	03:35 PM	Gjvkbkb	2020-05-20 09:36:44	2020-05-20 09:36:44	\N	\N	\N	\N	\N	\N	\N
111	267	259	t	03:45 AM	Gugkbln	2020-05-20 09:36:44	2020-05-20 09:36:44	\N	\N	\N	\N	\N	\N	\N
112	267	258	\N	10:00 AM	vjbu	2020-05-20 10:15:50	2020-05-20 10:15:50	\N	\N	\N	\N	\N	\N	\N
113	268	258	t	12:00 AM	igibi	2020-05-20 10:15:50	2020-05-20 10:15:50	\N	\N	\N	\N	\N	\N	\N
114	267	258	\N	12:00 AM	igibi	2020-05-20 10:15:50	2020-05-20 10:15:50	\N	\N	\N	\N	\N	\N	\N
115	268	258	t	10:00 AM	uguguhih	2020-05-20 10:15:50	2020-05-20 10:15:50	\N	\N	\N	\N	\N	\N	\N
116	267	259	t	10:00 AM	jgjbjb	2020-05-20 10:15:50	2020-05-20 10:15:50	\N	\N	\N	\N	\N	\N	\N
117	267	259	t	10:00 AM	ubuhuh	2020-05-20 10:15:50	2020-05-20 10:15:50	\N	\N	\N	\N	\N	\N	\N
118	267	259	t	10:00 AM	jvhvjvu	2020-05-20 10:15:50	2020-05-20 10:15:50	\N	\N	\N	\N	\N	\N	\N
119	267	259	t	10:00 AM	hvuv	2020-05-20 10:15:50	2020-05-20 10:15:50	\N	\N	\N	\N	\N	\N	\N
120	268	258	t	10:00 AM	Fff	2020-05-20 10:15:50	2020-05-20 10:15:50	\N	\N	\N	\N	\N	\N	\N
121	257	256	\N	10:00 AM	Hdhbdjdhd	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
122	257	256	\N	10:00 AM	Hdhbdjdhd	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
123	126	264	\N	10:00 AM	Home	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
124	257	256	\N	01:00 AM	     	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
125	266	256	f	01:00 AM	@	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
126	266	256	t	02:00 AM	@	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
127	266	256	f	02:00 AM	@	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
128	257	257	f	10:00 AM	T	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
129	257	256	\N	10:00 AM	Test	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
130	261	254	\N	10:00 AM	 	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
131	261	254	\N	10:00 AM	 	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
132	261	254	\N	10:00 AM	 Faesfa	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
133	280	267	\N	10:00 AM	Bathroom	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
134	280	267	\N	10:00 AM	Bathroom	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
135	280	267	\N	11:00 AM	Bathroom	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
136	278	266	\N	12:00 AM	Vath	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
137	261	254	\N	10:14 AM	Kjk	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
138	261	254	\N	11:19 AM	Adcfadsf	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
139	261	254	\N	11:19 AM	Sdfds	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
140	261	254	\N	12:00 AM	Rgg	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
141	261	271	\N	12:32 PM	Sfsf	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
142	289	275	\N	10:00 AM	T	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
143	289	275	\N	12:00 AM	T	2020-05-22 08:52:23	2020-05-22 08:52:23	\N	\N	\N	\N	\N	\N	\N
144	285	276	\N	10:00 AM	Flat	2020-05-22 08:52:23	2020-05-22 08:52:23	\N	\N	\N	\N	\N	\N	\N
145	285	276	\N	12:00 AM	Flat	2020-05-22 08:52:23	2020-05-22 08:52:23	\N	\N	\N	\N	\N	\N	\N
146	285	276	\N	12:00 AM	Flat	2020-05-22 08:52:23	2020-05-22 08:52:23	\N	\N	\N	\N	\N	\N	\N
147	285	276	\N	12:00 AM	Flat	2020-05-22 08:52:23	2020-05-22 08:52:23	\N	\N	\N	\N	\N	\N	\N
148	293	277	\N	10:00 AM	Flat	2020-05-22 08:52:23	2020-05-22 08:52:23	\N	\N	\N	\N	\N	\N	\N
149	285	276	\N	12:00 AM	Flat	2020-05-22 08:52:23	2020-05-22 08:52:23	\N	\N	\N	\N	\N	\N	\N
150	285	276	\N	01:00 AM	Flat	2020-05-22 08:52:23	2020-05-22 08:52:23	\N	\N	\N	\N	\N	\N	\N
151	285	276	\N	01:00 AM	Flat	2020-05-22 08:52:23	2020-05-22 08:52:23	\N	\N	\N	\N	\N	\N	\N
152	52	227	\N	Master Room	10:12 PM	2020-05-22 10:17:43	2020-05-22 10:17:43	\N	\N	\N	\N	\N	\N	\N
153	257	257	f	01:00 AM	Flat	2020-05-22 10:17:43	2020-05-22 10:17:43	\N	\N	\N	\N	\N	\N	\N
154	266	256	f	10:00 AM	Test	2020-05-22 10:17:43	2020-05-22 10:17:43	\N	\N	\N	\N	\N	\N	\N
155	266	256	t	01:00 AM	Testhuuh	2020-05-22 10:17:43	2020-05-22 10:17:43	\N	\N	\N	\N	\N	\N	\N
156	257	256	\N	01:00 AM	Testhuuh	2020-05-22 10:17:43	2020-05-22 10:17:43	\N	\N	\N	\N	\N	\N	\N
157	264	291	t	10:00 AM	Efreawrghjh	2020-05-22 10:17:43	2020-05-22 10:17:43	\N	\N	\N	\N	\N	\N	\N
158	264	291	f	10:00 AM	Sdfs	2020-05-22 10:17:43	2020-05-22 10:17:43	\N	\N	\N	\N	\N	\N	\N
159	261	290	f	10:00 AM	Jkgh	2020-05-22 10:17:43	2020-05-22 10:17:43	\N	\N	\N	\N	\N	\N	\N
161	289	293	\N	10:00 AM	F	2020-05-22 10:17:43	2020-05-22 10:17:43	\N	\N	\N	\N	\N	\N	\N
160	298	293	f	10:00 AM	F	2020-05-22 10:17:43	2020-05-22 10:17:43	\N	\N	\N	\N	\N	\N	\N
162	298	293	t	10:00 AM	Fa	2020-05-22 10:17:43	2020-05-22 10:17:43	\N	\N	\N	\N	\N	\N	\N
163	298	293	t	10:00 AM	Fa	2020-05-22 10:17:43	2020-05-22 10:17:43	\N	\N	\N	\N	\N	\N	\N
164	298	293	t	10:00 AM	Fa	2020-05-22 10:17:43	2020-05-22 10:17:43	\N	\N	\N	\N	\N	\N	\N
165	298	293	t	10:00 AM	Faa	2020-05-22 10:17:43	2020-05-22 10:17:43	\N	\N	\N	\N	\N	\N	\N
166	298	293	t	10:00 AM	Faa	2020-05-22 10:17:43	2020-05-22 10:17:43	\N	\N	\N	\N	\N	\N	\N
167	298	293	t	10:00 AM	Faa	2020-05-22 10:17:43	2020-05-22 10:17:43	\N	\N	\N	\N	\N	\N	\N
168	298	293	t	10:00 AM	Faa	2020-05-22 10:17:43	2020-05-22 10:17:43	\N	\N	\N	\N	\N	\N	\N
169	298	293	t	10:00 AM	Faa	2020-05-22 10:17:43	2020-05-22 10:17:43	\N	\N	\N	\N	\N	\N	\N
170	298	293	t	10:00 AM	Faa	2020-05-22 10:17:43	2020-05-22 10:17:43	\N	\N	\N	\N	\N	\N	\N
171	298	293	t	10:00 AM	Faa	2020-05-22 10:17:43	2020-05-22 10:17:43	\N	\N	\N	\N	\N	\N	\N
172	289	293	\N	10:00 AM	Faa	2020-05-22 01:16:18	2020-05-22 01:16:18	\N	\N	\N	\N	\N	\N	\N
173	261	295	\N	10:00 AM	Dfsdf	2020-05-22 01:16:18	2020-05-22 01:16:18	\N	\N	\N	\N	\N	\N	\N
174	261	295	\N	10:00 AM	Fdeaf	2020-05-22 01:16:18	2020-05-22 01:16:18	\N	\N	\N	\N	\N	\N	\N
175	289	298	t	10:00 AM	Q	2020-05-22 04:20:34	2020-05-22 04:20:34	\N	\N	\N	\N	\N	\N	\N
176	289	298	f	10:00 AM	Q	2020-05-22 04:20:34	2020-05-22 04:20:34	\N	\N	\N	\N	\N	\N	\N
177	289	298	f	10:00 AM	Q	2020-05-22 04:20:34	2020-05-22 04:20:34	\N	\N	\N	\N	\N	\N	\N
179	300	298	\N	10:00 AM	Bathroom	2020-05-22 04:20:34	2020-05-22 04:20:34	\N	\N	\N	\N	\N	\N	\N
178	289	298	f	10:00 AM	Q	2020-05-22 04:20:34	2020-05-22 04:20:34	\N	\N	\N	\N	\N	\N	\N
180	289	298	t	10:00 AM	Bathroom	2020-05-22 04:20:34	2020-05-22 04:20:34	\N	\N	\N	\N	\N	\N	\N
181	289	298	t	10:00 AM	Bathroom	2020-05-22 04:20:34	2020-05-22 04:20:34	\N	\N	\N	\N	\N	\N	\N
182	266	256	t	10:00 AM	Ths	2020-05-22 04:20:34	2020-05-22 04:20:34	\N	\N	\N	\N	\N	\N	\N
183	261	296	f	10:00 AM	rcrcr	2020-05-22 04:20:34	2020-05-22 04:20:34	\N	\N	\N	\N	\N	\N	\N
184	261	296	t	11:00 AM	jfhg	2020-05-22 04:20:34	2020-05-22 04:20:34	\N	\N	\N	\N	\N	\N	\N
185	261	296	f	10:00 AM	jvkvkg	2020-05-22 04:20:34	2020-05-22 04:20:34	\N	\N	\N	\N	\N	\N	\N
196	289	310	t	10:00 AM	U	2020-05-23 09:56:11	2020-05-23 09:56:11	\N	\N	\N	\N	\N	\N	\N
186	264	296	f	10:00 AM	vjgigkhkb	2020-05-22 04:20:34	2020-05-22 04:20:34	\N	\N	\N	\N	\N	\N	\N
187	264	296	t	11:00 AM	gugih	2020-05-22 04:20:34	2020-05-22 04:20:34	\N	\N	\N	\N	\N	\N	\N
188	301	305	f	09:05 AM	Vjgjg	2020-05-22 04:20:34	2020-05-22 04:20:34	\N	\N	\N	\N	\N	\N	\N
189	302	304	t	04:00 AM	vjvjh	2020-05-22 04:20:34	2020-05-22 04:20:34	\N	\N	\N	\N	\N	\N	\N
190	302	305	t	08:00 AM	Hfjfughh	2020-05-22 04:20:34	2020-05-22 04:20:34	\N	\N	\N	\N	\N	\N	\N
191	301	304	f	09:00 AM	jhihi	2020-05-22 04:20:34	2020-05-22 04:20:34	\N	\N	\N	\N	\N	\N	\N
192	301	305	t	10:00 AM	Igjgj	2020-05-22 04:20:34	2020-05-22 04:20:34	\N	\N	\N	\N	\N	\N	\N
193	301	305	f	10:00 AM	Hchfhv	2020-05-22 04:20:34	2020-05-22 04:20:34	\N	\N	\N	\N	\N	\N	\N
197	308	313	f	10:00 AM	Bathroom	2020-05-23 09:56:11	2020-05-23 09:56:11	\N	\N	\N	\N	\N	\N	\N
194	302	305	t	08:00 AM	Gjgjhhjjk	2020-05-22 04:20:34	2020-05-22 04:20:34	\N	\N	\N	\N	\N	\N	\N
195	289	310	t	10:00 AM	T	2020-05-23 09:56:11	2020-05-23 09:56:11	\N	\N	\N	\N	\N	\N	\N
215	312	333	t	11:00 AM	jgjghcghjj	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
199	308	316	\N	10:00 AM	Hyfb	2020-05-23 09:56:11	2020-05-23 09:56:11	\N	\N	\N	\N	\N	\N	\N
198	308	313	t	10:00 AM	Bathroom	2020-05-23 09:56:11	2020-05-23 09:56:11	\N	\N	\N	\N	\N	\N	\N
200	266	316	t	10:00 AM	Sff	2020-05-23 09:56:11	2020-05-23 09:56:11	\N	\N	\N	\N	\N	\N	\N
201	308	317	t	10:00 AM	Changes	2020-05-23 09:56:11	2020-05-23 09:56:11	\N	\N	\N	\N	\N	\N	\N
202	313	326	t	10:00 AM	E	2020-05-25 01:48:57	2020-05-25 01:48:57	\N	\N	\N	\N	\N	\N	\N
203	309	327	f	10:00 AM	T	2020-05-25 01:48:57	2020-05-25 01:48:57	\N	\N	\N	\N	\N	\N	\N
204	309	327	f	10:00 AM	G	2020-05-25 01:48:57	2020-05-25 01:48:57	\N	\N	\N	\N	\N	\N	\N
216	312	333	t	11:00 AM	jgjghcghjj	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
205	309	326	t	10:00 AM	Rr	2020-05-25 01:48:57	2020-05-25 01:48:57	\N	\N	\N	\N	\N	\N	\N
206	51	226	\N	12:10 AM	Vhk	2020-05-25 01:48:57	2020-05-25 01:48:57	\N	\N	\N	\N	\N	\N	\N
207	51	226	t	12:35 AM	Njs	2020-05-26 10:23:35	2020-05-26 10:23:35	\N	\N	\N	\N	\N	\N	\N
208	314	328	\N	10:00 AM	Test	2020-05-26 10:23:35	2020-05-26 10:23:35	\N	\N	\N	\N	\N	\N	\N
209	285	328	f	10:00 AM	Thf	2020-05-26 10:23:35	2020-05-26 10:23:35	\N	\N	\N	\N	\N	\N	\N
210	314	331	f	10:00 AM	Hcfv	2020-05-26 10:23:35	2020-05-26 10:23:35	\N	\N	\N	\N	\N	\N	\N
211	314	328	t	12:00 AM	Ghh CC cdsy	2020-05-26 10:23:35	2020-05-26 10:23:35	\N	\N	\N	\N	\N	\N	\N
212	311	332	f	10:00 AM	Hkjhkjh	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
213	311	332	t	10:00 AM	jgjgjvj	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
217	312	333	f	10:00 AM	Hfhfj	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
214	312	332	f	11:00 AM	jgjghc	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
218	312	333	t	10:00 AM	Hfhfjhfhdjf	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
219	312	333	f	10:00 AM	Xnndk	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
220	312	333	t	10:00 AM	Xnndkjdjdjd	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
221	311	332	f	10:00 AM	jgjjgjv	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
222	311	332	f	10:00 AM	igibjv	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
223	311	332	f	10:00 AM	ugigjgjg	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
224	311	332	f	10:00 AM	gugkhk	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
225	311	332	t	08:00 AM	gugkhkhhjjkkk	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
226	311	332	f	10:00 AM	nvjgjg	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
227	312	333	f	10:00 AM	Jsjsj	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
228	312	333	t	09:00 AM	Jsjsjhzbbs	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
229	311	332	f	10:00 AM	fhfhfj	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
231	311	333	t	10:00 AM	fhfhfj	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
230	312	332	f	08:00 AM	fhfhfj	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
232	312	333	f	10:00 AM	Hdhfhd	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
233	312	333	f	09:00 AM	Hdhfhdhcjdjf	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
234	311	333	t	09:00 AM	Hdhfhdhcjdjf	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
235	317	335	t	10:00 AM	G	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
237	319	341	\N	10:00 AM	Test	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
236	309	335	t	10:00 AM	 Tq	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
238	319	354	t	12:00 AM	In public	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
239	320	354	f	10:00 AM	In shop	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
240	320	354	t	10:00 AM	In shop	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
241	320	354	f	10:00 AM	Ohe	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
242	320	354	t	10:00 AM	Icuf	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
290	311	383	t	10:00 AM	Ugibnk	2020-05-27 02:11:34	2020-05-27 02:11:34	\N	\N	\N	\N	\N	\N	\N
243	319	354	f	12:00 AM	Oysoyd	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
244	319	355	t	01:00 AM	Oysoyd	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
245	320	354	f	10:00 AM	Vyg	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
246	320	354	f	10:00 AM	Vyg	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
247	319	355	f	10:00 AM	Cxcd	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
248	311	353	\N	10:00 AM	Rsdfsff	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
249	311	353	\N	10:00 AM	Sfaszfaszf	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
250	312	357	f	10:00 AM	Fsgdsg	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
251	311	357	\N	10:00 AM	Sdfsfdf	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
252	312	364	f	10:00 AM	Jgkgkvjjv	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
253	312	364	f	10:00 AM	Jfjgjvm	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
254	312	364	t	10:00 AM	Jgjgjvk	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
255	312	364	t	10:00 AM	Jgkgkv	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
256	312	364	t	09:00 AM	Jgjvjv	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
257	312	364	t	11:00 AM	Fjvmvmv	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
291	311	391	\N	10:00 AM	Efsfsff	2020-05-27 02:11:34	2020-05-27 02:11:34	\N	\N	\N	\N	\N	\N	\N
258	312	365	f	09:00 AM	nvnvnv	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
259	312	365	f	09:00 AM	fhfhf	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
292	311	390	t	05:35 AM	Awfafaf	2020-05-28 11:31:04	2020-05-28 11:31:04	\N	\N	\N	\N	\N	\N	\N
260	312	365	t	10:00 AM	vngjvhfjgjg	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
293	312	390	\N	05:40 AM	Asfafasdf	2020-05-28 11:31:04	2020-05-28 11:31:04	\N	\N	\N	\N	\N	\N	\N
261	312	365	t	08:00 AM	ncngng	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
262	312	364	f	10:00 AM	Kgkbkv	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
263	311	364	\N	10:00 AM	Kgkbkv	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
264	311	365	f	10:00 AM	jfjgjv	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
265	312	365	\N	10:00 AM	jfjgjv	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
266	312	365	\N	10:00 AM	jfjgjv	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
267	311	365	f	10:00 AM	hfjgj	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
268	312	365	\N	10:00 AM	hfjgj	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
269	312	365	\N	10:00 AM	Rffghh	2020-05-27 01:24:42	2020-05-27 01:24:42	\N	\N	\N	\N	\N	\N	\N
270	312	365	\N	10:00 AM	Sfsdfsdfg	2020-05-27 01:24:42	2020-05-27 01:24:42	\N	\N	\N	\N	\N	\N	\N
271	312	365	\N	10:00 AM	Fdsff	2020-05-27 01:24:42	2020-05-27 01:24:42	\N	\N	\N	\N	\N	\N	\N
272	312	365	\N	10:00 AM	Faszfazf	2020-05-27 01:24:42	2020-05-27 01:24:42	\N	\N	\N	\N	\N	\N	\N
273	312	365	\N	10:00 AM	Sdfsfsf	2020-05-27 01:24:42	2020-05-27 01:24:42	\N	\N	\N	\N	\N	\N	\N
274	311	376	f	10:00 AM	nvkgjg	2020-05-27 02:11:34	2020-05-27 02:11:34	\N	\N	\N	\N	\N	\N	\N
275	311	376	f	10:00 AM	vnvkgkg	2020-05-27 02:11:34	2020-05-27 02:11:34	\N	\N	\N	\N	\N	\N	\N
276	311	378	\N	10:00 AM	Jgjgjvjvv	2020-05-27 02:11:34	2020-05-27 02:11:34	\N	\N	\N	\N	\N	\N	\N
277	311	379	f	10:00 AM	fhfnvnvncn	2020-05-27 02:11:34	2020-05-27 02:11:34	\N	\N	\N	\N	\N	\N	\N
278	311	378	\N	10:00 AM	Jfjgkgj	2020-05-27 02:11:34	2020-05-27 02:11:34	\N	\N	\N	\N	\N	\N	\N
279	312	379	\N	10:00 AM	fjncncnc	2020-05-27 02:11:34	2020-05-27 02:11:34	\N	\N	\N	\N	\N	\N	\N
280	312	378	f	10:00 AM	Kgkgkggj	2020-05-27 02:11:34	2020-05-27 02:11:34	\N	\N	\N	\N	\N	\N	\N
281	311	378	\N	10:00 AM	Jgjvjv	2020-05-27 02:11:34	2020-05-27 02:11:34	\N	\N	\N	\N	\N	\N	\N
282	322	387	t	10:00 AM	V	2020-05-27 02:11:34	2020-05-27 02:11:34	\N	\N	\N	\N	\N	\N	\N
283	317	386	f	11:00 AM	R	2020-05-27 02:11:34	2020-05-27 02:11:34	\N	\N	\N	\N	\N	\N	\N
284	317	386	t	11:00 AM	Rq	2020-05-27 02:11:34	2020-05-27 02:11:34	\N	\N	\N	\N	\N	\N	\N
285	317	386	t	11:00 PM	Q	2020-05-27 02:11:34	2020-05-27 02:11:34	\N	\N	\N	\N	\N	\N	\N
286	311	382	\N	10:00 AM	Hcvnvkb	2020-05-27 02:11:34	2020-05-27 02:11:34	\N	\N	\N	\N	\N	\N	\N
287	312	383	\N	10:00 AM	Hcjbkb	2020-05-27 02:11:34	2020-05-27 02:11:34	\N	\N	\N	\N	\N	\N	\N
288	311	383	f	10:00 AM	Jgjv in	2020-05-27 02:11:34	2020-05-27 02:11:34	\N	\N	\N	\N	\N	\N	\N
289	312	383	\N	10:00 AM	Hfjvjjb	2020-05-27 02:11:34	2020-05-27 02:11:34	\N	\N	\N	\N	\N	\N	\N
294	311	390	t	05:40 PM	Fafaf	2020-05-28 11:31:04	2020-05-28 11:31:04	\N	\N	\N	\N	\N	\N	\N
295	311	390	t	05:45 PM	Sdadad	2020-05-28 11:31:04	2020-05-28 11:31:04	\N	\N	\N	\N	\N	\N	\N
306	311	391	\N	12:50 PM	Afssafas	2020-05-28 12:14:12	2020-05-28 12:14:12	\N	\N	\N	\N	\N	\N	\N
296	312	391	t	12:30 PM	Fadsfsdf	2020-05-28 12:08:28	2020-05-28 12:08:28	\N	\N	\N	\N	\N	\N	\N
297	311	391	\N	12:35 PM	Asfafaf	2020-05-28 12:14:12	2020-05-28 12:14:12	\N	\N	\N	\N	\N	\N	\N
298	311	391	\N	12:40 PM	Afafaf	2020-05-28 12:14:12	2020-05-28 12:14:12	\N	\N	\N	\N	\N	\N	\N
299	320	354	f	10:00 AM	Rdsx	2020-05-28 12:14:12	2020-05-28 12:14:12	\N	\N	\N	\N	\N	\N	\N
300	312	391	t	12:40 PM	Asfsafasf	2020-05-28 12:14:12	2020-05-28 12:14:12	\N	\N	\N	\N	\N	\N	\N
301	320	354	f	12:00 PM	Rdsxjshshsbnsysgshsbsjsksisjsgegbensjshsshhehejsisyshebsjsjusuddhbsnsnsjxjzjssbshshshehehsbsbsbhshshshdyhxbdnsnsjzjzhzhdbsbshshshsjsushhehshshshshhshshshsbsbsbsb	2020-05-28 12:14:12	2020-05-28 12:14:12	\N	\N	\N	\N	\N	\N	\N
302	311	391	\N	12:40 PM	Adfrafrafr	2020-05-28 12:14:12	2020-05-28 12:14:12	\N	\N	\N	\N	\N	\N	\N
303	311	391	\N	12:45 PM	Sdgsgg	2020-05-28 12:14:12	2020-05-28 12:14:12	\N	\N	\N	\N	\N	\N	\N
305	311	391	\N	12:45 PM	Asfasf	2020-05-28 12:14:12	2020-05-28 12:14:12	\N	\N	\N	\N	\N	\N	\N
307	312	391	t	12:50 PM	Dadasd	2020-05-28 12:14:12	2020-05-28 12:14:12	\N	\N	\N	\N	\N	\N	\N
304	319	354	f	10:00 AM	Testtesrtrefstrvdhtvdhyvdhvjfu	2020-05-28 12:14:12	2020-05-28 12:14:12	\N	\N	\N	\N	\N	\N	\N
315	312	391	t	01:10 PM	Gtsgtsgt	2020-05-28 12:55:52	2020-06-03 10:39:50	t	\N	t	f	\N	\N	\N
308	320	354	f	10:00 AM	Hsgdnehdjshshdjsbejdhejdbejebe	2020-05-28 12:14:12	2020-05-28 12:43:28	\N	\N	\N	\N	\N	\N	\N
310	312	391	t	01:05 PM	Safaf	2020-05-28 12:43:28	2020-05-28 12:43:28	\N	\N	\N	\N	\N	\N	\N
311	312	391	t	01:00 PM	Afadsf	2020-05-28 12:47:10	2020-05-28 12:47:10	\N	\N	\N	\N	\N	\N	\N
312	312	391	t	01:05 PM	Afafg	2020-05-28 12:50:08	2020-05-28 12:50:08	\N	\N	\N	\N	\N	\N	\N
313	312	391	t	01:10 PM	Fbhdfbh	2020-05-28 12:50:58	2020-05-28 12:50:58	\N	\N	\N	\N	\N	\N	\N
314	312	391	t	01:10 PM	Afafrafr	2020-05-28 12:55:52	2020-05-28 12:55:52	t	\N	\N	\N	\N	\N	\N
309	312	391	t	01:00 PM	Asfasfas	2020-05-28 12:14:12	2020-06-09 10:48:42	\N	t	t	t	t	f	1
316	312	391	t	01:05 PM	Dgsgs	2020-05-28 12:55:52	2020-05-28 12:55:52	f	\N	\N	\N	\N	\N	\N
317	311	390	t	01:20 PM	jvjvjv	2020-05-28 12:55:52	2020-05-28 12:55:52	t	\N	\N	\N	\N	\N	\N
318	311	390	t	01:25 PM	jvkgkh	2020-05-28 12:55:52	2020-05-28 12:55:52	\N	\N	\N	\N	\N	\N	\N
319	312	391	f	04:30 AM	Hxjxjxj	2020-05-28 12:55:52	2020-05-28 12:55:52	\N	\N	\N	\N	\N	\N	\N
320	312	391	t	04:30 AM	Hxjxjxj	2020-05-28 12:55:52	2020-05-28 12:55:52	\N	\N	\N	\N	\N	\N	\N
321	312	391	t	04:30 AM	Hxjdjd	2020-05-28 12:55:52	2020-05-28 12:55:52	\N	\N	\N	\N	\N	\N	\N
322	312	391	t	04:30 PM	Hfjcn	2020-05-28 12:55:52	2020-05-28 12:55:52	\N	\N	\N	\N	\N	\N	\N
323	312	391	f	04:30 PM	Udjdndj	2020-05-28 12:55:52	2020-05-28 12:55:52	\N	\N	\N	\N	\N	\N	\N
324	311	391	t	05:30 PM	Uejdnd	2020-05-28 12:55:52	2020-05-28 12:55:52	\N	\N	\N	\N	\N	\N	\N
371	330	464	t	07:00 AM	Bathroom	2020-06-03 06:24:18	2020-06-03 06:24:18	\N	\N	\N	\N	\N	\N	\N
325	312	391	t	01:30 PM	Hcjcjc	2020-05-28 12:55:52	2020-05-28 12:55:52	t	f	\N	\N	\N	\N	\N
326	326	409	t	08:20 AM	Q	2020-05-28 01:17:52	2020-05-28 01:17:52	\N	\N	\N	\N	\N	\N	\N
356	312	440	t	06:30 AM	Ihknkn	2020-06-01 11:11:54	2020-06-01 11:11:54	t	\N	\N	\N	\N	\N	\N
328	325	409	t	01:30 PM	Aaaaa	2020-05-28 01:17:52	2020-05-28 01:17:52	\N	\N	\N	\N	\N	\N	\N
327	326	409	t	08:45 AM	Q	2020-05-28 01:17:52	2020-05-28 01:17:52	t	t	\N	\N	\N	\N	\N
329	52	227	\N	Master Room	10:12 PM	2020-05-29 11:52:51	2020-05-29 11:52:51	\N	\N	\N	\N	\N	\N	\N
330	320	424	f	09:30 PM	Hfhv	2020-05-30 07:26:11	2020-05-30 07:26:11	\N	\N	\N	\N	\N	\N	\N
331	320	424	t	09:45 AM	Hfhv	2020-05-30 07:26:11	2020-05-30 07:26:11	\N	\N	\N	\N	\N	\N	\N
357	311	447	t	12:40 PM	Hzhz	2020-06-01 11:11:54	2020-06-01 11:11:54	f	\N	\N	\N	\N	\N	\N
332	312	429	t	09:20 AM	Sdgdgdgd	2020-05-30 07:26:11	2020-05-30 07:26:11	t	\N	t	f	\N	\N	\N
358	311	449	\N	02:00 AM	hfhfhf	2020-06-01 11:11:54	2020-06-01 11:11:54	\N	\N	\N	\N	\N	\N	\N
333	312	441	t	10:25 AM	Gdfxgdfg	2020-05-30 07:26:11	2020-05-30 07:26:11	t	\N	\N	\N	\N	\N	\N
334	311	440	t	10:40 AM	fjgjvnvnnvjv	2020-05-30 07:26:11	2020-05-30 07:26:11	\N	\N	\N	\N	\N	\N	\N
335	311	440	t	10:40 AM	jgjgjv	2020-05-30 07:26:11	2020-05-30 07:26:11	\N	\N	\N	\N	\N	\N	\N
336	311	440	f	10:40 AM	gjgjv	2020-05-30 07:26:11	2020-05-30 07:26:11	\N	\N	\N	\N	\N	\N	\N
337	311	440	f	10:45 AM	gjgjv	2020-05-30 07:26:11	2020-05-30 07:26:11	\N	\N	\N	\N	\N	\N	\N
339	311	440	t	04:30 AM	bfbchc	2020-05-30 07:26:11	2020-05-30 07:26:11	t	\N	\N	\N	\N	\N	\N
340	312	440	t	05:30 AM	cjgjv	2020-05-30 07:26:11	2020-05-30 07:26:11	\N	\N	\N	\N	\N	\N	\N
359	312	449	t	02:00 AM	bfbfjg	2020-06-01 11:11:54	2020-06-01 11:11:54	t	t	\N	\N	\N	\N	\N
341	312	440	f	04:30 PM	jghvbc	2020-05-30 07:26:11	2020-05-30 07:26:11	\N	\N	\N	\N	\N	\N	\N
342	311	440	t	10:40 AM	jfjgjv	2020-05-30 07:26:11	2020-05-30 07:26:11	\N	\N	\N	\N	\N	\N	\N
360	332	452	\N	04:30 AM	Test	2020-06-02 08:44:28	2020-06-02 08:44:28	\N	\N	\N	\N	\N	\N	\N
338	311	440	t	10:45 AM	gjgjv	2020-05-30 07:26:11	2020-05-30 07:26:11	t	t	\N	\N	\N	\N	\N
343	312	440	\N	05:30 PM	gugjc	2020-06-01 10:53:11	2020-06-01 10:53:11	\N	\N	\N	\N	\N	\N	\N
344	312	440	\N	04:30 PM	bcfbc	2020-06-01 10:56:07	2020-06-01 10:56:07	\N	\N	\N	\N	\N	\N	\N
345	312	440	\N	04:30 PM	nvnvnv	2020-06-01 10:56:07	2020-06-01 10:56:07	\N	\N	\N	\N	\N	\N	\N
346	312	440	\N	04:30 PM	bcnvnv	2020-06-01 10:56:07	2020-06-01 10:56:07	\N	\N	\N	\N	\N	\N	\N
348	311	440	f	04:30 PM	ufhfhf	2020-06-01 11:11:54	2020-06-01 11:11:54	\N	\N	\N	\N	\N	\N	\N
349	312	441	t	04:30 PM	Hxjdjd	2020-06-01 11:11:54	2020-06-01 11:11:54	\N	\N	\N	\N	\N	\N	\N
350	312	441	f	04:30 PM	Jvjbb	2020-06-01 11:11:54	2020-06-01 11:11:54	\N	\N	\N	\N	\N	\N	\N
351	312	441	t	04:30 PM	Jvjbb	2020-06-01 11:11:54	2020-06-01 11:11:54	\N	\N	\N	\N	\N	\N	\N
361	330	453	\N	11:50 AM	Bathroom	2020-06-02 09:30:22	2020-06-02 09:30:22	\N	\N	\N	\N	\N	\N	\N
352	311	441	t	05:30 PM	Cvhj	2020-06-01 11:11:54	2020-06-01 11:11:54	\N	\N	\N	\N	\N	\N	\N
362	332	452	\N	11:50 AM	Bathroom	2020-06-02 09:30:22	2020-06-02 09:30:22	\N	\N	\N	\N	\N	\N	\N
363	330	453	\N	11:55 AM	Hfvhgv	2020-06-02 09:30:22	2020-06-02 09:30:22	\N	\N	\N	\N	\N	\N	\N
353	312	441	t	12:00 PM	jfgjv	2020-06-01 11:11:54	2020-06-01 11:11:54	t	t	\N	\N	\N	\N	\N
354	312	441	t	04:30 PM	cjfhf	2020-06-01 11:11:54	2020-06-01 11:11:54	\N	\N	\N	\N	\N	\N	\N
355	311	440	f	04:30 PM	Ihknkn	2020-06-01 11:11:54	2020-06-01 11:11:54	\N	\N	\N	\N	\N	\N	\N
386	332	478	t	10:10 AM	Bdhdbd	2020-06-03 08:24:50	2020-06-03 08:24:50	t	t	\N	\N	\N	\N	\N
364	332	453	t	12:30 PM	Vfuc g	2020-06-02 09:30:22	2020-06-02 09:30:22	\N	t	\N	\N	t	t	\N
378	311	448	t	09:20 AM	dhfbcbc	2020-06-03 08:24:50	2020-06-03 08:24:50	f	t	\N	\N	\N	\N	\N
372	332	467	t	07:40 AM	Bathroom	2020-06-03 06:24:18	2020-06-03 06:24:18	t	t	\N	\N	\N	\N	\N
365	330	452	t	03:30 AM	Test	2020-06-02 09:30:22	2020-06-02 09:30:22	f	t	\N	\N	\N	\N	\N
373	311	448	t	07:45 AM	ngnfjg	2020-06-03 06:24:18	2020-06-03 06:24:18	\N	t	\N	\N	\N	\N	\N
366	332	453	t	04:15 AM	Hctbbc	2020-06-02 09:30:22	2020-06-02 09:30:22	\N	t	\N	\N	\N	\N	\N
367	332	454	t	04:30 AM	Bathroom	2020-06-02 09:30:22	2020-06-02 09:30:22	\N	\N	\N	\N	\N	\N	\N
374	311	448	t	07:45 AM	cjvnvnv	2020-06-03 06:24:18	2020-06-03 06:24:18	t	\N	\N	\N	\N	\N	\N
368	52	226	t	Master	12:29 PM	2020-06-03 05:46:12	2020-06-03 05:46:12	t	\N	\N	\N	\N	\N	\N
369	332	463	t	06:35 AM	Bathroom	2020-06-03 06:01:48	2020-06-03 06:24:18	t	t	\N	\N	\N	\N	\N
383	311	448	t	09:20 AM	hfhcbc	2020-06-03 08:24:50	2020-06-03 08:24:50	t	t	\N	\N	\N	\N	\N
375	332	468	t	08:20 AM	Bathroom	2020-06-03 07:59:35	2020-06-03 07:59:35	t	t	\N	\N	\N	\N	\N
379	312	449	t	09:25 AM	Ihhkbkn	2020-06-03 08:24:50	2020-06-03 08:24:50	t	t	\N	\N	\N	\N	\N
376	332	471	t	08:50 AM	Hsvshsb	2020-06-03 08:24:50	2020-06-03 08:24:50	f	f	\N	\N	\N	\N	\N
377	332	472	t	09:10 AM	Bshsvs	2020-06-03 08:24:50	2020-06-03 08:24:50	\N	f	\N	\N	\N	\N	\N
381	311	448	t	09:15 PM	vdbfnc	2020-06-03 08:24:50	2020-06-03 08:24:50	\N	\N	\N	\N	\N	\N	\N
384	332	477	f	09:40 AM	Hftv	2020-06-03 08:24:50	2020-06-03 08:24:50	\N	\N	\N	\N	\N	\N	\N
380	332	475	t	09:30 AM	Bshsb	2020-06-03 08:24:50	2020-06-03 08:24:50	f	t	\N	\N	\N	\N	\N
389	330	489	t	02:00 PM	Hfuh	2020-06-03 01:37:02	2020-06-03 01:37:02	\N	\N	\N	\N	\N	\N	\N
385	332	477	t	09:40 AM	Hftv	2020-06-03 08:24:50	2020-06-03 08:24:50	\N	t	\N	\N	\N	\N	\N
390	332	490	t	02:15 PM	Gsbsbbx	2020-06-03 01:52:11	2020-06-03 01:52:11	\N	\N	\N	\N	\N	\N	\N
382	311	448	t	09:15 AM	vcbcb	2020-06-03 08:24:50	2020-06-03 01:52:11	t	t	\N	\N	\N	\N	\N
387	52	227	\N	4:28 PM	room	2020-06-03 10:39:50	2020-06-03 10:39:50	\N	\N	t	f	t	t	1
388	330	488	\N	01:55 PM	In public	2020-06-03 01:37:02	2020-06-03 01:37:02	\N	\N	\N	\N	\N	\N	\N
392	51	226	t	2:25 PM	5:22 PM	2020-06-03 01:52:11	2020-06-03 01:52:11	\N	\N	\N	\N	\N	\N	\N
393	332	490	t	04:20 PM	Test	2020-06-03 01:52:11	2020-06-03 01:52:11	\N	\N	\N	\N	\N	\N	\N
391	330	491	t	02:20 PM	Hsgshs	2020-06-03 01:52:11	2020-06-03 01:52:11	t	t	\N	\N	\N	\N	\N
394	332	490	t	03:25 PM	Test	2020-06-03 01:52:11	2020-06-03 01:52:11	\N	\N	\N	\N	\N	\N	\N
395	332	490	t	03:45 PM	Bathroom	2020-06-03 01:52:11	2020-06-03 01:52:11	t	t	\N	\N	\N	\N	\N
396	332	490	t	04:00 PM	Bathroom	2020-06-03 01:52:11	2020-06-03 01:52:11	\N	\N	\N	\N	\N	\N	\N
370	52	226	t	Master	08:02 AM	2020-06-03 06:24:18	2020-06-04 05:18:49	t	t	\N	\N	\N	\N	\N
397	52	227	t	07:20 AM	03:50 AM	2020-06-03 01:52:11	2020-06-04 07:08:10	t	\N	\N	\N	\N	\N	\N
398	332	490	t	05:05 AM	Test	2020-06-03 01:52:11	2020-06-03 01:52:11	\N	\N	\N	\N	\N	\N	\N
399	332	490	t	08:45 AM	Bathroom	2020-06-04 07:26:43	2020-06-04 07:26:43	t	t	\N	\N	\N	\N	\N
478	343	506	t	01:40 PM	jgjvjv	2020-06-09 01:16:26	2020-06-09 01:16:26	\N	\N	\N	\N	\N	\N	\N
479	343	506	t	01:35 AM	jfgjv	2020-06-09 01:16:26	2020-06-09 01:16:26	\N	\N	\N	\N	\N	\N	\N
456	336	494	t	09:25 AM	Chc	2020-06-09 08:54:31	2020-06-09 08:54:31	\N	\N	\N	\N	\N	\N	\N
452	336	494	t	07:35 AM	Test	2020-06-09 07:02:36	2020-06-09 07:02:36	t	f	\N	\N	\N	\N	\N
432	51	226	\N	11:15 AM	Jkkk	2020-06-08 10:57:44	2020-06-08 10:57:44	\N	\N	\N	\N	\N	\N	\N
400	52	227	t	08:58 AM	03:50 AM	2020-06-04 08:39:20	2020-06-04 08:57:53	t	t	\N	\N	\N	\N	\N
419	337	495	t	05:45 PM	Gdxv	2020-06-05 12:31:15	2020-06-05 12:31:15	\N	\N	\N	\N	\N	\N	\N
401	52	227	t	09:20 AM	03:50 AM	2020-06-04 09:02:11	2020-06-04 09:04:05	\N	t	\N	\N	\N	\N	\N
411	336	494	t	11:05 AM	Ttttr	2020-06-04 10:35:41	2020-06-04 10:35:41	t	t	\N	\N	\N	\N	\N
402	52	227	t	09:20 AM	03:50 AM	2020-06-04 09:04:05	2020-06-04 09:04:05	t	t	\N	\N	\N	\N	\N
420	337	495	t	05:50 PM	Rec	2020-06-05 12:31:15	2020-06-05 12:31:15	\N	\N	\N	\N	\N	\N	\N
433	51	226	\N	11:15 AM	Hhjj	2020-06-08 10:57:44	2020-06-08 10:57:44	\N	\N	\N	\N	\N	\N	\N
412	336	494	t	11:30 AM	Test	2020-06-04 11:05:14	2020-06-04 11:05:14	t	t	\N	\N	\N	\N	\N
421	336	494	t	04:55 PM	Deccd	2020-06-05 12:31:15	2020-06-05 12:31:15	t	t	\N	\N	\N	\N	\N
434	339	502	t	04:30 AM	Dffg	2020-06-08 10:57:44	2020-06-08 10:57:44	\N	\N	\N	\N	\N	\N	\N
403	52	227	t	09:25 AM	03:50 AM	2020-06-04 09:06:58	2020-06-04 09:06:58	t	\N	\N	\N	\N	\N	\N
404	52	494	t	10:11 AM	03:50 AM	2020-06-04 09:06:58	2020-06-04 09:51:11	t	t	\N	\N	\N	\N	\N
423	337	495	t	09:10 AM	Test	2020-06-05 12:31:15	2020-06-05 12:31:15	\N	\N	\N	\N	\N	\N	\N
413	336	494	t	12:15 PM	Tt	2020-06-04 11:20:11	2020-06-04 11:20:11	t	t	\N	\N	\N	\N	\N
414	337	495	t	04:50 AM	Bathroom	2020-06-04 12:32:48	2020-06-04 12:32:48	\N	\N	\N	\N	\N	\N	\N
415	337	494	\N	04:45 AM	Bathroom	2020-06-04 12:32:48	2020-06-04 12:32:48	\N	\N	\N	\N	\N	\N	\N
424	336	494	t	09:10 AM	Test	2020-06-05 12:31:15	2020-06-05 12:31:15	\N	\N	\N	\N	\N	\N	\N
435	339	502	t	11:35 AM	Ccc	2020-06-08 10:57:44	2020-06-08 10:57:44	\N	\N	\N	\N	\N	\N	\N
416	336	494	t	04:40 AM	Bzhdd	2020-06-05 04:22:28	2020-06-05 04:22:28	t	t	\N	\N	\N	\N	\N
405	52	227	t	10:20 AM	03:50 AM	2020-06-04 09:51:11	2020-06-04 10:17:40	t	t	\N	\N	\N	\N	\N
422	337	495	t	09:10 AM	Couch	2020-06-05 12:31:15	2020-06-05 12:31:15	f	\N	\N	\N	\N	\N	\N
436	340	503	t	11:40 AM	Ccc	2020-06-08 11:17:15	2020-06-08 11:17:15	\N	\N	\N	\N	\N	\N	\N
407	52	227	t	10:25 AM	03:50 AM	2020-06-04 10:23:00	2020-06-04 10:23:00	\N	\N	\N	\N	\N	\N	\N
437	339	503	\N	04:30 AM	Vvb	2020-06-08 11:24:19	2020-06-08 11:24:19	\N	\N	\N	\N	\N	\N	\N
425	337	495	t	09:30 AM	Test	2020-06-05 12:31:15	2020-06-05 12:31:15	t	t	\N	\N	\N	\N	\N
426	336	495	\N	01:00 PM	Yfv	2020-06-05 12:31:15	2020-06-05 12:31:15	\N	\N	\N	\N	\N	\N	\N
406	52	227	t	10:25 AM	03:50 AM	2020-06-04 10:20:57	2020-06-04 10:23:00	t	t	\N	\N	\N	\N	\N
438	340	503	f	04:30 AM	Bbh	2020-06-08 11:24:19	2020-06-08 11:24:19	\N	\N	\N	\N	\N	\N	\N
408	52	227	t	10:30 AM	03:50 AM	2020-06-04 10:23:00	2020-06-04 10:26:35	t	t	\N	\N	\N	\N	\N
427	336	494	t	01:00 PM	Bfb	2020-06-05 12:31:15	2020-06-05 12:31:15	t	t	\N	\N	\N	\N	\N
417	337	495	t	05:05 AM	Bathroom	2020-06-05 04:39:44	2020-06-05 04:39:44	t	t	\N	\N	\N	\N	\N
409	52	227	t	10:30 AM	03:50 AM	2020-06-04 10:26:35	2020-06-04 10:28:39	t	t	\N	\N	\N	\N	\N
439	340	503	f	04:30 AM	Bbh	2020-06-08 11:24:19	2020-06-08 11:24:19	\N	\N	\N	\N	\N	\N	\N
446	337	495	t	04:55 AM	Bathroom	2020-06-08 11:24:19	2020-06-08 11:24:19	f	f	\N	\N	\N	\N	\N
429	336	494	t	01:35 PM	Test	2020-06-05 12:31:15	2020-06-05 12:31:15	\N	t	\N	\N	t	t	\N
428	337	495	t	01:30 PM	Test	2020-06-05 12:31:15	2020-06-05 12:31:15	t	\N	t	t	\N	\N	\N
440	340	503	t	12:15 PM	Bbh	2020-06-08 11:24:19	2020-06-08 11:24:19	t	f	\N	\N	\N	\N	\N
410	52	227	t	10:45 AM	03:50 AM	2020-06-04 10:28:39	2020-06-05 06:34:41	t	\N	\N	\N	\N	\N	\N
447	336	494	t	05:25 AM	Bathrom	2020-06-08 11:24:19	2020-06-08 11:24:19	f	t	\N	\N	\N	\N	\N
431	340	503	t	07:30 AM	Ggg	2020-06-08 04:22:51	2020-06-08 04:22:51	\N	t	\N	\N	\N	\N	\N
430	340	503	t	04:30 AM	Bedroom	2020-06-08 04:22:51	2020-06-08 04:22:51	t	\N	\N	\N	t	t	\N
441	339	502	t	12:20 PM	Cvv	2020-06-08 11:24:19	2020-06-08 11:24:19	t	t	t	t	\N	\N	\N
442	51	226	t	03:45 AM	03:50 AM	2020-06-08 11:24:19	2020-06-08 11:24:19	t	\N	\N	\N	\N	\N	\N
453	336	494	t	08:10 AM	Bsgavs	2020-06-09 07:02:36	2020-06-09 07:02:36	\N	t	\N	\N	\N	\N	\N
448	337	495	t	05:40 AM	Bathroom	2020-06-08 11:24:19	2020-06-08 11:24:19	t	f	\N	\N	\N	\N	\N
444	51	226	t	04:30 AM	Fggj	2020-06-08 11:24:19	2020-06-08 11:24:19	\N	\N	\N	\N	\N	\N	\N
443	51	226	t	04:09 AM	03:50 AM	2020-06-08 11:24:19	2020-06-08 11:24:19	t	t	\N	\N	\N	\N	\N
454	336	494	t	08:45 AM	Dac	2020-06-09 07:02:36	2020-06-09 07:02:36	\N	f	\N	\N	\N	\N	\N
445	336	494	t	04:30 AM	Test	2020-06-08 11:24:19	2020-06-08 11:24:19	t	t	\N	\N	\N	\N	\N
418	52	227	t	08:55 AM	03:50 AM	2020-06-05 11:49:14	2020-06-09 08:34:48	t	t	\N	\N	\N	\N	\N
449	336	494	t	06:15 AM	Bathroom	2020-06-08 11:24:19	2020-06-08 11:24:19	f	f	\N	\N	\N	\N	\N
450	336	494	f	07:10 AM	Bsbsb	2020-06-08 11:24:19	2020-06-08 11:24:19	\N	\N	\N	\N	\N	\N	\N
457	336	494	t	09:55 AM	Bath	2020-06-09 08:54:31	2020-06-09 08:54:31	t	f	\N	\N	\N	\N	\N
451	336	494	t	07:10 AM	Bsbsb	2020-06-08 11:24:19	2020-06-08 11:24:19	t	t	\N	\N	\N	\N	\N
458	340	503	f	09:55 AM	Bbv	2020-06-09 08:54:31	2020-06-09 08:54:31	\N	\N	\N	\N	\N	\N	\N
459	340	503	f	09:55 AM	Bbv	2020-06-09 08:54:31	2020-06-09 08:54:31	\N	\N	\N	\N	\N	\N	\N
460	336	494	t	09:50 AM	Bath	2020-06-09 08:54:31	2020-06-09 08:54:31	\N	\N	\N	\N	\N	\N	\N
455	52	226	t	08:50 AM	03:50 AM	2020-06-09 08:34:48	2020-06-09 08:49:04	\N	t	\N	\N	\N	\N	\N
462	340	503	t	10:20 AM	Ccg	2020-06-09 09:51:39	2020-06-09 09:51:39	\N	\N	\N	\N	\N	\N	\N
463	336	494	t	11:15 AM	Bath	2020-06-09 10:48:42	2020-06-09 10:48:42	\N	\N	\N	\N	\N	\N	\N
465	336	494	t	11:35 AM	Bath	2020-06-09 11:21:32	2020-06-09 11:21:32	\N	t	\N	\N	\N	\N	\N
464	336	494	t	11:15 AM	Test	2020-06-09 10:48:42	2020-06-09 10:48:42	f	t	\N	\N	\N	\N	\N
466	344	507	t	12:45 PM	Dfsszfsf	2020-06-09 11:37:47	2020-06-09 11:37:47	\N	\N	\N	\N	\N	\N	\N
467	344	507	t	12:35 PM	Dada	2020-06-09 11:37:47	2020-06-09 11:37:47	\N	\N	\N	\N	\N	\N	\N
469	344	506	\N	04:30 AM	bchfjg	2020-06-09 11:37:47	2020-06-09 11:37:47	\N	\N	\N	\N	\N	\N	\N
468	344	507	t	12:40 PM	Dszfsf	2020-06-09 11:37:47	2020-06-09 11:37:47	f	\N	\N	\N	\N	\N	\N
471	344	506	\N	04:30 AM	fhfjcj	2020-06-09 01:00:19	2020-06-09 01:00:19	\N	\N	\N	\N	\N	\N	\N
470	343	506	t	04:30 AM	jfjghv	2020-06-09 01:00:19	2020-06-09 01:00:19	\N	\N	\N	\N	\N	\N	\N
472	343	506	t	04:30 AM	kgjgjg	2020-06-09 01:04:20	2020-06-09 01:04:20	\N	\N	\N	\N	\N	\N	\N
473	344	506	\N	04:30 AM	jgngj	2020-06-09 01:04:20	2020-06-09 01:04:20	\N	\N	\N	\N	\N	\N	\N
474	343	506	t	04:30 AM	igigjv	2020-06-09 01:04:20	2020-06-09 01:04:20	\N	\N	\N	\N	\N	\N	\N
475	343	506	t	01:10 PM	fjgkv	2020-06-09 01:04:20	2020-06-09 01:04:20	\N	\N	\N	\N	\N	\N	\N
476	343	506	t	01:15 PM	fjgjgjg	2020-06-09 01:04:20	2020-06-09 01:04:20	\N	\N	\N	\N	\N	\N	\N
477	343	506	t	01:30 PM	gjgkgj	2020-06-09 01:04:20	2020-06-09 01:04:20	\N	\N	\N	\N	\N	\N	\N
502	344	507	t	04:30 AM	Jxjdjd	2020-06-09 01:53:02	2020-06-09 01:53:02	\N	\N	\N	\N	\N	\N	\N
503	52	226	t	09:30 AM	Bhh	2020-06-09 01:53:02	2020-06-09 01:53:02	\N	\N	\N	\N	\N	\N	\N
504	52	226	t	09:35 AM	Cvg	2020-06-10 09:31:03	2020-06-10 09:31:03	\N	\N	\N	\N	\N	\N	\N
505	52	226	t	09:35 AM	Vbh	2020-06-10 09:31:03	2020-06-10 09:31:03	\N	t	\N	\N	\N	\N	\N
506	52	226	t	09:40 AM	Gbh	2020-06-10 09:31:03	2020-06-10 09:31:03	\N	\N	\N	\N	\N	\N	\N
507	52	226	t	09:40 AM	Bhj	2020-06-10 09:31:03	2020-06-10 09:31:03	\N	\N	\N	\N	\N	\N	\N
480	343	506	t	01:50 PM	hfjgjv	2020-06-09 01:16:26	2020-06-09 01:16:26	\N	\N	\N	\N	\N	\N	\N
521	336	513	t	12:30 PM	Fvg	2020-06-10 09:49:30	2020-06-10 09:49:30	\N	\N	\N	\N	\N	\N	\N
508	52	226	t	09:40 AM	Vvh	2020-06-10 09:31:03	2020-06-10 09:31:03	t	t	\N	\N	\N	\N	\N
522	336	513	t	05:30 AM	Dfg	2020-06-10 09:49:30	2020-06-10 09:49:30	\N	\N	\N	\N	\N	\N	\N
347	311	440	f	04:30 PM	jfjgj	2020-06-01 11:03:49	2020-06-09 01:37:36	\N	f	\N	\N	\N	\N	\N
481	343	507	\N	01:55 PM	hfjgj	2020-06-09 01:37:36	2020-06-09 01:37:36	\N	\N	\N	\N	\N	\N	\N
482	343	507	\N	01:50 AM	gjgj	2020-06-09 01:37:36	2020-06-09 01:37:36	\N	\N	\N	\N	\N	\N	\N
483	343	506	t	01:50 PM	cjgjv	2020-06-09 01:37:36	2020-06-09 01:37:36	\N	\N	\N	\N	\N	\N	\N
461	52	226	t	01:55 PM	03:50 AM	2020-06-09 09:51:39	2020-06-09 01:37:36	f	t	\N	\N	\N	\N	\N
484	343	506	t	02:05 PM	fjgkv	2020-06-09 01:37:36	2020-06-09 01:37:36	\N	\N	\N	\N	\N	\N	\N
509	52	226	t	09:45 AM	Hhgg	2020-06-10 09:31:03	2020-06-10 09:31:03	t	t	\N	\N	\N	\N	\N
485	343	506	t	01:55 PM	fjgjv	2020-06-09 01:37:36	2020-06-09 01:37:36	t	f	\N	\N	\N	\N	\N
486	344	507	t	02:25 PM	jfjgj	2020-06-09 01:53:02	2020-06-09 01:53:02	f	t	\N	\N	\N	\N	\N
510	52	226	t	09:50 AM	Gg	2020-06-10 09:49:30	2020-06-10 09:49:30	\N	t	\N	\N	\N	\N	\N
487	344	507	t	02:25 PM	hfbc	2020-06-09 01:53:02	2020-06-09 01:53:02	t	f	\N	\N	\N	\N	\N
523	336	513	t	06:30 AM	Vvg	2020-06-10 09:49:30	2020-06-10 09:49:30	\N	t	\N	\N	\N	\N	\N
511	52	226	t	09:55 AM	Ghhh	2020-06-10 09:49:30	2020-06-10 09:49:30	\N	t	\N	\N	\N	\N	\N
488	336	508	t	08:05 AM	Hh	2020-06-09 01:53:02	2020-06-09 01:53:02	t	t	\N	\N	\N	\N	\N
489	336	508	t	08:10 AM	Test	2020-06-09 01:53:02	2020-06-09 01:53:02	\N	\N	\N	\N	\N	\N	\N
490	336	508	t	08:20 AM	Test	2020-06-09 01:53:02	2020-06-09 01:53:02	\N	\N	\N	\N	\N	\N	\N
491	336	508	t	08:20 AM	Dx	2020-06-09 01:53:02	2020-06-09 01:53:02	\N	\N	\N	\N	\N	\N	\N
492	336	508	t	08:40 AM	Resc	2020-06-09 01:53:02	2020-06-09 01:53:02	f	t	\N	\N	\N	\N	\N
512	51	227	t	10:00 AM	Ghhhj	2020-06-10 09:49:30	2020-06-10 09:49:30	\N	t	\N	\N	\N	\N	\N
493	336	508	t	09:00 AM	Test	2020-06-09 01:53:02	2020-06-09 01:53:02	f	t	\N	\N	\N	\N	\N
494	336	508	t	08:55 AM	Tedt	2020-06-09 01:53:02	2020-06-09 01:53:02	\N	\N	\N	\N	\N	\N	\N
495	337	508	\N	09:15 AM	Baha	2020-06-09 01:53:02	2020-06-09 01:53:02	\N	\N	\N	\N	\N	\N	\N
496	337	508	\N	09:15 AM	Bahsb	2020-06-09 01:53:02	2020-06-09 01:53:02	\N	\N	\N	\N	\N	\N	\N
524	336	515	t	11:30 AM	Cjfj	2020-06-10 09:49:30	2020-06-10 09:49:30	\N	\N	\N	\N	\N	\N	\N
498	52	226	t	09:09 AM	03:50 AM	2020-06-09 01:53:02	2020-06-09 01:53:02	\N	\N	\N	\N	\N	\N	\N
525	347	518	\N	04:30 AM	Ee	2020-06-10 12:25:13	2020-06-10 12:25:13	\N	\N	\N	\N	\N	\N	\N
497	337	509	t	09:20 AM	Tfhc	2020-06-09 01:53:02	2020-06-09 01:53:02	f	t	\N	\N	\N	\N	\N
499	51	226	t	09:10 AM	Hhh	2020-06-09 01:53:02	2020-06-09 01:53:02	\N	\N	\N	\N	\N	\N	\N
500	52	226	t	09:20 AM	Vvb	2020-06-09 01:53:02	2020-06-09 01:53:02	\N	\N	\N	\N	\N	\N	\N
501	52	226	t	09:30 AM	Hhjj	2020-06-09 01:53:02	2020-06-09 01:53:02	\N	\N	\N	\N	\N	\N	\N
513	336	508	t	10:15 AM	Test	2020-06-10 09:49:30	2020-06-10 09:49:30	f	f	\N	\N	\N	\N	\N
514	345	511	t	10:25 AM	Hhj	2020-06-10 09:49:30	2020-06-10 09:49:30	\N	\N	\N	\N	\N	\N	\N
541	364	529	f	04:30 PM	Test	2020-06-19 11:09:02	2020-06-19 11:09:02	\N	\N	\N	\N	\N	\N	\N
515	346	510	t	10:30 AM	Hhhj	2020-06-10 09:49:30	2020-06-10 09:49:30	t	t	\N	\N	\N	\N	\N
516	336	508	f	10:35 AM	Test	2020-06-10 09:49:30	2020-06-10 09:49:30	\N	\N	\N	\N	\N	\N	\N
533	345	510	t	11:55 AM	Go to heaven	2020-06-16 11:07:20	2020-06-16 12:18:18	t	\N	\N	\N	\N	\N	\N
526	348	520	t	10:20 AM	Qa	2020-06-10 12:25:13	2020-06-10 12:25:13	t	t	\N	\N	\N	\N	\N
517	336	508	t	10:35 AM	Test	2020-06-10 09:49:30	2020-06-10 09:49:30	t	t	\N	\N	\N	\N	\N
518	336	513	t	10:35 AM	Test	2020-06-10 09:49:30	2020-06-10 09:49:30	\N	t	\N	\N	\N	\N	\N
519	336	513	t	10:55 AM	Q	2020-06-10 09:49:30	2020-06-10 09:49:30	\N	\N	\N	\N	\N	\N	\N
520	336	513	t	11:30 AM	Fgbf	2020-06-10 09:49:30	2020-06-10 09:49:30	\N	\N	\N	\N	\N	\N	\N
534	345	510	t	12:50 AM	Ghare	2020-06-16 12:24:20	2020-06-16 12:24:20	\N	\N	\N	\N	\N	\N	\N
527	358	522	t	12:30 PM	Wdd	2020-06-11 12:13:26	2020-06-11 12:13:26	t	f	\N	\N	\N	\N	\N
528	342	525	t	09:25 AM	sdxadas	2020-06-11 12:13:26	2020-06-11 12:13:26	t	\N	\N	\N	\N	\N	\N
529	345	510	t	11:00 AM	Ghare	2020-06-16 10:34:35	2020-06-16 10:34:35	\N	\N	\N	\N	\N	\N	\N
530	345	510	t	11:05 AM	Ghare	2020-06-16 10:44:45	2020-06-16 10:44:45	\N	\N	\N	\N	\N	\N	\N
531	345	510	t	11:10 PM	Ghare	2020-06-16 10:52:31	2020-06-16 10:52:31	\N	\N	\N	\N	\N	\N	\N
535	345	510	t	12:50 PM	Ghare	2020-06-16 12:31:16	2020-06-16 12:31:16	\N	\N	\N	\N	\N	\N	\N
532	345	510	t	11:35 AM	Ghare	2020-06-16 11:07:20	2020-06-16 11:07:20	t	\N	\N	\N	\N	\N	\N
536	345	510	t	12:50 PM	Gh J	2020-06-16 12:32:54	2020-06-16 12:32:54	\N	\N	\N	\N	\N	\N	\N
537	345	510	t	01:00 PM	Gjgj	2020-06-16 12:54:39	2020-06-16 12:54:39	t	\N	\N	\N	\N	\N	\N
538	345	510	t	04:35 AM	Ghare	2020-06-17 04:08:42	2020-06-17 04:08:42	t	\N	\N	\N	\N	\N	\N
539	342	524	\N	04:30 AM	Ghhhj	2020-06-19 11:09:02	2020-06-19 11:09:02	\N	\N	\N	\N	\N	\N	\N
540	363	527	t	04:30 AM	Gjgjg	2020-06-19 11:09:02	2020-06-19 11:09:02	t	\N	\N	\N	\N	\N	\N
542	364	529	t	04:30 PM	Test	2020-06-19 11:09:02	2020-06-19 11:09:02	\N	t	\N	\N	t	f	\N
543	357	529	t	04:50 PM	Test2	2020-06-19 11:09:02	2020-06-19 11:09:02	\N	t	t	t	\N	\N	\N
544	364	528	\N	02:00 AM	Test June 27	2020-06-19 11:09:02	2020-06-19 11:09:02	\N	\N	\N	\N	\N	\N	\N
545	368	532	\N	04:00 PM	Bedroom	2020-06-19 11:09:02	2020-06-19 11:09:02	\N	\N	\N	\N	\N	\N	\N
\.


--
-- Name: quickies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quickies_id_seq', 545, true);


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, role_title, status, create_time, update_time) FROM stdin;
1	Admin	1	2020-01-14 00:00:00	2020-01-14 00:00:00
2	User	1	2020-01-14 00:00:00	2020-01-14 00:00:00
\.


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 1, false);


--
-- Data for Name: subscripations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subscripations (id, user_id, partner_mapping_id, purchase_plan_id, amount, device_name, subscripation_plan, receipt, status, create_time, update_time, expiry_date) FROM stdin;
1	52	227	123456dfsf	1234	apple	yearly	sasassas1212	1	2020-05-21 04:42:47	2020-05-21 04:42:47	\N
2	52	227	123456dfsf	1234	apple	monthly	sasassas1212	1	2020-05-21 12:35:58	2020-05-21 12:35:58	2020-06-20 12:35:58.684
3	52	227	123456dfsf	1234	apple	monthly	sasassas1212	1	2020-05-22 04:20:34	2020-05-22 04:20:34	2020-06-21 16:20:34.697
4	52	227	123456dfsf	1234	apple	monthly	sasassas1212	1	2020-05-25 01:48:59	2020-05-25 01:48:59	2020-06-24 13:48:59.033
5	52	227	123456dfsf	1234	apple	monthly	sasassas1212	1	2020-05-25 01:48:59	2020-05-25 01:48:59	2020-06-24 13:48:59.033
\.


--
-- Name: subscripations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subscripations_id_seq', 5, true);


--
-- Data for Name: unavailabilities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.unavailabilities (id, user_id, unavailability_start, unavailability_end, status, create_time, update_time) FROM stdin;
1	6	2020-01-25 00:00:00	2020-01-30 00:00:00	1	2020-01-21 00:50:50	2020-01-21 00:50:50
2	6	2020-01-25 00:00:00	2020-01-30 00:00:00	1	2020-01-21 00:51:08	2020-01-21 00:51:08
3	6	2020-01-25 00:00:00	2020-01-30 00:00:00	1	2020-01-21 00:53:57	2020-01-21 00:53:57
4	6	2020-01-25 00:00:00	2020-01-30 00:00:00	1	2020-01-21 00:54:28	2020-01-21 00:54:28
5	6	2020-01-25 00:00:00	2020-01-30 00:00:00	1	2020-01-21 00:54:28	2020-01-21 00:54:28
6	6	2020-01-25 00:00:00	2020-01-30 00:00:00	1	2020-01-21 00:54:29	2020-01-21 00:54:29
7	6	2020-01-25 00:00:00	2020-01-30 00:00:00	1	2020-01-21 00:54:30	2020-01-21 00:54:30
8	6	2020-01-25 00:00:00	2020-01-30 00:00:00	1	2020-01-21 00:54:31	2020-01-21 00:54:31
9	6	2020-01-25 00:00:00	2020-01-30 00:00:00	1	2020-01-21 00:54:31	2020-01-21 00:54:31
10	6	2020-01-25 00:00:00	2020-01-30 00:00:00	1	2020-01-21 00:54:32	2020-01-21 00:54:32
11	6	2020-01-23 00:00:00	2020-01-30 00:00:00	1	2020-01-21 00:54:37	2020-01-21 00:54:37
12	6	2020-01-23 00:00:00	2020-01-30 00:00:00	1	2020-01-21 00:54:38	2020-01-21 00:54:38
13	6	2020-01-22 00:00:00	2020-01-30 00:00:00	1	2020-01-21 00:54:42	2020-01-21 00:54:42
14	6	2020-01-22 00:00:00	2020-01-30 00:00:00	1	2020-01-21 00:54:43	2020-01-21 00:54:43
15	6	2020-01-21 00:00:00	2020-01-30 00:00:00	1	2020-01-21 00:54:46	2020-01-21 00:54:46
16	6	2020-01-21 00:00:00	2020-01-30 00:00:00	1	2020-01-21 00:54:47	2020-01-21 00:54:47
17	6	2020-01-21 00:00:00	2020-01-30 00:00:00	1	2020-01-21 00:54:48	2020-01-21 00:54:48
18	6	2020-01-21 00:00:00	2020-01-30 00:00:00	1	2020-01-21 00:55:02	2020-01-21 00:55:02
19	6	2020-01-22 00:00:00	2020-01-30 00:00:00	1	2020-01-21 00:56:00	2020-01-21 00:56:00
\.


--
-- Name: unavailabilities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.unavailabilities_id_seq', 1, false);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, role_id, first_name, last_name, gender, email, password, profile_image, face_id, touch_id, access_token, unique_code, notification_mute_status, notification_mute_end, status, create_time, update_time, fcmid, stage, device_name, receipt, expiry_time, notification_mute_start) FROM stdin;
61	2	Partner	One	Male	partnerone@yopmail.com	$2a$10$hcNkREvxZOBIEYPChiPBSuc6pf57Py.UU57pLA0tiW64AVm11nycy	\N	\N	\N	\N		\N	\N	1	2020-04-16 22:47:49	2020-04-16 22:47:49	\N	1	\N	\N	\N	\N
60	2	Partner	One	Male	partnertwo@yopmail.com	$2a$10$Zgok9DwQrS2.148le0P44.xfcd.iDwJt92Pg2E6TNYDAh8W5S4IwG	\N	\N	\N	\N		\N	\N	1	2020-04-16 22:46:50	2020-04-16 23:24:09	BDSPK6589G	1	\N	\N	\N	\N
25	2	Neha	Sharma	Female	neha.sharma@subcodevs.com	$2a$10$UWZKK/Ikhpw9aUHU/OIwre0huVAHtERMSyrJf/fnyJBcHJSPEkR2a	\N	\N		\N		\N	\N	1	2020-01-27 05:41:55	2020-04-15 23:09:33	BDSPK6589G	1	\N	\N	\N	\N
24	2	Balwant	Singh	Male	balwant.singh@subcodevs.com	$2a$10$HxYIMqZxtZsN.7mCUJXGa.k.LGEHT6FcIJR7iGs8GZHjyo1IEaWzC	1587019912809.jpeg	\N	\N	\N		\N	\N	1	2020-01-27 05:37:42	2020-04-15 23:10:59	eyJhbGciOiJIUzI1NiIsInRNNYUI	1	\N	\N	\N	\N
1	1	Navneet	Kumar	Male	navneet.kumar@subcodevs.com	$2a$10$VEwSlOIYPfnDYG5nX4zrE.g7vDujZmpaBfcS/5mAuncC/jz1WKePa	\N	\N	\N	\N		\N	\N	1	2020-01-15 00:00:00	2020-01-22 05:57:29	\N	1	\N	\N	\N	\N
26	2	Monika	Sharma	Female	monika.sharma@subcodevs.com	$2a$10$YGJsRqXRXsxfcj8fLUIcTO2FArzUeq6wNhK3WuMmBUAqne5XRiQwC	\N	\N	\N	\N		\N	\N	1	2020-02-10 21:32:38	2020-02-17 06:53:35	\N	1	\N	\N	\N	\N
338	2	mka	mka	female	mka1@yopmail.com	$2a$10$P/mNOTzK4KIBgToYJuHM2OuC79i4mmhhRvtWuIocMaAADg4ImHUnu	\N	\N	\N	\N	FEAR	\N	\N	1	2020-06-08 05:45:36	2020-06-08 05:45:36	\N	1	\N	\N	\N	\N
310	2	tests	users	Female	testing@gmail.com	$2a$10$Ec0JVYoljF0VGt/jSn5dlO/8hvqFgZUa5ioGiR2Z16qMZBB3mLhwq	\N	\N	\N	\N	RKOM	\N	\N	1	2020-05-25 01:45:43	2020-05-25 01:45:43	\N	1	\N	\N	\N	\N
3	2	Hsjs	Hshhs	female	bsjjs@hdjis.hsjks	$2a$10$w35qD.lAZ3l5x/Tx8Q0zku6FLRnLfg26thR962uWCRwdUjl1ZNbxm	\N	\N	\N	\N	ECZY	\N	\N	1	2020-05-05 06:43:29	2020-05-05 06:43:29	\N	1	\N	\N	\N	\N
13	2	dsfsdf	sgsfg	female	sgsfg@efewfr.weg	$2a$10$F95qn8gOAGDztQWHH0rrs.4FDohb8kPCa/JbZJ7eTRmMEQNOvqGg2	\N	\N	\N	\N	OJFT	\N	\N	1	2020-05-05 06:57:55	2020-05-05 06:57:55	\N	1	\N	\N	\N	\N
28	2	Test	User	Female	tester5@yopmail.com	$2a$10$kNdeyBEZCrffYkdyMKDfrebIAcwj3I44QQx5TOwqIKmhIzsO6L8wK	\N	\N	\N	\N	ZAHV	\N	\N	1	2020-05-05 07:26:47	2020-05-06 09:51:22	fJdaNn10TJedC7-L3wYBxG:APA91bHZyC-hvENtlYiAfW-Jyk...	5	\N	\N	\N	\N
14	2	sfsdf	sdgdsg	female	sgsdg@egsdg.srgrsg	$2a$10$p7pvSgc9d0eEeuAXKixAzecpvMs.mg8JK4Kl4BS4E9oTAVm0EJoeu	\N	\N	\N	\N	WHDC	\N	\N	1	2020-05-05 06:59:14	2020-05-05 06:59:14	\N	1	\N	\N	\N	\N
6	2	Jsjka	Jdjdj	female	jsjjs@jskks.hsjsj	$2a$10$JqJ0frQDv75H4QTRGdqEs.8eirtzqPXARE0SPRDBx/Ddf9zjXBrHq	\N	\N	\N	\N	KGEM	\N	\N	1	2020-05-05 06:47:21	2020-05-05 06:47:21	\N	1	\N	\N	\N	\N
7	2	sdfgsdf	sdgsdfg	female	sdgfsf@faesf.aefaf	$2a$10$7hKO4vaNlKpY743UDS.u7.j3WHHhfLhoxT7yzQARUPAYjh4YsIOlu	1588661306543.jpeg	\N	\N	\N	IEWN	\N	\N	1	2020-05-05 06:48:10	2020-05-05 06:48:26	\N	1	\N	\N	\N	\N
355	2	Vhhuj	Gggh	female	an.globaliasoft@gmail.com	$2a$10$mIhWPUzV2kzUPlSSNcfYru3hpv445TkShdVcmTeWcNhjq6UeWhFT6	\N	\N	\N	\N	FNAD	\N	\N	1	2020-06-11 12:08:04	2020-06-11 12:08:04	\N	1	\N	\N	\N	\N
9	2	test	users	male	testusers3@gmail.com	$2a$10$rRUHmclVF1Uwl4LESwPMfu/j7qnzM0FpSPalszvBRnzGjEnu7GlN6	\N	\N	\N	\N	FNEU	\N	\N	1	2020-05-05 06:50:31	2020-05-05 06:50:31	\N	1	\N	\N	\N	\N
10	2	Hsjjs	Jzjjs	female	hsjjs@jskks.jsks	$2a$10$bi9TbifTF.5sA91SWKTNYee5Iw5K015SV/zGavt0ikX4qV0PCL5F2	\N	\N	\N	\N	XVBD	\N	\N	1	2020-05-05 06:52:12	2020-05-05 06:52:12	\N	1	\N	\N	\N	\N
15	2	sgsfg	sgsdg	female	sdgdsg@aegsg.sgs	$2a$10$0gy6OWKdHsVLw7XYvOc3JOMchDzdf9KUJgjVdJutYkFSHrX0.C1zO	\N	\N	\N	\N	UYHG	\N	\N	1	2020-05-05 07:01:50	2020-05-05 07:01:50	\N	1	\N	\N	\N	\N
16	2	sdfdsf	sdgs	female	sdgsdfg@afasf.rggerg	$2a$10$taqcEoGeRerKQEmIHhvhpulO9y1FBqrnYSiNxKy2pQsIPIi.lLrui	\N	\N	\N	\N	LXEX	\N	\N	1	2020-05-05 07:02:14	2020-05-05 07:02:14	\N	1	\N	\N	\N	\N
11	2	dvdzxfv	dsfvdsfv	female	sdfdsf@wfaf.aefsf	$2a$10$jbSSN1.uAqK1sGTJEEK9YusHlF1kh8Y.9UXc7zestlm9GVdE6CmjC	1588661740356.jpeg	\N	\N	\N	XOOF	\N	\N	1	2020-05-05 06:55:35	2020-05-05 06:55:40	\N	1	\N	\N	\N	\N
17	2	Jsjs	Jsjs	female	jsjjs@jsjj.nskjs	$2a$10$krbCGiXgtd5bGJcJVggQK.z0UjEDrNSLWD/Hymisxkkj3DEKvML.a	\N	\N	\N	\N	OCZZ	\N	\N	1	2020-05-05 07:02:57	2020-05-05 07:02:57	\N	1	\N	\N	\N	\N
18	2	dsfdsf	sdfdsf	female	fsf@fgeesf.aefgaf	$2a$10$RjmM/BChFhZHd.Mr1MMPYOQKxS3ZsVxObFvt4Bt6W1tfWEQwe3o8O	\N	\N	\N	\N	RLCW	\N	\N	1	2020-05-05 07:04:28	2020-05-05 07:04:28	\N	1	\N	\N	\N	\N
318	2	AKHILESH	SINGH	male	akhilesh@yopmail.com	$2a$10$EZLAwJcz8l8Tc0hVZPWZ4OfHRD8AVtaPj/bOONGobciWlrmI2qCJO	1590528717265.jpeg	\N	\N	\N	XZID	\N	\N	1	2020-05-26 09:31:24	2020-05-26 09:33:02	fRcm_o67Qbq23swBOMeyhJ:APA91bFr9OXIJh6Y-ufDejWGnlZnZ_CuiMmDKSF5KXusdDpvId3O_79NZsG2BuPJBM8_Nkfm5bwSABaYJDGVLIye3MATpGx3HsgAmmUQ--U7L3wmQN7cK5rAgeriYK5yVVvENXH9bmCR	1	\N	\N	\N	\N
31	2	Test	User	Female	tester8@yopmail.com	$2a$10$jJolY7wgMx2CoXpARA2PYewtfi5zKtnlpFEO3gGpZOPgL.4fKlASu	\N	\N	\N	\N	DVBZ	\N	\N	1	2020-05-05 07:30:47	2020-05-06 11:52:10	fJdaNn10TJedC7-L3wYBxG:APA91bHZyC-hvENtlYiAfW-Jyk...	6	\N	\N	\N	\N
2	2	Test	User	Female	tester34@yopmail.com	$2a$10$AiCxq2ah9gJsOWjh2S4kHObMYVCPhOIugITChh.l/w.TEoHIpEF1.	\N	\N	\N	\N	NAHJ	\N	\N	1	2020-05-05 06:04:16	2020-05-05 06:57:30	fJdaNn10TJedC7-L3wYBxG:APA91bHZyC-hvENtlYiAfW-Jyk...	1	\N	\N	\N	\N
19	2	afseaf	afasf	female	asfasf@afasf.asfasf	$2a$10$marsDSYwK6JbnmvEZENOz.QpCRVAKDxO/D2Yg2GH1e/EcRuhXdl2y	1588662301297.jpeg	\N	\N	\N	NCYD	\N	\N	1	2020-05-05 07:04:47	2020-05-05 07:05:01	\N	1	\N	\N	\N	\N
20	2	Jsjs	Hsjs	female	bsjjs@jdjs.ksoos	$2a$10$qsexsE9p7DYyvxvcbdVFZO9GG8/noLYTt/6ZouWZKoXp0qW8sP5mS	\N	\N	\N	\N	NJGK	\N	\N	1	2020-05-05 07:05:17	2020-05-05 07:05:17	\N	1	\N	\N	\N	\N
21	2	Jzjs	Jdjsj	female	ksjs@jsks.jzkks	$2a$10$XwkcE.Y464EsZ5piK54JiOctUt8OQ0gzL/.yc/v5PSW/1N/3O2aES	\N	\N	\N	\N	MQEQ	\N	\N	1	2020-05-05 07:06:29	2020-05-05 07:06:29	\N	1	\N	\N	\N	\N
22	2	Test	User	Female	tester2@yopmail.com	$2a$10$LJNMoDU/j88/I6ts3/5evOCokru8NgcuWqfo6bFgbJSc2qyOsy/RG	\N	\N	\N	\N	VWMR	\N	\N	1	2020-05-05 07:18:16	2020-05-06 10:03:30	fJdaNn10TJedC7-L3wYBxG:APA91bHZyC-hvENtlYiAfW-Jyk...	5	\N	\N	\N	\N
27	2	Test	User	Female	testusers12@gmail.com	$2y$12$8gHAAkwN.94SSQDIZqociOi8obGlXALDmMpeYJEEMKPt.BtY7QAGO	\N	\N	\N	\N	BHRJ	\N	\N	1	2020-05-05 07:23:59	2020-05-09 06:22:12	1234567894dsd	6	\N	\N	\N	\N
12	2	test	user	male	testuser111@gmail.com	$2y$12$8gHAAkwN.94SSQDIZqociOi8obGlXALDmMpeYJEEMKPt.BtY7QAGO\n	\N	\N	\N	\N	\N	\N	\N	0	2020-04-16 22:47:49	2020-04-16 22:47:49	\N	1	\N	\N	\N	\N
32	2	Test	User	Female	tester9@yopmail.com	$2a$10$G.b7D7uBfoWMb/UWEaO/7.2DZMNCkteF3mb5NSJ7K1GFLyrhm7R1q	\N	\N	\N	\N	YYQE	\N	\N	1	2020-05-05 09:20:32	2020-05-06 12:06:30	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	5	\N	\N	\N	\N
30	2	Test	User	Female	tester7@yopmail.com	$2a$10$rcJy4wn2aI3lCb.Fy6VMueqZZhGGMUBxQOPEZNlsmH4afN6Swz1Bu	\N	\N	\N	\N	LGGH	\N	\N	1	2020-05-05 07:30:11	2020-05-06 11:52:15	fJdaNn10TJedC7-L3wYBxG:APA91bHZyC-hvENtlYiAfW-Jyk...	6	\N	\N	\N	\N
23	2	Test	User	Female	tester3@yopmail.com	$2a$10$8uIR2eBzi4OtePKIsQS6ie8Vo6oJE5HZ.2YEriaedWSC76q57lIJO	\N	\N	\N	\N	DQGV	\N	\N	1	2020-05-05 07:22:19	2020-05-06 09:11:06	fJdaNn10TJedC7-L3wYBxG:APA91bHZyC-hvENtlYiAfW-Jyk...	3	\N	\N	\N	\N
4	2	Test	User	Female	tester1@yopmail.com	$2a$10$buAzlJ1ojiqbqyt1vCk73OvAsznI0gjs4lLWd5Mg.sRohpyamWDIS	1588661836627.jpeg	\N	\N	\N	JOWA	\N	\N	1	2020-05-05 06:44:37	2020-05-05 09:13:27	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	4	\N	\N	\N	\N
47	2	Test	User	Female	tester24@yopmail.com	$2a$10$OZmTo2OdPCVgsjZy8TCHM.WmLvAFCfGdtNwJxhSsbJSO9GQpS2ErC	\N	\N	\N	\N	JLFN	\N	\N	1	2020-05-05 12:09:30	2020-05-05 12:20:48	cP7o-75PCUjAlbV4M-eU4X:APA91bHP1nLLKBZ5OLHBD7Kt3muGAfMjBZSScIjiqdjTI7f4xpCE_n3Dd2HFDbBW98C8aetCGFjIEG2NKNvN3kLOs_M9kypRTFRWJPfnvF6iFUV6ALKHH1XzMjPX_xePJlhY2yFOKytG	4	\N	\N	\N	\N
38	2	Test	User	Female	tester15@yopmail.com	$2a$10$ZU71bgihSLJVx7wkAbUbKu/aMCQL.pjC28QrfEvsNX42Ntkj542ym	\N	\N	\N	\N	BPJN	\N	\N	1	2020-05-05 09:47:38	2020-05-05 09:47:56	fUTYBQHkRuCbgLDwTCjOcr:APA91bF9-gSDXPNH3c395JEFy3BG9kRXzpZQKsmGyQRIOjXhWsjfqEBbcjH1T8CDA7ASIx0C9BiV6Bngr4mn2YjuT99Ca1FCT9-VRrM-mbCJZNS7FjaajyTu4OsTDgxcnk4oz3m4UoDf	4	\N	\N	\N	\N
50	2	Test	User	Female	tester27@yopmail.com	$2a$10$fs9r.KwcdBj5ycSx0GSTWeejjVEuSK2.Q.CH.wTx.z0yFR5ELma6q	\N	\N	\N	\N	TTCQ	\N	\N	1	2020-05-05 01:00:59	2020-05-05 01:01:20	fUTYBQHkRuCbgLDwTCjOcr:APA91bF9-gSDXPNH3c395JEFy3BG9kRXzpZQKsmGyQRIOjXhWsjfqEBbcjH1T8CDA7ASIx0C9BiV6Bngr4mn2YjuT99Ca1FCT9-VRrM-mbCJZNS7FjaajyTu4OsTDgxcnk4oz3m4UoDf	4	\N	\N	\N	\N
37	2	Test	User	Female	tester14@yopmail.com	$2a$10$hjVw2kM6G8vBkdef/H6wf.2XwOp7zfDuevHkwxqWHiq63EGW4xGky	\N	\N	\N	\N	TVAI	\N	\N	1	2020-05-05 09:44:52	2020-05-05 09:45:12	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	4	\N	\N	\N	\N
36	2	Test	User	Female	tester13@yopmail.com	$2a$10$SPtpHXDRBCVICSlXLEhmj.pURh8YJaocu7RfuUXv2SyT5j2dMImeK	\N	\N	\N	\N	KSRV	\N	\N	1	2020-05-05 09:44:26	2020-05-05 09:44:46	fUTYBQHkRuCbgLDwTCjOcr:APA91bF9-gSDXPNH3c395JEFy3BG9kRXzpZQKsmGyQRIOjXhWsjfqEBbcjH1T8CDA7ASIx0C9BiV6Bngr4mn2YjuT99Ca1FCT9-VRrM-mbCJZNS7FjaajyTu4OsTDgxcnk4oz3m4UoDf	4	\N	\N	\N	\N
39	2	Test	User	Female	tester16@yopmail.com	$2a$10$xxZfvdwkOZ5HbkXICnisMu4YVxGJ4.I42ABTOllPgs8Q7iVE4/Cq6	\N	\N	\N	\N	OJDU	\N	\N	1	2020-05-05 09:48:06	2020-05-05 10:00:03	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	4	\N	\N	\N	\N
43	2	Test	User	Female	tester20@yopmail.com	$2a$10$KN2AUIPI9g3UG0Dcd8RxNO5V1zZWwnYTIV5QZlhkXd41g6sXvl51u	\N	\N	\N	\N	TRMO	\N	\N	1	2020-05-05 10:48:39	2020-05-05 10:49:02	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	4	\N	\N	\N	\N
34	2	Test	User	Female	tester11@yopmail.com	$2a$10$dAprwjll5pxBEU/7mqwvCeCsj7T2DSv0fMDHlcWlrjG0bH1xD2YXW	\N	\N	\N	\N	UFOZ	\N	\N	1	2020-05-05 09:39:56	2020-05-06 12:08:23	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
57	2	Test	User	Female	tester30@yopmail.com	$2a$10$rctPref9237gr22F6d3HhOEGfpbi.J1zo3dYZjwaPMZHLKmezhPNm	\N	\N	\N	\N	HEMC	\N	\N	1	2020-05-06 05:22:49	2020-05-06 12:42:40	fJdaNn10TJedC7-L3wYBxG:APA91bHZyC-hvENtlYiAfW-Jyk...	6	\N	\N	\N	\N
42	2	Test	User	Female	tester19@yopmail.com	$2a$10$b4D2CvdfGJIjj7EZjhQ6Le8nxFDgXQz3ZIIUgAL5HJQ9Kix2I7HLO	\N	\N	\N	\N	CJSZ	\N	\N	1	2020-05-05 10:48:16	2020-05-05 10:48:34	fUTYBQHkRuCbgLDwTCjOcr:APA91bF9-gSDXPNH3c395JEFy3BG9kRXzpZQKsmGyQRIOjXhWsjfqEBbcjH1T8CDA7ASIx0C9BiV6Bngr4mn2YjuT99Ca1FCT9-VRrM-mbCJZNS7FjaajyTu4OsTDgxcnk4oz3m4UoDf	4	\N	\N	\N	\N
44	2	Test	User	Female	tester21@yopmail.com	$2a$10$NoCJulSLle13D.ZTXkCiw.17di4C0tKF0hsZ5KaIPa1Tds7c.h/QC	\N	\N	\N	\N	CMBH	\N	\N	1	2020-05-05 10:53:07	2020-05-05 12:09:51	fUTYBQHkRuCbgLDwTCjOcr:APA91bF9-gSDXPNH3c395JEFy3BG9kRXzpZQKsmGyQRIOjXhWsjfqEBbcjH1T8CDA7ASIx0C9BiV6Bngr4mn2YjuT99Ca1FCT9-VRrM-mbCJZNS7FjaajyTu4OsTDgxcnk4oz3m4UoDf	4	\N	\N	\N	\N
45	2	Test	User	Female	tester22@yopmail.com	$2a$10$iaMo3zKaT1LSV7wPe0Q5uu1584L38EUMUxZvXfLc0JB1kMn2MLzFS	\N	\N	\N	\N	NFJI	\N	\N	1	2020-05-05 10:53:33	2020-05-05 12:11:33	cP7o-75PCUjAlbV4M-eU4X:APA91bHP1nLLKBZ5OLHBD7Kt3muGAfMjBZSScIjiqdjTI7f4xpCE_n3Dd2HFDbBW98C8aetCGFjIEG2NKNvN3kLOs_M9kypRTFRWJPfnvF6iFUV6ALKHH1XzMjPX_xePJlhY2yFOKytG	4	\N	\N	\N	\N
40	2	Test	User	Female	tester17@yopmail.com	$2a$10$6xE2YjCyNZ2yZUXba/4kmuHDXU2ZreYPRLVkeXNVGBbLBw4ulF8/m	\N	\N	\N	\N	YZRK	\N	\N	1	2020-05-05 10:12:28	2020-05-05 10:45:54	fUTYBQHkRuCbgLDwTCjOcr:APA91bF9-gSDXPNH3c395JEFy3BG9kRXzpZQKsmGyQRIOjXhWsjfqEBbcjH1T8CDA7ASIx0C9BiV6Bngr4mn2YjuT99Ca1FCT9-VRrM-mbCJZNS7FjaajyTu4OsTDgxcnk4oz3m4UoDf	4	\N	\N	\N	\N
48	2	Test	User	Female	tester25@yopmail.com	$2a$10$w4SOdlxQHtTnWA3cLdLjOeY1GrDDvyteK1A8GQCCUCri0ZnqB.XK6	\N	\N	\N	\N	VUJR	\N	\N	1	2020-05-05 12:29:48	2020-05-05 12:58:48	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	3	\N	\N	\N	\N
46	2	Test	User	Female	tester23@yopmail.com	$2a$10$5Wlall.xtaHWzYROQBoAcu9JUgbBa/cYcRoTB4WtxHwA2QNLD693q	\N	\N	\N	\N	XDYP	\N	\N	1	2020-05-05 12:05:44	2020-05-05 12:15:39	fUTYBQHkRuCbgLDwTCjOcr:APA91bF9-gSDXPNH3c395JEFy3BG9kRXzpZQKsmGyQRIOjXhWsjfqEBbcjH1T8CDA7ASIx0C9BiV6Bngr4mn2YjuT99Ca1FCT9-VRrM-mbCJZNS7FjaajyTu4OsTDgxcnk4oz3m4UoDf	4	\N	\N	\N	\N
49	2	Test	User	Female	tester26@yopmail.com	$2a$10$Bsda0auXrTlt9VQNeQAzb.k.ud89qqw6rPQdtW2nHVlDEHm3fBS9q	\N	\N	\N	\N	IASV	\N	\N	1	2020-05-05 12:30:21	2020-05-05 12:31:14	dzRpPkJbDk7OgEIvDMdO8a:APA91bGbgslSWr6Bpb99bhNZavZvWrUZL1vRWCIfxrwCP6y80d04fk19ne5V3hT1dV5Cbx9aNvey60x1DViQ37buj18etU1VvXh4gSb06PZvDeQXKAqhDl6kjAigR1M-XKLxl-S2OMNK	4	\N	\N	\N	\N
29	2	Test	User	Female	tester6@yopmail.com	$2a$10$NEeyTcRM2eWfNKSHoPOCH.XPG9pCSMFiR/7Yi9jDQ0gV7fjPtlK7G	\N	\N	\N	\N	KCRF	\N	\N	1	2020-05-05 07:28:12	2020-05-06 09:51:38	fJdaNn10TJedC7-L3wYBxG:APA91bHZyC-hvENtlYiAfW-Jyk...	5	\N	\N	\N	\N
55	2	sdxds	sdfsdf	female	sdfsdf2efef@dghd.sdgfsdf	$2a$10$fPV67W0LJaHIeMfz.XeGW.tVwNKoIhAeTXcJE0jbCsC.Xvu8Z.Jxm	\N	\N	\N	\N	JGCK	\N	\N	1	2020-05-05 01:11:42	2020-05-05 01:11:42	\N	1	\N	\N	\N	\N
41	2	Test	User	Female	tester18@yopmail.com	$2a$10$Ok0by2XTRV2Aj6kJPEn/COSelKDrQw.tjJtGPAP6a26MDJSfXk87O	\N	\N	\N	\N	YXXJ	\N	\N	1	2020-05-05 10:12:58	2020-05-05 01:02:07	fJdaNn10TJedC7-L3wYBxG:APA91bHZyC-hvENtlYiAfW-Jyk...	4	\N	\N	\N	\N
53	2	Test	User	Female	tester28@yopmail.com	$2a$10$VxXr4L8JrD55785mMav6sOawttWwwfmdA1f/i31814zl/SLzduSN6	\N	\N	\N	\N	EGXO	\N	\N	1	2020-05-05 01:02:18	2020-05-05 01:02:18	\N	1	\N	\N	\N	\N
56	2	David	nibley	male	dave@dave.com	$2a$10$roLrMMUVrC/7q6qFn374y.W.0Jxeq5VMNb7dJKL/uBwyxvqZYJLgu	\N	\N	\N	\N	NDEL	\N	\N	1	2020-05-05 02:04:01	2020-05-05 02:04:01	\N	1	\N	\N	\N	\N
54	2	Test	User	Female	tester29@yopmail.com	$2a$10$f8NJKhJ4vMmdUUAJmSMFWulPb5zNtBsmwF.cUP.S2GbBEqmbpE9dG	\N	\N	\N	\N	ZQLO	\N	\N	1	2020-05-05 01:03:10	2020-05-05 01:03:30	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	4	\N	\N	\N	\N
339	2	mka	mka	female	mk1@yopmail.com	$2a$10$69EnDC6eToFmqvexiJHKOe3MRjE9qNAExH.y89SY46Hs6dlX9rsJK	\N	\N	\N	\N	KDTP	0	2020-06-11 07:50:14	1	2020-06-08 05:47:14	2020-06-10 07:48:49	cBGUBvLg3UkCvIyOVaEWgE:APA91bGd17wyo3qilgVfI6KCFWlCBS8DvqnW8en68TCPtgvAb8nLKVCQobnovbWL2aX76zwFYoCXomycf3b8RwzIASz-UJLRVLY337twfgU-GB6eHXgWwHqQs-z8ogGWnhtznrbpn4tM	7	\N	\N	\N	2020-06-10 07:50:14
365	2	Aaa	Abc	female	abc1@yopmail.com	$2a$10$yg9lSld0iS.8UTO.BKjXhuJk/rnVO5OBWdeBU9kBufmMgqs/QUoja	\N	\N	\N	\N	NTJQ	\N	\N	1	2020-06-30 04:29:00	2020-07-01 04:26:34	dAWo1eAZR7a0v8xE19aj4o:APA91bFCoZUC1ICfdzgXcEXIJkRDM7F__WpxpHfeV9kWhimH6RPLiMq606W4lbydTflMHwKUJEaaZL4Z6AlpKpLIniSDeCuzqvRH3BCdnoI9VK15LTfl7drcEDw26FV8CAXiS9oC5qyp	1	\N	\N	\N	\N
70	2	Test	User	Female	tester41@yopmail.com	$2a$10$QfkXLr6dKs7Ppmf1FJnbWuyz3QFiN1n3yf19.E0hn7fiJn20OzLJa	\N	\N	\N	\N	DYEV	\N	\N	1	2020-05-06 12:47:42	2020-05-06 12:50:49	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
64	2	Test	User	Female	tester37@yopmail.com	$2a$10$B1gG7.4R8wqeIoGkIodHOen/Isx8b53H2o1/8N7V0hczc8eOd9GHC	\N	\N	\N	\N	SJGP	\N	\N	1	2020-05-06 12:31:56	2020-05-06 12:32:36	ef_3W_0uSp-SgyBseyU7hw:APA91bEU4kjdhMn0ppVBE4ipXBovKzCFpYAKLFsev_uFjta4SxgDGl4c5LU9kbQTbl9yWwAAyLLFws-7GfaNx_1kyuST8yMSqVs0k6D8YGMD7BP11Bx86yByDSrmLVaWmYbDvca_CLfq	4	\N	\N	\N	\N
63	2	Test	User	Female	tester36@yopmail.com	$2a$10$w8BedfjXlegj8FnHwPjLH.Pkn9e2OvoQS4n61XGE1Ur9dbmNNjkbe	\N	\N	\N	\N	IFDV	\N	\N	1	2020-05-06 12:31:37	2020-05-06 12:32:14	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	5	\N	\N	\N	\N
33	2	Test	User	Female	tester10@yopmail.com	$2a$10$sL/NWcTan28MA0DuSh0cE.SbHJiFoHOZhu.T9RXOoZzQIkI587md6	\N	\N	\N	\N	ZDVP	\N	\N	1	2020-05-05 09:21:17	2020-05-06 12:07:00	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	5	\N	\N	\N	\N
35	2	Test	User	Female	tester12@yopmail.com	$2a$10$/gq6qfmFwyHL5N0.2PNDkudT8afFXeZULdiCcCYVU.v7UISgsdPMC	\N	\N	\N	\N	JNHH	\N	\N	1	2020-05-05 09:40:31	2020-05-06 12:08:49	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
66	2	Test	User	Female	tester39@yopmail.com	$2a$10$YkqAAsdxcnU4c4wLS9F.rOs4FeOyHjtQS7r3nRfyFp0/tGD3fUrAq	\N	\N	\N	\N	MQET	\N	\N	1	2020-05-06 12:35:32	2020-05-06 12:36:18	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
58	2	Test	User	Female	tester31@yopmail.com	$2a$10$fEXkJRUVBPFg.8wSn5Vl.efLaz05kW2hxISZia.qQYT/AbhFwwb5C	\N	\N	\N	\N	IOJU	\N	\N	1	2020-05-06 12:09:07	2020-05-06 12:13:05	ef_3W_0uSp-SgyBseyU7hw:APA91bEU4kjdhMn0ppVBE4ipXBovKzCFpYAKLFsev_uFjta4SxgDGl4c5LU9kbQTbl9yWwAAyLLFws-7GfaNx_1kyuST8yMSqVs0k6D8YGMD7BP11Bx86yByDSrmLVaWmYbDvca_CLfq	6	\N	\N	\N	\N
59	2	Test	User	Female	tester32@yopmail.com	$2a$10$du4wHr4XsteSiJFWwdLDGeBqrOnUEM2qUW8nq9v6ZJLSf.ot/H8zG	\N	\N	\N	\N	UMWL	\N	\N	1	2020-05-06 12:18:44	2020-05-06 12:30:10	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
62	2	Test	User	Female	tester35@yopmail.com	$2a$10$oVgS5Npqnf6nfy0OhKimxeyYU8OtTbzt5X2VImlGCD2bpm11Wl5m.	\N	\N	\N	\N	GONE	\N	\N	1	2020-05-06 12:20:15	2020-05-06 12:31:01	ef_3W_0uSp-SgyBseyU7hw:APA91bEU4kjdhMn0ppVBE4ipXBovKzCFpYAKLFsev_uFjta4SxgDGl4c5LU9kbQTbl9yWwAAyLLFws-7GfaNx_1kyuST8yMSqVs0k6D8YGMD7BP11Bx86yByDSrmLVaWmYbDvca_CLfq	5	\N	\N	\N	\N
65	2	Test	User	Female	tester38@yopmail.com	$2a$10$NcWaw1Sx/wZwHTQCLceueeYZpwEl00oWdCWHr54NeR0HgD.xa34Am	\N	\N	\N	\N	SFLN	\N	\N	1	2020-05-06 12:35:29	2020-05-06 12:35:55	ef_3W_0uSp-SgyBseyU7hw:APA91bEU4kjdhMn0ppVBE4ipXBovKzCFpYAKLFsev_uFjta4SxgDGl4c5LU9kbQTbl9yWwAAyLLFws-7GfaNx_1kyuST8yMSqVs0k6D8YGMD7BP11Bx86yByDSrmLVaWmYbDvca_CLfq	5	\N	\N	\N	\N
67	2	skkdkx	skkcck	female	atw@yopmail.com	$2a$10$3Y92er0Vpirm3c0e5nhCJucNQFQ0eEIFLF2imR4NtbmLVVybnKEmq	\N	\N	\N	\N	TOOK	\N	\N	1	2020-05-06 12:45:23	2020-05-06 12:45:23	\N	1	\N	\N	\N	\N
68	2	bush	Kay	male	if@yopmail.com	$2a$10$rn3dtF7//qz35/5eIJtZa.kxmvU2bOM9xDcvPwqgM.Wvi6379g17m	1588769274214.jpeg	\N	\N	\N	TGFY	\N	\N	1	2020-05-06 12:47:38	2020-05-06 12:47:54	\N	1	\N	\N	\N	\N
71	2	ajsj	skjd	female	ak@yopmail.com	$2a$10$evcqRl2Kf5L8hBPb4wphx.mItNIKrTYpP6GH4sRhWPGqfFwT/pWWS	1588769373467.jpeg	\N	\N	\N	LGDR	\N	\N	1	2020-05-06 12:49:14	2020-05-06 12:50:41	fy-PIK2y_Uunk8QEBtTRUn:APA91bFO5xOPVlmuD6t8Yurh5oYZttXGXzOjGAj3If_LViD-piQ3iY4AZzhQGYdI6SBJ3BycTfi76OXQxLHBJQZmSMlGCzvMOUfhSaSNKLu56cN-nOjYBr1y7NsO17ZlJKHl7QRUpcpy	4	\N	\N	\N	\N
73	2	sgvsxgs	sdgvdsxg	female	dsgdsgv@afaf.afaf	$2a$10$bg5hOomEsWbViTpnPpWTLucqJJLmEjOleyOIi2VBdCr5m6pk5QtBO	\N	\N	\N	\N	EZLW	\N	\N	1	2020-05-06 01:03:37	2020-05-06 01:03:37	\N	1	\N	\N	\N	\N
74	2	sdfgdfg	sgg	female	sdgdsg@awf.af	$2a$10$lEm.jbQJxo7Nhkuni1UeV.moy6NdXVdFaFuyvy98tPwnb/YUtGlEO	\N	\N	\N	\N	XQNP	\N	\N	1	2020-05-06 01:04:19	2020-05-06 01:04:19	\N	1	\N	\N	\N	\N
75	2	dfsf	sdfsdf	female	sgsdf@af.afs	$2a$10$XeGVWoWR7y6f4kH.hG3AFuJPvTjZm8sWzQdjEmESRKPXjnl1MoUou	\N	\N	\N	\N	RYPM	\N	\N	1	2020-05-06 01:05:07	2020-05-06 01:05:07	\N	1	\N	\N	\N	\N
76	2	sfsdf	sdfsf	female	sdfsf@af.aszf	$2a$10$XW7ndyZr5b.mvbekuEOOueLtsxZjBONARY8TsEaTBWLTVNz.p51la	\N	\N	\N	\N	XYWJ	\N	\N	1	2020-05-06 01:06:14	2020-05-06 01:06:14	\N	1	\N	\N	\N	\N
69	2	Test	User	Female	tester40@yopmail.com	$2a$10$0cC44vYR/Plfz7nDN883s.cEE9j5/ql03pfxWDW0GP3c3/VIkvu2q	\N	\N	\N	\N	IYUQ	\N	\N	1	2020-05-06 12:47:38	2020-05-06 12:50:40	ef_3W_0uSp-SgyBseyU7hw:APA91bEU4kjdhMn0ppVBE4ipXBovKzCFpYAKLFsev_uFjta4SxgDGl4c5LU9kbQTbl9yWwAAyLLFws-7GfaNx_1kyuST8yMSqVs0k6D8YGMD7BP11Bx86yByDSrmLVaWmYbDvca_CLfq	6	\N	\N	\N	\N
80	2	Test	User	Female	tester42@yopmail.com	$2a$10$y6lwYDnrSIYUKHwSWSUQHuKFarHlMr3xK8yvWuzKhgr/vC.LTR52W	\N	\N	\N	\N	ANDM	\N	\N	1	2020-05-06 01:09:11	2020-05-06 01:10:59	ef_3W_0uSp-SgyBseyU7hw:APA91bEU4kjdhMn0ppVBE4ipXBovKzCFpYAKLFsev_uFjta4SxgDGl4c5LU9kbQTbl9yWwAAyLLFws-7GfaNx_1kyuST8yMSqVs0k6D8YGMD7BP11Bx86yByDSrmLVaWmYbDvca_CLfq	5	\N	\N	\N	\N
72	2	Ana	Hathaway	female	ana@yopmail.com	$2a$10$uVoSo0FGllRE6ohBWky5vubQM7kGKaGuE0L/8P1p96vNefYA.8s4u	1588769863809.jpeg	\N	\N	\N	QIKA	\N	\N	1	2020-05-06 12:57:23	2020-05-07 08:26:22	eTCwc_kts00kmi-8P9jIUZ:APA91bGRtRBixfJy7X8n0EWuU3SEn7CMw9MV4N2J4KuoxF-ujjZL6f8yAFgw7v1yhc-mRCUr3yXJX_chmOVtamv_fqYbvWM3cgFT90vr-NYwvIMvY-m0P5A0tE5CgaI2Wkz6YxYKsmpK	4	\N	\N	\N	\N
77	2	Jsjd	Jsjs	female	jsjd@jdkd.jdkd	$2a$10$8dS3YngyT3PI3/NGALfODe4pJ4.eBXQS2y8VXCeAvsVr5u81CifLm	\N	\N	\N	\N	QWHL	\N	\N	1	2020-05-06 01:07:35	2020-05-06 01:07:35	\N	1	\N	\N	\N	\N
78	2	Hzjs	Hsjs	female	hsjs@hsks.jdkd	$2a$10$3mwFyoxr9Dao.7DQAvVfH.z04TtXprCMtxLw7kMYiqeVrT6kQeNhW	\N	\N	\N	\N	YCFE	\N	\N	1	2020-05-06 01:08:07	2020-05-06 01:08:07	\N	1	\N	\N	\N	\N
79	2	adszf	dsdfv	female	sdvdszfv@fa.aef	$2a$10$ivPeJIv/OvbGbFYlCmRK2OagTAnxORNv7XjNWeKcyivpdhCwOT3m.	\N	\N	\N	\N	OZNX	\N	\N	1	2020-05-06 01:08:35	2020-05-06 01:08:35	\N	1	\N	\N	\N	\N
81	2	Test	User	Female	tester43@yopmail.com	$2a$10$PsX/ED41q/SLtB9lLN4W9.xo/q/QOclaGFRkWiS3flZ7/PWZvunOK	\N	\N	\N	\N	KAUM	\N	\N	1	2020-05-06 01:09:14	2020-05-06 01:11:24	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
82	2	Test	User	Female	tester44@yopmail.com	$2a$10$GldZkhKod3oYm3SjHr5Ztek6B1QSejI1GggOyYrJrgEi47fUubuS6	\N	\N	\N	\N	FNPL	\N	\N	1	2020-05-06 01:14:28	2020-05-06 01:14:50	ef_3W_0uSp-SgyBseyU7hw:APA91bEU4kjdhMn0ppVBE4ipXBovKzCFpYAKLFsev_uFjta4SxgDGl4c5LU9kbQTbl9yWwAAyLLFws-7GfaNx_1kyuST8yMSqVs0k6D8YGMD7BP11Bx86yByDSrmLVaWmYbDvca_CLfq	4	\N	\N	\N	\N
83	2	Test	User	Female	tester45@yopmail.com	$2a$10$MfAY9B4BFgrn0wY6tbsBU.kP.9akq7qRuRCkwTMzdE9.7e1wLfPfC	\N	\N	\N	\N	IFMS	\N	\N	1	2020-05-06 01:14:31	2020-05-06 01:15:20	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	4	\N	\N	\N	\N
94	2	Test	User	Female	tester56@yopmail.com	$2a$10$1ynsfr8Qn5mj0r6UW8mWXuK8t3VBhb1Ir60RMY5hP54XF3473NceG	\N	\N	\N	\N	FFHB	\N	\N	1	2020-05-06 01:39:47	2020-05-07 08:51:58	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
95	2	Test	User	Female	tester57@yopmail.com	$2a$10$HAqN1Ti7VQanGHMqN8ssje6aFk2fC3tdvbFeSI1drJtOTpAGjbI8q	\N	\N	\N	\N	PNBP	\N	\N	1	2020-05-06 01:39:51	2020-05-07 08:31:44	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
91	2	Test	User	Female	tester53@yopmail.com	$2a$10$3zcg.1BKRLSbTprbNkkueu.TX4Ssf2SLvGGZsBWQTlZDysHSC.6LC	\N	\N	\N	\N	QUDP	\N	\N	1	2020-05-06 01:34:12	2020-05-06 01:35:36	ef_3W_0uSp-SgyBseyU7hw:APA91bEU4kjdhMn0ppVBE4ipXBovKzCFpYAKLFsev_uFjta4SxgDGl4c5LU9kbQTbl9yWwAAyLLFws-7GfaNx_1kyuST8yMSqVs0k6D8YGMD7BP11Bx86yByDSrmLVaWmYbDvca_CLfq	6	\N	\N	\N	\N
87	2	Test	User	Female	tester49@yopmail.com	$2a$10$49mfG9HaEim1VgkOp4lEK.g09gYIJ9hhbvEcnLIGVZ9lqym19t6Ba	\N	\N	\N	\N	BXPZ	\N	\N	1	2020-05-06 01:22:12	2020-05-06 01:22:58	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
88	2	Test	User	Female	tester50@yopmail.com	$2a$10$0DJKRIzcwiQRM/PzZD6g3OK4JFwQjgrYg0pgUb/XrBkGsjXxFVBBO	\N	\N	\N	\N	APQC	\N	\N	1	2020-05-06 01:31:25	2020-05-06 01:31:51	ef_3W_0uSp-SgyBseyU7hw:APA91bEU4kjdhMn0ppVBE4ipXBovKzCFpYAKLFsev_uFjta4SxgDGl4c5LU9kbQTbl9yWwAAyLLFws-7GfaNx_1kyuST8yMSqVs0k6D8YGMD7BP11Bx86yByDSrmLVaWmYbDvca_CLfq	6	\N	\N	\N	\N
89	2	Test	User	Female	tester51@yopmail.com	$2a$10$RVQn2QHdwoSxAN.YdkG8VeQMwv8iF7HWdSp2kpNQnX9vzFCRn5U..	\N	\N	\N	\N	JXXR	\N	\N	1	2020-05-06 01:31:28	2020-05-06 01:32:07	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
86	2	Test	User	Female	tester48@yopmail.com	$2a$10$3P2.S8Z3o0nWfMA13mJrl.tSzkUGOx2ThjUKgtCoJqtejv16.LPGa	\N	\N	\N	\N	RFKR	\N	\N	1	2020-05-06 01:22:08	2020-05-06 01:22:35	ef_3W_0uSp-SgyBseyU7hw:APA91bEU4kjdhMn0ppVBE4ipXBovKzCFpYAKLFsev_uFjta4SxgDGl4c5LU9kbQTbl9yWwAAyLLFws-7GfaNx_1kyuST8yMSqVs0k6D8YGMD7BP11Bx86yByDSrmLVaWmYbDvca_CLfq	5	\N	\N	\N	\N
85	2	Test	User	Female	tester47@yopmail.com	$2a$10$AOY4o38MaVX5vUyUBUbbi.yGF1VMBsfko7L.xw81Gwc9TXggjNFoS	\N	\N	\N	\N	MCMP	\N	\N	1	2020-05-06 01:17:22	2020-05-06 01:18:48	ef_3W_0uSp-SgyBseyU7hw:APA91bEU4kjdhMn0ppVBE4ipXBovKzCFpYAKLFsev_uFjta4SxgDGl4c5LU9kbQTbl9yWwAAyLLFws-7GfaNx_1kyuST8yMSqVs0k6D8YGMD7BP11Bx86yByDSrmLVaWmYbDvca_CLfq	6	\N	\N	\N	\N
84	2	Test	User	Female	tester46@yopmail.com	$2a$10$FkopihKFc/ilMYKoH.99VOJ3AJsQU8A.gMWrNGiZ.PvndN2NM9AF6	\N	\N	\N	\N	AGPH	\N	\N	1	2020-05-06 01:17:18	2020-05-06 01:18:46	ef_3W_0uSp-SgyBseyU7hw:APA91bEU4kjdhMn0ppVBE4ipXBovKzCFpYAKLFsev_uFjta4SxgDGl4c5LU9kbQTbl9yWwAAyLLFws-7GfaNx_1kyuST8yMSqVs0k6D8YGMD7BP11Bx86yByDSrmLVaWmYbDvca_CLfq	6	\N	\N	\N	\N
90	2	Test	User	Female	tester52@yopmail.com	$2a$10$zsnKhjVwGSximueBNe3x5Ob0z5Bdy2X.X492jbT74Em6n0abBdWkS	\N	\N	\N	\N	OUEX	\N	\N	1	2020-05-06 01:34:08	2020-05-06 01:35:02	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
92	2	Test	User	Female	tester54@yopmail.com	$2a$10$fma8udAvgk61/rS0xz5dxeJWAPHuUIBoSb0VL7wIpJLvAE3cnayua	\N	\N	\N	\N	ESWW	\N	\N	1	2020-05-06 01:37:18	2020-05-06 01:37:52	ef_3W_0uSp-SgyBseyU7hw:APA91bEU4kjdhMn0ppVBE4ipXBovKzCFpYAKLFsev_uFjta4SxgDGl4c5LU9kbQTbl9yWwAAyLLFws-7GfaNx_1kyuST8yMSqVs0k6D8YGMD7BP11Bx86yByDSrmLVaWmYbDvca_CLfq	6	\N	\N	\N	\N
93	2	Test	User	Female	tester55@yopmail.com	$2a$10$g9lF.bi/QS8.TrcXoO.7PeEMRDB8w1l6gq1PIDnb655NL8sdQc2am	\N	\N	\N	\N	DOGU	\N	\N	1	2020-05-06 01:37:22	2020-05-06 01:38:07	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
100	2	tester	users	female	testuser@yopmail.com	$2a$10$CgTk/FEDbyfex4GnxI1kNOixw4nCDLo26IVcdKHRNNGDqXwL79AAa	1588846491539.jpeg	\N	\N	\N	ZHVW	\N	\N	1	2020-05-07 10:14:37	2020-05-07 10:43:57	fJdaNn10TJedC7-L3wYBxG:APA91bHZyC-hvENtlYiAfW-Jyk...	6	\N	\N	\N	\N
96	2	af	SZC	female	axd@af.sf	$2a$10$YA.vxu18ebURvJBosurEDeRqcTbVIXjuXbUdu.N0dKwEp6cnLGCsO	\N	\N	\N	\N	OUBP	\N	\N	1	2020-05-07 08:49:24	2020-05-07 08:49:24	\N	1	\N	\N	\N	\N
97	2	ESDF	SF	female	sdf@af.sg	$2a$10$ylsl9yqlfxs2nG.P0J54LelctYPFuNIz54Y6vdi7hsPAaenzFxQUS	\N	\N	\N	\N	RDDU	\N	\N	1	2020-05-07 08:51:30	2020-05-07 08:51:30	\N	1	\N	\N	\N	\N
103	2	Test	User	Female	tester62@yopmail.com	$2a$10$O0qDlaDCC/.xXL4YSs9hEOH76VC9A498ufajqdpHQgPih3mBDPa62	\N	\N	\N	\N	EQMO	\N	\N	1	2020-05-07 12:49:03	2020-05-07 01:00:15	fDTae80rTjuAXawqwI1Scj:APA91bEnegfkrCQf2IAsmy6lDRfprQVHqUmHd3YdxD3L8zt-5LtNc0_MUwBCcfpUGtuKim3oMYUXL2S3mrMOlO68v27Vg2fA9Vzwcv2P2AXU-h8xum9beBJlTn_NGt-FIsLnOG2Hnc82	6	\N	\N	\N	\N
101	2	Test	User	Female	tester60@yopmail.com	$2a$10$Qbw4RmLHESPWu9tfhh2VnOT2mKkJs4m.Mw8PG6g9MNa1IfolsVrwq	\N	\N	\N	\N	OGQI	\N	\N	1	2020-05-07 10:37:17	2020-05-07 10:41:36	ef_3W_0uSp-SgyBseyU7hw:APA91bEU4kjdhMn0ppVBE4ipXBovKzCFpYAKLFsev_uFjta4SxgDGl4c5LU9kbQTbl9yWwAAyLLFws-7GfaNx_1kyuST8yMSqVs0k6D8YGMD7BP11Bx86yByDSrmLVaWmYbDvca_CLfq	6	\N	\N	\N	\N
102	2	Test	User	Female	tester61@yopmail.com	$2a$10$NZafQ2/7yqYpsB0UqQKO0OZIrwC4V6HbQksjzuE5qN4trbLxK/U3e	\N	\N	\N	\N	FZME	\N	\N	1	2020-05-07 10:47:43	2020-05-07 02:13:56	fJdaNn10TJedC7-L3wYBxG:APA91bHZyC-hvENtlYiAfW-Jyk...	6	\N	\N	\N	\N
98	2	Test	User	Female	tester59@yopmail.com	$2a$10$4eAnBHViJmsfYGkfl1DafOEIlBWPuqIguB41JtZlcITxDzDC7rHb.	\N	\N	\N	\N	EQAI	\N	\N	1	2020-05-07 08:52:44	2020-05-14 06:30:01	1234567894dsd	7	\N	\N	\N	\N
104	2	Tester	User	Male	tester63@yopmail.com	$2a$10$f4aMrHj8uYHG8Lw5uAeSTeWd9EpbGtrNpcDVmL6bcK4s1YgsbDzLm	\N	\N	\N	\N	LKMQ	\N	\N	1	2020-05-07 01:00:51	2020-05-07 01:41:42	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
358	2	Female	Test	female	female@yopmail.com	$2a$10$Olfpq03Al535/VvYtUPHauuScYN1IJuEA1yK6FZ6oa66pcytCbB7W	\N	\N	\N	\N	AATQ	\N	\N	1	2020-06-12 10:54:15	2020-06-12 10:56:29	czIDQJQfS02amsfu51wV9I:APA91bEg7ShlMZ3R7kTVlUQ4sqvdMQOUMORtcvzqHHhX9do_lZRL5sA7zKxmKxh5zDrn9OzpcL2e7c0O7gILl1c_D43Kibr6oAEPSM17yrsvwAOeqPCmX6SvMb9oq_EEazh5miKVwz93	1	\N	\N	\N	\N
366	2	Felice	Mcknight	female	felicemcknight@hotmail.com	$2a$10$Lpzf1K9OXVSVsvMTSu9t8.UBl8UUw0c2tdRj.jLXKoqiQb86fu.lG	\N	\N	\N	\N	ANXJ	\N	\N	1	2020-07-14 04:09:12	2020-07-17 03:35:34	c4q-8mzhJ00npVjO21QbvX:APA91bGHIb-Nn_h2EpeEtl77Kfc-qbBUqRFBsJ8K8hhk5Dcfq-pfP3EZT1MbPtiLuRevs_r-AYjnNjZ3dZ-uappdoZWq8Jwu8Y2e73E7P6mKQjdciGgL08wT0LwDAMiEVuJCGnpXASak	6	\N	\N	\N	\N
110	2	tester	useerrM	male	tester65@gmail.com	$2a$10$JTJBy38m8a0I0zcfixKUduiTCvDSsdxlrRTl2BZaZeDaDF3WS7rIu	1588862110832.jpeg	\N	\N	\N	SKOH	\N	\N	1	2020-05-07 02:35:01	2020-05-07 02:35:11	\N	1	\N	\N	\N	\N
111	2	tester	userm	female	tester66@gmail.com	$2a$10$Lvwt4qGzxmFbQztvPQy7UOhbcaIzRZ9EyYXy72j9bMCXd.fTY1JNO	\N	\N	\N	\N	MNJZ	\N	\N	1	2020-05-07 02:37:28	2020-05-07 02:37:28	\N	1	\N	\N	\N	\N
105	2	Testerrr	Userrr	Female	tester64@yopmail.com	$2a$10$ssNLJ7VIJvZiVWfDQVQxR./Yh8XIZwDJVKJfcGqSpHnOZJwisqni2	\N	\N	\N	\N	SBYB	\N	\N	1	2020-05-07 01:01:10	2020-05-07 01:01:52	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
106	2	test	test	female	test70@yopmail.com	$2a$10$/K1ywNb2G2URmzHKn6kZ8uFK6ns8Q4fEVht7m7xCfkk9CIyUtd1Au	\N	\N	\N	\N	MLSN	\N	\N	1	2020-05-07 01:46:13	2020-05-07 01:46:13	\N	1	\N	\N	\N	\N
112	2	test	userm	male	testter65@yopmail.com	$2a$10$ZO3s2OTsFeN4pwwHGZ/2rujvpT.XX1vamveujG.Nl1aZAi20VHVCC	1588862337629.jpeg	\N	\N	\N	KWIO	\N	\N	1	2020-05-07 02:38:45	2020-05-07 02:38:58	\N	1	\N	\N	\N	\N
108	2	at	ta	female	abhinav.t@yopmail.con	$2a$10$6HAhUAB1InT1vTUkhZzeKuKb1Ip6hIbmqBJ.0oMioHPoscPyQ4ihi	\N	\N	\N	\N	KNGA	\N	\N	1	2020-05-07 01:52:33	2020-05-07 01:52:33	\N	1	\N	\N	\N	\N
115	2	Testerrr	Userrr	memale	tester68@yopmail.com	$2a$10$OljuFte5UXu96oH8X3yLL.8M5BS6kWn4diayigmvaRINWR8NdVUbC	\N	\N	\N	\N	JTGT	\N	\N	1	2020-05-07 02:57:38	2020-05-07 02:57:38	\N	1	\N	\N	\N	\N
119	2	Testerrr	Userrr	male	tester72@yopmail.com	$2a$10$2J/Qx5YBH5IczgSJw66s8uA4LM95Z6Pfps5zS665pSxBvq2Jyz4/C	\N	\N	\N	\N	HIWY	\N	\N	1	2020-05-07 03:15:20	2020-05-07 03:19:09	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
113	2	asf	asf	female	tester65@yopmail.com	$2a$10$ax4.In7DEA6eRh9VQkyQpeRpKgmYGU0b6exif9V25qMptxZjM1Bbe	1588862377935.jpeg	\N	\N	\N	TJCE	\N	\N	1	2020-05-07 02:39:32	2020-05-07 03:23:16	fJdaNn10TJedC7-L3wYBxG:APA91bHZyC-hvENtlYiAfW-Jyk...	6	\N	\N	\N	\N
109	2	as	ss	female	aa@yopmail.com	$2a$10$W0lppJ9EhTlUYZ6rCefuPuentnGc3ZvTnXtbMb.lNH2nyq9vkcy0y	\N	\N	\N	\N	LXEM	\N	\N	1	2020-05-07 01:53:43	2020-05-07 01:54:28	fy-PIK2y_Uunk8QEBtTRUn:APA91bFO5xOPVlmuD6t8Yurh5oYZttXGXzOjGAj3If_LViD-piQ3iY4AZzhQGYdI6SBJ3BycTfi76OXQxLHBJQZmSMlGCzvMOUfhSaSNKLu56cN-nOjYBr1y7NsO17ZlJKHl7QRUpcpy	6	\N	\N	\N	\N
117	2	Testerrr	Userrr	female	tester70@yopmail.com	$2a$10$5g3COE334LZi06kouMwQ2.lbbRrndnhtaKXt7/Tt7vmp8FNtkfiwe	\N	\N	\N	\N	QICV	\N	\N	1	2020-05-07 02:57:58	2020-05-07 03:07:38	fDTae80rTjuAXawqwI1Scj:APA91bEnegfkrCQf2IAsmy6lDRfprQVHqUmHd3YdxD3L8zt-5LtNc0_MUwBCcfpUGtuKim3oMYUXL2S3mrMOlO68v27Vg2fA9Vzwcv2P2AXU-h8xum9beBJlTn_NGt-FIsLnOG2Hnc82	6	\N	\N	\N	\N
107	2	test	test	female	test71@yopmail.com	$2a$10$uiDUcZT7ls8iEeOGs.3qYeglt8gvCiyy6iQoal9RrJ8nz62AKznUy	\N	\N	\N	\N	NQBA	\N	\N	1	2020-05-07 01:47:10	2020-05-07 02:26:32	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
118	2	Testerrr	Userrr	female	tester71@yopmail.com	$2a$10$Q2j54Ctk5ZxWqlBwYYKfF.48ahomnXfwEtC4sfQdrmUS4M7zM.IoO	\N	\N	\N	\N	FJCX	\N	\N	1	2020-05-07 03:15:12	2020-05-07 03:15:41	fDTae80rTjuAXawqwI1Scj:APA91bEnegfkrCQf2IAsmy6lDRfprQVHqUmHd3YdxD3L8zt-5LtNc0_MUwBCcfpUGtuKim3oMYUXL2S3mrMOlO68v27Vg2fA9Vzwcv2P2AXU-h8xum9beBJlTn_NGt-FIsLnOG2Hnc82	6	\N	\N	\N	\N
120	2	Testerrr	Userrr	male	tester73@yopmail.com	$2a$10$FFhBcgeiipteIuzP5rL0t.0ChiN9eMu5.pc0TW3xpJyb2pVGJ/yey	\N	\N	\N	\N	QOPQ	\N	\N	1	2020-05-07 03:19:54	2020-05-07 03:26:55	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
114	2	Test	Jdjjd	male	tester66@yopmail.com	$2a$10$/IkF0V7tJ3Q6DcJ7.PrDbOQOWb0qJjqQa8f2MxAjG7LMsVuNvCX8G	\N	\N	\N	\N	MTCH	\N	\N	1	2020-05-07 02:45:19	2020-05-07 02:52:39	fDTae80rTjuAXawqwI1Scj:APA91bEnegfkrCQf2IAsmy6lDRfprQVHqUmHd3YdxD3L8zt-5LtNc0_MUwBCcfpUGtuKim3oMYUXL2S3mrMOlO68v27Vg2fA9Vzwcv2P2AXU-h8xum9beBJlTn_NGt-FIsLnOG2Hnc82	6	\N	\N	\N	\N
116	2	Testerrr	Userrr	male	tester69@yopmail.com	$2a$10$iKwK3x.fY2/KFmQI2KwDae/GYfanCEZlvmoYqw5mKID9ZzXu3WTDu	\N	\N	\N	\N	YPWP	\N	\N	1	2020-05-07 02:57:48	2020-05-07 02:58:21	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
121	2	Testerrr	Userrr	male	tester74@yopmail.com	$2a$10$hfkmyL.iR9RwJ0/hs5orUugF8lXzERX3TqDlUGgGVjjTPfvhC0Ex.	\N	\N	\N	\N	TRRC	\N	\N	1	2020-05-07 03:19:57	2020-05-07 03:28:10	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
122	2	Testerrr	Userrr	male	tester75@yopmail.com	$2a$10$Hvt0/fPYivXt/4zfNCqap.z2nVpy33FtEV5ugto/s4OI/FRo8DPeC	\N	\N	\N	\N	MPAW	\N	\N	1	2020-05-07 03:26:15	2020-05-07 03:32:02	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
123	2	Testerrr	Userrr	female	tester76@yopmail.com	$2a$10$812sXdcrPaldAAWRne7WXuQKobQtm5oB9qPT7/G.4dOs3nE4Xirva	\N	\N	\N	\N	KVEJ	\N	\N	1	2020-05-07 03:26:22	2020-05-07 05:18:46	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
125	2	Blake	Lively	female	blakelively@yopmail.com	$2a$10$gM8RE6Xt3EaAmEqQ2mZm0.Z16q/0sJuKFI.VDdt62WFHkV/9mT2Ha	1588868161908.jpeg	\N	\N	\N	MEXS	\N	\N	1	2020-05-07 04:15:09	2020-05-07 04:17:21	dc1ClKkb1krnk3C6Kq1suR:APA91bGV0KNWtHJCllQxtqv-60DGuaANkzAnUHhvIPQmR_MoSWGoka5h1yA0YghS5f6wNxaM8ZJH-4odTmBEnY8Z9ooLGr5x5fxc9QTaiQdZknmG2Ajn8MpdHUdj3fLzkz78_RrqTBF-	6	\N	\N	\N	\N
124	2	a	d	male	ab@yopmail.com	$2a$10$WBN1OAWdznm8VJuoSIx31OKW6/nZM9fK2kXtkIWB.CeNxezjKuSza	1588868013365.jpeg	\N	\N	\N	IFOM	\N	\N	1	2020-05-07 04:12:47	2020-05-07 04:36:56	dWDag3JrAUcltiwyt4H4XW:APA91bFAyhWYVNEv2uWrYh_ku5TnjcFjVu-t6BEdSK9YTRRjL5wCBTCtClP8hcDxWXWo0RjYsI54maDRxDk4q1e680W65ppXSGYZ_Hn0Tf_OSj7Q_9w2P55W5EQ8k68zgvJJSMQxOX7u	6	\N	\N	\N	\N
127	2	David	Mcknight	female	david@powerofzero.com	$2a$10$S0zvgDCTmdEvnm.43gFrYeFMXVAFdSjb1jR1HcSA2Qgj5wsNd2o0u	\N	\N	\N	\N	XACC	\N	\N	1	2020-05-07 05:21:20	2020-07-14 04:16:29	eiXuvUDiUUmPr1jkonX8ZF:APA91bGVczRus9g4jPgno0Nmxnrvm1_auNKrz4SNHGPzy_dRJb36rhWXKcGk47S1dwjRZCR72i7cRQ4tUc4gT65u9oXrKVxZmkjkLsGJBtQPfD8nbUAURmcXEtY46Gp7Vx-JY_Mvejol	1	\N	\N	\N	\N
129	2	He	Qwerty	male	she@subcodevs.com	$2a$10$5830Axb9bIzvceIVhyr5Ie954EjomckHPrskVgwQZ9e7ZM/2nX.jm	1588874370910.jpeg	\N	\N	\N	JOFX	\N	\N	1	2020-05-07 05:59:13	2020-05-07 05:59:31	\N	1	\N	\N	\N	\N
128	2	she	try	female	gry@yopmail.com	$2a$10$0jDg62Ep..8HJtWO6DbHO.cm7QG8W75ySp1eTTRYHbkRzD5GAmoqO	1588874321120.jpeg	\N	\N	\N	VSCI	\N	\N	1	2020-05-07 05:58:22	2020-05-07 06:00:35	d2-0hMHahUB7gK13pHWB1U:APA91bEdlHHHP5j2e5OssO3G77fLqq3tudNKFI1N5IrsPNFBO-k3bDPBBQ6HFS5Nvs03v2bPTuNsLuk17ANMVVWMwPUKaMGqAIZNJAQH1vlyuDfZXOZjSxa37aq2ER9ZzxYpBW1J1nd9	5	\N	\N	\N	\N
367	2	David	Mcknight	female	david@pozmarketing.com	$2a$10$s/M5AWYvzjAwJrwKECTbs.8Jg7zF2UYwouoMJspCCW/msJO51TcJC	\N	\N	\N	\N	BLFR	\N	\N	1	2020-07-14 04:18:32	2020-07-14 04:19:28	eiXuvUDiUUmPr1jkonX8ZF:APA91bGVczRus9g4jPgno0Nmxnrvm1_auNKrz4SNHGPzy_dRJb36rhWXKcGk47S1dwjRZCR72i7cRQ4tUc4gT65u9oXrKVxZmkjkLsGJBtQPfD8nbUAURmcXEtY46Gp7Vx-JY_Mvejol	1	\N	\N	\N	\N
147	2	secF	Userrr	female	tester91@yopmail.com	$2a$10$o8XoKnUWH2a/2ct2fiEOj.zKTz1tYw.BH3GDSEyKAc9EDUf4wwTlu	\N	\N	\N	\N	LTKX	\N	\N	1	2020-05-08 01:02:15	2020-05-08 01:03:26	ezLQXBscTvePlmZWXetGht:APA91bGVhaeSFmV20jZDyPLESMVgu2c-jH-h4Edozy6bqsyuOB-ImCkQ_925uxWTFH86E_oxkGT-fuz7PvT0dAQoXr-LTS6zSbksZb0J0emZBFIo_LP7r9_I0aJVPjioVR_QgRkFEAdn	6	\N	\N	\N	\N
130	2	Eidi	Diid	male	fun@yopmail.com	$2a$10$RvdOGHkL1vtbwRvmqeqM3uOyf6IXqBWg.pHwVeGDvQ1iLHkzmRkYa	\N	\N	\N	\N	AXHV	\N	\N	1	2020-05-07 06:01:01	2020-05-07 06:07:57	d2-0hMHahUB7gK13pHWB1U:APA91bEdlHHHP5j2e5OssO3G77fLqq3tudNKFI1N5IrsPNFBO-k3bDPBBQ6HFS5Nvs03v2bPTuNsLuk17ANMVVWMwPUKaMGqAIZNJAQH1vlyuDfZXOZjSxa37aq2ER9ZzxYpBW1J1nd9	5	\N	\N	\N	\N
140	2	TestF	Userrr	male	tester84@yopmail.com	$2a$10$HYU5QQblv00lUPPn7ipMKOXGEl1Pt75FoTy.Rf6g9Fb09sGGpnHsW	\N	\N	\N	\N	BEIF	\N	\N	1	2020-05-08 06:54:01	2020-05-08 10:58:37	ezLQXBscTvePlmZWXetGht:APA91bGVhaeSFmV20jZDyPLESMVgu2c-jH-h4Edozy6bqsyuOB-ImCkQ_925uxWTFH86E_oxkGT-fuz7PvT0dAQoXr-LTS6zSbksZb0J0emZBFIo_LP7r9_I0aJVPjioVR_QgRkFEAdn	6	\N	\N	\N	\N
144	2	twoFemale	Userrr	female	tester88@yopmail.com	$2a$10$jpSpaXTY.y04VHq1EJ8heuXfGUIPjQmf0ONf.jlkH8VSl1zFaYZtO	\N	\N	\N	\N	FTJA	\N	\N	1	2020-05-08 11:10:48	2020-05-08 11:12:35	ezLQXBscTvePlmZWXetGht:APA91bGVhaeSFmV20jZDyPLESMVgu2c-jH-h4Edozy6bqsyuOB-ImCkQ_925uxWTFH86E_oxkGT-fuz7PvT0dAQoXr-LTS6zSbksZb0J0emZBFIo_LP7r9_I0aJVPjioVR_QgRkFEAdn	6	\N	\N	\N	\N
139	2	TestM	Userrr	male	tester83@yopmail.com	$2a$10$FEXqeU5dhdz.LhprYjQE9O4w6IpxT3eg4k/NSFbAyAH./aP4Y.12K	\N	\N	\N	\N	INLX	\N	\N	1	2020-05-08 06:53:55	2020-05-08 11:06:52	fJdaNn10TJedC7-L3wYBxG:APA91bHZyC-hvENtlYiAfW-Jyk...	6	\N	\N	\N	\N
136	2	Testerrr	Userrr	female	tester80@yopmail.com	$2a$10$43/2zceNd27gOUYYfYVXx.LF1S0Tgi3HHKUF6Y8QAZsG0M7hx/pM2	\N	\N	\N	\N	IYXW	\N	\N	1	2020-05-08 06:30:14	2020-05-08 06:35:38	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
133	2	Testerrr	Userrr	female	tester77@yopmail.com	$2a$10$OJ3AOEPoYIPyRjAE24k88ex8WhKWMHAW45Wtvy3kb.Sox70O0FCs2	\N	\N	\N	\N	XXCG	\N	\N	1	2020-05-08 05:45:42	2020-05-08 06:27:40	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	5	\N	\N	\N	\N
134	2	Testerrr	Userrr	female	tester78@yopmail.com	$2a$10$fhRLhvX6VlTGY.t8FBfVL.XBaeV/.dkDZuoYEizpFxC1BA.eWBKWy	\N	\N	\N	\N	UHFN	\N	\N	1	2020-05-08 05:45:46	2020-05-08 06:27:56	czEDsJsVRwWC8-jRT4hMzT:APA91bHON2A0A3M2lxhsLmZO0e1rLsKd-7153sbW7_4cwMxnMuH6b2U21hEwwSKRT52ijUd5_gY0bWSgXw0EZzJ0NvwvSAyi9xbyhhmoEJKVKSa1ovduITbrlcvy0qZCO1B7UspzFxm5	5	\N	\N	\N	\N
137	2	Testerrr	Userrr	female	tester81@yopmail.com	$2a$10$DkFEDNwueEeSA4JK4C65PuUVDoJKGFBgEN49CDpMS6WJSPRpHJh9O	\N	\N	\N	\N	NRDV	\N	\N	1	2020-05-08 06:35:56	2020-05-08 06:36:42	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
131	2	adam	eava	female	t@yopmail.com	$2a$10$nqscWlmJFeGdLiBRfiK3uulnwYHLunDW8jhhCy4Dv7Gm2hp65uk/2	\N	\N	\N	\N	RJBQ	\N	\N	1	2020-05-07 06:10:24	2020-05-07 06:11:01	d2-0hMHahUB7gK13pHWB1U:APA91bEdlHHHP5j2e5OssO3G77fLqq3tudNKFI1N5IrsPNFBO-k3bDPBBQ6HFS5Nvs03v2bPTuNsLuk17ANMVVWMwPUKaMGqAIZNJAQH1vlyuDfZXOZjSxa37aq2ER9ZzxYpBW1J1nd9	6	\N	\N	\N	\N
138	2	Testerrr	Userrr	male	tester82@yopmail.com	$2a$10$zzBKHHFLiDFB4Kt6azyCj.sXTRWa7BXOX8Gmfj29HXJ8lJsBZHoyK	\N	\N	\N	\N	ARJJ	\N	\N	1	2020-05-08 06:36:05	2020-05-08 06:37:30	czEDsJsVRwWC8-jRT4hMzT:APA91bHON2A0A3M2lxhsLmZO0e1rLsKd-7153sbW7_4cwMxnMuH6b2U21hEwwSKRT52ijUd5_gY0bWSgXw0EZzJ0NvwvSAyi9xbyhhmoEJKVKSa1ovduITbrlcvy0qZCO1B7UspzFxm5	6	\N	\N	\N	\N
143	2	oneMale	Userrr	male	tester87@yopmail.com	$2a$10$.XLdTwDpDK5UxvmITIHgZuwQ/PPU7YdlSIjEHYkclN902omTW7GM.	\N	\N	\N	\N	VPNI	\N	\N	1	2020-05-08 11:10:34	2020-05-08 11:14:33	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
135	2	Testerrr	Userrr	female	tester79@yopmail.com	$2a$10$1AhZaBVZKCWoP7dOqGg1dee7JPJMfdS7pW1j.1cDtLU/MVUSqhP7W	\N	\N	\N	\N	EETW	\N	\N	1	2020-05-08 06:21:36	2020-05-08 07:05:20	fJdaNn10TJedC7-L3wYBxG:APA91bHZyC-hvENtlYiAfW-Jyk...	5	\N	\N	\N	\N
141	2	TestF	Userrr	female	tester85@yopmail.com	$2a$10$XQWrXVpwETjOtPgOVjmUSOrpRLnkse8qPf6UBsKzufOq6wp9hT.JG	\N	\N	\N	\N	WXNX	\N	\N	1	2020-05-08 07:13:18	2020-05-08 07:23:17	fJdaNn10TJedC7-L3wYBxG:APA91bHZyC-hvENtlYiAfW-Jyk...	5	\N	\N	\N	\N
146	2	secF	Userrr	female	tester90@yopmail.com	$2a$10$y6y5VlN4cYIUNkxVdrJbLeBZtJot9aX67YO3grPsa5zeyE7Eo/ZiC	\N	\N	\N	\N	PDAQ	\N	\N	1	2020-05-08 12:45:22	2020-05-08 12:52:28	foCrzbML90J_vsXwjHYFx7:APA91bFNFUZOwGhHz_6MY9Lks1phck2gCX1GzP6mwUibpAYr59pTHaWFOChDHxGEKuookBqHLu3aBYoPk_Bd7h6N2Ktx34R9GQqOMH9Nqpd4q6PMUAadzbYszZXmPONeC-7F8ux2yKb2	6	\N	\N	\N	\N
148	2	secF	Userrr	female	tester92@yopmail.com	$2a$10$jm9aVaPI03pV/8Iy0DMove1VaRavTuTilIc4e4SLr9fChlxEgh5uC	\N	\N	\N	\N	IPIJ	\N	\N	1	2020-05-08 01:03:04	2020-05-08 01:15:06	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
142	2	TestF	Userrr	female	tester86@yopmail.com	$2a$10$6PEVboC0gzUL1NpMdUOcD.4sBcaOcb3c/DgKZAkHNkSZnyjNNyjAu	\N	\N	\N	\N	ANJO	\N	\N	1	2020-05-08 11:00:31	2020-05-08 11:12:00	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
145	2	firstM	Userrr	male	tester89@yopmail.com	$2a$10$p7l0lKb9ViQojDF.L7HSf.X8rg0.4yfpmKyssc34xHYXw2XzB1IhS	\N	\N	\N	\N	BPHK	\N	\N	1	2020-05-08 12:45:05	2020-05-08 12:59:29	fJdaNn10TJedC7-L3wYBxG:APA91bHZyC-hvENtlYiAfW-Jyk...	5	\N	\N	\N	\N
149	2	secF	Userrr	female	tester93@yopmail.com	$2a$10$Uy/cO2frWWkotNxQbBnEG.qf33IKH33ERHTDoq/xbb4v6XYpLwCOa	\N	\N	\N	\N	ELZC	\N	\N	1	2020-05-08 01:22:40	2020-05-08 01:25:48	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	5	\N	\N	\N	\N
150	2	secF	Userrr	female	tester94@yopmail.com	$2a$10$x3eRXY3dcb.tclmE7loavucOLAZeCpF.3W8Ws9hunJVCS.5wU/Tmu	\N	\N	\N	\N	QIVC	\N	\N	1	2020-05-08 01:22:46	2020-05-08 01:31:07	ezLQXBscTvePlmZWXetGht:APA91bGVhaeSFmV20jZDyPLESMVgu2c-jH-h4Edozy6bqsyuOB-ImCkQ_925uxWTFH86E_oxkGT-fuz7PvT0dAQoXr-LTS6zSbksZb0J0emZBFIo_LP7r9_I0aJVPjioVR_QgRkFEAdn	4	\N	\N	\N	\N
132	2	Qa	Aq	female	a@yopmail.com	$2a$10$3N6y7iIIkGg1KFTbHXU1x.qyKLDE3sVtlKrfeh4yGCz/D8VbNWHuW	\N	\N	\N	\N	IIOQ	\N	\N	1	2020-05-07 06:11:32	2020-05-22 04:12:09	cu8cR8qlSXyRh59Uv8SllX:APA91bH-cTdn4k7EYINFN53SqQVGKDEeblgrKT8Z-l4NOmsGFycleVAlb8iYvFLrBgn3M4HD6CqJMPZqUx0nG-NDp7p0kbxRwjLTmjSqimo0yjYJasc-OyW87WV9dxoT98Do_Kdtxvvp	6	\N	\N	\N	\N
152	2	secF	Userrr	female	tester96@yopmail.com	$2a$10$iwJuxwpi.zX1jPHoiwGHlOWSzpggxg7GcXuF0OYwxl0rR7XYGQ3ne	\N	\N	\N	\N	MOGX	\N	\N	1	2020-05-08 01:31:42	2020-05-08 01:34:44	ezLQXBscTvePlmZWXetGht:APA91bGVhaeSFmV20jZDyPLESMVgu2c-jH-h4Edozy6bqsyuOB-ImCkQ_925uxWTFH86E_oxkGT-fuz7PvT0dAQoXr-LTS6zSbksZb0J0emZBFIo_LP7r9_I0aJVPjioVR_QgRkFEAdn	6	\N	\N	\N	\N
160	2	secFs	Userrr	female	tester104@yopmail.com	$2a$10$CSZb3.XKmpRZClLd4oga4ONWjDGDApdNkFA9EyCb01e7/.bDa.dlm	\N	\N	\N	\N	NTXT	\N	\N	1	2020-05-09 09:02:19	2020-05-09 09:05:55	cr5EzKuTQkKG2jHdzoCyvT:APA91bF3j2f7mZDuyhUnJlX7i4cqBcJEUf_S_ne3494cp8eCBoIxUtUrCYDJSH8lt7K3QKnwjUj-bfsuygL5h1v4gAmANSRGfs1roHrgJvkkWE3ES08mZbb9hLua0SotJ8eHj5UvFhiN	6	\N	\N	\N	\N
159	2	firstM	Userrr	male	tester103@yopmail.com	$2a$10$KNutQQe4X20YLKFjyx9ffOHdXjweijBQmTpvdkZsH43G5B7LX4mYC	\N	\N	\N	\N	EURI	\N	\N	1	2020-05-09 09:02:01	2020-05-09 09:05:27	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
151	2	secF	Userrr	female	tester95@yopmail.com	$2a$10$zMWPPSXGLK8dNWgnwHt1N.e2w7yPXKLmyeAR4WMP1U9OFogFFCfJS	\N	\N	\N	\N	VDGS	\N	\N	1	2020-05-08 01:31:38	2020-05-08 01:35:47	ezLQXBscTvePlmZWXetGht:APA91bGVhaeSFmV20jZDyPLESMVgu2c-jH-h4Edozy6bqsyuOB-ImCkQ_925uxWTFH86E_oxkGT-fuz7PvT0dAQoXr-LTS6zSbksZb0J0emZBFIo_LP7r9_I0aJVPjioVR_QgRkFEAdn	6	\N	\N	\N	\N
172	2	secFs	Userrr	female	tester116@yopmail.com	$2a$10$yrQIHCR0lw8eoPz8nxiV1urdeauvkjollpj/2tblsNT1mLTaqUnm6	\N	\N	\N	\N	SWAH	\N	\N	1	2020-05-13 11:48:34	2020-05-13 11:48:34	\N	1	\N	\N	\N	\N
155	2	secF	Userrr	female	tester99@yopmail.com	$2a$10$WzRlf7Ujp5N.qx2Bg/P60.ViRzM/yoWJCeaBenu4yLVg5afWuPnQK	\N	\N	\N	\N	HQUZ	\N	\N	1	2020-05-08 01:40:07	2020-05-08 01:40:41	ezLQXBscTvePlmZWXetGht:APA91bGVhaeSFmV20jZDyPLESMVgu2c-jH-h4Edozy6bqsyuOB-ImCkQ_925uxWTFH86E_oxkGT-fuz7PvT0dAQoXr-LTS6zSbksZb0J0emZBFIo_LP7r9_I0aJVPjioVR_QgRkFEAdn	6	\N	\N	\N	\N
156	2	secF	Userrr	female	tester100@yopmail.com	$2a$10$xfs/oRba9c2Ww2fX3hAc7O1j5V/8RXRYBASrh08rc64gerkQS.XKm	\N	\N	\N	\N	ICEF	\N	\N	1	2020-05-08 01:40:11	2020-05-08 01:42:41	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
153	2	secF	Userrr	female	tester97@yopmail.com	$2a$10$uwG57Xe7ln7HkVWtqB7ji.PqUuKgqakOaHSo.2eTGVdH0Dvf4bGta	\N	\N	\N	\N	HIAE	\N	\N	1	2020-05-08 01:36:25	2020-05-08 01:37:01	ezLQXBscTvePlmZWXetGht:APA91bGVhaeSFmV20jZDyPLESMVgu2c-jH-h4Edozy6bqsyuOB-ImCkQ_925uxWTFH86E_oxkGT-fuz7PvT0dAQoXr-LTS6zSbksZb0J0emZBFIo_LP7r9_I0aJVPjioVR_QgRkFEAdn	6	\N	\N	\N	\N
154	2	secF	Userrr	female	tester98@yopmail.com	$2a$10$IGUUI2aTye3/X9RK64X2W.sgoLu/KFaKswTZIAxSTKlzM8gc4KeAC	\N	\N	\N	\N	JMZH	\N	\N	1	2020-05-08 01:36:30	2020-05-08 01:37:48	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
161	2	secFs	Userrr	female	tester105@yopmail.com	$2a$10$ShPO3RltevhtYQQJ5kkt2.w8JHJIMfFgOxxYKJtYsWbsW8pAif55W	\N	\N	\N	\N	EIQR	\N	\N	1	2020-05-09 09:07:27	2020-05-09 10:12:03	1234567894dsd	6	\N	\N	\N	\N
166	2	secFs	Userrr	female	tester110@yopmail.com	$2a$10$3GYNv03WYh.MO7eB0y6VleWLn3P8UnnkXF5bDbhYdV7stm8iHSpZ.	\N	\N	\N	\N	XFOH	\N	\N	1	2020-05-09 10:16:21	2020-05-09 10:16:56	cr5EzKuTQkKG2jHdzoCyvT:APA91bF3j2f7mZDuyhUnJlX7i4cqBcJEUf_S_ne3494cp8eCBoIxUtUrCYDJSH8lt7K3QKnwjUj-bfsuygL5h1v4gAmANSRGfs1roHrgJvkkWE3ES08mZbb9hLua0SotJ8eHj5UvFhiN	6	\N	\N	\N	\N
165	2	firstM	Userrr	male	tester109@yopmail.com	$2a$10$QlH4bZWgxYsikcxjmUc0zeYuqJhw1O5/3OtBkcfqw/K/HuRU2o6Qm	\N	\N	\N	\N	AEIJ	\N	\N	1	2020-05-09 10:15:50	2020-05-09 10:16:53	foCrzbML90J_vsXwjHYFx7:APA91bFNFUZOwGhHz_6MY9Lks1phck2gCX1GzP6mwUibpAYr59pTHaWFOChDHxGEKuookBqHLu3aBYoPk_Bd7h6N2Ktx34R9GQqOMH9Nqpd4q6PMUAadzbYszZXmPONeC-7F8ux2yKb2	6	\N	\N	\N	\N
162	2	secFs	Userrr	female	tester106@yopmail.com	$2a$10$AX.FdACy8GTuUQHGKG6vH.Tnv0ga0I1QiFoWgjQRKAOOj.Vop1EKm	\N	\N	\N	\N	PHOW	\N	\N	1	2020-05-09 09:07:38	2020-05-09 09:11:34	1234567894dsd	6	\N	\N	\N	\N
163	2	secFs	Userrr	female	tester107@yopmail.com	$2a$10$A1UzPXAunpRVaVb6ZDVKguz0o3y9SYitjYk0YHvF3C35W2gy5Ii6a	\N	\N	\N	\N	PPJN	\N	\N	1	2020-05-09 09:58:15	2020-05-09 10:06:49	cr5EzKuTQkKG2jHdzoCyvT:APA91bF3j2f7mZDuyhUnJlX7i4cqBcJEUf_S_ne3494cp8eCBoIxUtUrCYDJSH8lt7K3QKnwjUj-bfsuygL5h1v4gAmANSRGfs1roHrgJvkkWE3ES08mZbb9hLua0SotJ8eHj5UvFhiN	6	\N	\N	\N	\N
164	2	firstM	Userrr	male	tester108@yopmail.com	$2a$10$4k0MSEDNw8q/EiUYjNI4ge5iwok/7/zX.haBemPTMlDeKUqkAD.tq	\N	\N	\N	\N	XIZG	\N	\N	1	2020-05-09 09:58:26	2020-05-09 10:13:25	foCrzbML90J_vsXwjHYFx7:APA91bFNFUZOwGhHz_6MY9Lks1phck2gCX1GzP6mwUibpAYr59pTHaWFOChDHxGEKuookBqHLu3aBYoPk_Bd7h6N2Ktx34R9GQqOMH9Nqpd4q6PMUAadzbYszZXmPONeC-7F8ux2yKb2	6	\N	\N	\N	\N
171	2	secFs	Userrr	female	tester115@yopmail.com	$2a$10$XidNauJsc8HK6BM/0ulo3ORqIJMhuHI.6P3nbmfhyoqY.pXcmelZO	\N	\N	\N	\N	PTEI	\N	\N	1	2020-05-13 11:35:26	2020-05-13 11:35:26	\N	1	\N	\N	\N	\N
173	2	secFs	Userrr	female	tester117@yopmail.com	$2a$10$NFopH.Jl/TqQv6oZauzILeqnMbVz7WDLfGC0JwGha/tuerXg7X0sG	\N	\N	\N	\N	TOXK	\N	\N	1	2020-05-13 11:49:10	2020-05-13 11:49:10	\N	1	\N	\N	\N	\N
359	2	John	Doe	male	elgoogclass5@gmail.com	$2a$10$Z3pYfZOa9tMK2pNGG1YZW.rtfLcl2/pEl1kg33rHYCDa1XLPdFrUW	\N	\N	\N	\N	KLBT	\N	\N	1	2020-06-13 02:03:05	2020-06-13 02:07:19	cQ2xgf1gTGWJw4SJOy5G4Y:APA91bEm_FdTntmR1ZWufNIO_b3jAB4Nbq40s7SHuSDsFStr4mU0ZhN2scvkqdP0BGMAULJCx7mCArB8LwlYth2otheJSxYo_B-LiNhYMLhXebwdl7GXnHQC4sE9MgtWP4-jbtgDz0ZS	1	\N	\N	\N	\N
158	2	firstM	Userrr	male	tester102@yopmail.com	$2a$10$lr77tcUrYvIC/l8T8zzbReu2YR83tDMs6dyuusyLGud9JZpVtbbGS	\N	\N	\N	\N	SYUV	\N	\N	1	2020-05-08 01:53:00	2020-05-09 12:04:42	1234567894dsd	7	\N	\N	\N	\N
99	2	Test	User	Female	tester58@yopmail.com	$2a$10$6Rsq1duW59RNaITJHlW2z..Zc/YUq3LcJXhnKArS4J8yuSRKA9EEm	\N	\N	\N	\N	SKZL	\N	\N	1	2020-05-07 09:50:00	2020-05-07 12:46:52	fDTae80rTjuAXawqwI1Scj:APA91bEnegfkrCQf2IAsmy6lDRfprQVHqUmHd3YdxD3L8zt-5LtNc0_MUwBCcfpUGtuKim3oMYUXL2S3mrMOlO68v27Vg2fA9Vzwcv2P2AXU-h8xum9beBJlTn_NGt-FIsLnOG2Hnc82	7	\N	\N	\N	\N
170	2	secFs	Userrr	female	tester114@yopmail.com	$2a$10$1pTLTx/qYT8RJJ2uW9Fk7eCZSROpSmQj4/WC3.N3jzTCEUt0xyeKu	\N	\N	\N	\N	ZAEA	\N	\N	1	2020-05-09 10:32:29	2020-05-13 11:42:02	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	7	\N	\N	\N	\N
174	2	secFs	Userrr	female	testuser1@yopmail.com	$2a$10$zlJwCOP9Qryf2j5KkwwxTeaMfAIIBr99khFDY4UDEHz.FXHhjnw9W	\N	\N	\N	\N	TNLL	\N	\N	1	2020-05-13 11:49:32	2020-05-13 11:49:32	\N	1	\N	\N	\N	\N
169	2	firstM	Userrr	male	tester113@yopmail.com	$2a$10$lVJHfo4IRBC.yjXRcDGRquHNTo8TA76KTS3pjUnUWWinvPg6WtymG	\N	\N	\N	\N	ZIHV	\N	\N	1	2020-05-09 10:32:00	2020-05-13 11:41:46	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	7	\N	\N	\N	\N
175	2	secFs	Userrr	female	testuser101@yopmail.com	$2a$10$xE7BumJ67ZtUlyAe6IgKmOLxEaf90489buI05/MwAbP777bYUnWEm	\N	\N	\N	\N	XGGO	\N	\N	1	2020-05-13 11:49:52	2020-05-13 11:49:52	\N	1	\N	\N	\N	\N
176	2	secFs	Userrr	female	testuser111@yopmail.com	$2a$10$dOFomZ3QvkamgGSvfPJHmOnV5GsuRAKfyZJQFKRkS0.pL163QYqqe	\N	\N	\N	\N	KFGC	\N	\N	1	2020-05-13 11:50:05	2020-05-13 11:50:05	\N	1	\N	\N	\N	\N
196	2	secf	userrt	female	user10@yopmail.com	$2a$10$cWxR9ghWtWzKfGeB4To2BOdFvof8cFxCIqJFS/Rav2pcZ34Eop0la	1589379342577.jpeg	\N	\N	\N	YLHX	\N	\N	1	2020-05-13 02:15:36	2020-05-13 02:16:21	cj2rVhFpQm-FEYuxrQlsjj:APA91bFurpLXORS4AkD-f4PtHfjdh9hFVHIcP8Es9Npb5C8F67ussqAnAzM_SENk9mOUGVbC2dk-9cLXwUKbgCgpiqpsv_beA9iRhL0UjKoeXjhTK4701JxLcpRYBZ-1yRmZUcMpF5iW	4	\N	\N	\N	\N
197	2	firstM	user	male	user11@yopmail.com	$2a$10$GBR.oGG0rtIK.1To7K3PguQ6ljrvdnoW3IkJ.36d7DqVm1hn3/Gq.	1589379527967.jpeg	\N	\N	\N	UUJE	\N	\N	1	2020-05-13 02:18:43	2020-05-13 02:19:28	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	6	\N	\N	\N	\N
167	2	secFs	Userrr	female	tester111@yopmail.com	$2a$10$5JtCc6VmLi9hiilP7q5VMOGaRo/a2mB7PPqepCjJpmw1t1IhII1sG	\N	\N	\N	\N	BVPN	\N	\N	1	2020-05-09 10:22:32	2020-05-13 11:54:08	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	7	\N	\N	\N	\N
168	2	firstM	Userrr	male	tester112@yopmail.com	$2a$10$JzTiDej2LBJ46waQWP4dX.FMBLMY2C/n3bbyfc/BxSx8aT8iYBbTG	\N	\N	\N	\N	NELQ	\N	\N	1	2020-05-09 10:22:40	2020-05-13 11:55:37	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	7	\N	\N	\N	\N
177	2	Test	Yese	female	qwert@gmail.com	$2a$10$rsrCS8yORxovdGa/kiocqe/d5cIAeMDgXmx.1/VaJukI8/882IDpW	\N	\N	\N	\N	DVSS	\N	\N	1	2020-05-13 11:59:05	2020-05-13 11:59:05	\N	1	\N	\N	\N	\N
183	2	firstm	userr	male	user1@yopmail.com	$2y$12$8gHAAkwN.94SSQDIZqociOi8obGlXALDmMpeYJEEMKPt.BtY7QAGO	1589376418114.jpeg	\N	\N	\N	AQSR	\N	\N	1	2020-05-13 01:26:39	2020-05-13 01:38:42	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	6	\N	\N	\N	\N
189	2	secFs	Userrr	female	user2@yopmail.com	$2a$10$LOPf5yOvPOYaj5O/YYhVduPT49EdvfeX9lQfr99kgb.nHz5m5IIjq	\N	\N	\N	\N	WECA	\N	\N	1	2020-05-13 01:38:07	2020-05-13 01:38:52	cj2rVhFpQm-FEYuxrQlsjj:APA91bFurpLXORS4AkD-f4PtHfjdh9hFVHIcP8Es9Npb5C8F67ussqAnAzM_SENk9mOUGVbC2dk-9cLXwUKbgCgpiqpsv_beA9iRhL0UjKoeXjhTK4701JxLcpRYBZ-1yRmZUcMpF5iW	6	\N	\N	\N	\N
157	2	secF	Userrr	female	tester101@yopmail.com	$2a$10$NKAvFXtmBkplDN/yS1EDre4UhvFp2SHmqCis/N7gUU/OqC66cQgcu	\N	\N	\N	\N	NXHN	\N	\N	1	2020-05-08 01:52:49	2020-05-13 01:52:54	1234567894dsd	7	\N	\N	\N	\N
186	2	secf	usert	female	user3@yopmail.com	$2a$10$r84/97eEIV7WHiyO1Gec5uHJXsjwl11eaCrZwcj4kKnvybvh5UlQO	\N	\N	\N	\N	HYTN	\N	\N	1	2020-05-13 01:33:36	2020-05-13 01:33:36	\N	1	\N	\N	\N	\N
187	2	secFs	Userrr	female	testuser112@yopmail.com	$2a$10$drqKGLCGe0g4NSTIThK0wufDSa1ZjuOYpuT2d./U4c7sUshYgg2/a	\N	\N	\N	\N	KIDZ	\N	\N	1	2020-05-13 01:34:34	2020-05-13 01:34:34	\N	1	\N	\N	\N	\N
190	2	firstM	user	male	user4@yopmail.com	$2a$10$cz3fP8dGchkX/mMcGjXNGOlXhgy2zjOlvDS0ebrSr9aAyeiqeYipC	1589377742697.jpeg	\N	\N	\N	PWNE	\N	\N	1	2020-05-13 01:48:57	2020-05-13 01:53:23	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	3	\N	\N	\N	\N
191	2	secf	usert	female	user5@yopmail.com	$2a$10$7zm2M3UoVLTXno1Ps4VyQukXBWPyykUM1.LE3WWiD0KJaGprHV./u	1589377799330.jpeg	\N	\N	\N	CEYD	\N	\N	1	2020-05-13 01:49:44	2020-05-13 02:07:44	cj2rVhFpQm-FEYuxrQlsjj:APA91bFurpLXORS4AkD-f4PtHfjdh9hFVHIcP8Es9Npb5C8F67ussqAnAzM_SENk9mOUGVbC2dk-9cLXwUKbgCgpiqpsv_beA9iRhL0UjKoeXjhTK4701JxLcpRYBZ-1yRmZUcMpF5iW	4	\N	\N	\N	\N
192	2	firstM	user	male	user6@yopmail.com	$2a$10$PVbEFaF2sExCeleNu4GFseAeaZhA.aIXSyHja63cNpSiidrWLiEj6	1589378141150.jpeg	\N	\N	\N	PIZL	\N	\N	1	2020-05-13 01:55:35	2020-05-13 02:07:59	cj2rVhFpQm-FEYuxrQlsjj:APA91bFurpLXORS4AkD-f4PtHfjdh9hFVHIcP8Es9Npb5C8F67ussqAnAzM_SENk9mOUGVbC2dk-9cLXwUKbgCgpiqpsv_beA9iRhL0UjKoeXjhTK4701JxLcpRYBZ-1yRmZUcMpF5iW	6	\N	\N	\N	\N
202	2	secF	user	female	user16@yopmail.com	$2a$10$E6SGelSKiHBhktMHNTeh8eYCbQfM2GBljlRZsLZuGEDgNROcGaK16	1589430237534.jpeg	\N	\N	\N	QEFY	\N	\N	1	2020-05-14 04:23:50	2020-05-14 04:24:47	cj2rVhFpQm-FEYuxrQlsjj:APA91bFurpLXORS4AkD-f4PtHfjdh9hFVHIcP8Es9Npb5C8F67ussqAnAzM_SENk9mOUGVbC2dk-9cLXwUKbgCgpiqpsv_beA9iRhL0UjKoeXjhTK4701JxLcpRYBZ-1yRmZUcMpF5iW	4	\N	\N	\N	\N
193	2	secf	user	female	user7@yopmail.com	$2a$10$0S.MBmjDdQGS81ZKcQxe2ulM2Vpq77zFYwgCITigKdthYmRzXa5AS	1589378167463.jpeg	\N	\N	\N	OPXG	\N	\N	1	2020-05-13 01:55:59	2020-05-13 02:09:14	cj2rVhFpQm-FEYuxrQlsjj:APA91bFurpLXORS4AkD-f4PtHfjdh9hFVHIcP8Es9Npb5C8F67ussqAnAzM_SENk9mOUGVbC2dk-9cLXwUKbgCgpiqpsv_beA9iRhL0UjKoeXjhTK4701JxLcpRYBZ-1yRmZUcMpF5iW	6	\N	\N	\N	\N
199	2	firstM	user	male	user13@yopmail.com	$2a$10$hIIU4IG3SiymsUXg.IEWv.OLLrc.iVLHebQ.6C4jzaCGa94EcyPNO	1589429865637.jpeg	\N	\N	\N	WVXR	\N	\N	1	2020-05-14 04:17:25	2020-05-14 04:19:15	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	3	\N	\N	\N	\N
200	2	secF	user	female	user14@yopmail.com	$2a$10$B7Zx5E5Wtg.by7vFrD3Eq.BMklYlYwy/.jeYKovnhcm4Fyphz8/GS	1589429894244.jpeg	\N	\N	\N	EBUP	\N	\N	1	2020-05-14 04:18:08	2020-05-14 04:22:29	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	4	\N	\N	\N	\N
195	2	firstM	user	male	user9@yopmail.com	$2a$10$Bujca.l1U3jT98YkAWsHse2MeEL5mdGWRMLS8cBndPbCy2QQE0LHK	1589379319981.jpeg	\N	\N	\N	AFEJ	\N	\N	1	2020-05-13 02:15:15	2020-05-13 02:16:02	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	3	\N	\N	\N	\N
194	2	secFs	Userrr	female	user8@yopmail.com	$2a$10$uLcFX1UWpSbpfFynqByjzOyMyZOhv6wpvvn029W0Fio9rpHiF14wS	\N	\N	\N	\N	DFQD	\N	\N	1	2020-05-13 02:01:07	2020-05-13 02:25:21	1234567894dsd	1	\N	\N	\N	\N
198	2	secf	ussert	female	user12@yopmail.com	$2a$10$xEh4w/R6bwj0Yrc8Dew.8eIeWqwKnC0ocNN0EkCP217wJk.h1bQ1C	1589379551500.jpeg	\N	\N	\N	YNCC	\N	\N	1	2020-05-13 02:19:06	2020-05-13 02:25:52	1234567894dsd	6	\N	\N	\N	\N
201	2	firstM	USER	male	user15@yopmail.com	$2a$10$NEdHTtgWSna.eW5o8vhnYOJRUohPQTMnJGul7nFp1Bg5UYg1aPeLi	1589430207841.jpeg	\N	\N	\N	YPJD	\N	\N	1	2020-05-14 04:23:20	2020-05-14 04:24:16	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	3	\N	\N	\N	\N
204	2	secF	user	female	user18@yopmail.com	$2a$10$XtA7OCyFRZJ.Lb.TOi1PuOgX4tcPwdFIoKdC2sE.2LEJDNIPfS3R2	1589430450445.jpeg	\N	\N	\N	DHRX	\N	\N	1	2020-05-14 04:27:24	2020-05-14 04:50:07	1234567894dsd	4	\N	\N	\N	\N
207	2	firstM	user	male	user21@yopmail.com	$2a$10$fWU5RHtnYlLaZ/Lq/2RoAuy8j/yC/9hpWGCJ5JVe2enfrYVyeIcYi	1589432228720.jpeg	\N	\N	\N	JQEN	\N	\N	1	2020-05-14 04:57:03	2020-05-14 04:57:25	1234567894dsd	1	\N	\N	\N	\N
206	2	secF	user	female	user20@yopmail.com	$2a$10$6iK0Y.mgLO8HaMOwzODjVelEnys77RVfRBnZJGby3AnjeuPQr1BSa	1589431895976.jpeg	\N	\N	\N	JTDI	\N	\N	1	2020-05-14 04:51:26	2020-05-14 05:00:03	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	6	\N	\N	\N	\N
216	2	secF	user	female	user27@yopmail.com	$2a$10$2rCjtT64TQxzirynzfFwNuWoIY49e0NaZfzAWx3AQ1o2cH7sOOkaG	1589437873986.jpeg	\N	\N	\N	ODRL	\N	\N	1	2020-05-14 06:31:08	2020-05-14 09:29:56	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	7	\N	\N	\N	\N
211	2	secFs	Userrr	female	use25@yopmail.com	$2a$10$iUjmwhshmmlSP7D7yQ1WYudfND54L7MRkf.op3yGTQ6Fh5ll6NmKC	\N	\N	\N	\N	XGJG	\N	\N	1	2020-05-14 05:17:42	2020-05-14 05:18:25	cj2rVhFpQm-FEYuxrQlsjj:APA91bFurpLXORS4AkD-f4PtHfjdh9hFVHIcP8Es9Npb5C8F67ussqAnAzM_SENk9mOUGVbC2dk-9cLXwUKbgCgpiqpsv_beA9iRhL0UjKoeXjhTK4701JxLcpRYBZ-1yRmZUcMpF5iW	4	\N	\N	\N	\N
210	2	secFs	Userrr	female	use24@yopmail.com	$2a$10$DboSW1/tE1EqNT885FLXIeGB5uxoXT1itCOa81dSUNlXkfAZBfwm2	\N	\N	\N	\N	DXST	\N	\N	1	2020-05-14 05:17:39	2020-05-14 05:18:02	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	5	\N	\N	\N	\N
203	2	firstF	user	male	user17@yopmail.com	$2a$10$f2Twu8BZ.73esVERdpsCdu8fPwruB2pQsIkDZYRvK2cVZglN4WV1m	1589430427886.jpeg	\N	\N	\N	IWNT	\N	\N	1	2020-05-14 04:27:02	2020-05-14 05:48:27	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	3	\N	\N	\N	\N
212	2	fistM	user	male	user22@yopmail.com	$2a$10$KbtZiqeH8DnLlwezi7AfkemJ6gAugUjqR4UFuUV6d9Z4QUGwxj2gy	\N	\N	\N	\N	AHUQ	\N	\N	1	2020-05-14 06:22:25	2020-05-14 06:22:25	\N	1	\N	\N	\N	\N
208	2	secFs	Userrr	female	use22@yopmail.com	$2a$10$WC2PyVAxAhoaig3DLGG1Ru3FSo3uCHQIV83kWJTunKMc.W55ZUrd.	\N	\N	\N	\N	DMNP	\N	\N	1	2020-05-14 05:15:09	2020-05-14 05:15:51	cj2rVhFpQm-FEYuxrQlsjj:APA91bFurpLXORS4AkD-f4PtHfjdh9hFVHIcP8Es9Npb5C8F67ussqAnAzM_SENk9mOUGVbC2dk-9cLXwUKbgCgpiqpsv_beA9iRhL0UjKoeXjhTK4701JxLcpRYBZ-1yRmZUcMpF5iW	4	\N	\N	\N	\N
209	2	secFs	Userrr	female	use23@yopmail.com	$2a$10$QhSKud95cMIKiUxBl2ZcReZr3JMJ8AOKigi352xI4zeRcJI9LwvMO	\N	\N	\N	\N	YZAF	\N	\N	1	2020-05-14 05:15:12	2020-05-14 05:16:19	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	5	\N	\N	\N	\N
205	2	firstM	user	male	user19@yopmail.com	$2a$10$obUFCRXt9NGefb3wBJNIM.8RU8omMdXYnwpFVpz01wZhyH1yP.ekG	1589431867058.jpeg	\N	\N	\N	GKCO	\N	\N	1	2020-05-14 04:51:01	2020-05-14 04:52:02	cj2rVhFpQm-FEYuxrQlsjj:APA91bFurpLXORS4AkD-f4PtHfjdh9hFVHIcP8Es9Npb5C8F67ussqAnAzM_SENk9mOUGVbC2dk-9cLXwUKbgCgpiqpsv_beA9iRhL0UjKoeXjhTK4701JxLcpRYBZ-1yRmZUcMpF5iW	6	\N	\N	\N	\N
215	2	firstM	user	male	user26@yopmail.com	$2a$10$zGrWKwZUKmpbT.CMyMy/deP30iXlhxWXcYgNU/ZFLbC84zW3REDvy	1589437848298.jpeg	\N	\N	\N	ZHQY	\N	\N	1	2020-05-14 06:30:43	2020-05-14 06:31:32	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	6	\N	\N	\N	\N
326	2	Madan	Agrawal	female	madan@yopmail.com	$2a$10$2i9DtG9K9TthrowAkPH3aem6vItYTrHPkiDyzAgVsDXCrCAs1rYJe	1590739732057.jpeg	\N	\N	\N	OMTR	0	2020-06-01 05:15:00	1	2020-05-29 08:08:01	2020-06-04 02:10:43	e0QNplpoSBa5EK0OT6KC1z:APA91bGwvxaCF9PZBPUlyy156CW6m4giu3u1FYn05IgpoNBr6hehqIyjeoxsjZmp8iX0VPd4Nmw9ThtRtGWVmyRrbBeUI24-mMTQv7yw7kyUVavvJB4HtNCU8MjE_hL9kg4rfjP9-Qsz	7	\N	\N	\N	2020-06-01 05:15:00
243	2	new	new	female	ntest1@yopmail.com	$2a$10$JKD6M1rODBvksSWiiHT4vOp.9gymr0xQqydYQfCOCnqHiIb1y1SCi	\N	\N	\N	\N	OVQV	\N	\N	1	2020-05-14 05:48:11	2020-06-05 10:28:58	dZaJSAmH9kUos4Obpy4s6r:APA91bFGDk879XNaOBI3IOewjW_-w9uGIfsrBu6x-plMUkYQSMI06X6MScw7f3eQTpcuX_Bte3aF7a7Lp7fo1Dj2GgGVdUZM0gltbQftFIWqJbVbuWyQWDhsVVAX7wIofbQtzt-W7lFH	1	\N	\N	\N	\N
313	2	Try	Th	female	last@yopmail.com	$2a$10$k9GJWc4bRrr7PkVWjcsG8efwfzPQKsIjlSNWfUvj96F2HUNt52sZ.	1590426491955.jpeg	\N	\N	\N	NOWY	\N	\N	1	2020-05-25 05:07:51	2020-05-26 01:00:38	d3JQJ6KMRsquLVoe5F6f5h:APA91bG5KbEjvEQaRa1RoRQ8h3jBbJjfYu-qZNM491Ka-NgLwt1KyKlWPgqGIa-FlNEuE5yb8qfNI4Y2FrnaAIrWX5Qs2dt0zZA9ml2GqkJf53IR_7Cdo6t9Ppe3s1MjJD1baJBCYtZQ	1	\N	\N	\N	\N
213	2	firstM	user	male	user23@yopmail.com	$2a$10$q5PxnOF3SAd8xgQLdrnOvODBVANmjLPxhVLeygbpEDvN0CaqEorm6	1589437386347.jpeg	\N	\N	\N	BEZD	\N	\N	1	2020-05-14 06:22:47	2020-05-14 06:26:31	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	6	\N	\N	\N	\N
214	2	secF	user	female	user25@yopmail.com	$2a$10$Y6/O1VBaZXELfC0CzF2bMOXyr9e/ikIQeZ/8U1SNuZ1h8rqRQ09K6	1589437438546.jpeg	\N	\N	\N	IDRC	\N	\N	1	2020-05-14 06:23:48	2020-05-14 06:28:06	cj2rVhFpQm-FEYuxrQlsjj:APA91bFurpLXORS4AkD-f4PtHfjdh9hFVHIcP8Es9Npb5C8F67ussqAnAzM_SENk9mOUGVbC2dk-9cLXwUKbgCgpiqpsv_beA9iRhL0UjKoeXjhTK4701JxLcpRYBZ-1yRmZUcMpF5iW	6	\N	\N	\N	\N
217	2	firstM	user	male	user28@yopmail.com	$2a$10$qW54UzMFl/K6R5KKmjO5zu/JW4.nZHm1J/hqCviAn0GX4sufJHfnO	1589445821345.jpeg	\N	\N	\N	ZCJM	\N	\N	1	2020-05-14 08:43:36	2020-05-14 08:44:23	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	6	\N	\N	\N	\N
267	2	secF	Userrr	female	user48@yopmail.com	$2a$10$H8XqRM8TKagUq1YqclruXuqWGByAFqEFP5JA77s5F7zhenBfQ57MG	\N	\N	\N	\N	TYSP	\N	\N	1	2020-05-20 06:39:00	2020-05-25 11:11:08	cxnZV9EzQvClsuB0gV2xcB:APA91bGn6VNpdv65_aiXm1rHMyuuxWJEXMBsKKmqKVZx4iu1SA7hWnSHYRpWWWN7JgQ4RSBQL_ILSx4sAAeS72RRjtUyzNVpw_mEfi70lU3C4JSyuyhFWQ3hpI2yrBnYuvOrbFWMfXGH	6	\N	\N	\N	\N
240	2	qwerr	ssjdj	female	abc@yopmail.com	$2a$10$tGqqncHSqu4R1.v6ZmsFquNbRsUbUFKnmdaCL1USZTBtSUHHI6L2e	\N	\N	\N	\N	YTBE	\N	\N	1	2020-05-14 05:38:02	2020-05-14 05:54:09	eoelKeYjgUiKkrRdxOrJu9:APA91bEjxOzztPJnjSlSzsHzAfYgLhurKJsP6nGDfQN6WboxV6CAom-B590Y2MS-T4pFkRaZmPEgOvEhhFgmQbpuz9nAvOP96HFnmLiNkaEMu6PAH-YwOK-gBcCv6rB9MHPhYrFxDCGT	5	\N	\N	\N	\N
341	2	test	accout	male	test123@yopmail.com	$2a$10$Xx2I.j6Ombctmir2/MQAy.ocFM85Rl0opw3HV2acLJph0dUo8Ethi	1591599715771.jpeg	\N	\N	\N	ZSFU	0	2020-06-19 11:46:41	1	2020-06-08 07:01:41	2020-07-01 12:29:02	c08r1PQX90S9gEGwHYVTor:APA91bGvdAWo2QC6fnTqnPLH1nO4gFHMPv18dlMWC8wZh1p90rjPl77iY-f0hTb3KKOqSp5I2OEEdEkfihBaDlpiwuNyTV1Jb7SOPbZikKmfUB-w1l8oHb6c7NsL4BEhzdQaSdXtPzMn	7	\N	\N	\N	2020-06-19 11:46:41
257	2	Gautam	Marwaha	male	gautammarwaha786@gmail.com	$2a$10$qfL5nGG1cYPcZ0zkAIVb9.TxrBHEYrW8IkJoKFtLnAB10Svk0h23u	1590151745871.jpeg	\N	\N	\N	LDBK	\N	\N	1	2020-05-19 08:38:25	2020-05-23 04:00:39	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1	\N	\N	\N	\N
218	2	secF	user	female	user29@yopmail.com	$2a$10$X7GWSp4ih3p6Zo/ItGcdB.OpRLFJTKEsM98GwWpfygAZPesDEUxpy	1589445845569.jpeg	\N	\N	\N	NRXW	\N	\N	1	2020-05-14 08:43:59	2020-05-14 11:57:20	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	6	\N	\N	\N	\N
219	2	tester	users	male	tester@gmail.com	$2y$12$8gHAAkwN.94SSQDIZqociOi8obGlXALDmMpeYJEEMKPt.BtY7QAGO	\N	\N	\N	\N	NNNN	\N	\N	1	2020-04-16 22:47:49	2020-05-14 09:40:21	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	1	\N	\N	\N	\N
229	2	firstM	Userrr	male	user38@yopmail.com	$2a$10$OPdtqM.AGUpruuLQj.8nge16snvnDvk4QBzDcsSPeDUKsD7VySPGu	\N	\N	\N	\N	SQRR	\N	\N	1	2020-05-14 12:00:52	2020-05-14 12:39:36	cj2rVhFpQm-FEYuxrQlsjj:APA91bFurpLXORS4AkD-f4PtHfjdh9hFVHIcP8Es9Npb5C8F67ussqAnAzM_SENk9mOUGVbC2dk-9cLXwUKbgCgpiqpsv_beA9iRhL0UjKoeXjhTK4701JxLcpRYBZ-1yRmZUcMpF5iW	1	\N	\N	\N	\N
238	2	Dvdv	Fw	female	qc@yopmail.com	$2a$10$fEwVSalrTAILracyJlAREOqjqCsGcR2wD5IK6kaU7tkGFSXe6d1ZS	\N	\N	\N	\N	WWWV	\N	\N	1	2020-05-14 04:47:04	2020-05-14 04:47:04	\N	1	\N	\N	\N	\N
225	2	firstM	Userrr	male	user34@yopmail.com	$2a$10$kd81t5nJGAKftfTx3WQqWe76bmoOH4ewZw4ooXTq5ePN7MrLTMnh.	\N	\N	\N	\N	TEZY	\N	\N	1	2020-05-14 11:12:36	2020-05-14 11:52:14	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	1	\N	\N	\N	\N
239	2	Dhhd	Xbd	female	qz@yopmail.com	$2a$10$6pBYhxiHrDInsbj16V2c0ucdCE8qLuCrHE1idfST.KaSVa.Rxaf4m	\N	\N	\N	\N	THNU	\N	\N	1	2020-05-14 04:47:46	2020-05-14 04:47:46	\N	1	\N	\N	\N	\N
236	2	SecF	user	female	secuser@yopmail.com	$2a$10$/vw/6X80p.VQ/gKas5yLe.bQkGWlJbmIedJSwduZKbin8fzvvGeLq	1589474491906.jpeg	\N	\N	\N	INXF	\N	\N	1	2020-05-14 04:41:26	2020-05-14 04:44:15	c0ecrfQuTBaGRvDl5rmX9k:APA91bEu5YM3CjdiH5ubRY732Jcakz2sw1HcekdxXY1lpWf11wX8ZEuPp4PCvoeMqVRpLzet_jzmINU70R6jgTIeNs_A1rbLiEtNQ3mQcWafWOlFhirh4AEVK3wbSYXkvaXVJYqCb25N	1	\N	\N	\N	\N
314	2	Male	Male	male	gautam.android@mailinator.com	$2a$10$Q/oY12lo7wfUUwHMtGqsp.7kZRWUoVk/JtfLt/VvzJvXaafdLdtxi	1590485182949.jpeg	\N	\N	\N	JWWC	\N	\N	1	2020-05-26 09:23:49	2020-05-26 12:39:12	eZAknozQTRSwdZekkePT-8:APA91bFNxJvWN7p6Xm_xERL3_oVP1NHqKs-eqlQ6qk-xYicLnmSqKYmSAr1RZ9FcByW5vVD4Q03Hbtke4LyGH0Cib7GxLAMAebQy_Q56gqTjZD_LgJOV0-NvrtUAIx7UX6vddJf6zrOz	1	\N	\N	\N	\N
223	2	firstM	Userrr	male	user32@yopmail.com	$2a$10$3S9nL0KuiT2Fz0u2ug5D8eC99GuQJZ8ltXqCgZbckdpanJ.a0cvX.	\N	\N	\N	\N	LTNS	\N	\N	1	2020-05-14 10:28:29	2020-05-14 10:56:23	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	1	\N	\N	\N	\N
224	2	secF	Userrr	female	user33@yopmail.com	$2a$10$vcGEc./MMsFN/DK1XH3yq.GwFfmrglg5gypP2suKrE6msYATYMy/S	\N	\N	\N	\N	XYRY	\N	\N	1	2020-05-14 10:28:37	2020-05-14 11:55:53	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	1	\N	\N	\N	\N
227	2	firstM	Userrr	male	user36@yopmail.com	$2a$10$M39bs7W3lGUPZfZxx0VateT5Vw7zYgQJqIclfPQxfQwirsiBHYWoG	\N	\N	\N	\N	UGJT	\N	\N	1	2020-05-14 11:16:07	2020-05-14 11:33:55	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	1	\N	\N	\N	\N
222	2	secFs	Userrr	female	user31@yopmail.com	$2a$10$alB9xGXF31gOYOVVEMW0Y.UP/qO5CQbpuXg6L1LJlkLJFH0FbXO4S	\N	\N	\N	\N	HYNT	\N	\N	1	2020-05-14 09:42:35	2020-05-14 11:56:12	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	1	\N	\N	\N	\N
221	2	secFs	Userrr	female	user30@yopmail.com	$2a$10$wW1yT4E4w3Q0BnOxNEAcO.kI0xR0Mbsjf9PUZ92dRsH5GsUtKJOpi	\N	\N	\N	\N	CAGI	\N	\N	1	2020-05-14 09:42:31	2020-05-14 10:45:25	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	1	\N	\N	\N	\N
230	2	secF	Userrr	female	user39@yopmail.com	$2a$10$wCdpuGiAwBDmy4V0db8Bmeh0VAKt2oYWrTVPQwDtZCAuNYSbt6B1G	\N	\N	\N	\N	JBWT	\N	\N	1	2020-05-14 12:01:14	2020-05-14 03:13:13	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	1	\N	\N	\N	\N
231	2	secF	Userrr	female	user40@yopmail.com	$2a$10$r2oRTArjmC7st2DGcyilk.IvWty4i6zztjoee6v.OBxpHN9F/BDSC	\N	\N	\N	\N	DRCQ	\N	\N	1	2020-05-14 03:07:27	2020-05-14 03:08:04	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	1	\N	\N	\N	\N
233	2	subodh	srivastava	male	subodhsri1@subcodevs.com	$2a$10$AQVULt1ky.s1kS9hivq6u..R7FU6TbIjhd/XPFVPLRH2t3JFdjM/a	\N	\N	\N	\N	LBLX	\N	\N	1	2020-05-14 04:39:45	2020-05-14 04:39:45	\N	1	\N	\N	\N	\N
237	2	Abhi	Dff	female	dd@yopmail.com	$2a$10$i/vvqRZIlB93kgawyppuC.8x4fkcaiGdJXLov14hoqPymB77GlXuG	1589474651100.jpeg	\N	\N	\N	WVJR	\N	\N	1	2020-05-14 04:43:46	2020-05-14 04:44:11	\N	1	\N	\N	\N	\N
235	2	abhinav	teotia	male	ta@yopmail.com	$2a$10$14FpHzQxZlFH0IAUpsVtpuiSur8m1O2Gaz7yemHxfa8YTo92g/3Fe	1589474493726.jpeg	\N	\N	\N	MUYO	\N	\N	1	2020-05-14 04:41:20	2020-05-14 04:42:49	eoelKeYjgUiKkrRdxOrJu9:APA91bEjxOzztPJnjSlSzsHzAfYgLhurKJsP6nGDfQN6WboxV6CAom-B590Y2MS-T4pFkRaZmPEgOvEhhFgmQbpuz9nAvOP96HFnmLiNkaEMu6PAH-YwOK-gBcCv6rB9MHPhYrFxDCGT	1	\N	\N	\N	\N
234	2	FirstM	user	male	firstuser@yopmail.com	$2a$10$/ANaXAadmN4YT1gyCpbeteSGPt3yPwywMyvKBa7SrlRK97kHA7eUS	1589474463278.jpeg	\N	\N	\N	KOJG	\N	\N	1	2020-05-14 04:40:49	2020-05-14 04:49:57	dZaJSAmH9kUos4Obpy4s6r:APA91bFGDk879XNaOBI3IOewjW_-w9uGIfsrBu6x-plMUkYQSMI06X6MScw7f3eQTpcuX_Bte3aF7a7Lp7fo1Dj2GgGVdUZM0gltbQftFIWqJbVbuWyQWDhsVVAX7wIofbQtzt-W7lFH	1	\N	\N	\N	\N
244	2	Ellen	Johnson	female	ellen@yopmail.com	$2a$10$z75JSRL.tgrH5IdwojBosuXjV7sz6PalW2zKMiOQ6bXGbdK4cy/te	1589479629753.jpeg	\N	\N	\N	PSGX	\N	\N	1	2020-05-14 06:06:10	2020-05-14 06:07:57	ddNXKEUJwUgxk3DXc-ryb6:APA91bEcbz7WmoxlcffAIcC0yEpD-5e_EPIPabeOyXlFQZW72FCNL9qZ41kPfY59_vWprdyFaBYzO8rRy9gCl1O6OumVqI9WlQ_kM4vdMDBQxFvUlY5rL25sYoMVi2mCwVtAma2-co63	4	\N	\N	\N	\N
241	2	q	a	male	rcc@yopmail.com	$2a$10$PDioL2eP6n5HUrN3NF3IZ.1NXNEfTKOrrRiGgC9g.QA2hGtGY4qNy	\N	\N	\N	\N	OUNI	\N	\N	1	2020-05-14 05:43:55	2020-05-14 05:43:55	\N	1	\N	\N	\N	\N
242	2	aaa	aaaa	female	test1@yopmail.com	$2a$10$hCGFynh23Z57QeQ2PPQZmuDKvNcM5V2ruduztyb/KmqRCpNCH65b.	\N	\N	\N	\N	FHYJ	\N	\N	1	2020-05-14 05:47:24	2020-05-14 05:47:24	\N	1	\N	\N	\N	\N
342	2	test	last	female	test321@yopmail.com	$2a$10$R4AQWFNG2P2O5BgU1rYT5eG6X6s8Pltjr.ixkUl8f4kYubysIuvhe	1591599831273.jpeg	\N	\N	\N	XXRF	0	2020-06-19 11:46:41	1	2020-06-08 07:03:42	2020-07-10 11:12:27	eVBLsmpfh0n0uuS4kab4MH:APA91bH5vCZ820GJwAb_LZwxBgDj2K3oWtEJbP3h4jMXRmlV8gFnQQ0_FoIyZCxfTFK9miyyiNSVgqNnYxQLlxFSjgfnGEi_SIMf8HLe6KfrG3x916tX_pOXPnKK3x3YSEbHBk6Qk60A	7	\N	\N	\N	2020-06-19 11:46:41
245	2	dd	dd	female	fg@yopmail.com	$2a$10$LmAJn2yOXgFXH5RM1N4tQenK46kXfnkJlQrnoqAdNklDYZ6bVL2sa	1589479952507.jpeg	\N	\N	\N	XEPV	\N	\N	1	2020-05-14 06:12:20	2020-05-14 06:12:33	\N	1	\N	\N	\N	\N
263	2	gautam	marwaha	male	g@g.com	$2a$10$UvdTDCknZ4sz5jRYlJfnvuSqni.XNW7kGMK/J46flUDTif3kkt7q6	\N	\N	\N	\N	JCKU	\N	\N	1	2020-05-19 10:07:27	2020-05-26 10:14:42	\N	1	\N	\N	\N	\N
261	2	secF	Userrr	female	user46@yopmail.com	$2a$10$0QoieiSIONw/cQTfMEUlme2V9gwYmK9GexwNJkGfumC29cYKIS5kW	1590158026218.jpeg	\N	\N	\N	QZAE	\N	\N	1	2020-05-19 09:20:05	2020-05-25 10:03:30	cdniu6qW_U4ZgZVcdnnrwj:APA91bG1RM0W0sV9904coiivZXc3hUjndH-uKQ6rXIuvcubu2oS779T_j-NRSdcTdZ7yR7fDW0ACkqzJBicex2lEI7Ma0HwiIRzwT3-FxACGk3VFOUCYDuUWpMZ43VbNonedR7re8Meo	6	\N	\N	\N	\N
273	2	sfdsf	afsfsf	female	aas@gmail.com	$2a$10$4njVGtcRbsLWUzTHLTuSXuAefgAc5ulz7sGptLqDCaIg/JS1My3Mq	\N	\N	\N	\N	APFW	\N	\N	1	2020-05-20 02:31:08	2020-05-20 02:31:08	\N	1	\N	\N	\N	\N
246	2	sks	dkdk	female	qwerty@yopmail.com	$2a$10$BZDV2P71Bq1ufIbnzGJzyu.Vz8pia8wxSGTEFVR1OchI6I6qR2Ygm	1589480005590.jpeg	\N	\N	\N	LLDS	\N	\N	1	2020-05-14 06:13:06	2020-05-15 09:29:25	crvJphAah0janWbwwxad7o:APA91bFB0v3AUhQA_UG60pRxTab_ThZjnJeJRRJ8YoWPmBo2izR8BSp9FmVUH9ZLHragB6AkPiUoBeZEFb10RJV_24LdhKqnKrT5U4lSPJwaSJI319ySfje0luPAi7JJmFdQEuhjk5Rx	7	\N	\N	\N	\N
259	2	Gautam	qa	male	gautammarwaha786+2@gmail.com	$2a$10$XHx7ts3H/3O1VXhJSxrqYuNy2JXQdn32.Ze8l27IWWSrHyMS6QiY.	\N	\N	\N	\N	VGVX	\N	\N	1	2020-05-19 09:07:24	2020-05-19 09:07:24	\N	1	\N	\N	\N	\N
315	2	Rohit	Verma	Female	testuss@subcodevs.com	$2a$10$UVQXgexLqS9F3S5Beuwy7.ajAOcNNIWrXtWDj7JHLMVdWNME/.KVC	\N	\N	\N	\N	ONWK	\N	\N	1	2020-05-26 05:35:30	2020-05-26 05:35:30	\N	1	\N	\N	\N	\N
247	2	Ana	Hathway	female	ana1@yopmail.com	$2a$10$Pahkk55/aoFxE4IiBchLu.5dL10jm6AiK2tp3Mg50H0OVCbpna7Bu	1589480144311.jpeg	\N	\N	\N	ZXCI	\N	\N	1	2020-05-14 06:15:20	2020-05-14 06:28:27	ddNXKEUJwUgxk3DXc-ryb6:APA91bEcbz7WmoxlcffAIcC0yEpD-5e_EPIPabeOyXlFQZW72FCNL9qZ41kPfY59_vWprdyFaBYzO8rRy9gCl1O6OumVqI9WlQ_kM4vdMDBQxFvUlY5rL25sYoMVi2mCwVtAma2-co63	7	\N	\N	\N	\N
268	2	secF	Userrr	female	user49@yopmail.com	$2a$10$2VI3yjW5xJ2OqPF1iyDpT.4oBEBQFPNg9OBdYQt4wVshXvFIq/Vmy	\N	\N	\N	\N	ZLDD	\N	\N	1	2020-05-20 06:39:05	2020-05-25 11:11:49	cxnZV9EzQvClsuB0gV2xcB:APA91bGn6VNpdv65_aiXm1rHMyuuxWJEXMBsKKmqKVZx4iu1SA7hWnSHYRpWWWN7JgQ4RSBQL_ILSx4sAAeS72RRjtUyzNVpw_mEfi70lU3C4JSyuyhFWQ3hpI2yrBnYuvOrbFWMfXGH	6	\N	\N	\N	\N
360	2	Elgog	El	female	elgoogclass3@gmail.com	$2a$10$ujPgRPE22Zd813tK9D2GMecWaJuJYTHT/DNBEHjNE6b2Fxg7RDigO	\N	\N	\N	\N	WBJR	\N	\N	1	2020-06-17 07:46:08	2020-06-17 07:49:30	\N	1	\N	\N	\N	\N
260	2	gautam	qa	female	fgautammarwaha786+3@gmail.com	$2a$10$MItt7cXyMW8JbSrzXeRSouaHmSjquyK4lu9445jMac1D5sx6ToEF6	\N	\N	\N	\N	NDKP	\N	\N	1	2020-05-19 09:08:38	2020-05-19 09:08:38	\N	1	\N	\N	\N	\N
317	2	Q	L	male	email@yopmail.com	$2a$10$97W6MgIc0eoe5cjYAd.jQOp4scl/76sT2h9VnhCDv5tIDimdRg5ZO	1590598911026.jpeg	\N	\N	\N	UUKA	0	2020-05-27 17:19:16	1	2020-05-26 05:42:33	2020-06-11 05:17:32	fbEeuXuQRtilV3uIsGMtrm:APA91bHOMs8UHHUpyC6LuA-C7vDnryTb9g76rSLnhvl3pYDE6vcUxJadUId70ueXiXk6sKbTPcG197ax9Dav7PZ_5socb-BWmeCfwblXS8E891WXdQbQKNidERt2x80WOnwL8pbttw3V	1	\N	\N	\N	2020-05-27 17:19:16
262	2	gautam	qa	female	gautam@gmail.com	$2a$10$9EIVB4afUQaX.Azl4JUd1.XSkRzFJOlP.ATeQArC8RT30jlibkoRK	1589882759505.jpeg	\N	\N	\N	QAFS	\N	\N	1	2020-05-19 10:00:30	2020-05-19 10:06:00	\N	1	\N	\N	\N	\N
275	2	Divya	S	female	subodh.s@subcodevs.com	$2a$10$dG9LvPFwgaEMH7ZuTvee4e98RUuS94OIyLb3a8pMYmZc9e6..6qAu	\N	\N	\N	\N	PAWO	\N	\N	1	2020-05-21 03:05:55	2020-07-20 10:01:46	cEt9nI1WukDIpzxV0HGzgT:APA91bE1Kp6wZKSwXqBJ58uc0bTzZmBbQ0CoUnsSM6t42kk1RhTgsY089e45HP-xAKxOGLp93SrxUxgzmyhy73aqQ69LI4hfPvsVqGSMHj-tXcJJ0UhPPreS0EzMutQbXRjrnUhlRYLc	5	\N	\N	\N	\N
255	2	secF	Userrr	female	user44@yopmail.com	$2a$10$qhiZxDmnVFQjADtDR27Vd.oalnMlPBeFYjAC7LdcV/5upN8bRGXba	\N	\N	\N	\N	BYHY	\N	\N	1	2020-05-18 09:56:45	2020-05-18 01:19:32	cvTEtFXUTZek_GYwOnxHLt:APA91bE1aIwv-WJUyzAb9LIOdkpEQZkFZ_CxYbIs9g_RzSt2klkOhXS6Tmd2rbTmRfOOXtM8Sia1O0zmC91DxntA7Si1Tn1a9MUsIXsGx8GbBTfRG5aY9OuhCBbs1YEAByjZ_ZMpOFq-	7	\N	\N	\N	\N
249	2	secF	user	female	user43@yopmail.com	$2a$10$prLDP6PaEK8UJN/F/rKoNuJLPLsSn02eKusUYVFTZgzLgHFXAkwS2	1589880923011.jpeg	\N	\N	\N	UNWG	\N	\N	1	2020-05-15 09:03:41	2020-05-19 12:52:20	dD4NeqvoQEOiuge1wkTj5v:APA91bFEGUhEoWidTlD4Zo2aQPbQtAL-gpJP_beak4jOxNPX153941SUAlTEXgS7q6H8rdv_AmGf-Zx7sfEb1XFzHyEl9kMWenXyE7DkCQUYlfK9aECZLt-LxiMSptnoCc05MZlMRYE7	4	\N	\N	\N	\N
258	2	Gautam	Marwaha	male	$gautam$marwaha786$@gmail.com	$2a$10$1MpyMmF8QVtRBL8IdcAxgemkFdQDsXrgIp0yNfKIoh2ctz9HROnO2	\N	\N	\N	\N	AUGT	\N	\N	1	2020-05-19 08:50:55	2020-05-19 08:50:55	\N	1	\N	\N	\N	\N
269	2	sdgvsfg	dfdsf	female	$afdsf@dfvdsf.aefaf	$2a$10$HBrYB0.xC.e8xmn5GTFpjeIoBBtlsXPJKLF/ZCbYwoJ7Pskc0afiO	\N	\N	\N	\N	OMSM	\N	\N	1	2020-05-20 07:14:05	2020-05-20 07:14:05	\N	1	\N	\N	\N	\N
256	2	usersr	testerr	female	user45@yopmail.com	$2a$10$5CvS8e2FOlvoKo45f43xYOqyXEzZQzmAkKZdv7v/a3CPPhVvussVa	1589882618791.jpeg	\N	\N	\N	IPHT	\N	\N	1	2020-05-18 09:56:48	2020-05-19 10:03:39	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	7	\N	\N	\N	\N
254	2	secF	Userrr	female	user42@yopmail.com	$2a$10$fMIc5lAyKgxU9iNO6p/GgezgnmIQ2GE4F4O2GivKfYJoqm89avy6a	\N	\N	\N	\N	URRJ	\N	\N	1	2020-05-15 11:14:31	2020-05-19 12:52:43	cvTEtFXUTZek_GYwOnxHLt:APA91bE1aIwv-WJUyzAb9LIOdkpEQZkFZ_CxYbIs9g_RzSt2klkOhXS6Tmd2rbTmRfOOXtM8Sia1O0zmC91DxntA7Si1Tn1a9MUsIXsGx8GbBTfRG5aY9OuhCBbs1YEAByjZ_ZMpOFq-	5	\N	\N	\N	\N
270	2	sgsg	sgsdg	female	sdgdsg@sdef.sdfg	$2a$10$wwt22b8Cs2r2s9m5EEgU3.YC.uYq4jrGNq3..Mt/dJ6HWrTGp3gVa	\N	\N	\N	\N	XATT	\N	\N	1	2020-05-20 07:15:17	2020-05-20 07:15:17	\N	1	\N	\N	\N	\N
265	2	Subodh	testF	female	subodh@subcodevs.com	$2a$10$Npc22ET4MarrmVDXEOltOuqRnpoAN0ELCNxg5Z.Y/tSOvsyMPOdSO	\N	\N	\N	\N	REGD	\N	\N	1	2020-05-20 12:42:51	2020-05-20 12:42:51	\N	1	\N	\N	\N	\N
274	2	Hzjjs	Hsjjs	female	hsjja@hsj.jzk	$2a$10$56IrmgcBYZhh.zx7eWS23eW0rw0ua1ehCvetLCmk1OWK//D87Zo1.	\N	\N	\N	\N	CRGL	\N	\N	1	2020-05-21 11:34:32	2020-05-21 11:34:32	\N	1	\N	\N	\N	\N
271	2	sgsg	dgdsg	female	dsgsg@afs.sgesdg	$2a$10$tU1mTtOASTD5aHI.rQImteJDHwRivv1QxCimtihpfkan7BWhTHJR6	\N	\N	\N	\N	RICA	\N	\N	1	2020-05-20 07:15:33	2020-05-20 07:15:33	\N	1	\N	\N	\N	\N
272	2	asdfsd	asfasf	female	afaf@asfasf.asfasf	$2a$10$tMU25BhnkCVgwycTYsJhC.K1omG8PB/WNRnjutssLviTDI1L/3LFO	\N	\N	\N	\N	QVUX	\N	\N	1	2020-05-20 07:15:47	2020-05-20 07:15:47	\N	1	\N	\N	\N	\N
295	2	abhi	teoti	male	teotia@yopmail.com	$2a$10$/ZAzE8YM4N2EdZVH15.OBO/quq8QkqkPjb9asYnwOrJbKLPTrTD.6	\N	\N	\N	\N	XJCD	\N	\N	1	2020-05-22 10:18:21	2020-05-22 10:18:21	\N	1	\N	\N	\N	\N
283	2	Hhdh	Ehhehe	female	hehyryrueu@gmail.com	$2a$10$8kjEbE3U6vjtDZg70NUQWOGIy2LbQKZWPuWfBBfhg/0QMaeosle1C	\N	\N	\N	\N	POQZ	\N	\N	1	2020-05-22 07:13:54	2020-05-22 07:13:54	\N	1	\N	\N	\N	\N
284	2	Gautam	M	male	gomsymarwaha@yahoo.com	$2a$10$qKB1ORPsJvcN178L2kBmuean3wdw.lafguBH8FiXSEZN.b4ixNjku	\N	\N	\N	\N	UDYR	\N	\N	1	2020-05-22 07:21:58	2020-05-22 07:21:58	\N	1	\N	\N	\N	\N
278	2	arskd	ekd	female	qw@yopmail.com	$2a$10$I8JIs8Xgdz0a7IqY2G/hk.5g6KKWfPo8VmF9wyshaRGSnmFjS1x0S	\N	\N	\N	\N	NHLL	\N	\N	1	2020-05-22 03:45:37	2020-05-22 04:05:40	cCN1rOIJM07fpqoD8203M2:APA91bE18gFlQo0x8XpUgAce8Z7dnObksJDI6F5V20lNutwct395RZVPI9ycny4XcLmTpmyNECeK26zIZo_DOXulX52sMSdRm0rzVfbGUAfQcJmIZN1Ctq1raTBUtzPBey_NNgVL25Hu	7	\N	\N	\N	\N
264	2	secF	Userrr	female	user47@yopmail.com	$2a$10$n4OetG6Xt0ggul25NTdf.u5iVMJSM4ZgHW85G95QLer2GjhCTwTVa	1589950674635.jpeg	\N	\N	\N	IVFD	\N	\N	1	2020-05-19 12:53:42	2020-05-25 10:58:57	cxnZV9EzQvClsuB0gV2xcB:APA91bGn6VNpdv65_aiXm1rHMyuuxWJEXMBsKKmqKVZx4iu1SA7hWnSHYRpWWWN7JgQ4RSBQL_ILSx4sAAeS72RRjtUyzNVpw_mEfi70lU3C4JSyuyhFWQ3hpI2yrBnYuvOrbFWMfXGH	6	\N	\N	\N	\N
297	2	awdrwa	af	female	afs@afr.aer	$2a$10$bmwAZuS5X92Y1w.gh5U9rOyxMZSB/Y0xolLPjK1YcIyfS7gll8JJ.	\N	\N	\N	\N	NNCB	\N	\N	1	2020-05-22 12:19:58	2020-05-22 12:19:58	\N	1	\N	\N	\N	\N
276	2	ansn	skdj	female	at@gmail.com	$2a$10$t11FsejPvwGlPhgmjHF2T.J1hTednaYaqhgbid.hSXXrmXSkXcl5K	\N	\N	\N	\N	ZRCH	\N	\N	1	2020-05-22 03:44:21	2020-05-22 03:44:21	\N	1	\N	\N	\N	\N
277	2	jsis	skdk	female	try@gmail.com	$2a$10$qzqYl/A4Tl6cNwpjmLXkyOKGd4x4RoHIyNcrb.qdP8WFtCCjeF9Fi	\N	\N	\N	\N	BZOU	\N	\N	1	2020-05-22 03:45:05	2020-05-22 03:45:05	\N	1	\N	\N	\N	\N
282	2	Fry	Ff	female	try@yopmail.com	$2a$10$jaaW/J108xFG.h5WmPFdbOpnGVYbXiioERn0HFZdxSkaaU1RrxcwW	\N	\N	\N	\N	HVHI	\N	\N	1	2020-05-22 04:32:21	2020-05-22 04:32:21	\N	1	\N	\N	\N	\N
279	2	bhavna	qaf	female	gomjita@gmail.con	$2a$10$LluuISzNI58KG1Y7BJ3wauKdbW6Pu2gwoo01Xrj79FWVZANQe3NwC	\N	\N	\N	\N	ULTZ	\N	\N	1	2020-05-22 03:46:37	2020-05-22 03:46:37	\N	1	\N	\N	\N	\N
286	2	Gg	Ggt	female	gghgf@gmail.com	$2a$10$fm3KENlVyuTK1pLCNX9zx.r8LTYIK11QRBslixQfk3rwnDltmIHui	\N	\N	\N	\N	TANL	\N	\N	1	2020-05-22 07:53:23	2020-05-22 07:53:23	\N	1	\N	\N	\N	\N
287	2	Ghhh	Gggg	female	fuchfugj@gmail.com	$2a$10$omLlTALXsyi4RKesB7brVOzuuaEIaR01z/Bs2/7y83soo4FrSMpv2	\N	\N	\N	\N	QCHY	\N	\N	1	2020-05-22 07:54:23	2020-05-22 07:54:23	\N	1	\N	\N	\N	\N
293	2	Gg	Ghh	female	onspotyogi@gmail.com	$2a$10$e.1nbzouL1rL65ObaKRO1.u6WnHZYb3ePfytrIq1CDdlCNcZkOS1u	\N	\N	\N	\N	VPOJ	\N	\N	1	2020-05-22 08:50:23	2020-05-22 08:53:20	e2NFREC9RuStyQOyxOX5Jr:APA91bExtpLthKAUONFMmk6-85ZMa6foP4oNmR9nlE8h9slDuJTnSxddvZeJJe1s8q5q0mGi4iH635Gj_NfjBYZmciBas52haC6b2JREUkDyQYQ2IGfTtCZYvcXldZzPs_qsvZPS4GAS	1	\N	\N	\N	\N
126	2	Subodh	Srivastava	male	subodhsri1@gmail.com	$2a$10$BxKT7Md41PfvEuHuI.NoweqcdANlWmEGF6ffnZgjSEway5tWHE1.G	\N	\N	\N	\N	SQDT	\N	\N	1	2020-05-07 04:20:37	2020-06-23 03:35:39	cjbUl3ws50qivDvjEBc6Jf:APA91bHmC30c-TV7QVTEPpkqLfYr-SgeEyLPxCC2tNT4HVz_UQ5_RIFfQfyKIgjL60aThvMMIqJtgqVL685mDOGBHJS1KTW56K4wFclr46NW7JMjz6Kn-7KVhVwzwUK9Mub1Uu_MNq7N	4	\N	\N	\N	\N
288	2	afa	asfa	female	asf@awf.af	$2a$10$dIEE9xZv.OQdGJLXzX4Jxu62sIw9RoioKLeDByjRz46B7GUxapS8u	\N	\N	\N	\N	HJBN	\N	\N	1	2020-05-22 08:17:04	2020-05-22 08:17:04	\N	1	\N	\N	\N	\N
292	2	hhshs	hshs	female	jsj@hsj.com	$2a$10$XRs3ucF9INKG09B1orylJ.1Z7hQcqEPXY59CmbONC1dYHpZkDg.6u	\N	\N	\N	\N	LNXO	\N	\N	1	2020-05-22 08:44:40	2020-05-22 08:44:40	\N	1	\N	\N	\N	\N
280	2	Fhd	Eheh	female	raq@yopmail.com	$2a$10$MuakAfS9/rV5qwzOMInCQ.pPCznnMKWIoSg7CDUpEG3j3ZNb91/9G	\N	\N	\N	\N	VYNA	\N	\N	1	2020-05-22 04:08:54	2020-05-22 04:15:32	dCRQRPmQQxC7ZsEabqdisS:APA91bHd9wD1Q986hAv7hPS9da7A_O2P_jxk_prefmj7-jvveZICvp06inzfiGCzRt9ILlUA-Hk3z-YrQs_bxMJG0GI6TkFrM0jv81Vm2MhG2sm4rCskNncWvcwtbAPRAv1Tp--el8Xh	7	\N	\N	\N	\N
290	2	Trump	Us	male	trump@yopmail.com	$2a$10$i0m73FMlU2bqBgl6JfsJuOd3ezgw/lHg/CttP2uDRzVILfnFV4l12	\N	\N	\N	\N	BXBZ	\N	\N	1	2020-05-22 08:34:59	2020-05-22 08:34:59	\N	1	\N	\N	\N	\N
343	2	firstM	Userrr	male	user58@yopmail.com	$2a$10$biu7ahLh1MG6th/ORY9Wnei7pFEldXW6YZ/QspUfQWY7lrRh6Gl9.	\N	\N	\N	\N	FWXL	0	2020-06-11 09:52:06	1	2020-06-09 11:46:57	2020-06-17 08:37:02	cFw4ceeKSeWNhOlRfDP5Xg:APA91bHQRv763w4MGkHQ_sNdDvwERIRUVmhqsvYJmMUBZbUqIHfgOP4RJkKZC6KpRYqxz-YrxwxJo17RuL6DivJfsdc-qM6MVzINUEZjY257kR-uKelZ6A6iCyc6oC4CO5D5q4LMgoAV	7	\N	\N	\N	2020-06-10 09:52:06
316	2	Try	Angle	female	web@yopmail.com	$2a$10$iAwgrhgQHqYAuCiCPKO91eQCj1mZO7TdZsfzC3bDiBLEg5Qs5iJNe	1590514923147.jpeg	\N	\N	\N	LZAA	\N	\N	1	2020-05-26 05:41:48	2020-05-26 05:42:03	\N	1	\N	\N	\N	\N
285	2	female	female	female	gomsymarwaha@yahoo.in	$2a$10$FoRKA9w1.w7e9a.fIKHtiOdfaU2WQtDP.GDIZb83fnvlmfw.wI6P2	1590496789551.jpeg	\N	\N	\N	HGZW	\N	\N	1	2020-05-22 07:23:23	2020-05-27 06:52:34	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1	\N	\N	\N	\N
361	2	Elgoog	Play	female	elgoogclass2@gmail.com	$2a$10$9yNtzO9The5ZtCQRMEZ.kOS7W9IFVAEsxUeBGsvmRbPbZRLtSZgay	\N	\N	\N	\N	YVAE	\N	\N	1	2020-06-17 07:48:59	2020-06-17 07:48:59	\N	1	\N	\N	\N	\N
298	2	f	dk	female	dk@yopmail.com	$2a$10$EdPb4SE0YOC7wBe4MxF3AuHz0.2Jf9eBjvrupBUzbN.YOswhmHNbC	1590152875878.jpeg	\N	\N	\N	INJG	\N	\N	1	2020-05-22 12:42:08	2020-05-22 01:22:15	cCN1rOIJM07fpqoD8203M2:APA91bE18gFlQo0x8XpUgAce8Z7dnObksJDI6F5V20lNutwct395RZVPI9ycny4XcLmTpmyNECeK26zIZo_DOXulX52sMSdRm0rzVfbGUAfQcJmIZN1Ctq1raTBUtzPBey_NNgVL25Hu	1	\N	\N	\N	\N
348	2	Abhi	Teo	male	abcd@yopmail.com	$2a$10$9OQmOqXodC.nglnUkPMm3eH9nTYbOCOEpTaVHH0dm21o6YEqCBTv2	\N	\N	\N	\N	SAKT	\N	\N	1	2020-06-11 08:34:54	2020-06-11 09:59:24	czIDQJQfS02amsfu51wV9I:APA91bEg7ShlMZ3R7kTVlUQ4sqvdMQOUMORtcvzqHHhX9do_lZRL5sA7zKxmKxh5zDrn9OzpcL2e7c0O7gILl1c_D43Kibr6oAEPSM17yrsvwAOeqPCmX6SvMb9oq_EEazh5miKVwz93	7	\N	\N	\N	\N
294	2	qwer	qwert	female	car@yopmail.com	$2a$10$0n/vCJfggHqKo0DZnhDWQONHHFLcyAC69juaotYKjJTxI.9c6Yh1u	\N	\N	\N	\N	YNYN	\N	\N	1	2020-05-22 10:15:06	2020-05-22 10:15:06	\N	1	\N	\N	\N	\N
296	2	abhi	teotia	female	abhi@yopmail.com	$2a$10$GcsvgcyPj/SKZ5cYy.fu0.vrQOvDrhgYjcANM6J1v6F1hYV.wEANG	1590142752048.jpeg	\N	\N	\N	YPRG	\N	\N	1	2020-05-22 10:19:02	2020-05-22 10:23:55	cCN1rOIJM07fpqoD8203M2:APA91bE18gFlQo0x8XpUgAce8Z7dnObksJDI6F5V20lNutwct395RZVPI9ycny4XcLmTpmyNECeK26zIZo_DOXulX52sMSdRm0rzVfbGUAfQcJmIZN1Ctq1raTBUtzPBey_NNgVL25Hu	1	\N	\N	\N	\N
323	2	Tester	Users	Female	testers1@gmail.com	$2y$12$8gHAAkwN.94SSQDIZqociOi8obGlXALDmMpeYJEEMKPt.BtY7QAGO	\N	\N	\N	\N	WYBL	\N	\N	1	2020-05-28 03:53:55	2020-05-28 04:49:57	ft2VCHufQOiu1MprOTEPW4:APA91bHBObRr3Tpp8xn2UW2MuKUl4VDQiDbB9R61gXvxDQV0VbFZgeS8gGuqnwIjB0kBh3pOxK_sUf7uPWqQONxU07xxpR-8eWg3_mMLsWZaOxIUQuCDRAXDSgl7wFyK9tOGioH4hG7n	6	\N	\N	\N	\N
329	2	abhinav	teotia	male	teotia12@yopmail.com	$2a$10$8PTByRwzU55CbMqk/OvFOO7PotN2hAYnYfzZvgis6ex0X6tXOeWzK	1590988880684.jpeg	\N	\N	\N	XDBU	\N	\N	1	2020-06-01 05:21:09	2020-06-01 05:23:00	cpp9j3VaIUIFsCH2gXQmtj:APA91bE60XmothOYDJzjWbf712eWHEm26kc6a-KOqBnrDNuDNat2_vvFSlWSapU4v5WRBwfZJdRGuh3Lvge_wv8aNJtXKtPSyFSypG5Wlv5YtRnJBHH_Z-uzwXOwF-4r6Sb1WE_RIiuH	1	\N	\N	\N	\N
333	2	Demo	Te	female	demo@gms.com	$2a$10$7Te3U2uWCy.ho69Qi8ruweVimFQmVSjHptb/ZYssK1uRSBcOTuuZm	\N	\N	\N	\N	ZLOZ	\N	\N	1	2020-06-02 06:50:40	2020-06-02 06:50:40	\N	1	\N	\N	\N	\N
324	1	Tester	Users	Male	testers2@gmail.com	$2y$12$8gHAAkwN.94SSQDIZqociOi8obGlXALDmMpeYJEEMKPt.BtY7QAGO	\N	\N	\N	\N	YOXA	\N	\N	1	2020-05-28 03:56:00	2020-05-28 03:58:48	chJTK7FmSJqtjkScBd0Gba:APA91bHMyMzTcL6PCJCnJmlK0MgnYDqjZtGnT9_g-vV-lWB-mANhGDfM1n_bhkeYO64ntM4CYzeo4JfxPmdEVA0foUoS7JwKHJxSXSve-6kWCTBu2t2CV5L-krnTYdsYMpCI7ddoPNpv	6	\N	\N	\N	\N
299	2	test	test	female	test@test.com	$2a$10$hbI56SG2OIL5S67YQby/rer2e4Bxxy6uw8UdaHFodWeoP3YPQCf4a	\N	\N	\N	\N	UOCA	\N	\N	1	2020-05-22 02:55:38	2020-05-22 02:55:38	\N	1	\N	\N	\N	\N
368	2	David	Mcknight	female	davidcmcknight@gmail.com	$2a$10$/9ZRUwV9noYT8Q62.YV6e.b.eXWEo9iyfqHjI2xF56EZzPjqlB9fu	\N	\N	\N	\N	TYEF	\N	\N	1	2020-07-17 03:26:02	2020-07-17 03:27:00	cUE-KgjcoUsNlt2fJRwSu0:APA91bGSdysYVm8yjOCTzk5ItyueQpFhimAsVXG8P2zCoAnzNCZqP4aSzA_c_5-AAJ6qN7NIsEmIDWV8WJbsTVc1-8HMoXdIEeeH1qcCpwyVmjm2jVg5M-rD3KJNE0VOPjDgDyGC5QmO	7	\N	\N	\N	\N
344	2	secFjcjvvjjgjjgjgjgjgfhjf	Userrr	female	user59@yopmail.com	$2a$10$SsBrh7duTU.9rewkPucukuiI6J0eNZaPiRS4lWJwj.1a.zVZZWTDm	\N	\N	\N	\N	JWPY	0	2020-06-11 09:52:06	1	2020-06-09 11:47:11	2020-06-10 09:48:30	epWYhvmITLuxxv5A8RIqYg:APA91bFWISeTGwCIgmytcrvDRlktPK0tRa3k9ucb-VQAgJoM8-3CzPVb07VibnVAx5O5dmP-56zn8ac6abdCLyRNBppItbyTWiz1VivU5PdVEH1sEg-3rnU2rs_rf4ionhmQNTWMD2Xi	7	\N	\N	\N	2020-06-10 09:52:06
349	2	nav	tia	female	efgh@yopmail.com	$2a$10$rWHXT1PUNXmRUkDVVL7S/eHOkxxHm35ki8V67eyNB7jFnWGzy6EbS	\N	\N	\N	\N	TXSR	\N	\N	1	2020-06-11 08:35:14	2020-06-12 10:49:37	fpSEAjWv_UPIvorM68LiIk:APA91bHd2bHbqDzVAJVVdA67FX691drzvMLALOVWk1A3kgolanTYNfntzGPPGXHwUqqQ2PGqcnybp-J8mjBVTri4ICPfEya3P1S6N5ETUJn3aEtC8GOQ7uDLEri2gyr5of0mbiVO3QB6	7	\N	\N	\N	\N
289	2	face	tde	female	try1@yopmail.com	$2a$10$HwE87CZXdtCPE.ejUSdl1uhOb5LR8jVACnGQrWRkxh2LaGvG8kXuq	1590136331659.jpeg	\N	\N	\N	KLWZ	\N	\N	1	2020-05-22 08:32:04	2020-05-25 01:05:57	dCRQRPmQQxC7ZsEabqdisS:APA91bHd9wD1Q986hAv7hPS9da7A_O2P_jxk_prefmj7-jvveZICvp06inzfiGCzRt9ILlUA-Hk3z-YrQs_bxMJG0GI6TkFrM0jv81Vm2MhG2sm4rCskNncWvcwtbAPRAv1Tp--el8Xh	6	\N	\N	\N	\N
325	2	notification	test	male	test@yopmail.com	$2a$10$zKsv6lVno7RTMeI.fSVBz.2mHFDsycaK5Goh5F4xW91KZSg4k9xOW	1590739562148.jpeg	\N	\N	\N	TZXH	0	2020-06-01 05:15:00	1	2020-05-29 08:05:46	2020-06-01 05:12:57	cpp9j3VaIUIFsCH2gXQmtj:APA91bE60XmothOYDJzjWbf712eWHEm26kc6a-KOqBnrDNuDNat2_vvFSlWSapU4v5WRBwfZJdRGuh3Lvge_wv8aNJtXKtPSyFSypG5Wlv5YtRnJBHH_Z-uzwXOwF-4r6Sb1WE_RIiuH	7	\N	\N	\N	2020-06-01 05:15:00
336	2	Gautam	Male	male	gautam.male@mailinator.com	$2a$10$a4tX/WEHTKaqfzqsB/0id.qdZZNPKiMkfLhZDRrDx606yKTpymWm2	\N	\N	\N	\N	VLRF	0	2020-06-10 07:39:28	1	2020-06-04 08:52:55	2020-06-10 10:22:29	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	7	\N	\N	\N	2020-06-10 07:39:28
321	2	Rohit	Verma	Female	testussfdfd@subcodevs.com	$2a$10$412GuNP3rSQA12CX5K/DNelbzsrBMK8MYxcdbX.2RfZzhzD0Ftygq	\N	\N	\N	\N	BOLL	\N	\N	1	2020-05-27 02:48:43	2020-05-27 02:48:43	\N	1	\N	\N	\N	\N
307	2	abhinav	teotia	female	teotia1@yopmail.com	$2a$10$GSiMxOX1xxAady0EfqgtJOjxD6/t6OQOsZDVQuFn2ozRHskWDg2Ja	1590368564142.jpeg	\N	\N	\N	TUOX	\N	\N	1	2020-05-25 01:02:21	2020-05-25 01:03:30	cr3zxBF_WEtBvsxd67j4ow:APA91bG_6OID-Zx4_j1SaCEq97u9qQZOlcM98cllqF6JSbaODWzi-7THYEOjJdWzUQKXRzIy5Ie2ze7w-kJQKyYx93CHppkrsv3qCt_l4oGU0965QNOeBveS-PVXTxYbmVDja-shIOVE	6	\N	\N	\N	\N
302	2	firstM	Userrr	male	user51@yopmail.com	$2a$10$nqOQOleXML3lNP0heIA8LOlDldWs3F6aC9HKdMiPnS9pCNaphGyH.	1590406124836.jpeg	\N	\N	\N	MAQP	\N	\N	1	2020-05-23 08:31:53	2020-05-25 01:20:50	cdniu6qW_U4ZgZVcdnnrwj:APA91bG1RM0W0sV9904coiivZXc3hUjndH-uKQ6rXIuvcubu2oS779T_j-NRSdcTdZ7yR7fDW0ACkqzJBicex2lEI7Ma0HwiIRzwT3-FxACGk3VFOUCYDuUWpMZ43VbNonedR7re8Meo	6	\N	\N	\N	\N
305	2	gautam	marwaha	female	gautam.test@mailinator.com	$2a$10$Fja8WJSth9mTRbfgczJnSO9OqnfLY6CvirHlHuXyNzrTXKBuQSh02	\N	\N	\N	\N	WOIH	\N	\N	1	2020-05-24 05:29:21	2020-05-24 05:36:31	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1	\N	\N	\N	\N
306	2	test	name	female	testthemailabhinav@yopmail.com	$2a$10$v0zGHPqkRdpku.Aw3f4PkeMVjrJRBHK.fl6dmxWAvETe4zd3tgXvW	1590368423174.jpeg	\N	\N	\N	ELEJ	\N	\N	1	2020-05-25 01:00:02	2020-05-25 01:00:24	\N	1	\N	\N	\N	\N
301	2	secF	Userrr	female	user50@yopmail.com	$2a$10$GiMuiBilQMjebn5JOhnELeR1XPyQ9/6one3x5RUfciyqwVbx8jJ/y	1590406078376.jpeg	\N	\N	\N	ZNTM	\N	\N	1	2020-05-23 08:31:39	2020-05-25 12:58:28	cdniu6qW_U4ZgZVcdnnrwj:APA91bG1RM0W0sV9904coiivZXc3hUjndH-uKQ6rXIuvcubu2oS779T_j-NRSdcTdZ7yR7fDW0ACkqzJBicex2lEI7Ma0HwiIRzwT3-FxACGk3VFOUCYDuUWpMZ43VbNonedR7re8Meo	6	\N	\N	\N	\N
327	2	firstM	Userrr	male	user54@yopmail.com	$2a$10$ctq0nk0gFnoPv2DZmWkFu.A3ds97k1.ZWlRsrsmKBPub7rubAmqle	\N	\N	\N	\N	BGUA	\N	\N	1	2020-05-29 10:14:58	2020-06-03 01:46:40	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	7	\N	\N	\N	\N
303	2	gautam	test	male	gautam_marwaha@yahoo.in	$2a$10$7.hR/QyHJysfJi9upzk9kewIYtaF9XP.OMaAJbXaJ435JIpXaSGiK	\N	\N	\N	\N	EKYN	\N	\N	1	2020-05-24 05:22:10	2020-05-24 05:22:10	\N	1	\N	\N	\N	\N
300	2	a	f	female	asf@yopmail.com	$2a$10$93IkN2ty8VTsE6G3HDSjS.DI3txIsh9pvHI7kjkLAZFG/4zEUBhQm	1590168674246.jpeg	\N	\N	\N	QZNY	\N	\N	1	2020-05-22 04:35:13	2020-05-22 05:31:14	fciXgSmjI05lg8BWe_UCNC:APA91bFQAhL_fik98j33TaxLrsmQwOCHdcZTXNs-DO96NSWz48mCry8LiZkjOuH4tMVC3BU-Zv2Kxpf02ovuP_kxTZGe1s8jBi07VC5OsOsDqup9daJliV7AOhudVxzInLfeAH4MZH5l	1	\N	\N	\N	\N
304	2	gautam	marwaha	female	test-q@gmail.com	$2a$10$fvzJWAeffZf0qs7pXiY1jut9YFqs6nra711vj8ZBUcLgohi2KbaIi	\N	\N	\N	\N	GGQX	\N	\N	1	2020-05-24 05:26:40	2020-05-24 05:26:40	\N	1	\N	\N	\N	\N
369	2	Kristine	Cooj	female	ahart3188@gmail.com	$2a$10$TRErp5zUvm12JpR/Yz/HsejqdiO5PZEdZr7aTTRG.0ICzytJiMO.W	1595035377248.jpeg	\N	\N	\N	LLMI	\N	\N	1	2020-07-18 01:22:18	2020-07-18 05:24:09	dJ8mCy57QIiyVCcan4WmKd:APA91bF-wONl3sa2nogd9tNvKDX5jkYlfIqCwMNgRAAbami-TOLE9k05RgmB3oCZ7U02PVMAUBrazo2rMfgdVwN9HBPQIuCwUPfTYwiUNTfrK_EQQUpPaf_RgIXuosoXKGDK6SaHMdhP	1	\N	\N	\N	\N
312	2	secMas	userasfafasfasfsafafsasfa	male	user53@yopmail.com	$2a$10$UyX9IbcHqPWxr/amH3jFbuCzxUFPuJmxVQz5DcRiqiBo5lF62IxYe	1590414391861.jpeg	\N	\N	\N	MWLY	0	2020-05-28 05:44:28	1	2020-05-25 01:46:22	2020-06-03 01:45:37	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	7	\N	\N	\N	2020-05-28 05:44:28
308	2	gautam	marwaha	male	gautam.oh@mailinator.com	$2a$10$vmpveq5OgXLN295d/8hrHuq5oxfG97Q54mL7PV61veupZuCHZeCKG	\N	\N	\N	\N	SUKX	\N	\N	1	2020-05-25 04:38:02	2020-05-25 01:02:53	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	7	\N	\N	\N	\N
363	2	Release	Test	male	release1@yopmail.com	$2a$10$mVxQjVZaW1aZHmEDunQ54..CkYZYpnWwrWMUFhBHaSMavi4Fxc2ky	\N	\N	\N	\N	WMFB	0	2020-06-19 12:07:45	1	2020-06-19 11:53:03	2020-06-19 01:11:49	dXM2S0w-Q3e4gMQVnONWo8:APA91bHfWF9u4ip_oUzOjezHSftB62CDrmfmGlS5PG4OQZUjs_PcbExYpkZohC8moei5YlLatoKQum_ZqHmaVCAwvylt1hL5gjkxRSwJhgvH8n7OZrwiSFz9rPyf8hxmTiIVqn5UtFSU	7	\N	\N	\N	2020-06-19 12:07:45
337	2	Bhavna	Female	female	bhavna.female@mailinator.com	$2a$10$/NZ0mJHdEdHqVrwjOb2kJOxUcVdwZRl5UhBxWdvZw8WAWbqwPeeDO	\N	\N	\N	\N	DMOP	0	2020-06-10 07:39:28	1	2020-06-04 08:55:45	2020-06-27 07:07:58	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	7	\N	\N	\N	2020-06-10 07:39:28
331	2	Gautam	Android	male	male.android@mailinator.com	$2a$10$cDFZRKQ7ZXCBvgCM0rRnnOK79laGqFEqiylXTSs2.jAnwlZ5oKTDe	\N	\N	\N	\N	UQAQ	\N	\N	1	2020-06-01 09:28:28	2020-06-01 09:30:23	\N	1	\N	\N	\N	\N
328	2	secF	Userrr	female	user55@yopmail.com	$2a$10$rgSW7kE6MvU41vGwL9sLrOSjaRTU7QAd70UbmSbA1zP1cNL.VLBJC	\N	\N	\N	\N	MEOP	\N	\N	1	2020-05-29 10:15:11	2020-06-03 01:46:27	e7Ufb4lLQYWy1MupwYXU3e:APA91bEPkV_yX_82OTYb-D_YTFzJ7cjaUt1-IudepvJXkNbGNkCL-1yUFHywZxNa68_lYuuJiQALw4q5ApyQoKpIo6jj9TrLGPiuRjPniZIYmuwjpMxqF7glv3Wi3E82mcP81q0wSP-9	7	\N	\N	\N	\N
311	2	firstM	Userrr	male	user52@yopmail.com	$2a$10$gUrEpJbwtilpEzFogDbq8OgKMSHHy5gW9w0SxYqH9SzFTjwq8.0qy	1590414827812.jpeg	\N	\N	\N	WGAE	0	2020-05-28 05:44:28	1	2020-05-25 01:45:46	2020-06-03 01:19:26	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	7	\N	\N	\N	2020-05-28 05:44:28
350	2	Tedt	Tedt	female	demo.globalia2@gmail.com	$2a$10$lpRZ21gmZPTd8r9l/XflqOqEcd8OADgFtzdpWicxPx8.DnF81aRa.	\N	\N	\N	\N	MHXD	\N	\N	1	2020-06-11 09:54:17	2020-06-11 09:54:17	\N	1	\N	\N	\N	\N
322	2	test	rest	male	on1@yopmail.com	$2a$10$wMCpUHW0y7mLuDk0fhas6OXEz4hL0cylQaBGV9DY..Ibj9WO3aCgi	1590599515298.jpeg	\N	\N	\N	KYAA	0	2020-05-27 17:19:16	1	2020-05-27 05:11:44	2020-05-29 07:41:24	c-v8W5JS2kuwtElzIm240t:APA91bGIoshnH5G4LicHKjKUnASajeu_EYW9wvM58n6WGQJ5y3kbhaM0lR2XfnBn6FOypS9_N6Hmvo9v5UyshwqiIy00dPi9wcf8g-_IT4jad8YwdOilIul-qPrIlO97y2rDkY5yIFUM	1	\N	\N	\N	2020-05-27 17:19:16
362	2	latest	test	female	release@yopmail.com	$2a$10$.9JJpx716itDLuzcyjvY7eXaaaDJkCnp2EsjkkyEMrzvAQEWkjEOW	1592566485325.jpeg	\N	\N	\N	IBDO	0	2020-06-19 12:07:45	1	2020-06-19 11:34:16	2020-06-19 11:54:29	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	7	\N	\N	\N	2020-06-19 12:07:45
340	2	mkb	Mkb	male	mk2@yopmail.com	$2a$10$y1OI9/lgSif5i/ATwBBCeeMOLo6YBtppChhh5qVVcyeYTdFKRlNAG	\N	\N	\N	\N	DHDD	0	2020-06-11 07:50:14	1	2020-06-08 05:49:08	2020-06-20 02:30:01	e0QNplpoSBa5EK0OT6KC1z:APA91bGwvxaCF9PZBPUlyy156CW6m4giu3u1FYn05IgpoNBr6hehqIyjeoxsjZmp8iX0VPd4Nmw9ThtRtGWVmyRrbBeUI24-mMTQv7yw7kyUVavvJB4HtNCU8MjE_hL9kg4rfjP9-Qsz	7	\N	\N	\N	2020-06-10 07:50:14
352	2	Tedtb	Ggghh	female	demos@yopmail.com	$2a$10$OCfDfraOE5Q/y/r6pxL/ruuaCql4u2n70Qup8/0t978ypq9uoAk6W	\N	\N	\N	\N	ADWN	\N	\N	1	2020-06-11 12:01:25	2020-06-11 12:01:25	\N	1	\N	\N	\N	\N
334	2	secF	Userrr	female	user56@yopmail.com	$2a$10$SKp6GEeLpgfua6fktHvFguVAy/AIYIRzRl4sWAqvFCqnnv/AwQGpy	\N	\N	\N	\N	EROF	\N	\N	1	2020-06-03 01:47:53	2020-06-09 11:12:42	eK_CqKB0RNeS9Toz5d6hE3:APA91bG3UC3oNH4v7BDElUB4sYsY9KnMZH9sc1ARWMNcDKGSP4pOoGRv3Dk3ESZyvlIOFeK0UUi0Ld7XlC_RNEQzxJZbyiQAbWcV52SDPKOiusP4yoEoyqv2XO3cpat-m-oEiVMbTLe3	7	\N	\N	\N	\N
330	2	sheetal	iPhone	female	female.iphone@mailinator.com	$2a$10$8rH8Kv.MUzQ9U0L.ToWum.fChdKjnjIWqBpG6oqMmdq/Rtq7K3YpW	\N	\N	\N	\N	BSQF	\N	\N	1	2020-06-01 09:25:36	2020-06-04 04:32:09	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1	\N	\N	\N	\N
332	2	Gomsy	Android	male	gomsy.android@mailinator.com	$2a$10$WwtQU4UIjeZQIRlk5hy35eFHoV1pGzkUDjDEF6/VMnnkgtvLXb6Ta	\N	\N	\N	\N	FPVE	\N	\N	1	2020-06-01 09:48:18	2020-06-04 08:22:04	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	1	\N	\N	\N	\N
345	2	TesterQ	Testerw	female	testusers1@gmail.com	$2y$12$8gHAAkwN.94SSQDIZqociOi8obGlXALDmMpeYJEEMKPt.BtY7QAGO	\N	\N	\N	\N	IQOU	\N	\N	1	2020-06-10 10:02:34	2020-06-17 04:09:37	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	7	\N	\N	\N	\N
319	2	Male	Kumar	male	male.oh@mailinator.com	$2a$10$HvWDMRXTGHRGb/v3cSgCGev.osyQH1WBCO3CNPmEWSY7.WghNjsFm	1590567316755.jpeg	\N	\N	\N	IDYA	\N	\N	1	2020-05-27 08:13:39	2020-06-01 09:14:46	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	7	\N	\N	\N	\N
364	2	Subodh	Srivastava	female	subodh@yopmail.com	$2a$10$EcytYriMCBqVpL24udfP8eA3hqDvKUCaN.iJzKhheoWhTR1cAFGNC	1592927043420.jpeg	\N	\N	\N	XPOE	0	2020-07-18 03:49:51	1	2020-06-23 03:43:16	2020-07-18 03:56:52	cjbUl3ws50qivDvjEBc6Jf:APA91bHmC30c-TV7QVTEPpkqLfYr-SgeEyLPxCC2tNT4HVz_UQ5_RIFfQfyKIgjL60aThvMMIqJtgqVL685mDOGBHJS1KTW56K4wFclr46NW7JMjz6Kn-7KVhVwzwUK9Mub1Uu_MNq7N	1	\N	\N	\N	2020-07-18 03:49:51
320	2	female	kumari	female	female.oh@mailinator.com	$2a$10$u/HAC4Ym3UmiBwfnQCD2d.d5XWs9fkCHukth6ES2YKOpfe36JlK6G	1590568680147.jpeg	\N	\N	\N	ESIM	\N	\N	1	2020-05-27 08:37:38	2020-06-01 09:17:20	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	7	\N	\N	\N	\N
346	2	Testuser	Test	female	testuser2@gmail.com	$2y$12$8gHAAkwN.94SSQDIZqociOi8obGlXALDmMpeYJEEMKPt.BtY7QAGO	\N	\N	\N	\N	BKRE	\N	\N	1	2020-06-10 10:05:12	2020-06-10 11:13:54	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	6	\N	\N	\N	\N
357	2	male	id	male	male@yopmail.com	$2a$10$NdIyU3JwBtTrm64nyRWIL.XNgLMtZkoxlYHbYM0nZQFi8pTo9bcHi	\N	\N	\N	\N	STVY	0	2020-07-18 03:49:51	1	2020-06-12 10:50:36	2020-06-26 06:26:54	cm0zU4n030Bap7ZrOuWzlZ:APA91bEZfHPON2x1rmvE7qLmXp449qt2GGqJpwQtrjMGFXbjD3dzzfc9B88FmjV-wKXQc-7NTNehoxMCl_RX3AZp01ZcPIL68mMqBESFhd8D-TTfMve3T9IyhL3ma9Lvqmt8ctFF6N3Y	1	\N	\N	\N	2020-07-18 03:49:51
335	2	firstM	Userrr	male	user57@yopmail.com	$2a$10$60C./2wVuTdS5n56ZnjJJO3bDBEqOMohBQh54u3fBPeQzCsgEVFwm	\N	\N	\N	\N	WZRQ	\N	\N	1	2020-06-03 01:48:06	2020-06-09 11:15:45	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	7	\N	\N	\N	\N
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 369, true);


--
-- Name: Options_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Options"
    ADD CONSTRAINT "Options_pkey" PRIMARY KEY (id);


--
-- Name: chat_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_attachments
    ADD CONSTRAINT chat_attachments_pkey PRIMARY KEY (id);


--
-- Name: chat_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_messages
    ADD CONSTRAINT chat_messages_pkey PRIMARY KEY (id);


--
-- Name: chat_status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_status
    ADD CONSTRAINT chat_status_pkey PRIMARY KEY (id);


--
-- Name: completion_goals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.completion_goals
    ADD CONSTRAINT completion_goals_pkey PRIMARY KEY (id);


--
-- Name: goal_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goal_notifications
    ADD CONSTRAINT goal_notifications_pkey PRIMARY KEY (id);


--
-- Name: goal_setting_answers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goal_setting_answers
    ADD CONSTRAINT goal_setting_answers_pkey PRIMARY KEY (id);


--
-- Name: goal_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goal_settings
    ADD CONSTRAINT goal_settings_pkey PRIMARY KEY (id);


--
-- Name: info_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.info_messages
    ADD CONSTRAINT info_messages_pkey PRIMARY KEY (id);


--
-- Name: monthly_goals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.monthly_goals
    ADD CONSTRAINT monthly_goals_pkey PRIMARY KEY (id);


--
-- Name: notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: pages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);


--
-- Name: quickies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quickies
    ADD CONSTRAINT quickies_pkey PRIMARY KEY (id);


--
-- Name: roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: subscripations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscripations
    ADD CONSTRAINT subscripations_pkey PRIMARY KEY (id);


--
-- Name: unavailabilities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unavailabilities
    ADD CONSTRAINT unavailabilities_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.21
-- Dumped by pg_dump version 9.5.19

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: Options; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Options" (
    title character varying(250),
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    question_id bigint,
    id integer NOT NULL
);


ALTER TABLE public."Options" OWNER TO postgres;

--
-- Name: Options_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Options_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Options_id_seq" OWNER TO postgres;

--
-- Name: Options_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Options_id_seq" OWNED BY public."Options".id;


--
-- Name: chat_attachments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chat_attachments (
    id bigint NOT NULL,
    chat_id bigint,
    original_file_name character varying(100),
    unique_file_name character varying(100),
    status smallint,
    create_time timestamp without time zone,
    update_time timestamp without time zone
);


ALTER TABLE public.chat_attachments OWNER TO postgres;

--
-- Name: chat_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.chat_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.chat_attachments_id_seq OWNER TO postgres;

--
-- Name: chat_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.chat_attachments_id_seq OWNED BY public.chat_attachments.id;


--
-- Name: chat_messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chat_messages (
    id bigint NOT NULL,
    goal_id bigint,
    sender_id bigint,
    receiver_id bigint,
    message text,
    chat_status_id bigint,
    create_time timestamp without time zone,
    update_time timestamp without time zone
);


ALTER TABLE public.chat_messages OWNER TO postgres;

--
-- Name: chat_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.chat_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.chat_messages_id_seq OWNER TO postgres;

--
-- Name: chat_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.chat_messages_id_seq OWNED BY public.chat_messages.id;


--
-- Name: chat_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chat_status (
    id bigint NOT NULL,
    status character varying(100),
    create_time timestamp without time zone,
    update_time timestamp without time zone
);


ALTER TABLE public.chat_status OWNER TO postgres;

--
-- Name: chat_status_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.chat_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.chat_status_id_seq OWNER TO postgres;

--
-- Name: chat_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.chat_status_id_seq OWNED BY public.chat_status.id;


--
-- Name: completion_goals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.completion_goals (
    id integer NOT NULL,
    user_id bigint,
    goal_id bigint,
    partner_mapping_id bigint,
    "didYouConnectLastNight" boolean,
    "WhoInitiative" boolean,
    create_time timestamp without time zone,
    update_time timestamp without time zone
);


ALTER TABLE public.completion_goals OWNER TO postgres;

--
-- Name: completion_goals_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.completion_goals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.completion_goals_id_seq OWNER TO postgres;

--
-- Name: completion_goals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.completion_goals_id_seq OWNED BY public.completion_goals.id;


--
-- Name: contact_us; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contact_us (
    id integer NOT NULL,
    feedback_details text,
    user_id bigint,
    create_time timestamp without time zone,
    update_time timestamp without time zone
);


ALTER TABLE public.contact_us OWNER TO postgres;

--
-- Name: contact_us_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contact_us_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contact_us_id_seq OWNER TO postgres;

--
-- Name: contact_us_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contact_us_id_seq OWNED BY public.contact_us.id;


--
-- Name: goal_notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.goal_notifications (
    id bigint NOT NULL,
    goal_id bigint,
    user_id bigint,
    device_id text,
    notification_id text,
    parent_notification_id bigint,
    answer text,
    status smallint,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    stage bigint DEFAULT 1
);


ALTER TABLE public.goal_notifications OWNER TO postgres;

--
-- Name: goal_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.goal_notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.goal_notifications_id_seq OWNER TO postgres;

--
-- Name: goal_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.goal_notifications_id_seq OWNED BY public.goal_notifications.id;


--
-- Name: goal_setting_answers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.goal_setting_answers (
    id bigint NOT NULL,
    question_id bigint,
    answer text,
    status smallint,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    user_id bigint,
    custom_answer text
);


ALTER TABLE public.goal_setting_answers OWNER TO postgres;

--
-- Name: goal_setting_answers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.goal_setting_answers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.goal_setting_answers_id_seq OWNER TO postgres;

--
-- Name: goal_setting_answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.goal_setting_answers_id_seq OWNED BY public.goal_setting_answers.id;


--
-- Name: goal_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.goal_settings (
    id bigint NOT NULL,
    question_descripation character varying(500),
    status smallint,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    question_title character(500),
    iscustom character(500)
);


ALTER TABLE public.goal_settings OWNER TO postgres;

--
-- Name: goal_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.goal_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.goal_settings_id_seq OWNER TO postgres;

--
-- Name: goal_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.goal_settings_id_seq OWNED BY public.goal_settings.id;


--
-- Name: info_messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.info_messages (
    id integer NOT NULL,
    title character varying(200),
    description text,
    status bigint,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    key character varying(100),
    screen character varying(100)
);


ALTER TABLE public.info_messages OWNER TO postgres;

--
-- Name: info_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.info_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.info_messages_id_seq OWNER TO postgres;

--
-- Name: info_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.info_messages_id_seq OWNED BY public.info_messages.id;


--
-- Name: monthly_goals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.monthly_goals (
    id bigint NOT NULL,
    partner_mapping_id bigint,
    user_id bigint,
    goal_identifier character varying(150),
    month_start character varying(50),
    month_end character varying(50),
    connect_number character varying(50),
    initiator_count character varying(50),
    percentage character varying(50),
    complete_count character varying(50),
    complete_percentage character varying(50),
    status smallint,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    intimate_time character varying(50),
    intimate_request_time character varying(50),
    intimate_account_time character varying(50),
    initiator_count1 character varying(50),
    contribution2 bigint DEFAULT 0 NOT NULL,
    contribution1 bigint DEFAULT 0 NOT NULL,
    hours character varying(200)
);


ALTER TABLE public.monthly_goals OWNER TO postgres;

--
-- Name: monthly_goals_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.monthly_goals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.monthly_goals_id_seq OWNER TO postgres;

--
-- Name: monthly_goals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.monthly_goals_id_seq OWNED BY public.monthly_goals.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications (
    id bigint NOT NULL,
    question character varying(500),
    status smallint,
    create_time timestamp without time zone,
    update_time timestamp without time zone
);


ALTER TABLE public.notifications OWNER TO postgres;

--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notifications_id_seq OWNER TO postgres;

--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: pages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pages (
    id bigint NOT NULL,
    title character varying(250),
    description text,
    status smallint,
    create_time timestamp without time zone,
    update_time timestamp without time zone
);


ALTER TABLE public.pages OWNER TO postgres;

--
-- Name: pages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pages_id_seq OWNER TO postgres;

--
-- Name: pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pages_id_seq OWNED BY public.pages.id;


--
-- Name: partner_mappings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.partner_mappings (
    id bigint NOT NULL,
    partner_one_id bigint,
    partner_two_id bigint,
    status smallint,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    uniqe_id character varying(100)
);


ALTER TABLE public.partner_mappings OWNER TO postgres;

--
-- Name: partner_mappings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.partner_mappings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.partner_mappings_id_seq OWNER TO postgres;

--
-- Name: partner_mappings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.partner_mappings_id_seq OWNED BY public.partner_mappings.id;


--
-- Name: quickies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quickies (
    id integer NOT NULL,
    user_id bigint,
    partner_mapping_id bigint,
    partner_response boolean,
    "when" character varying(200),
    "where" character varying(200),
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    partner1_intrest boolean,
    partner2_intrest boolean,
    partner1_answer1 boolean,
    partner1_answer2 boolean,
    partner2_answer1 boolean,
    partner2_answer2 boolean,
    contribution bigint
);


ALTER TABLE public.quickies OWNER TO postgres;

--
-- Name: quickies_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.quickies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.quickies_id_seq OWNER TO postgres;

--
-- Name: quickies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.quickies_id_seq OWNED BY public.quickies.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    role_title character varying(100),
    status smallint,
    create_time timestamp without time zone,
    update_time timestamp without time zone
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_id_seq OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: subscripations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subscripations (
    id integer NOT NULL,
    user_id bigint,
    partner_mapping_id bigint,
    purchase_plan_id text,
    amount bigint,
    device_name character varying(200),
    subscripation_plan character varying(200),
    receipt text,
    status bigint,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    expiry_date timestamp without time zone
);


ALTER TABLE public.subscripations OWNER TO postgres;

--
-- Name: subscripations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subscripations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subscripations_id_seq OWNER TO postgres;

--
-- Name: subscripations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subscripations_id_seq OWNED BY public.subscripations.id;


--
-- Name: unavailabilities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.unavailabilities (
    id integer NOT NULL,
    user_id bigint,
    unavailability_start timestamp without time zone,
    unavailability_end timestamp without time zone,
    status smallint,
    create_time timestamp without time zone,
    update_time timestamp without time zone
);


ALTER TABLE public.unavailabilities OWNER TO postgres;

--
-- Name: unavailabilities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.unavailabilities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.unavailabilities_id_seq OWNER TO postgres;

--
-- Name: unavailabilities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.unavailabilities_id_seq OWNED BY public.unavailabilities.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    role_id bigint NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    gender character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    password character varying(100) NOT NULL,
    profile_image character varying(100),
    face_id character varying(250),
    touch_id character varying(250),
    access_token character varying(150),
    unique_code character varying(150),
    notification_mute_status smallint,
    notification_mute_end timestamp without time zone,
    status smallint NOT NULL,
    create_time timestamp without time zone NOT NULL,
    update_time timestamp without time zone NOT NULL,
    fcmid character varying(250),
    stage smallint DEFAULT 1,
    device_name character varying(100),
    receipt text,
    expiry_time timestamp without time zone,
    notification_mute_start timestamp without time zone
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Options" ALTER COLUMN id SET DEFAULT nextval('public."Options_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_attachments ALTER COLUMN id SET DEFAULT nextval('public.chat_attachments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_messages ALTER COLUMN id SET DEFAULT nextval('public.chat_messages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_status ALTER COLUMN id SET DEFAULT nextval('public.chat_status_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.completion_goals ALTER COLUMN id SET DEFAULT nextval('public.completion_goals_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_us ALTER COLUMN id SET DEFAULT nextval('public.contact_us_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goal_notifications ALTER COLUMN id SET DEFAULT nextval('public.goal_notifications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goal_setting_answers ALTER COLUMN id SET DEFAULT nextval('public.goal_setting_answers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goal_settings ALTER COLUMN id SET DEFAULT nextval('public.goal_settings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.info_messages ALTER COLUMN id SET DEFAULT nextval('public.info_messages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.monthly_goals ALTER COLUMN id SET DEFAULT nextval('public.monthly_goals_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pages ALTER COLUMN id SET DEFAULT nextval('public.pages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partner_mappings ALTER COLUMN id SET DEFAULT nextval('public.partner_mappings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quickies ALTER COLUMN id SET DEFAULT nextval('public.quickies_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscripations ALTER COLUMN id SET DEFAULT nextval('public.subscripations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unavailabilities ALTER COLUMN id SET DEFAULT nextval('public.unavailabilities_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: Options; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Options" (title, create_time, update_time, question_id, id) FROM stdin;
Cuddling	2020-05-22 06:22:31	2020-05-22 06:22:31	17	143
Showering together	2020-05-22 06:22:31	2020-05-22 06:22:31	17	144
Pillow-talk	2020-05-22 06:22:31	2020-05-22 06:22:31	17	145
Woman on top	2020-05-22 05:58:04	2020-05-22 05:58:04	8	28
 Man on top	2020-05-22 05:58:04	2020-05-22 05:58:04	8	29
Rear entry	2020-05-22 05:58:04	2020-05-22 05:58:04	8	30
Side by side	2020-05-22 05:58:04	2020-05-22 05:58:04	8	31
Standing	2020-05-22 05:58:04	2020-05-22 05:58:04	8	32
Kneeling	2020-05-22 05:58:04	2020-05-22 05:58:04	8	33
Seated	2020-05-22 05:58:04	2020-05-22 05:58:04	8	34
Mirror	2020-05-22 06:04:05	2020-05-22 06:04:05	9	48
Blindfold	2020-05-22 06:04:05	2020-05-22 06:04:05	9	49
Lubrication	2020-05-22 06:04:05	2020-05-22 06:04:05	9	50
Kissing	2020-05-22 06:04:30	2020-05-22 06:04:30	7	51
Petting 	2020-05-22 06:04:30	2020-05-22 06:04:30	7	52
Massage	2020-05-22 06:04:30	2020-05-22 06:04:30	7	53
Massage with oil	2020-05-22 06:04:30	2020-05-22 06:04:30	7	54
Verbal	2020-05-22 06:04:30	2020-05-22 06:04:30	7	55
Oral	2020-05-22 06:04:30	2020-05-22 06:04:30	7	56
Candles Low	2020-05-22 06:20:19	2020-05-22 06:20:19	16	128
 lighting	2020-05-22 06:20:19	2020-05-22 06:20:19	16	129
Completely dark	2020-05-22 06:20:19	2020-05-22 06:20:19	16	131
5 minutes	2020-05-22 06:20:36	2020-05-22 06:20:36	15	132
15 minutes	2020-05-22 06:20:36	2020-05-22 06:20:36	15	133
30 minutes	2020-05-22 06:20:36	2020-05-22 06:20:36	15	134
Not important	2020-05-22 06:10:02	2020-05-22 06:10:02	11	71
Important	2020-05-22 06:10:02	2020-05-22 06:10:02	11	72
Very important!	2020-05-22 06:10:02	2020-05-22 06:10:02	11	73
60 minutes	2020-05-22 06:20:36	2020-05-22 06:20:36	15	135
\.


--
-- Name: Options_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Options_id_seq"', 152, true);


--
-- Data for Name: chat_attachments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.chat_attachments (id, chat_id, original_file_name, unique_file_name, status, create_time, update_time) FROM stdin;
\.


--
-- Name: chat_attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.chat_attachments_id_seq', 1, false);


--
-- Data for Name: chat_messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.chat_messages (id, goal_id, sender_id, receiver_id, message, chat_status_id, create_time, update_time) FROM stdin;
649	11	24	25	c2RzYWRhYWRhZHNh	1	2020-02-11 23:34:39	2020-02-11 23:34:39
650	11	24	25	YWFkc2Fkc2FzYWRhZGFz	1	2020-02-11 23:34:53	2020-02-11 23:34:53
651	11	24	25	ZHNhYWRhZGFzZHNh	1	2020-02-11 23:39:13	2020-02-11 23:39:13
652	11	24	25	ZHNhZGFkc2Fkc2Fkc2E=	1	2020-02-11 23:44:35	2020-02-11 23:44:35
653	11	24	25	c2Rmc2Zkcw==	1	2020-02-11 23:44:40	2020-02-11 23:44:40
654	11	24	25	c2RzYWRhYWRhYQ==	1	2020-02-11 23:44:45	2020-02-11 23:44:45
655	11	24	25	YXNkYXNkc2FzYWQ=	1	2020-02-11 23:44:50	2020-02-11 23:44:50
656	11	24	25	c2FkYWFkYXNkc2Fhc2FzZHNhcw==	1	2020-02-11 23:44:57	2020-02-11 23:44:57
657	11	24	25	ZXF3ZWVld3Fld3Fld3E=	1	2020-02-11 23:45:46	2020-02-11 23:45:46
658	11	24	25	c2FzZHNhZGRzZGE=	1	2020-02-11 23:45:52	2020-02-11 23:45:52
659	11	25	24	YXNkc2FkYWRhc2Rh	1	2020-02-11 23:46:39	2020-02-11 23:46:39
660	11	25	24	c3Nkc2RzYWRzYWRzYXM=	1	2020-02-11 23:46:59	2020-02-11 23:46:59
661	11	25	24	cWVxd3FxcXdld3Fld3Fld3E=	1	2020-02-11 23:47:12	2020-02-11 23:47:12
662	11	25	24	c2Fkc2FhYXNzYWRh	1	2020-02-11 23:47:22	2020-02-11 23:47:22
663	11	24	25	ZGFkc2FkYWRhYXNkYQ==	1	2020-02-11 23:56:44	2020-02-11 23:56:44
664	11	24	25	YXNkYXNhYWFkYWRhc2Rhc2RzYQ==	1	2020-02-11 23:57:01	2020-02-11 23:57:01
665	11	24	25	c2FkYWFkYWRhc2RhZHNh	1	2020-02-11 23:57:29	2020-02-11 23:57:29
666	11	24	25	ZGFkYXNhc2FzYQ==	1	2020-02-12 00:06:49	2020-02-12 00:06:49
667	11	24	25	YWRhc2FkYWRhZGFzZGFkc2E=	1	2020-02-12 00:07:25	2020-02-12 00:07:25
668	11	24	25	ZGFkZGFzZGFkYXM=	1	2020-02-12 00:17:41	2020-02-12 00:17:41
669	11	24	25	YWRhYWRhZGFzZHNhZHNh	1	2020-02-12 00:18:49	2020-02-12 00:18:49
670	11	34	35	ZHNhZGFhZGFhc2RhZHNhZGRhZHNhcw==	1	2020-02-12 00:19:04	2020-02-12 00:19:04
671	11	24	25	ZGFzZHNhYWRzYWRzYQ==	1	2020-02-12 00:19:14	2020-02-12 00:19:14
672	11	24	25	ZGFkc2Rhc2RhZGFz	1	2020-02-12 00:21:00	2020-02-12 00:21:00
673	11	24	25	c2FkYWFkYXNhcw==	1	2020-02-12 00:21:49	2020-02-12 00:21:49
674	11	24	25	ZGFzZGFzZGFzZGE=	1	2020-02-12 00:28:11	2020-02-12 00:28:11
675	11	24	25	ZGRhYXNkYXNkYQ==	1	2020-02-12 00:28:43	2020-02-12 00:28:43
676	11	25	24	ZGFhZGFkc2Fkc2Fkc2E=	1	2020-02-12 00:29:01	2020-02-12 00:29:01
\.


--
-- Name: chat_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.chat_messages_id_seq', 1, false);


--
-- Data for Name: chat_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.chat_status (id, status, create_time, update_time) FROM stdin;
1	NEW	2020-01-14 00:00:00	2020-01-14 00:00:00
2	READ	2020-01-14 00:00:00	2020-01-14 00:00:00
3	UNREAD	2020-01-14 00:00:00	2020-01-14 00:00:00
4	DELETE	2020-01-14 00:00:00	2020-01-14 00:00:00
\.


--
-- Name: chat_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.chat_status_id_seq', 1, false);


--
-- Data for Name: completion_goals; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.completion_goals (id, user_id, goal_id, partner_mapping_id, "didYouConnectLastNight", "WhoInitiative", create_time, update_time) FROM stdin;
1	51	162	226	t	t	2020-05-16 08:22:43	2020-05-16 08:22:43
2	52	162	226	t	f	2020-05-16 08:22:52	2020-05-16 08:22:52
3	267	221	258	t	t	2020-05-20 11:15:17	2020-05-20 11:15:17
4	268	221	258	t	f	2020-05-20 11:18:41	2020-05-20 11:18:41
5	267	221	258	t	t	2020-05-20 11:19:37	2020-05-20 11:19:37
6	327	328	414	t	f	2020-05-29 06:48:44	2020-05-29 06:48:44
7	327	328	414	t	f	2020-05-29 06:51:00	2020-05-29 06:51:00
8	327	328	414	t	f	2020-05-29 06:51:16	2020-05-29 06:51:16
9	327	328	414	t	f	2020-05-29 06:51:18	2020-05-29 06:51:18
10	327	328	414	t	f	2020-05-29 06:51:41	2020-05-29 06:51:41
11	328	328	414	t	t	2020-05-29 06:52:11	2020-05-29 06:52:11
12	330	353	453	t	t	2020-06-02 06:32:05	2020-06-02 06:32:05
13	311	347	448	t	f	2020-06-03 06:32:27	2020-06-03 06:32:27
14	311	347	448	t	f	2020-06-03 10:51:14	2020-06-03 10:51:14
15	311	347	448	t	f	2020-06-03 10:51:21	2020-06-03 10:51:21
16	311	347	448	t	f	2020-06-03 10:59:00	2020-06-03 10:59:00
17	311	347	448	t	f	2020-06-03 10:59:47	2020-06-03 10:59:47
18	311	347	448	t	f	2020-06-03 10:59:56	2020-06-03 10:59:56
19	311	347	448	t	f	2020-06-03 11:00:14	2020-06-03 11:00:14
20	311	347	448	t	f	2020-06-03 11:00:38	2020-06-03 11:00:38
21	311	347	448	t	f	2020-06-03 11:00:52	2020-06-03 11:00:52
22	311	347	448	t	f	2020-06-03 11:05:13	2020-06-03 11:05:13
23	311	347	449	t	t	2020-06-03 11:06:05	2020-06-03 11:06:05
24	311	347	448	t	f	2020-06-03 11:06:21	2020-06-03 11:06:21
25	311	347	449	t	t	2020-06-03 11:06:23	2020-06-03 11:06:23
26	312	347	449	t	f	2020-06-03 11:07:20	2020-06-03 11:07:20
27	312	347	448	t	t	2020-06-03 11:07:23	2020-06-03 11:07:23
28	312	347	449	t	f	2020-06-03 11:10:19	2020-06-03 11:10:19
29	312	347	448	t	t	2020-06-03 11:10:26	2020-06-03 11:10:26
30	312	347	449	t	f	2020-06-03 11:36:30	2020-06-03 11:36:30
31	312	347	449	t	f	2020-06-03 11:36:53	2020-06-03 11:36:53
32	312	347	449	t	f	2020-06-03 11:37:10	2020-06-03 11:37:10
33	312	347	449	t	f	2020-06-03 11:37:15	2020-06-03 11:37:15
34	312	347	449	t	f	2020-06-03 11:37:30	2020-06-03 11:37:30
35	312	372	449	t	f	2020-06-03 11:54:01	2020-06-03 11:54:01
36	312	372	449	t	f	2020-06-03 11:54:09	2020-06-03 11:54:09
37	312	372	449	t	f	2020-06-03 11:54:15	2020-06-03 11:54:15
38	312	374	448	t	t	2020-06-03 12:00:09	2020-06-03 12:00:09
39	312	374	449	t	f	2020-06-03 12:00:20	2020-06-03 12:00:20
40	312	374	448	t	t	2020-06-03 12:00:23	2020-06-03 12:00:23
41	312	375	448	t	t	2020-06-03 12:02:07	2020-06-03 12:02:07
42	312	375	449	t	f	2020-06-03 12:02:08	2020-06-03 12:02:08
43	51	355	226	t	t	2020-06-03 12:05:44	2020-06-03 12:05:44
44	312	377	448	t	t	2020-06-03 12:09:44	2020-06-03 12:09:44
45	312	377	449	t	f	2020-06-03 12:09:48	2020-06-03 12:09:48
46	312	378	449	t	f	2020-06-03 12:19:35	2020-06-03 12:19:35
47	312	378	449	t	f	2020-06-03 12:25:21	2020-06-03 12:25:21
48	312	378	449	t	f	2020-06-03 12:25:30	2020-06-03 12:25:30
49	312	378	449	t	f	2020-06-03 12:25:37	2020-06-03 12:25:37
50	312	378	449	t	f	2020-06-03 12:25:53	2020-06-03 12:25:53
51	312	384	449	t	f	2020-06-03 12:37:32	2020-06-03 12:37:32
52	312	384	448	t	t	2020-06-03 12:37:34	2020-06-03 12:37:34
53	312	387	448	t	t	2020-06-03 12:40:04	2020-06-03 12:40:04
54	312	387	449	t	f	2020-06-03 12:40:05	2020-06-03 12:40:05
55	312	387	449	t	f	2020-06-03 12:40:16	2020-06-03 12:40:16
56	312	389	449	t	f	2020-06-03 12:43:20	2020-06-03 12:43:20
57	312	389	448	t	t	2020-06-03 12:43:22	2020-06-03 12:43:22
58	312	389	449	t	f	2020-06-03 12:43:52	2020-06-03 12:43:52
59	312	390	449	t	f	2020-06-03 12:47:14	2020-06-03 12:47:14
60	312	390	448	t	t	2020-06-03 12:47:14	2020-06-03 12:47:14
61	312	395	448	t	t	2020-06-03 12:54:02	2020-06-03 12:54:02
62	312	395	449	t	f	2020-06-03 12:54:08	2020-06-03 12:54:08
63	312	396	449	t	f	2020-06-03 12:57:45	2020-06-03 12:57:45
64	312	396	448	t	t	2020-06-03 01:02:57	2020-06-03 01:02:57
65	335	419	493	t	f	2020-06-03 01:50:36	2020-06-03 01:50:36
66	334	419	492	t	f	2020-06-03 01:50:40	2020-06-03 01:50:40
67	335	419	493	t	f	2020-06-03 01:50:51	2020-06-03 01:50:51
68	335	420	493	t	f	2020-06-03 01:51:37	2020-06-03 01:51:37
69	335	421	493	t	f	2020-06-03 01:53:16	2020-06-03 01:53:16
70	334	421	492	t	f	2020-06-03 01:53:23	2020-06-03 01:53:23
71	335	421	493	t	f	2020-06-03 01:53:34	2020-06-03 01:53:34
72	334	425	497	t	f	2020-06-05 10:05:59	2020-06-05 10:05:59
73	335	425	496	t	f	2020-06-05 10:06:04	2020-06-05 10:06:04
74	334	427	499	t	f	2020-06-05 10:29:22	2020-06-05 10:29:22
75	334	427	499	t	f	2020-06-05 10:29:27	2020-06-05 10:29:27
76	337	423	494	t	t	2020-06-06 07:35:29	2020-06-06 07:35:29
77	337	423	494	t	t	2020-06-06 07:35:46	2020-06-06 07:35:46
78	337	423	494	t	t	2020-06-07 01:30:58	2020-06-07 01:30:58
79	364	459	529	t	f	2020-06-25 11:46:40	2020-06-25 11:46:40
80	357	459	529	t	t	2020-06-26 12:27:00	2020-06-26 12:27:00
\.


--
-- Name: completion_goals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.completion_goals_id_seq', 80, true);


--
-- Data for Name: contact_us; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contact_us (id, feedback_details, user_id, create_time, update_time) FROM stdin;
1	IT's good looking and usefull App	52	2020-05-14 11:44:29	2020-05-14 11:44:29
2	Hhjji	230	2020-05-14 01:11:29	2020-05-14 01:11:29
3	Vuvjbbk	236	2020-05-14 04:49:31	2020-05-14 04:49:31
4	Hhjj	234	2020-05-14 04:49:34	2020-05-14 04:49:34
5	Sjdjccjcjdjjcccfncccxdjdjjxjx	281	2020-05-22 08:29:25	2020-05-22 08:29:25
6	Etehehy	291	2020-05-22 09:23:17	2020-05-22 09:23:17
7	     	257	2020-05-23 04:17:25	2020-05-23 04:17:25
8	Happy to help 	289	2020-05-25 01:13:56	2020-05-25 01:13:56
10	Jangal gangal 	317	2020-05-27 05:16:44	2020-05-27 05:16:44
11	Ggdfxgg	341	2020-06-15 09:11:46	2020-06-15 09:11:46
12	Ghhjk	342	2020-06-19 11:46:33	2020-06-19 11:46:33
13	Vfgjghj	362	2020-06-19 12:07:33	2020-06-19 12:07:33
\.


--
-- Name: contact_us_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contact_us_id_seq', 13, true);


--
-- Data for Name: goal_notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.goal_notifications (id, goal_id, user_id, device_id, notification_id, parent_notification_id, answer, status, create_time, update_time, stage) FROM stdin;
1107	115	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589336820027441%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:27:00	2020-05-13 02:27:00	1
1108	115	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589336820027275%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:27:00	2020-05-13 02:27:00	1
1109	115	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589336880024134%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:28:00	2020-05-13 02:28:00	1
1110	115	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589336880027630%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:28:00	2020-05-13 02:28:00	1
1111	115	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589336940025815%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:29:00	2020-05-13 02:29:00	1
1112	115	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589336940026164%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:29:00	2020-05-13 02:29:00	1
1113	115	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337000028962%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:30:00	2020-05-13 02:30:00	1
1114	115	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337000028767%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:30:00	2020-05-13 02:30:00	1
1115	115	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337060028562%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:31:00	2020-05-13 02:31:00	1
1116	115	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337060026786%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:31:00	2020-05-13 02:31:00	1
1117	115	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337120026401%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:32:00	2020-05-13 02:32:00	1
1118	115	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337120017926%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:32:00	2020-05-13 02:32:00	1
1119	115	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337180018580%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:33:00	2020-05-13 02:33:00	1
1120	115	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337180037662%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:33:00	2020-05-13 02:33:00	1
1121	115	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337240026049%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:34:00	2020-05-13 02:34:00	1
1122	115	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337240027544%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:34:00	2020-05-13 02:34:00	1
1123	115	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337300027804%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:35:00	2020-05-13 02:35:00	1
1124	115	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337300027097%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:35:00	2020-05-13 02:35:00	1
1125	115	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337360026210%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:36:00	2020-05-13 02:36:00	1
1126	115	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337360023137%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:36:00	2020-05-13 02:36:00	1
1127	115	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337420026771%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:37:00	2020-05-13 02:37:00	1
1128	115	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337420017351%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:37:00	2020-05-13 02:37:00	1
1129	115	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337480027809%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:38:00	2020-05-13 02:38:00	1
1130	115	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337480028526%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:38:00	2020-05-13 02:38:00	1
1131	115	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337540017614%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:39:00	2020-05-13 02:39:00	1
1132	115	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337540018183%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:39:00	2020-05-13 02:39:00	1
1133	115	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337600027656%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:40:00	2020-05-13 02:40:00	1
1134	115	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337600026346%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:40:00	2020-05-13 02:40:00	1
1136	115	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337660023805%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:41:00	2020-05-13 02:41:00	1
1135	115	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337660024759%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:41:00	2020-05-13 02:41:00	1
1137	115	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337720028911%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:42:00	2020-05-13 02:42:00	1
1138	115	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337720031088%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:42:00	2020-05-13 02:42:00	1
1139	115	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337780024885%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:43:00	2020-05-13 02:43:00	1
1140	115	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337780023459%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:43:00	2020-05-13 02:43:00	1
1141	115	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337840020026%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:44:00	2020-05-13 02:44:00	1
1142	115	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337840027467%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:44:00	2020-05-13 02:44:00	1
1143	115	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337900029848%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:45:00	2020-05-13 02:45:00	1
1144	115	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337900028983%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:45:00	2020-05-13 02:45:00	1
1146	115	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337960038889%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:46:00	2020-05-13 02:46:00	1
1147	118	193	cj2rVhFpQm-FEYuxrQlsjj:APA91bFurpLXORS4AkD-f4PtHfjdh9hFVHIcP8Es9Npb5C8F67ussqAnAzM_SENk9mOUGVbC2dk-9cLXwUKbgCgpiqpsv_beA9iRhL0UjKoeXjhTK4701JxLcpRYBZ-1yRmZUcMpF5iW	0:1589390400046836%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 05:20:00	2020-05-13 05:20:00	1
1148	118	193	cj2rVhFpQm-FEYuxrQlsjj:APA91bFurpLXORS4AkD-f4PtHfjdh9hFVHIcP8Es9Npb5C8F67ussqAnAzM_SENk9mOUGVbC2dk-9cLXwUKbgCgpiqpsv_beA9iRhL0UjKoeXjhTK4701JxLcpRYBZ-1yRmZUcMpF5iW	0:1589390400046487%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 05:20:00	2020-05-13 05:20:00	1
1149	117	189	cj2rVhFpQm-FEYuxrQlsjj:APA91bFurpLXORS4AkD-f4PtHfjdh9hFVHIcP8Es9Npb5C8F67ussqAnAzM_SENk9mOUGVbC2dk-9cLXwUKbgCgpiqpsv_beA9iRhL0UjKoeXjhTK4701JxLcpRYBZ-1yRmZUcMpF5iW	0:1589393700038639%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 06:15:00	2020-05-13 06:15:00	1
1150	117	189	cj2rVhFpQm-FEYuxrQlsjj:APA91bFurpLXORS4AkD-f4PtHfjdh9hFVHIcP8Es9Npb5C8F67ussqAnAzM_SENk9mOUGVbC2dk-9cLXwUKbgCgpiqpsv_beA9iRhL0UjKoeXjhTK4701JxLcpRYBZ-1yRmZUcMpF5iW	0:1589393700038159%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 06:15:00	2020-05-13 06:15:00	1
1151	119	198	cj2rVhFpQm-FEYuxrQlsjj:APA91bFurpLXORS4AkD-f4PtHfjdh9hFVHIcP8Es9Npb5C8F67ussqAnAzM_SENk9mOUGVbC2dk-9cLXwUKbgCgpiqpsv_beA9iRhL0UjKoeXjhTK4701JxLcpRYBZ-1yRmZUcMpF5iW	0:1589396400025918%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 07:00:00	2020-05-13 07:00:00	1
1152	119	198	cj2rVhFpQm-FEYuxrQlsjj:APA91bFurpLXORS4AkD-f4PtHfjdh9hFVHIcP8Es9Npb5C8F67ussqAnAzM_SENk9mOUGVbC2dk-9cLXwUKbgCgpiqpsv_beA9iRhL0UjKoeXjhTK4701JxLcpRYBZ-1yRmZUcMpF5iW	0:1589396400026477%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 07:00:00	2020-05-13 07:00:00	1
1153	137	243	dZaJSAmH9kUos4Obpy4s6r:APA91bFGDk879XNaOBI3IOewjW_-w9uGIfsrBu6x-plMUkYQSMI06X6MScw7f3eQTpcuX_Bte3aF7a7Lp7fo1Dj2GgGVdUZM0gltbQftFIWqJbVbuWyQWDhsVVAX7wIofbQtzt-W7lFH	1589482800041107	\N	\N	1	2020-05-14 07:00:00	2020-05-14 07:00:00	1
1154	137	243	dZaJSAmH9kUos4Obpy4s6r:APA91bFGDk879XNaOBI3IOewjW_-w9uGIfsrBu6x-plMUkYQSMI06X6MScw7f3eQTpcuX_Bte3aF7a7Lp7fo1Dj2GgGVdUZM0gltbQftFIWqJbVbuWyQWDhsVVAX7wIofbQtzt-W7lFH	1589482800041630	\N	\N	1	2020-05-14 07:00:00	2020-05-14 07:00:00	1
1145	115	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589337960034215%fc0c01eafc0c01ea	\N	\N	1	2020-05-13 02:46:00	2020-05-16 09:50:01	2
1155	178	249	fcvNsIWoTbWpeCBkGc5DAr:APA91bGsNmsVTOP4gbx4JEZXgAhbI4A0DighXLkBGiHJK0D4pNTVCJuIwIxICHzi8EBURCAHTdSTlAXp8FOjohXAkOZqBrnpYu65uN10V-6RgUebrWq7N8rnoW3RyEbOi9C9N5LQ4CN7	0:1589870820087688%0d63f7200d63f720	\N	\N	1	2020-05-19 06:47:00	2020-05-19 06:47:00	1
1156	178	254	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589870820093017%fc0c01eafc0c01ea	\N	\N	1	2020-05-19 06:47:00	2020-05-19 06:47:00	1
1157	178	249	fcvNsIWoTbWpeCBkGc5DAr:APA91bGsNmsVTOP4gbx4JEZXgAhbI4A0DighXLkBGiHJK0D4pNTVCJuIwIxICHzi8EBURCAHTdSTlAXp8FOjohXAkOZqBrnpYu65uN10V-6RgUebrWq7N8rnoW3RyEbOi9C9N5LQ4CN7	0:1589870880040372%0d63f7200d63f720	\N	\N	1	2020-05-19 06:48:00	2020-05-19 06:48:00	1
1158	178	254	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589870880058460%fc0c01eafc0c01ea	\N	\N	1	2020-05-19 06:48:00	2020-05-19 06:48:00	1
1159	196	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589878904131974%fc0c01eafc0c01ea	\N	\N	1	2020-05-19 09:01:44	2020-05-19 09:01:44	1
1160	196	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589878904131440%fc0c01eafc0c01ea	\N	\N	1	2020-05-19 09:01:44	2020-05-19 09:01:44	1
1161	196	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589878905094348%fc0c01eafc0c01ea	\N	\N	1	2020-05-19 09:01:45	2020-05-19 09:01:45	1
1162	196	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589878905102971%fc0c01eafc0c01ea	\N	\N	1	2020-05-19 09:01:45	2020-05-19 09:01:45	1
1163	196	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589878906091428%fc0c01eafc0c01ea	\N	\N	1	2020-05-19 09:01:46	2020-05-19 09:01:46	1
1169	196	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589878909089480%fc0c01eafc0c01ea	\N	\N	1	2020-05-19 09:01:49	2020-05-19 09:01:49	1
1164	196	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589878906090279%fc0c01eafc0c01ea	\N	\N	1	2020-05-19 09:01:46	2020-05-19 09:01:46	1
1165	196	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589878907090381%fc0c01eafc0c01ea	\N	\N	1	2020-05-19 09:01:47	2020-05-19 09:01:47	1
1166	196	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589878907097770%fc0c01eafc0c01ea	\N	\N	1	2020-05-19 09:01:47	2020-05-19 09:01:47	1
1167	196	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589878908080406%fc0c01eafc0c01ea	\N	\N	1	2020-05-19 09:01:48	2020-05-19 09:01:48	1
1168	196	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589878908090906%fc0c01eafc0c01ea	\N	\N	1	2020-05-19 09:01:48	2020-05-19 09:01:48	1
1170	196	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589878909092743%fc0c01eafc0c01ea	\N	\N	1	2020-05-19 09:01:49	2020-05-19 09:01:49	1
1173	217	264	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589895000070957%fc0c01eafc0c01ea	\N	\N	1	2020-05-19 01:30:00	2020-05-19 01:30:00	1
1174	217	261	dD4NeqvoQEOiuge1wkTj5v:APA91bFEGUhEoWidTlD4Zo2aQPbQtAL-gpJP_beak4jOxNPX153941SUAlTEXgS7q6H8rdv_AmGf-Zx7sfEb1XFzHyEl9kMWenXyE7DkCQUYlfK9aECZLt-LxiMSptnoCc05MZlMRYE7	0:1589895000068380%0d63f7200d63f720	\N	\N	1	2020-05-19 01:30:00	2020-05-19 01:30:00	1
1175	218	264	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589895300026803%fc0c01eafc0c01ea	\N	\N	1	2020-05-19 01:35:00	2020-05-19 01:35:00	1
1176	218	261	cvTEtFXUTZek_GYwOnxHLt:APA91bE1aIwv-WJUyzAb9LIOdkpEQZkFZ_CxYbIs9g_RzSt2klkOhXS6Tmd2rbTmRfOOXtM8Sia1O0zmC91DxntA7Si1Tn1a9MUsIXsGx8GbBTfRG5aY9OuhCBbs1YEAByjZ_ZMpOFq-	0:1589895300031639%0d63f7200d63f720	\N	\N	1	2020-05-19 01:35:00	2020-05-19 01:35:00	1
1177	219	264	dD4NeqvoQEOiuge1wkTj5v:APA91bFEGUhEoWidTlD4Zo2aQPbQtAL-gpJP_beak4jOxNPX153941SUAlTEXgS7q6H8rdv_AmGf-Zx7sfEb1XFzHyEl9kMWenXyE7DkCQUYlfK9aECZLt-LxiMSptnoCc05MZlMRYE7	0:1589895600062101%0d63f7200d63f720	\N	\N	1	2020-05-19 01:40:00	2020-05-19 01:40:00	1
1178	219	261	cvTEtFXUTZek_GYwOnxHLt:APA91bE1aIwv-WJUyzAb9LIOdkpEQZkFZ_CxYbIs9g_RzSt2klkOhXS6Tmd2rbTmRfOOXtM8Sia1O0zmC91DxntA7Si1Tn1a9MUsIXsGx8GbBTfRG5aY9OuhCBbs1YEAByjZ_ZMpOFq-	0:1589895600069958%0d63f7200d63f720	\N	\N	1	2020-05-19 01:40:00	2020-05-19 01:40:00	1
1186	221	267	cvTEtFXUTZek_GYwOnxHLt:APA91bE1aIwv-WJUyzAb9LIOdkpEQZkFZ_CxYbIs9g_RzSt2klkOhXS6Tmd2rbTmRfOOXtM8Sia1O0zmC91DxntA7Si1Tn1a9MUsIXsGx8GbBTfRG5aY9OuhCBbs1YEAByjZ_ZMpOFq-	0:1589962200118856%0d63f7200d63f720	\N	\N	1	2020-05-20 08:10:00	2020-05-20 08:10:00	1
1180	220	264	dD4NeqvoQEOiuge1wkTj5v:APA91bFEGUhEoWidTlD4Zo2aQPbQtAL-gpJP_beak4jOxNPX153941SUAlTEXgS7q6H8rdv_AmGf-Zx7sfEb1XFzHyEl9kMWenXyE7DkCQUYlfK9aECZLt-LxiMSptnoCc05MZlMRYE7	0:1589895900027655%0d63f7200d63f720	\N	\N	1	2020-05-19 01:45:00	2020-05-22 05:50:25	3
1185	221	268	fcvNsIWoTbWpeCBkGc5DAr:APA91bGsNmsVTOP4gbx4JEZXgAhbI4A0DighXLkBGiHJK0D4pNTVCJuIwIxICHzi8EBURCAHTdSTlAXp8FOjohXAkOZqBrnpYu65uN10V-6RgUebrWq7N8rnoW3RyEbOi9C9N5LQ4CN7	0:1589962200040010%0d63f7200d63f720	\N	\N	1	2020-05-20 08:10:00	2020-05-20 08:10:05	2
1181	221	268	fcvNsIWoTbWpeCBkGc5DAr:APA91bGsNmsVTOP4gbx4JEZXgAhbI4A0DighXLkBGiHJK0D4pNTVCJuIwIxICHzi8EBURCAHTdSTlAXp8FOjohXAkOZqBrnpYu65uN10V-6RgUebrWq7N8rnoW3RyEbOi9C9N5LQ4CN7	0:1589957100044384%0d63f7200d63f720	\N	\N	1	2020-05-20 06:45:00	2020-05-20 06:45:00	1
1188	221	267	fcvNsIWoTbWpeCBkGc5DAr:APA91bGsNmsVTOP4gbx4JEZXgAhbI4A0DighXLkBGiHJK0D4pNTVCJuIwIxICHzi8EBURCAHTdSTlAXp8FOjohXAkOZqBrnpYu65uN10V-6RgUebrWq7N8rnoW3RyEbOi9C9N5LQ4CN7	0:1589962500031894%0d63f7200d63f720	\N	\N	1	2020-05-20 08:15:00	2020-05-20 08:15:00	1
1182	221	267	cvTEtFXUTZek_GYwOnxHLt:APA91bE1aIwv-WJUyzAb9LIOdkpEQZkFZ_CxYbIs9g_RzSt2klkOhXS6Tmd2rbTmRfOOXtM8Sia1O0zmC91DxntA7Si1Tn1a9MUsIXsGx8GbBTfRG5aY9OuhCBbs1YEAByjZ_ZMpOFq-	0:1589957100039476%0d63f7200d63f720	\N	\N	1	2020-05-20 06:45:00	2020-05-20 06:50:50	2
1187	221	268	cvTEtFXUTZek_GYwOnxHLt:APA91bE1aIwv-WJUyzAb9LIOdkpEQZkFZ_CxYbIs9g_RzSt2klkOhXS6Tmd2rbTmRfOOXtM8Sia1O0zmC91DxntA7Si1Tn1a9MUsIXsGx8GbBTfRG5aY9OuhCBbs1YEAByjZ_ZMpOFq-	0:1589962500024433%0d63f7200d63f720	\N	\N	1	2020-05-20 08:15:00	2020-05-20 08:15:08	2
1171	202	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589883780279389%fc0c01eafc0c01ea	\N	\N	1	2020-05-19 10:23:00	2020-05-20 06:56:04	3
1172	202	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589883780325756%fc0c01eafc0c01ea	\N	\N	1	2020-05-19 10:23:00	2020-05-20 06:56:04	3
1184	208	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589960100082607%fc0c01eafc0c01ea	\N	\N	1	2020-05-20 07:35:00	2020-05-20 07:35:00	1
1190	221	268	cvTEtFXUTZek_GYwOnxHLt:APA91bE1aIwv-WJUyzAb9LIOdkpEQZkFZ_CxYbIs9g_RzSt2klkOhXS6Tmd2rbTmRfOOXtM8Sia1O0zmC91DxntA7Si1Tn1a9MUsIXsGx8GbBTfRG5aY9OuhCBbs1YEAByjZ_ZMpOFq-	0:1589962800026783%0d63f7200d63f720	\N	\N	1	2020-05-20 08:20:00	2020-05-20 09:53:40	3
1189	221	267	fcvNsIWoTbWpeCBkGc5DAr:APA91bGsNmsVTOP4gbx4JEZXgAhbI4A0DighXLkBGiHJK0D4pNTVCJuIwIxICHzi8EBURCAHTdSTlAXp8FOjohXAkOZqBrnpYu65uN10V-6RgUebrWq7N8rnoW3RyEbOi9C9N5LQ4CN7	0:1589962800023928%0d63f7200d63f720	\N	\N	1	2020-05-20 08:20:00	2020-05-20 09:53:40	3
1179	220	261	cvTEtFXUTZek_GYwOnxHLt:APA91bE1aIwv-WJUyzAb9LIOdkpEQZkFZ_CxYbIs9g_RzSt2klkOhXS6Tmd2rbTmRfOOXtM8Sia1O0zmC91DxntA7Si1Tn1a9MUsIXsGx8GbBTfRG5aY9OuhCBbs1YEAByjZ_ZMpOFq-	0:1589895900035666%0d63f7200d63f720	\N	\N	1	2020-05-19 01:45:00	2020-05-22 05:50:25	3
1201	220	261	cdniu6qW_U4ZgZVcdnnrwj:APA91bG1RM0W0sV9904coiivZXc3hUjndH-uKQ6rXIuvcubu2oS779T_j-NRSdcTdZ7yR7fDW0ACkqzJBicex2lEI7Ma0HwiIRzwT3-FxACGk3VFOUCYDuUWpMZ43VbNonedR7re8Meo	0:1590129600073450%0d63f7200d63f720	\N	\N	1	2020-05-22 06:40:00	2020-05-22 07:02:05	3
1196	222	257	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1590103800083220	\N	\N	1	2020-05-21 11:30:00	2020-05-22 03:17:50	3
1195	222	266	dArFeGuzw0OKqERpGgwJ8i:APA91bEe0KbgzFSBSyZ3JyGIZeUBG0w2sJeeydChA-4d0cCxL-IXucEocZVcgGfUK7_u3EulXFivEuuC3I0oJKBTQvuxFGU-z5b2Wm_WmSrFvKn83xGrBd9AiFQSZyFf4OHLAeBMK1CM	1590103800089043	\N	\N	1	2020-05-21 11:30:00	2020-05-22 03:17:50	3
1198	222	266	dArFeGuzw0OKqERpGgwJ8i:APA91bEe0KbgzFSBSyZ3JyGIZeUBG0w2sJeeydChA-4d0cCxL-IXucEocZVcgGfUK7_u3EulXFivEuuC3I0oJKBTQvuxFGU-z5b2Wm_WmSrFvKn83xGrBd9AiFQSZyFf4OHLAeBMK1CM	1590103800088841	\N	\N	1	2020-05-21 11:30:00	2020-05-22 03:22:07	3
1197	222	257	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1590103800083736	\N	\N	1	2020-05-21 11:30:00	2020-05-22 03:22:07	3
1200	222	257	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1590103800083489	\N	\N	1	2020-05-21 11:30:00	2020-05-22 03:27:23	3
1199	222	266	dArFeGuzw0OKqERpGgwJ8i:APA91bEe0KbgzFSBSyZ3JyGIZeUBG0w2sJeeydChA-4d0cCxL-IXucEocZVcgGfUK7_u3EulXFivEuuC3I0oJKBTQvuxFGU-z5b2Wm_WmSrFvKn83xGrBd9AiFQSZyFf4OHLAeBMK1CM	1590103800089998	\N	\N	1	2020-05-21 11:30:00	2020-05-22 03:27:23	3
1202	220	261	cdniu6qW_U4ZgZVcdnnrwj:APA91bG1RM0W0sV9904coiivZXc3hUjndH-uKQ6rXIuvcubu2oS779T_j-NRSdcTdZ7yR7fDW0ACkqzJBicex2lEI7Ma0HwiIRzwT3-FxACGk3VFOUCYDuUWpMZ43VbNonedR7re8Meo	0:1590129600073355%0d63f7200d63f720	\N	\N	1	2020-05-22 06:40:00	2020-05-22 06:40:00	1
1192	221	267	fcvNsIWoTbWpeCBkGc5DAr:APA91bGsNmsVTOP4gbx4JEZXgAhbI4A0DighXLkBGiHJK0D4pNTVCJuIwIxICHzi8EBURCAHTdSTlAXp8FOjohXAkOZqBrnpYu65uN10V-6RgUebrWq7N8rnoW3RyEbOi9C9N5LQ4CN7	0:1589968800040972%0d63f7200d63f720	\N	\N	1	2020-05-20 10:00:00	2020-05-20 11:19:18	3
1191	221	268	cvTEtFXUTZek_GYwOnxHLt:APA91bE1aIwv-WJUyzAb9LIOdkpEQZkFZ_CxYbIs9g_RzSt2klkOhXS6Tmd2rbTmRfOOXtM8Sia1O0zmC91DxntA7Si1Tn1a9MUsIXsGx8GbBTfRG5aY9OuhCBbs1YEAByjZ_ZMpOFq-	0:1589968800039326%0d63f7200d63f720	\N	\N	1	2020-05-20 10:00:00	2020-05-20 11:19:18	3
1193	234	126	cjbUl3ws50qivDvjEBc6Jf:APA91bHmC30c-TV7QVTEPpkqLfYr-SgeEyLPxCC2tNT4HVz_UQ5_RIFfQfyKIgjL60aThvMMIqJtgqVL685mDOGBHJS1KTW56K4wFclr46NW7JMjz6Kn-7KVhVwzwUK9Mub1Uu_MNq7N	1590087600109676	\N	\N	1	2020-05-21 07:00:00	2020-05-21 07:00:00	1
1194	234	275	cEt9nI1WukDIpzxV0HGzgT:APA91bE1Kp6wZKSwXqBJ58uc0bTzZmBbQ0CoUnsSM6t42kk1RhTgsY089e45HP-xAKxOGLp93SrxUxgzmyhy73aqQ69LI4hfPvsVqGSMHj-tXcJJ0UhPPreS0EzMutQbXRjrnUhlRYLc	1590087600111055	\N	\N	1	2020-05-21 07:00:00	2020-05-21 07:00:00	1
1203	220	261	cdniu6qW_U4ZgZVcdnnrwj:APA91bG1RM0W0sV9904coiivZXc3hUjndH-uKQ6rXIuvcubu2oS779T_j-NRSdcTdZ7yR7fDW0ACkqzJBicex2lEI7Ma0HwiIRzwT3-FxACGk3VFOUCYDuUWpMZ43VbNonedR7re8Meo	0:1590129600073150%0d63f7200d63f720	\N	\N	1	2020-05-22 06:40:00	2020-05-22 06:40:00	1
1204	220	261	cdniu6qW_U4ZgZVcdnnrwj:APA91bG1RM0W0sV9904coiivZXc3hUjndH-uKQ6rXIuvcubu2oS779T_j-NRSdcTdZ7yR7fDW0ACkqzJBicex2lEI7Ma0HwiIRzwT3-FxACGk3VFOUCYDuUWpMZ43VbNonedR7re8Meo	0:1590129600073446%0d63f7200d63f720	\N	\N	1	2020-05-22 06:40:00	2020-05-22 06:40:00	1
1205	220	261	cdniu6qW_U4ZgZVcdnnrwj:APA91bG1RM0W0sV9904coiivZXc3hUjndH-uKQ6rXIuvcubu2oS779T_j-NRSdcTdZ7yR7fDW0ACkqzJBicex2lEI7Ma0HwiIRzwT3-FxACGk3VFOUCYDuUWpMZ43VbNonedR7re8Meo	0:1590129600073642%0d63f7200d63f720	\N	\N	1	2020-05-22 06:40:00	2020-05-22 06:40:00	1
1206	220	261	cdniu6qW_U4ZgZVcdnnrwj:APA91bG1RM0W0sV9904coiivZXc3hUjndH-uKQ6rXIuvcubu2oS779T_j-NRSdcTdZ7yR7fDW0ACkqzJBicex2lEI7Ma0HwiIRzwT3-FxACGk3VFOUCYDuUWpMZ43VbNonedR7re8Meo	0:1590129600074461%0d63f7200d63f720	\N	\N	1	2020-05-22 06:40:00	2020-05-22 06:40:00	1
1207	220	261	cdniu6qW_U4ZgZVcdnnrwj:APA91bG1RM0W0sV9904coiivZXc3hUjndH-uKQ6rXIuvcubu2oS779T_j-NRSdcTdZ7yR7fDW0ACkqzJBicex2lEI7Ma0HwiIRzwT3-FxACGk3VFOUCYDuUWpMZ43VbNonedR7re8Meo	0:1590129600073855%0d63f7200d63f720	\N	\N	1	2020-05-22 06:40:00	2020-05-22 06:40:00	1
1208	220	261	cdniu6qW_U4ZgZVcdnnrwj:APA91bG1RM0W0sV9904coiivZXc3hUjndH-uKQ6rXIuvcubu2oS779T_j-NRSdcTdZ7yR7fDW0ACkqzJBicex2lEI7Ma0HwiIRzwT3-FxACGk3VFOUCYDuUWpMZ43VbNonedR7re8Meo	0:1590129600074173%0d63f7200d63f720	\N	\N	1	2020-05-22 06:40:00	2020-05-22 06:40:00	1
1218	220	264	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1590129600070992%fc0c01eafc0c01ea	\N	\N	1	2020-05-22 06:40:00	2020-05-22 06:40:00	1
1213	220	264	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1590129600068061%fc0c01eafc0c01ea	\N	\N	1	2020-05-22 06:40:00	2020-05-22 07:02:05	3
1209	220	261	cdniu6qW_U4ZgZVcdnnrwj:APA91bG1RM0W0sV9904coiivZXc3hUjndH-uKQ6rXIuvcubu2oS779T_j-NRSdcTdZ7yR7fDW0ACkqzJBicex2lEI7Ma0HwiIRzwT3-FxACGk3VFOUCYDuUWpMZ43VbNonedR7re8Meo	0:1590129600074521%0d63f7200d63f720	\N	\N	1	2020-05-22 06:40:00	2020-05-22 06:40:00	1
1214	220	264	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1590129600067606%fc0c01eafc0c01ea	\N	\N	1	2020-05-22 06:40:00	2020-05-22 06:40:00	1
1219	220	264	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1590129600069775%fc0c01eafc0c01ea	\N	\N	1	2020-05-22 06:40:00	2020-05-22 06:40:00	1
1210	220	261	cdniu6qW_U4ZgZVcdnnrwj:APA91bG1RM0W0sV9904coiivZXc3hUjndH-uKQ6rXIuvcubu2oS779T_j-NRSdcTdZ7yR7fDW0ACkqzJBicex2lEI7Ma0HwiIRzwT3-FxACGk3VFOUCYDuUWpMZ43VbNonedR7re8Meo	0:1590129600074172%0d63f7200d63f720	\N	\N	1	2020-05-22 06:40:00	2020-05-22 06:40:00	1
1215	220	264	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1590129600067620%fc0c01eafc0c01ea	\N	\N	1	2020-05-22 06:40:00	2020-05-22 06:40:00	1
1220	220	264	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1590129600071779%fc0c01eafc0c01ea	\N	\N	1	2020-05-22 06:40:00	2020-05-22 06:40:00	1
1211	220	264	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1590129600069290%fc0c01eafc0c01ea	\N	\N	1	2020-05-22 06:40:00	2020-05-22 06:40:00	1
1216	220	264	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1590129600069960%fc0c01eafc0c01ea	\N	\N	1	2020-05-22 06:40:00	2020-05-22 06:40:00	1
1212	220	264	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1590129600067721%fc0c01eafc0c01ea	\N	\N	1	2020-05-22 06:40:00	2020-05-22 06:40:00	1
1217	220	264	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1590129600069979%fc0c01eafc0c01ea	\N	\N	1	2020-05-22 06:40:00	2020-05-22 06:40:00	1
1221	273	311	cdniu6qW_U4ZgZVcdnnrwj:APA91bG1RM0W0sV9904coiivZXc3hUjndH-uKQ6rXIuvcubu2oS779T_j-NRSdcTdZ7yR7fDW0ACkqzJBicex2lEI7Ma0HwiIRzwT3-FxACGk3VFOUCYDuUWpMZ43VbNonedR7re8Meo	0:1590426000094582%0d63f7200d63f720	\N	\N	1	2020-05-25 05:00:00	2020-05-25 05:00:00	1
1240	342	311	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1591005300067589%0d63f7200d63f720	\N	\N	1	2020-06-01 09:55:00	2020-06-01 09:55:00	1
1241	341	311	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1591005300067673%0d63f7200d63f720	\N	\N	1	2020-06-01 09:55:00	2020-06-01 09:55:00	1
1242	341	312	f8XPbzFsRtCdU5qOmfxm5T:APA91bHWWCXx5CUsvvPRTtSL3kOXtxSwKTwo_Wi_9XcCYpiB1sfN9cJ1GN9ZDSyDXGZV2nmQbAYzDmkZutHF6da29_jGX8KvE_LOAtsvliOAQOsNcNbFqvOtY7kGnZh3sOxv0-n7nBQ4	0:1591005300060571%0d63f7200d63f720	\N	\N	1	2020-06-01 09:55:00	2020-06-01 09:55:31	2
1183	208	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1589960100081953%fc0c01eafc0c01ea	\N	\N	1	2020-05-20 07:35:00	2020-05-26 03:52:01	2
1222	303	312	ck7vgGLF7UOajo7SDoRsqa:APA91bHskk_kh2C1YyjgQhdUDDZLB4ECA4lGPhyahoM5ZAEO4GnfjRmCczNiQmkDAB4ZSia8cQqtMj92wgcd1_FDzNEgN6tCk7MdzaW-DO9JGmHrdKBglHOWNiCrCsrenzTa2XDos3GG	0:1590598800098199%0d63f7200d63f720	\N	\N	1	2020-05-27 05:00:00	2020-05-27 05:00:00	1
1223	303	311	ck7vgGLF7UOajo7SDoRsqa:APA91bHskk_kh2C1YyjgQhdUDDZLB4ECA4lGPhyahoM5ZAEO4GnfjRmCczNiQmkDAB4ZSia8cQqtMj92wgcd1_FDzNEgN6tCk7MdzaW-DO9JGmHrdKBglHOWNiCrCsrenzTa2XDos3GG	0:1590598800098503%0d63f7200d63f720	\N	\N	1	2020-05-27 05:00:00	2020-05-27 05:00:00	1
1224	306	312	e07TyMeXT_GqMwE8tuFECo:APA91bEzzTUyRRFG5mPA99fcZ6M30vr2GVmf3mUbvPRIkkE6-B2sfbn9GQG44rPcj4ZpRQ85GJArFMrOoGFYi98njPtjICtisBgf43tymMYR3PtPFvUmKp66k6JKx-FnU61P8DnTl5AJ	0:1590598800110463%0d63f7200d63f720	\N	\N	1	2020-05-27 05:00:00	2020-05-27 05:00:00	1
1225	304	312	e07TyMeXT_GqMwE8tuFECo:APA91bEzzTUyRRFG5mPA99fcZ6M30vr2GVmf3mUbvPRIkkE6-B2sfbn9GQG44rPcj4ZpRQ85GJArFMrOoGFYi98njPtjICtisBgf43tymMYR3PtPFvUmKp66k6JKx-FnU61P8DnTl5AJ	0:1590598800110975%0d63f7200d63f720	\N	\N	1	2020-05-27 05:00:00	2020-05-27 05:00:00	1
1226	323	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1590742860114009%fc0c01eafc0c01ea	\N	\N	1	2020-05-29 09:01:00	2020-05-29 09:01:00	1
1227	323	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1590742860114961%fc0c01eafc0c01ea	\N	\N	1	2020-05-29 09:01:00	2020-05-29 09:01:00	1
1228	324	311	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1590745500155851%0d63f7200d63f720	\N	\N	1	2020-05-29 09:45:00	2020-05-29 09:45:00	1
1229	324	312	f-EApn08SQO7VRip3xt0-H:APA91bEknfIfd1EQtzNAGm8nAEkuVVtlaBrQdTyj3rXKf-n_L4f3iQbkUHEBGOXECny0jLMftDajySlnBSjS65U7xec3KhOwyfnbvIaZcX8Y05RWBV6SnKxxBLjrFM6E-2-myRQrc7ab	0:1590745500152616%0d63f7200d63f720	\N	\N	1	2020-05-29 09:45:00	2020-05-29 09:45:00	1
1230	325	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1590746940057355%fc0c01eafc0c01ea	\N	\N	1	2020-05-29 10:09:00	2020-05-29 10:09:00	1
1231	325	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1590746940053442%fc0c01eafc0c01ea	\N	\N	1	2020-05-29 10:09:00	2020-05-29 10:09:00	1
1232	326	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1590747060043908%fc0c01eafc0c01ea	\N	\N	1	2020-05-29 10:11:00	2020-05-29 10:11:00	1
1233	326	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1590747060043716%fc0c01eafc0c01ea	\N	\N	1	2020-05-29 10:11:00	2020-05-29 10:11:00	1
1235	328	327	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1590747600128689%0d63f7200d63f720	\N	\N	1	2020-05-29 10:20:00	2020-05-29 10:20:00	1
1234	328	328	f-EApn08SQO7VRip3xt0-H:APA91bEknfIfd1EQtzNAGm8nAEkuVVtlaBrQdTyj3rXKf-n_L4f3iQbkUHEBGOXECny0jLMftDajySlnBSjS65U7xec3KhOwyfnbvIaZcX8Y05RWBV6SnKxxBLjrFM6E-2-myRQrc7ab	0:1590747600117917%0d63f7200d63f720	\N	\N	1	2020-05-29 10:20:00	2020-05-29 10:20:06	2
1236	336	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1590994500057980%fc0c01eafc0c01ea	\N	\N	1	2020-06-01 06:55:00	2020-06-01 06:55:00	1
1237	336	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1590994500058262%fc0c01eafc0c01ea	\N	\N	1	2020-06-01 06:55:00	2020-06-01 06:55:00	1
1239	337	311	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1591001700072522%0d63f7200d63f720	\N	\N	1	2020-06-01 08:55:00	2020-06-01 08:55:00	1
1238	337	312	f8XPbzFsRtCdU5qOmfxm5T:APA91bHWWCXx5CUsvvPRTtSL3kOXtxSwKTwo_Wi_9XcCYpiB1sfN9cJ1GN9ZDSyDXGZV2nmQbAYzDmkZutHF6da29_jGX8KvE_LOAtsvliOAQOsNcNbFqvOtY7kGnZh3sOxv0-n7nBQ4	0:1591001700039204%0d63f7200d63f720	\N	\N	1	2020-06-01 08:55:00	2020-06-01 08:55:24	2
1243	342	312	f8XPbzFsRtCdU5qOmfxm5T:APA91bHWWCXx5CUsvvPRTtSL3kOXtxSwKTwo_Wi_9XcCYpiB1sfN9cJ1GN9ZDSyDXGZV2nmQbAYzDmkZutHF6da29_jGX8KvE_LOAtsvliOAQOsNcNbFqvOtY7kGnZh3sOxv0-n7nBQ4	0:1591005300060987%0d63f7200d63f720	\N	\N	1	2020-06-01 09:55:00	2020-06-01 09:55:00	1
1244	343	311	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1591005900042363%0d63f7200d63f720	\N	\N	1	2020-06-01 10:05:00	2020-06-01 10:05:00	1
1245	343	312	f8XPbzFsRtCdU5qOmfxm5T:APA91bHWWCXx5CUsvvPRTtSL3kOXtxSwKTwo_Wi_9XcCYpiB1sfN9cJ1GN9ZDSyDXGZV2nmQbAYzDmkZutHF6da29_jGX8KvE_LOAtsvliOAQOsNcNbFqvOtY7kGnZh3sOxv0-n7nBQ4	0:1591005900035432%0d63f7200d63f720	\N	\N	1	2020-06-01 10:05:00	2020-06-01 10:05:03	2
1246	328	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1591008840078522%fc0c01eafc0c01ea	\N	\N	1	2020-06-01 10:54:00	2020-06-01 10:54:00	1
1247	328	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1591008840254843%fc0c01eafc0c01ea	\N	\N	1	2020-06-01 10:54:00	2020-06-01 10:54:00	1
1248	328	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1591009500139685%fc0c01eafc0c01ea	\N	\N	1	2020-06-01 11:05:00	2020-06-01 11:05:00	1
1249	328	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1591009500139189%fc0c01eafc0c01ea	\N	\N	1	2020-06-01 11:05:00	2020-06-01 11:05:00	1
1251	343	311	ezkb5h6RR_a55bzGCDltVE:APA91bHE9VaDOMfachqpPiUDsIgbEtBX1dLsCk4lYowwmclahenYEWyQX-qq-OkNhEN9Nzqbrj4MTwPGfWSPr162a0DRG8WldBQKQ7taBGiHt66abqE9leEE6PexLvDvSkObIsTOuatM	0:1591010700114227%0d63f7200d63f720	\N	\N	1	2020-06-01 11:25:00	2020-06-01 11:25:00	1
1262	346	311	f8XPbzFsRtCdU5qOmfxm5T:APA91bHWWCXx5CUsvvPRTtSL3kOXtxSwKTwo_Wi_9XcCYpiB1sfN9cJ1GN9ZDSyDXGZV2nmQbAYzDmkZutHF6da29_jGX8KvE_LOAtsvliOAQOsNcNbFqvOtY7kGnZh3sOxv0-n7nBQ4	0:1591014000099499%0d63f7200d63f720	\N	\N	1	2020-06-01 12:20:00	2020-06-01 12:20:09	2
1250	343	311	ezkb5h6RR_a55bzGCDltVE:APA91bHE9VaDOMfachqpPiUDsIgbEtBX1dLsCk4lYowwmclahenYEWyQX-qq-OkNhEN9Nzqbrj4MTwPGfWSPr162a0DRG8WldBQKQ7taBGiHt66abqE9leEE6PexLvDvSkObIsTOuatM	0:1591010700103028%0d63f7200d63f720	\N	\N	1	2020-06-01 11:25:00	2020-06-01 11:25:00	2
1252	343	312	f8XPbzFsRtCdU5qOmfxm5T:APA91bHWWCXx5CUsvvPRTtSL3kOXtxSwKTwo_Wi_9XcCYpiB1sfN9cJ1GN9ZDSyDXGZV2nmQbAYzDmkZutHF6da29_jGX8KvE_LOAtsvliOAQOsNcNbFqvOtY7kGnZh3sOxv0-n7nBQ4	0:1591010700113889%0d63f7200d63f720	\N	\N	1	2020-06-01 11:25:00	2020-06-01 11:25:01	2
1253	343	312	f8XPbzFsRtCdU5qOmfxm5T:APA91bHWWCXx5CUsvvPRTtSL3kOXtxSwKTwo_Wi_9XcCYpiB1sfN9cJ1GN9ZDSyDXGZV2nmQbAYzDmkZutHF6da29_jGX8KvE_LOAtsvliOAQOsNcNbFqvOtY7kGnZh3sOxv0-n7nBQ4	0:1591010700113051%0d63f7200d63f720	\N	\N	1	2020-06-01 11:25:00	2020-06-01 11:25:01	2
1254	346	312	ezkb5h6RR_a55bzGCDltVE:APA91bHE9VaDOMfachqpPiUDsIgbEtBX1dLsCk4lYowwmclahenYEWyQX-qq-OkNhEN9Nzqbrj4MTwPGfWSPr162a0DRG8WldBQKQ7taBGiHt66abqE9leEE6PexLvDvSkObIsTOuatM	0:1591012800050949%0d63f7200d63f720	\N	\N	1	2020-06-01 12:00:00	2020-06-01 12:00:00	1
1255	346	311	f8XPbzFsRtCdU5qOmfxm5T:APA91bHWWCXx5CUsvvPRTtSL3kOXtxSwKTwo_Wi_9XcCYpiB1sfN9cJ1GN9ZDSyDXGZV2nmQbAYzDmkZutHF6da29_jGX8KvE_LOAtsvliOAQOsNcNbFqvOtY7kGnZh3sOxv0-n7nBQ4	0:1591012800050938%0d63f7200d63f720	\N	\N	1	2020-06-01 12:00:00	2020-06-01 12:00:00	1
1256	343	311	f8XPbzFsRtCdU5qOmfxm5T:APA91bHWWCXx5CUsvvPRTtSL3kOXtxSwKTwo_Wi_9XcCYpiB1sfN9cJ1GN9ZDSyDXGZV2nmQbAYzDmkZutHF6da29_jGX8KvE_LOAtsvliOAQOsNcNbFqvOtY7kGnZh3sOxv0-n7nBQ4	0:1591013100044207%0d63f7200d63f720	\N	\N	1	2020-06-01 12:05:00	2020-06-01 12:05:00	1
1257	343	312	ezkb5h6RR_a55bzGCDltVE:APA91bHE9VaDOMfachqpPiUDsIgbEtBX1dLsCk4lYowwmclahenYEWyQX-qq-OkNhEN9Nzqbrj4MTwPGfWSPr162a0DRG8WldBQKQ7taBGiHt66abqE9leEE6PexLvDvSkObIsTOuatM	0:1591013100055971%0d63f7200d63f720	\N	\N	1	2020-06-01 12:05:00	2020-06-01 12:05:00	2
1259	346	311	f8XPbzFsRtCdU5qOmfxm5T:APA91bHWWCXx5CUsvvPRTtSL3kOXtxSwKTwo_Wi_9XcCYpiB1sfN9cJ1GN9ZDSyDXGZV2nmQbAYzDmkZutHF6da29_jGX8KvE_LOAtsvliOAQOsNcNbFqvOtY7kGnZh3sOxv0-n7nBQ4	0:1591013400063327%0d63f7200d63f720	\N	\N	1	2020-06-01 12:10:00	2020-06-01 12:10:00	1
1258	346	312	ezkb5h6RR_a55bzGCDltVE:APA91bHE9VaDOMfachqpPiUDsIgbEtBX1dLsCk4lYowwmclahenYEWyQX-qq-OkNhEN9Nzqbrj4MTwPGfWSPr162a0DRG8WldBQKQ7taBGiHt66abqE9leEE6PexLvDvSkObIsTOuatM	0:1591013400065494%0d63f7200d63f720	\N	\N	1	2020-06-01 12:10:00	2020-06-01 12:10:04	2
1260	346	312	ezkb5h6RR_a55bzGCDltVE:APA91bHE9VaDOMfachqpPiUDsIgbEtBX1dLsCk4lYowwmclahenYEWyQX-qq-OkNhEN9Nzqbrj4MTwPGfWSPr162a0DRG8WldBQKQ7taBGiHt66abqE9leEE6PexLvDvSkObIsTOuatM	0:1591013700040951%0d63f7200d63f720	\N	\N	1	2020-06-01 12:15:00	2020-06-01 12:15:00	1
1261	346	311	f8XPbzFsRtCdU5qOmfxm5T:APA91bHWWCXx5CUsvvPRTtSL3kOXtxSwKTwo_Wi_9XcCYpiB1sfN9cJ1GN9ZDSyDXGZV2nmQbAYzDmkZutHF6da29_jGX8KvE_LOAtsvliOAQOsNcNbFqvOtY7kGnZh3sOxv0-n7nBQ4	0:1591013700043226%0d63f7200d63f720	\N	\N	1	2020-06-01 12:15:00	2020-06-01 12:15:15	2
1263	346	312	ezkb5h6RR_a55bzGCDltVE:APA91bHE9VaDOMfachqpPiUDsIgbEtBX1dLsCk4lYowwmclahenYEWyQX-qq-OkNhEN9Nzqbrj4MTwPGfWSPr162a0DRG8WldBQKQ7taBGiHt66abqE9leEE6PexLvDvSkObIsTOuatM	0:1591014000093596%0d63f7200d63f720	\N	\N	1	2020-06-01 12:20:00	2020-06-01 12:20:00	1
1265	346	312	ezkb5h6RR_a55bzGCDltVE:APA91bHE9VaDOMfachqpPiUDsIgbEtBX1dLsCk4lYowwmclahenYEWyQX-qq-OkNhEN9Nzqbrj4MTwPGfWSPr162a0DRG8WldBQKQ7taBGiHt66abqE9leEE6PexLvDvSkObIsTOuatM	0:1591014300063617%0d63f7200d63f720	\N	\N	1	2020-06-01 12:25:00	2020-06-01 12:25:00	1
1264	346	311	f8XPbzFsRtCdU5qOmfxm5T:APA91bHWWCXx5CUsvvPRTtSL3kOXtxSwKTwo_Wi_9XcCYpiB1sfN9cJ1GN9ZDSyDXGZV2nmQbAYzDmkZutHF6da29_jGX8KvE_LOAtsvliOAQOsNcNbFqvOtY7kGnZh3sOxv0-n7nBQ4	0:1591014300062368%0d63f7200d63f720	\N	\N	1	2020-06-01 12:25:00	2020-06-01 12:25:44	2
1267	346	311	f8XPbzFsRtCdU5qOmfxm5T:APA91bHWWCXx5CUsvvPRTtSL3kOXtxSwKTwo_Wi_9XcCYpiB1sfN9cJ1GN9ZDSyDXGZV2nmQbAYzDmkZutHF6da29_jGX8KvE_LOAtsvliOAQOsNcNbFqvOtY7kGnZh3sOxv0-n7nBQ4	0:1591015200103949%0d63f7200d63f720	\N	\N	1	2020-06-01 12:40:00	2020-06-01 12:40:00	1
1270	347	311	f8XPbzFsRtCdU5qOmfxm5T:APA91bHWWCXx5CUsvvPRTtSL3kOXtxSwKTwo_Wi_9XcCYpiB1sfN9cJ1GN9ZDSyDXGZV2nmQbAYzDmkZutHF6da29_jGX8KvE_LOAtsvliOAQOsNcNbFqvOtY7kGnZh3sOxv0-n7nBQ4	0:1591018500048296%0d63f7200d63f720	\N	\N	1	2020-06-01 01:35:00	2020-06-01 01:35:00	1
1268	347	311	f8XPbzFsRtCdU5qOmfxm5T:APA91bHWWCXx5CUsvvPRTtSL3kOXtxSwKTwo_Wi_9XcCYpiB1sfN9cJ1GN9ZDSyDXGZV2nmQbAYzDmkZutHF6da29_jGX8KvE_LOAtsvliOAQOsNcNbFqvOtY7kGnZh3sOxv0-n7nBQ4	0:1591018200055830%0d63f7200d63f720	\N	\N	1	2020-06-01 01:30:00	2020-06-01 01:30:00	1
1269	347	312	ezkb5h6RR_a55bzGCDltVE:APA91bHE9VaDOMfachqpPiUDsIgbEtBX1dLsCk4lYowwmclahenYEWyQX-qq-OkNhEN9Nzqbrj4MTwPGfWSPr162a0DRG8WldBQKQ7taBGiHt66abqE9leEE6PexLvDvSkObIsTOuatM	0:1591018200047755%0d63f7200d63f720	\N	\N	1	2020-06-01 01:30:00	2020-06-01 01:30:00	1
1271	347	312	ezkb5h6RR_a55bzGCDltVE:APA91bHE9VaDOMfachqpPiUDsIgbEtBX1dLsCk4lYowwmclahenYEWyQX-qq-OkNhEN9Nzqbrj4MTwPGfWSPr162a0DRG8WldBQKQ7taBGiHt66abqE9leEE6PexLvDvSkObIsTOuatM	0:1591018500053553%0d63f7200d63f720	\N	\N	1	2020-06-01 01:35:00	2020-06-01 01:35:00	1
1272	347	311	f8XPbzFsRtCdU5qOmfxm5T:APA91bHWWCXx5CUsvvPRTtSL3kOXtxSwKTwo_Wi_9XcCYpiB1sfN9cJ1GN9ZDSyDXGZV2nmQbAYzDmkZutHF6da29_jGX8KvE_LOAtsvliOAQOsNcNbFqvOtY7kGnZh3sOxv0-n7nBQ4	0:1591018800057057%0d63f7200d63f720	\N	\N	1	2020-06-01 01:40:00	2020-06-01 01:40:00	1
1273	347	312	ezkb5h6RR_a55bzGCDltVE:APA91bHE9VaDOMfachqpPiUDsIgbEtBX1dLsCk4lYowwmclahenYEWyQX-qq-OkNhEN9Nzqbrj4MTwPGfWSPr162a0DRG8WldBQKQ7taBGiHt66abqE9leEE6PexLvDvSkObIsTOuatM	0:1591018800111665%0d63f7200d63f720	\N	\N	1	2020-06-01 01:40:00	2020-06-01 01:40:00	1
1293	353	332	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591089600068568%0d63f7200d63f720	\N	\N	1	2020-06-02 09:20:00	2020-06-02 09:21:14	2
1274	347	311	f8XPbzFsRtCdU5qOmfxm5T:APA91bHWWCXx5CUsvvPRTtSL3kOXtxSwKTwo_Wi_9XcCYpiB1sfN9cJ1GN9ZDSyDXGZV2nmQbAYzDmkZutHF6da29_jGX8KvE_LOAtsvliOAQOsNcNbFqvOtY7kGnZh3sOxv0-n7nBQ4	0:1591019100045980%0d63f7200d63f720	\N	\N	1	2020-06-01 01:45:00	2020-06-01 01:45:00	1
1275	347	312	f8XPbzFsRtCdU5qOmfxm5T:APA91bHWWCXx5CUsvvPRTtSL3kOXtxSwKTwo_Wi_9XcCYpiB1sfN9cJ1GN9ZDSyDXGZV2nmQbAYzDmkZutHF6da29_jGX8KvE_LOAtsvliOAQOsNcNbFqvOtY7kGnZh3sOxv0-n7nBQ4	0:1591019100044706%0d63f7200d63f720	\N	\N	1	2020-06-01 01:45:00	2020-06-01 01:45:00	1
1276	347	312	ezkb5h6RR_a55bzGCDltVE:APA91bHE9VaDOMfachqpPiUDsIgbEtBX1dLsCk4lYowwmclahenYEWyQX-qq-OkNhEN9Nzqbrj4MTwPGfWSPr162a0DRG8WldBQKQ7taBGiHt66abqE9leEE6PexLvDvSkObIsTOuatM	0:1591019400055199%0d63f7200d63f720	\N	\N	1	2020-06-01 01:50:00	2020-06-01 01:50:00	1
1277	347	311	f8XPbzFsRtCdU5qOmfxm5T:APA91bHWWCXx5CUsvvPRTtSL3kOXtxSwKTwo_Wi_9XcCYpiB1sfN9cJ1GN9ZDSyDXGZV2nmQbAYzDmkZutHF6da29_jGX8KvE_LOAtsvliOAQOsNcNbFqvOtY7kGnZh3sOxv0-n7nBQ4	0:1591019400056148%0d63f7200d63f720	\N	\N	1	2020-06-01 01:50:00	2020-06-01 01:50:00	1
1266	346	312	ezkb5h6RR_a55bzGCDltVE:APA91bHE9VaDOMfachqpPiUDsIgbEtBX1dLsCk4lYowwmclahenYEWyQX-qq-OkNhEN9Nzqbrj4MTwPGfWSPr162a0DRG8WldBQKQ7taBGiHt66abqE9leEE6PexLvDvSkObIsTOuatM	0:1591015200048126%0d63f7200d63f720	\N	\N	1	2020-06-01 12:40:00	2020-06-01 01:50:08	2
1278	349	332	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591084800058544%0d63f7200d63f720	\N	\N	1	2020-06-02 08:00:00	2020-06-02 08:00:00	1
1279	349	330	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1591084800073403%fc0c01eafc0c01ea	\N	\N	1	2020-06-02 08:00:00	2020-06-02 08:00:00	1
1280	350	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1591085400045984%fc0c01eafc0c01ea	\N	\N	1	2020-06-02 08:10:00	2020-06-02 08:10:00	1
1281	350	51	ccUDYp7RSeqXWLkRfh5q6K:APA91bE5W3_iumjGvPMXYh2W2mYJDGuhLSX_uTtMADVu5xLWsr_RjPgxaNOqTqhMB_SzMGflWRTGH5roNo0wwZf_9rWsOVRDzh1L9jNXVsIHaoycVh7GCdhdn7nBKq2rdLqHMYiXevBE	0:1591085400097798%0d63f7200d63f720	\N	\N	1	2020-06-02 08:10:00	2020-06-02 08:10:00	1
1282	322	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1591086060100860%fc0c01eafc0c01ea	\N	\N	1	2020-06-02 08:21:00	2020-06-02 08:21:00	1
1283	322	51	ccUDYp7RSeqXWLkRfh5q6K:APA91bE5W3_iumjGvPMXYh2W2mYJDGuhLSX_uTtMADVu5xLWsr_RjPgxaNOqTqhMB_SzMGflWRTGH5roNo0wwZf_9rWsOVRDzh1L9jNXVsIHaoycVh7GCdhdn7nBKq2rdLqHMYiXevBE	0:1591086060116805%0d63f7200d63f720	\N	\N	1	2020-06-02 08:21:00	2020-06-02 08:21:00	1
1285	322	326	e0QNplpoSBa5EK0OT6KC1z:APA91bGwvxaCF9PZBPUlyy156CW6m4giu3u1FYn05IgpoNBr6hehqIyjeoxsjZmp8iX0VPd4Nmw9ThtRtGWVmyRrbBeUI24-mMTQv7yw7kyUVavvJB4HtNCU8MjE_hL9kg4rfjP9-Qsz	0:1591086900070390%0d63f7200d63f720	\N	\N	1	2020-06-02 08:35:00	2020-06-02 08:35:00	1
1286	322	325	cpp9j3VaIUIFsCH2gXQmtj:APA91bE60XmothOYDJzjWbf712eWHEm26kc6a-KOqBnrDNuDNat2_vvFSlWSapU4v5WRBwfZJdRGuh3Lvge_wv8aNJtXKtPSyFSypG5Wlv5YtRnJBHH_Z-uzwXOwF-4r6Sb1WE_RIiuH	1591086900060045	\N	\N	1	2020-06-02 08:35:00	2020-06-02 08:35:00	1
1287	322	325	cpp9j3VaIUIFsCH2gXQmtj:APA91bE60XmothOYDJzjWbf712eWHEm26kc6a-KOqBnrDNuDNat2_vvFSlWSapU4v5WRBwfZJdRGuh3Lvge_wv8aNJtXKtPSyFSypG5Wlv5YtRnJBHH_Z-uzwXOwF-4r6Sb1WE_RIiuH	1591086900060868	\N	\N	1	2020-06-02 08:35:00	2020-06-02 08:35:00	1
1284	322	326	e0QNplpoSBa5EK0OT6KC1z:APA91bGwvxaCF9PZBPUlyy156CW6m4giu3u1FYn05IgpoNBr6hehqIyjeoxsjZmp8iX0VPd4Nmw9ThtRtGWVmyRrbBeUI24-mMTQv7yw7kyUVavvJB4HtNCU8MjE_hL9kg4rfjP9-Qsz	0:1591086900071652%0d63f7200d63f720	\N	\N	1	2020-06-02 08:35:00	2020-06-02 08:36:20	2
1288	322	326	e0QNplpoSBa5EK0OT6KC1z:APA91bGwvxaCF9PZBPUlyy156CW6m4giu3u1FYn05IgpoNBr6hehqIyjeoxsjZmp8iX0VPd4Nmw9ThtRtGWVmyRrbBeUI24-mMTQv7yw7kyUVavvJB4HtNCU8MjE_hL9kg4rfjP9-Qsz	0:1591087200041586%0d63f7200d63f720	\N	\N	1	2020-06-02 08:40:00	2020-06-02 08:40:00	1
1289	322	325	cpp9j3VaIUIFsCH2gXQmtj:APA91bE60XmothOYDJzjWbf712eWHEm26kc6a-KOqBnrDNuDNat2_vvFSlWSapU4v5WRBwfZJdRGuh3Lvge_wv8aNJtXKtPSyFSypG5Wlv5YtRnJBHH_Z-uzwXOwF-4r6Sb1WE_RIiuH	1591087200047825	\N	\N	1	2020-06-02 08:40:00	2020-06-02 08:40:00	1
1290	351	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1591087980102539%fc0c01eafc0c01ea	\N	\N	1	2020-06-02 08:53:00	2020-06-02 08:53:00	1
1291	355	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1591089060069754%fc0c01eafc0c01ea	\N	\N	1	2020-06-02 09:11:00	2020-06-02 09:11:00	1
1292	354	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1591089600063176%fc0c01eafc0c01ea	\N	\N	1	2020-06-02 09:20:00	2020-06-02 09:20:00	1
1294	353	330	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591089600077247	\N	\N	1	2020-06-02 09:20:00	2020-06-02 09:20:00	1
1296	353	330	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591153800068092	\N	\N	1	2020-06-03 03:10:00	2020-06-03 03:10:00	1
1295	353	332	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591153800061679%0d63f7200d63f720	\N	\N	1	2020-06-03 03:10:00	2020-06-03 03:10:31	2
1297	353	332	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591156500040871%0d63f7200d63f720	\N	\N	1	2020-06-03 03:55:00	2020-06-03 03:55:00	1
1298	353	330	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591156500039038	\N	\N	1	2020-06-03 03:55:00	2020-06-03 03:55:05	2
1299	356	332	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591158600049893%0d63f7200d63f720	\N	\N	1	2020-06-03 04:30:00	2020-06-03 04:30:00	1
1300	356	330	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591158600050111	\N	\N	1	2020-06-03 04:30:00	2020-06-03 04:30:22	2
1301	357	332	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591162200064836%0d63f7200d63f720	\N	\N	1	2020-06-03 05:30:00	2020-06-03 05:30:00	1
1302	357	330	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591162200065759	\N	\N	1	2020-06-03 05:30:00	2020-06-03 05:30:00	1
1303	360	332	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591164600100903%0d63f7200d63f720	\N	\N	1	2020-06-03 06:10:00	2020-06-03 06:10:00	1
1304	360	330	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591164600099768	\N	\N	1	2020-06-03 06:10:00	2020-06-03 06:12:16	2
1306	361	330	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591167300046561	\N	\N	1	2020-06-03 06:55:00	2020-06-03 06:55:00	1
1305	361	332	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591167300120725%0d63f7200d63f720	\N	\N	1	2020-06-03 06:55:00	2020-06-03 06:55:20	2
1307	362	332	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591168800048114%0d63f7200d63f720	\N	\N	1	2020-06-03 07:20:00	2020-06-03 07:20:00	1
1308	362	330	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591168800051460	\N	\N	1	2020-06-03 07:20:00	2020-06-03 07:20:18	2
1309	347	311	e7Ufb4lLQYWy1MupwYXU3e:APA91bEPkV_yX_82OTYb-D_YTFzJ7cjaUt1-IudepvJXkNbGNkCL-1yUFHywZxNa68_lYuuJiQALw4q5ApyQoKpIo6jj9TrLGPiuRjPniZIYmuwjpMxqF7glv3Wi3E82mcP81q0wSP-9	0:1591169100047655%0d63f7200d63f720	\N	\N	1	2020-06-03 07:25:00	2020-06-03 07:25:00	1
1310	347	312	d2W2FTY4TyOIM2p7u4Gg3N:APA91bHXyFLxWnSqzjxl5e1ecBCCUux_DMs-hUFgLlhB6hrgkERNmM03HVAQKn2c95X1eJM70pFvq__twAKONM4MJcEkUSX24qeV2zK288_y2r0Fdm10nRzOmBSiC8uBla9iiimPSA6o	0:1591169100045810%0d63f7200d63f720	\N	\N	1	2020-06-03 07:25:00	2020-06-03 07:25:04	2
1311	363	332	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591170900043043%0d63f7200d63f720	\N	\N	1	2020-06-03 07:55:00	2020-06-03 07:55:00	1
1312	363	330	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591170900034576	\N	\N	1	2020-06-03 07:55:00	2020-06-03 08:00:25	2
1313	364	332	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591173000081150%0d63f7200d63f720	\N	\N	1	2020-06-03 08:30:00	2020-06-03 08:30:00	1
1314	364	330	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591173000080782	\N	\N	1	2020-06-03 08:30:00	2020-06-03 08:30:06	2
1316	347	311	e7Ufb4lLQYWy1MupwYXU3e:APA91bEPkV_yX_82OTYb-D_YTFzJ7cjaUt1-IudepvJXkNbGNkCL-1yUFHywZxNa68_lYuuJiQALw4q5ApyQoKpIo6jj9TrLGPiuRjPniZIYmuwjpMxqF7glv3Wi3E82mcP81q0wSP-9	0:1591174800054308%0d63f7200d63f720	\N	\N	1	2020-06-03 09:00:00	2020-06-03 09:00:00	1
1317	365	332	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591174800068808%0d63f7200d63f720	\N	\N	1	2020-06-03 09:00:00	2020-06-03 09:00:00	1
1318	365	330	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591174800066267	\N	\N	1	2020-06-03 09:00:00	2020-06-03 09:00:16	2
1315	347	312	d2W2FTY4TyOIM2p7u4Gg3N:APA91bHXyFLxWnSqzjxl5e1ecBCCUux_DMs-hUFgLlhB6hrgkERNmM03HVAQKn2c95X1eJM70pFvq__twAKONM4MJcEkUSX24qeV2zK288_y2r0Fdm10nRzOmBSiC8uBla9iiimPSA6o	0:1591174800062836%0d63f7200d63f720	\N	\N	1	2020-06-03 09:00:00	2020-06-03 09:00:49	2
1319	366	332	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591175400048728%0d63f7200d63f720	\N	\N	1	2020-06-03 09:10:00	2020-06-03 09:10:00	1
1320	366	330	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591175400057991	\N	\N	1	2020-06-03 09:10:00	2020-06-03 09:10:10	2
1321	367	332	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591176900040155%0d63f7200d63f720	\N	\N	1	2020-06-03 09:35:00	2020-06-03 09:35:00	1
1322	367	330	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591176900044896	\N	\N	1	2020-06-03 09:35:00	2020-06-03 09:35:21	2
1323	368	332	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591177800084972%0d63f7200d63f720	\N	\N	1	2020-06-03 09:50:00	2020-06-03 09:50:00	1
1325	385	52	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1591187220087410%fc0c01eafc0c01ea	\N	\N	1	2020-06-03 12:27:00	2020-06-03 12:27:00	1
1326	385	51	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	0:1591187220094701%fc0c01eafc0c01ea	\N	\N	1	2020-06-03 12:27:00	2020-06-03 12:27:00	1
1327	418	332	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591196400077997%0d63f7200d63f720	\N	\N	1	2020-06-03 03:00:00	2020-06-03 03:00:00	1
1328	418	330	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591196400075604	\N	\N	1	2020-06-03 03:00:00	2020-06-03 03:00:00	1
1329	418	332	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591197900041961%0d63f7200d63f720	\N	\N	1	2020-06-03 03:25:00	2020-06-03 03:25:00	1
1330	418	330	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591197900047402	\N	\N	1	2020-06-03 03:25:00	2020-06-03 03:25:00	1
1344	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591269000092512	\N	\N	1	2020-06-04 11:10:00	2020-06-04 11:10:06	2
1331	418	332	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591198800039357%0d63f7200d63f720	\N	\N	1	2020-06-03 03:40:00	2020-06-03 03:40:00	1
1332	418	330	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591198800033756	\N	\N	1	2020-06-03 03:40:00	2020-06-03 03:40:00	1
1324	368	330	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591177800074174	\N	\N	1	2020-06-03 09:50:00	2020-06-03 03:40:11	2
1333	418	332	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591245900056669%0d63f7200d63f720	\N	\N	1	2020-06-04 04:45:00	2020-06-04 04:45:00	1
1334	418	330	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591245900171973	\N	\N	1	2020-06-04 04:45:00	2020-06-04 04:45:46	2
1335	418	332	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591259100069962%0d63f7200d63f720	\N	\N	1	2020-06-04 08:25:00	2020-06-04 08:25:00	1
1336	418	330	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591259100077878	\N	\N	1	2020-06-04 08:25:00	2020-06-04 08:25:38	2
1337	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591261200039047%0d63f7200d63f720	\N	\N	1	2020-06-04 09:00:00	2020-06-04 09:00:00	1
1338	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591261200056765	\N	\N	1	2020-06-04 09:00:00	2020-06-04 09:00:33	2
1339	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591262100051628%0d63f7200d63f720	\N	\N	1	2020-06-04 09:15:00	2020-06-04 09:15:00	1
1340	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591262100041960	\N	\N	1	2020-06-04 09:15:00	2020-06-04 09:16:07	2
1341	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591267500090834%0d63f7200d63f720	\N	\N	1	2020-06-04 10:45:00	2020-06-04 10:45:00	1
1342	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591267500107451	\N	\N	1	2020-06-04 10:45:00	2020-06-04 10:45:32	2
1343	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591269000090543%0d63f7200d63f720	\N	\N	1	2020-06-04 11:10:00	2020-06-04 11:10:00	1
1345	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591271700043869%0d63f7200d63f720	\N	\N	1	2020-06-04 11:55:00	2020-06-04 11:55:00	1
1346	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591271700044047	\N	\N	1	2020-06-04 11:55:00	2020-06-04 11:55:15	2
1348	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591330800143096	\N	\N	1	2020-06-05 04:20:00	2020-06-05 04:20:00	1
1347	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591330800110544%0d63f7200d63f720	\N	\N	1	2020-06-05 04:20:00	2020-06-05 04:20:15	2
1350	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591332300041146	\N	\N	1	2020-06-05 04:45:00	2020-06-05 04:45:00	1
1349	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591332300044728%0d63f7200d63f720	\N	\N	1	2020-06-05 04:45:00	2020-06-05 04:45:08	2
1352	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591449300042856	\N	\N	1	2020-06-06 01:15:00	2020-06-06 01:15:00	1
1351	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591449300043157%0d63f7200d63f720	\N	\N	1	2020-06-06 01:15:00	2020-06-06 01:15:09	2
1353	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591449600053766%0d63f7200d63f720	\N	\N	1	2020-06-06 01:20:00	2020-06-06 01:20:00	1
1354	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591449600049114	\N	\N	1	2020-06-06 01:20:00	2020-06-06 01:20:07	2
1355	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591535700085825%0d63f7200d63f720	\N	\N	1	2020-06-07 01:15:00	2020-06-07 01:15:00	1
1356	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591535700079641	\N	\N	1	2020-06-07 01:15:00	2020-06-07 01:15:00	1
1357	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591536000067016%0d63f7200d63f720	\N	\N	1	2020-06-07 01:20:00	2020-06-07 01:20:00	1
1358	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591536000074300	\N	\N	1	2020-06-07 01:20:00	2020-06-07 01:20:00	1
1359	431	340	e0QNplpoSBa5EK0OT6KC1z:APA91bGwvxaCF9PZBPUlyy156CW6m4giu3u1FYn05IgpoNBr6hehqIyjeoxsjZmp8iX0VPd4Nmw9ThtRtGWVmyRrbBeUI24-mMTQv7yw7kyUVavvJB4HtNCU8MjE_hL9kg4rfjP9-Qsz	0:1591600200059674%0d63f7200d63f720	\N	\N	1	2020-06-08 07:10:00	2020-06-08 07:10:00	1
1360	431	339	cBGUBvLg3UkCvIyOVaEWgE:APA91bGd17wyo3qilgVfI6KCFWlCBS8DvqnW8en68TCPtgvAb8nLKVCQobnovbWL2aX76zwFYoCXomycf3b8RwzIASz-UJLRVLY337twfgU-GB6eHXgWwHqQs-z8ogGWnhtznrbpn4tM	1591600200066165	\N	\N	1	2020-06-08 07:10:00	2020-06-08 07:10:33	2
1361	431	340	e0QNplpoSBa5EK0OT6KC1z:APA91bGwvxaCF9PZBPUlyy156CW6m4giu3u1FYn05IgpoNBr6hehqIyjeoxsjZmp8iX0VPd4Nmw9ThtRtGWVmyRrbBeUI24-mMTQv7yw7kyUVavvJB4HtNCU8MjE_hL9kg4rfjP9-Qsz	0:1591617300103068%0d63f7200d63f720	\N	\N	1	2020-06-08 11:55:00	2020-06-08 11:55:00	1
1362	431	339	cBGUBvLg3UkCvIyOVaEWgE:APA91bGd17wyo3qilgVfI6KCFWlCBS8DvqnW8en68TCPtgvAb8nLKVCQobnovbWL2aX76zwFYoCXomycf3b8RwzIASz-UJLRVLY337twfgU-GB6eHXgWwHqQs-z8ogGWnhtznrbpn4tM	1591617300100082	\N	\N	1	2020-06-08 11:55:00	2020-06-08 11:55:21	2
1363	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591675800038528%0d63f7200d63f720	\N	\N	1	2020-06-09 04:10:00	2020-06-09 04:10:00	1
1364	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591675800039320	\N	\N	1	2020-06-09 04:10:00	2020-06-09 04:13:16	2
1366	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591677300043328	\N	\N	1	2020-06-09 04:35:00	2020-06-09 04:35:00	1
1365	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591677300042993%0d63f7200d63f720	\N	\N	1	2020-06-09 04:35:00	2020-06-09 04:35:45	2
1367	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591679100034981%0d63f7200d63f720	\N	\N	1	2020-06-09 05:05:00	2020-06-09 05:05:00	1
1368	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591679100020792	\N	\N	1	2020-06-09 05:05:00	2020-06-09 05:05:10	2
1369	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591679700037339%0d63f7200d63f720	\N	\N	1	2020-06-09 05:15:00	2020-06-09 05:15:00	1
1370	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591679700033974	\N	\N	1	2020-06-09 05:15:00	2020-06-09 05:15:16	2
1372	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591680000034830	\N	\N	1	2020-06-09 05:20:00	2020-06-09 05:20:00	1
1371	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591680000035996%0d63f7200d63f720	\N	\N	1	2020-06-09 05:20:00	2020-06-09 05:20:13	2
1373	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591682100037841%0d63f7200d63f720	\N	\N	1	2020-06-09 05:55:00	2020-06-09 05:55:00	1
1374	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591682100039896	\N	\N	1	2020-06-09 05:55:00	2020-06-09 05:56:02	2
1375	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591685400039056%0d63f7200d63f720	\N	\N	1	2020-06-09 06:50:00	2020-06-09 06:50:00	1
1376	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591685400041772	\N	\N	1	2020-06-09 06:50:00	2020-06-09 06:50:06	2
1377	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591686900078550%0d63f7200d63f720	\N	\N	1	2020-06-09 07:15:00	2020-06-09 07:15:00	1
1378	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591686900076890	\N	\N	1	2020-06-09 07:15:00	2020-06-09 07:15:12	2
1379	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591689000045676%0d63f7200d63f720	\N	\N	1	2020-06-09 07:50:00	2020-06-09 07:50:00	1
1380	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591689000055546	\N	\N	1	2020-06-09 07:50:00	2020-06-09 07:50:04	2
1381	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591691100037935%0d63f7200d63f720	\N	\N	1	2020-06-09 08:25:00	2020-06-09 08:25:00	1
1382	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591691100038785	\N	\N	1	2020-06-09 08:25:00	2020-06-09 08:25:32	2
1383	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591693500099616%0d63f7200d63f720	\N	\N	1	2020-06-09 09:05:00	2020-06-09 09:05:00	1
1384	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591693500089175	\N	\N	1	2020-06-09 09:05:00	2020-06-09 09:07:13	2
1385	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591695000052580%0d63f7200d63f720	\N	\N	1	2020-06-09 09:30:00	2020-06-09 09:30:00	1
1386	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591695000054710	\N	\N	1	2020-06-09 09:30:00	2020-06-09 09:38:28	2
1387	431	340	e0QNplpoSBa5EK0OT6KC1z:APA91bGwvxaCF9PZBPUlyy156CW6m4giu3u1FYn05IgpoNBr6hehqIyjeoxsjZmp8iX0VPd4Nmw9ThtRtGWVmyRrbBeUI24-mMTQv7yw7kyUVavvJB4HtNCU8MjE_hL9kg4rfjP9-Qsz	0:1591695600044875%0d63f7200d63f720	\N	\N	1	2020-06-09 09:40:00	2020-06-09 09:40:00	1
1388	431	339	cBGUBvLg3UkCvIyOVaEWgE:APA91bGd17wyo3qilgVfI6KCFWlCBS8DvqnW8en68TCPtgvAb8nLKVCQobnovbWL2aX76zwFYoCXomycf3b8RwzIASz-UJLRVLY337twfgU-GB6eHXgWwHqQs-z8ogGWnhtznrbpn4tM	1591695600046431	\N	\N	1	2020-06-09 09:40:00	2020-06-09 09:40:27	2
1389	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591695900041095%0d63f7200d63f720	\N	\N	1	2020-06-09 09:45:00	2020-06-09 09:45:00	1
1390	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591695900040563	\N	\N	1	2020-06-09 09:45:00	2020-06-09 09:45:23	2
1391	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591700100085486%0d63f7200d63f720	\N	\N	1	2020-06-09 10:55:00	2020-06-09 10:55:00	1
1392	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591700100086612	\N	\N	1	2020-06-09 10:55:00	2020-06-09 10:55:49	2
1393	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591700700032506%0d63f7200d63f720	\N	\N	1	2020-06-09 11:05:00	2020-06-09 11:05:00	1
1394	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591700700039162	\N	\N	1	2020-06-09 11:05:00	2020-06-09 11:05:46	2
1395	423	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591701900079939%0d63f7200d63f720	\N	\N	1	2020-06-09 11:25:00	2020-06-09 11:25:00	1
1396	423	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591701900079712	\N	\N	1	2020-06-09 11:25:00	2020-06-09 11:25:15	2
1398	433	343	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1591704300075549%0d63f7200d63f720	\N	\N	1	2020-06-09 12:05:00	2020-06-09 12:05:00	1
1397	433	344	eK_CqKB0RNeS9Toz5d6hE3:APA91bG3UC3oNH4v7BDElUB4sYsY9KnMZH9sc1ARWMNcDKGSP4pOoGRv3Dk3ESZyvlIOFeK0UUi0Ld7XlC_RNEQzxJZbyiQAbWcV52SDPKOiusP4yoEoyqv2XO3cpat-m-oEiVMbTLe3	0:1591704300063927%0d63f7200d63f720	\N	\N	1	2020-06-09 12:05:00	2020-06-09 12:05:04	2
1399	433	344	eK_CqKB0RNeS9Toz5d6hE3:APA91bG3UC3oNH4v7BDElUB4sYsY9KnMZH9sc1ARWMNcDKGSP4pOoGRv3Dk3ESZyvlIOFeK0UUi0Ld7XlC_RNEQzxJZbyiQAbWcV52SDPKOiusP4yoEoyqv2XO3cpat-m-oEiVMbTLe3	0:1591704600043711%0d63f7200d63f720	\N	\N	1	2020-06-09 12:10:00	2020-06-09 12:10:00	1
1400	433	343	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1591704600064556%0d63f7200d63f720	\N	\N	1	2020-06-09 12:10:00	2020-06-09 12:10:00	1
1401	434	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591775100033402%0d63f7200d63f720	\N	\N	1	2020-06-10 07:45:00	2020-06-10 07:45:00	1
1402	434	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591775100167751	\N	\N	1	2020-06-10 07:45:00	2020-06-10 07:45:24	2
1403	435	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1591783800038049%0d63f7200d63f720	\N	\N	1	2020-06-10 10:10:00	2020-06-10 10:10:00	1
1404	435	346	dqit6SbKSv2ydQuZ_HZKTW:APA91bHDcNFhYvuRMvIO3ZyfYCDpBkKZYdVoa3o4xONGHRoyfWbZxrLVF_H2cyXF9R_0ErI7R3G7ajnqWHP4OH17lxluT_BfbHKUdOYSdHbWgHuHPaq1pO3ZHZKoNrjbfIXdkMaGe3Wx	0:1591783800047813%0d63f7200d63f720	\N	\N	1	2020-06-10 10:10:00	2020-06-10 10:10:00	1
1405	437	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591785900071269%0d63f7200d63f720	\N	\N	1	2020-06-10 10:45:00	2020-06-10 10:45:00	1
1406	436	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591785900071733%0d63f7200d63f720	\N	\N	1	2020-06-10 10:45:00	2020-06-10 10:45:00	1
1407	436	347	cRMrnS4URYae4CvKjB9MDG:APA91bGea05G86vu_lYbGvnlgQfxWxdkJT7c7UjCJ-AMMBPiIYDm9WcdqdpqPuqQvx5N4lLnBRec1TZDOlo-YvGVk64zApODbRaHxT9apoURMD1RFELOo35mDkWwPxN6YZakMA4yhflJ	0:1591785900071919%0d63f7200d63f720	\N	\N	1	2020-06-10 10:45:00	2020-06-10 10:45:00	1
1408	437	347	cRMrnS4URYae4CvKjB9MDG:APA91bGea05G86vu_lYbGvnlgQfxWxdkJT7c7UjCJ-AMMBPiIYDm9WcdqdpqPuqQvx5N4lLnBRec1TZDOlo-YvGVk64zApODbRaHxT9apoURMD1RFELOo35mDkWwPxN6YZakMA4yhflJ	0:1591785900070390%0d63f7200d63f720	\N	\N	1	2020-06-10 10:45:00	2020-06-10 10:45:00	1
1409	435	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1591786800042665%0d63f7200d63f720	\N	\N	1	2020-06-10 11:00:00	2020-06-10 11:00:00	1
1410	435	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1591786800048036%0d63f7200d63f720	\N	\N	1	2020-06-10 11:00:00	2020-06-10 11:00:00	1
1411	435	346	dqit6SbKSv2ydQuZ_HZKTW:APA91bHDcNFhYvuRMvIO3ZyfYCDpBkKZYdVoa3o4xONGHRoyfWbZxrLVF_H2cyXF9R_0ErI7R3G7ajnqWHP4OH17lxluT_BfbHKUdOYSdHbWgHuHPaq1pO3ZHZKoNrjbfIXdkMaGe3Wx	0:1591786800042648%0d63f7200d63f720	\N	\N	1	2020-06-10 11:00:00	2020-06-10 11:00:00	1
1412	435	346	dqit6SbKSv2ydQuZ_HZKTW:APA91bHDcNFhYvuRMvIO3ZyfYCDpBkKZYdVoa3o4xONGHRoyfWbZxrLVF_H2cyXF9R_0ErI7R3G7ajnqWHP4OH17lxluT_BfbHKUdOYSdHbWgHuHPaq1pO3ZHZKoNrjbfIXdkMaGe3Wx	0:1591786800051328%0d63f7200d63f720	\N	\N	1	2020-06-10 11:00:00	2020-06-10 11:00:00	1
1413	435	346	dqit6SbKSv2ydQuZ_HZKTW:APA91bHDcNFhYvuRMvIO3ZyfYCDpBkKZYdVoa3o4xONGHRoyfWbZxrLVF_H2cyXF9R_0ErI7R3G7ajnqWHP4OH17lxluT_BfbHKUdOYSdHbWgHuHPaq1pO3ZHZKoNrjbfIXdkMaGe3Wx	0:1591787100092685%0d63f7200d63f720	\N	\N	1	2020-06-10 11:05:00	2020-06-10 11:05:00	1
1414	435	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1591787100092071%0d63f7200d63f720	\N	\N	1	2020-06-10 11:05:00	2020-06-10 11:05:00	1
1415	435	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1591787100090945%0d63f7200d63f720	\N	\N	1	2020-06-10 11:05:00	2020-06-10 11:05:00	1
1416	435	346	dqit6SbKSv2ydQuZ_HZKTW:APA91bHDcNFhYvuRMvIO3ZyfYCDpBkKZYdVoa3o4xONGHRoyfWbZxrLVF_H2cyXF9R_0ErI7R3G7ajnqWHP4OH17lxluT_BfbHKUdOYSdHbWgHuHPaq1pO3ZHZKoNrjbfIXdkMaGe3Wx	0:1591787100092050%0d63f7200d63f720	\N	\N	1	2020-06-10 11:05:00	2020-06-10 11:05:00	1
1417	438	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1591787700091979%0d63f7200d63f720	\N	\N	1	2020-06-10 11:15:00	2020-06-10 11:15:00	1
1418	438	346	dqit6SbKSv2ydQuZ_HZKTW:APA91bHDcNFhYvuRMvIO3ZyfYCDpBkKZYdVoa3o4xONGHRoyfWbZxrLVF_H2cyXF9R_0ErI7R3G7ajnqWHP4OH17lxluT_BfbHKUdOYSdHbWgHuHPaq1pO3ZHZKoNrjbfIXdkMaGe3Wx	0:1591787700091820%0d63f7200d63f720	\N	\N	1	2020-06-10 11:15:00	2020-06-10 11:15:00	1
1419	438	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1591788000026970%0d63f7200d63f720	\N	\N	1	2020-06-10 11:20:00	2020-06-10 11:20:00	1
1420	438	346	dqit6SbKSv2ydQuZ_HZKTW:APA91bHDcNFhYvuRMvIO3ZyfYCDpBkKZYdVoa3o4xONGHRoyfWbZxrLVF_H2cyXF9R_0ErI7R3G7ajnqWHP4OH17lxluT_BfbHKUdOYSdHbWgHuHPaq1pO3ZHZKoNrjbfIXdkMaGe3Wx	0:1591788000042987%0d63f7200d63f720	\N	\N	1	2020-06-10 11:20:00	2020-06-10 11:20:00	1
1421	439	336	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	0:1591788300045865%0d63f7200d63f720	\N	\N	1	2020-06-10 11:25:00	2020-06-10 11:25:00	1
1422	439	337	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1591788300034444	\N	\N	1	2020-06-10 11:25:00	2020-06-10 11:25:07	2
1423	438	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1591791600105690%0d63f7200d63f720	\N	\N	1	2020-06-10 12:20:00	2020-06-10 12:20:00	1
1424	438	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1591791600096251%0d63f7200d63f720	\N	\N	1	2020-06-10 12:20:00	2020-06-10 12:20:00	1
1425	438	346	dqit6SbKSv2ydQuZ_HZKTW:APA91bHDcNFhYvuRMvIO3ZyfYCDpBkKZYdVoa3o4xONGHRoyfWbZxrLVF_H2cyXF9R_0ErI7R3G7ajnqWHP4OH17lxluT_BfbHKUdOYSdHbWgHuHPaq1pO3ZHZKoNrjbfIXdkMaGe3Wx	0:1591791600102312%0d63f7200d63f720	\N	\N	1	2020-06-10 12:20:00	2020-06-10 12:20:00	1
1426	438	346	dqit6SbKSv2ydQuZ_HZKTW:APA91bHDcNFhYvuRMvIO3ZyfYCDpBkKZYdVoa3o4xONGHRoyfWbZxrLVF_H2cyXF9R_0ErI7R3G7ajnqWHP4OH17lxluT_BfbHKUdOYSdHbWgHuHPaq1pO3ZHZKoNrjbfIXdkMaGe3Wx	0:1591791600105453%0d63f7200d63f720	\N	\N	1	2020-06-10 12:20:00	2020-06-10 12:20:00	1
1427	441	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1591791900081185%0d63f7200d63f720	\N	\N	1	2020-06-10 12:25:00	2020-06-10 12:25:00	1
1428	441	346	dqit6SbKSv2ydQuZ_HZKTW:APA91bHDcNFhYvuRMvIO3ZyfYCDpBkKZYdVoa3o4xONGHRoyfWbZxrLVF_H2cyXF9R_0ErI7R3G7ajnqWHP4OH17lxluT_BfbHKUdOYSdHbWgHuHPaq1pO3ZHZKoNrjbfIXdkMaGe3Wx	0:1591791900072652%0d63f7200d63f720	\N	\N	1	2020-06-10 12:25:00	2020-06-10 12:25:00	1
1429	442	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1591792200085754%0d63f7200d63f720	\N	\N	1	2020-06-10 12:30:00	2020-06-10 12:30:00	1
1430	442	346	dqit6SbKSv2ydQuZ_HZKTW:APA91bHDcNFhYvuRMvIO3ZyfYCDpBkKZYdVoa3o4xONGHRoyfWbZxrLVF_H2cyXF9R_0ErI7R3G7ajnqWHP4OH17lxluT_BfbHKUdOYSdHbWgHuHPaq1pO3ZHZKoNrjbfIXdkMaGe3Wx	0:1591792200090349%0d63f7200d63f720	\N	\N	1	2020-06-10 12:30:00	2020-06-10 12:30:00	1
1431	443	348	czIDQJQfS02amsfu51wV9I:APA91bEg7ShlMZ3R7kTVlUQ4sqvdMQOUMORtcvzqHHhX9do_lZRL5sA7zKxmKxh5zDrn9OzpcL2e7c0O7gILl1c_D43Kibr6oAEPSM17yrsvwAOeqPCmX6SvMb9oq_EEazh5miKVwz93	0:1591867800035787%0d63f7200d63f720	\N	\N	1	2020-06-11 09:30:00	2020-06-11 09:30:00	1
1432	443	349	fpSEAjWv_UPIvorM68LiIk:APA91bHd2bHbqDzVAJVVdA67FX691drzvMLALOVWk1A3kgolanTYNfntzGPPGXHwUqqQ2PGqcnybp-J8mjBVTri4ICPfEya3P1S6N5ETUJn3aEtC8GOQ7uDLEri2gyr5of0mbiVO3QB6	1591867800063451	\N	\N	1	2020-06-11 09:30:00	2020-06-11 09:53:31	2
1433	444	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1591873500078125%0d63f7200d63f720	\N	\N	1	2020-06-11 11:05:00	2020-06-11 11:05:00	1
1434	444	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1591873800063130%0d63f7200d63f720	\N	\N	1	2020-06-11 11:10:00	2020-06-11 11:10:00	1
1435	444	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1591874100045128%0d63f7200d63f720	\N	\N	1	2020-06-11 11:15:00	2020-06-11 11:15:00	1
1436	445	358	czIDQJQfS02amsfu51wV9I:APA91bEg7ShlMZ3R7kTVlUQ4sqvdMQOUMORtcvzqHHhX9do_lZRL5sA7zKxmKxh5zDrn9OzpcL2e7c0O7gILl1c_D43Kibr6oAEPSM17yrsvwAOeqPCmX6SvMb9oq_EEazh5miKVwz93	0:1591959900057955%0d63f7200d63f720	\N	\N	1	2020-06-12 11:05:00	2020-06-12 11:05:00	1
1437	445	357	fpSEAjWv_UPIvorM68LiIk:APA91bHd2bHbqDzVAJVVdA67FX691drzvMLALOVWk1A3kgolanTYNfntzGPPGXHwUqqQ2PGqcnybp-J8mjBVTri4ICPfEya3P1S6N5ETUJn3aEtC8GOQ7uDLEri2gyr5of0mbiVO3QB6	1591959900081382	\N	\N	1	2020-06-12 11:05:00	2020-06-12 11:52:06	2
1438	445	358	czIDQJQfS02amsfu51wV9I:APA91bEg7ShlMZ3R7kTVlUQ4sqvdMQOUMORtcvzqHHhX9do_lZRL5sA7zKxmKxh5zDrn9OzpcL2e7c0O7gILl1c_D43Kibr6oAEPSM17yrsvwAOeqPCmX6SvMb9oq_EEazh5miKVwz93	0:1592046300106997%0d63f7200d63f720	\N	\N	1	2020-06-13 11:05:00	2020-06-13 11:05:00	1
1439	445	357	fpSEAjWv_UPIvorM68LiIk:APA91bHd2bHbqDzVAJVVdA67FX691drzvMLALOVWk1A3kgolanTYNfntzGPPGXHwUqqQ2PGqcnybp-J8mjBVTri4ICPfEya3P1S6N5ETUJn3aEtC8GOQ7uDLEri2gyr5of0mbiVO3QB6	1592046300114953	\N	\N	1	2020-06-13 11:05:00	2020-06-13 11:05:00	1
1440	445	358	czIDQJQfS02amsfu51wV9I:APA91bEg7ShlMZ3R7kTVlUQ4sqvdMQOUMORtcvzqHHhX9do_lZRL5sA7zKxmKxh5zDrn9OzpcL2e7c0O7gILl1c_D43Kibr6oAEPSM17yrsvwAOeqPCmX6SvMb9oq_EEazh5miKVwz93	0:1592132700056857%0d63f7200d63f720	\N	\N	1	2020-06-14 11:05:00	2020-06-14 11:05:00	1
1441	445	357	fpSEAjWv_UPIvorM68LiIk:APA91bHd2bHbqDzVAJVVdA67FX691drzvMLALOVWk1A3kgolanTYNfntzGPPGXHwUqqQ2PGqcnybp-J8mjBVTri4ICPfEya3P1S6N5ETUJn3aEtC8GOQ7uDLEri2gyr5of0mbiVO3QB6	1592132700067764	\N	\N	1	2020-06-14 11:05:00	2020-06-14 11:05:00	1
1442	446	341	eiFDCgUMcUG3tahht3wqKi:APA91bGCOvn2-ATnTtcCArRwbsL9epdqJcczSk3OHE9yn2FgazQyFW_c5xq9-x7FuPxvbkT2z965wv3ZqsI0oeJUXc4EzYMl_qEH3D_Vxtni-QFN5M9-s2SaFjEOeImiisOKLusZkBuB	0:1592211900113218%0d63f7200d63f720	\N	\N	1	2020-06-15 09:05:00	2020-06-15 09:05:00	1
1443	446	342	dy9t-1JMwU1OpkbUW_mkda:APA91bF6QcXQywhZHkK-8mC7NgNr7MZoyL_lMq6gk8km9VU2oTp-WbQ6d4ZTu9g7jF8RiPT5TFPeROaGKApX__xueXJ2rhBE5RqQ52k38CRhG4eaKnnwKHnn3MV1TjdmRjzAFt8YXVdp	1592211900087229	\N	\N	1	2020-06-15 09:05:00	2020-06-15 09:05:04	2
1444	445	358	czIDQJQfS02amsfu51wV9I:APA91bEg7ShlMZ3R7kTVlUQ4sqvdMQOUMORtcvzqHHhX9do_lZRL5sA7zKxmKxh5zDrn9OzpcL2e7c0O7gILl1c_D43Kibr6oAEPSM17yrsvwAOeqPCmX6SvMb9oq_EEazh5miKVwz93	0:1592219100052457%0d63f7200d63f720	\N	\N	1	2020-06-15 11:05:00	2020-06-15 11:05:00	1
1445	445	357	fpSEAjWv_UPIvorM68LiIk:APA91bHd2bHbqDzVAJVVdA67FX691drzvMLALOVWk1A3kgolanTYNfntzGPPGXHwUqqQ2PGqcnybp-J8mjBVTri4ICPfEya3P1S6N5ETUJn3aEtC8GOQ7uDLEri2gyr5of0mbiVO3QB6	1592219100063987	\N	\N	1	2020-06-15 11:05:00	2020-06-15 11:05:00	1
1446	446	341	eiFDCgUMcUG3tahht3wqKi:APA91bGCOvn2-ATnTtcCArRwbsL9epdqJcczSk3OHE9yn2FgazQyFW_c5xq9-x7FuPxvbkT2z965wv3ZqsI0oeJUXc4EzYMl_qEH3D_Vxtni-QFN5M9-s2SaFjEOeImiisOKLusZkBuB	0:1592298300085711%0d63f7200d63f720	\N	\N	1	2020-06-16 09:05:00	2020-06-16 09:05:00	1
1447	446	342	dy9t-1JMwU1OpkbUW_mkda:APA91bF6QcXQywhZHkK-8mC7NgNr7MZoyL_lMq6gk8km9VU2oTp-WbQ6d4ZTu9g7jF8RiPT5TFPeROaGKApX__xueXJ2rhBE5RqQ52k38CRhG4eaKnnwKHnn3MV1TjdmRjzAFt8YXVdp	1592298300053997	\N	\N	1	2020-06-16 09:05:00	2020-06-16 09:05:00	1
1448	447	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1592302500081326%0d63f7200d63f720	\N	\N	1	2020-06-16 10:15:00	2020-06-16 10:15:00	1
1449	448	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1592302800096544%0d63f7200d63f720	\N	\N	1	2020-06-16 10:20:00	2020-06-16 10:20:00	1
1450	450	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1592304000087092%0d63f7200d63f720	\N	\N	1	2020-06-16 10:40:00	2020-06-16 10:40:00	1
1451	451	346	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1592304600097944%0d63f7200d63f720	\N	\N	1	2020-06-16 10:50:00	2020-06-16 10:50:00	1
1452	451	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1592304600098574%0d63f7200d63f720	\N	\N	1	2020-06-16 10:50:00	2020-06-16 10:50:00	1
1453	452	346	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1592305200088708%0d63f7200d63f720	\N	\N	1	2020-06-16 11:00:00	2020-06-16 11:00:00	1
1454	452	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1592305200087022%0d63f7200d63f720	\N	\N	1	2020-06-16 11:00:00	2020-06-16 11:00:00	1
1455	453	346	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1592305500083953%0d63f7200d63f720	\N	\N	1	2020-06-16 11:05:00	2020-06-16 11:05:00	1
1456	453	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1592305500082858%0d63f7200d63f720	\N	\N	1	2020-06-16 11:05:00	2020-06-16 11:05:00	1
1457	454	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1592305800077210%0d63f7200d63f720	\N	\N	1	2020-06-16 11:10:00	2020-06-16 11:10:00	1
1458	454	346	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1592305800079614%0d63f7200d63f720	\N	\N	1	2020-06-16 11:10:00	2020-06-16 11:10:00	1
1459	454	346	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1592306100050245%0d63f7200d63f720	\N	\N	1	2020-06-16 11:15:00	2020-06-16 11:15:00	1
1460	454	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1592306100052829%0d63f7200d63f720	\N	\N	1	2020-06-16 11:15:00	2020-06-16 11:15:00	1
1461	455	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1592310600091235%0d63f7200d63f720	\N	\N	1	2020-06-16 12:30:00	2020-06-16 12:30:00	1
1462	455	346	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1592310600091836%0d63f7200d63f720	\N	\N	1	2020-06-16 12:30:00	2020-06-16 12:30:00	1
1463	457	346	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1592367300080772%0d63f7200d63f720	\N	\N	1	2020-06-17 04:15:00	2020-06-17 04:15:00	1
1464	457	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1592367300080166%0d63f7200d63f720	\N	\N	1	2020-06-17 04:15:00	2020-06-17 04:15:07	2
1465	457	346	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1592453700079242%0d63f7200d63f720	\N	\N	1	2020-06-18 04:15:00	2020-06-18 04:15:00	1
1466	457	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1592453700079011%0d63f7200d63f720	\N	\N	1	2020-06-18 04:15:00	2020-06-18 04:15:00	1
1467	457	346	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1592540100074571%0d63f7200d63f720	\N	\N	1	2020-06-19 04:15:00	2020-06-19 04:15:00	1
1468	457	345	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	0:1592540100076978%0d63f7200d63f720	\N	\N	1	2020-06-19 04:15:00	2020-06-19 04:15:00	1
1469	458	363	fiDOYDYpT-CLit1BzaUlq5:APA91bFY6DOambwxzTKIeLEOWXLxo-8UbdyOYk7tfv4U27Ut78kSSkNMHgRshG5X0YTq7vU80O45Fg0zQdjA7TiRBncQikiwDOyNI3vY82Y38hb6I-9xrumyRVvciYp02eqq0CWAIWUF	0:1592569200053769%0d63f7200d63f720	\N	\N	1	2020-06-19 12:20:00	2020-06-19 12:20:00	1
1470	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1592569200054379%0d63f7200d63f720	\N	\N	1	2020-06-19 12:20:00	2020-06-19 12:20:00	1
1471	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1592655600099834%0d63f7200d63f720	\N	\N	1	2020-06-20 12:20:00	2020-06-20 12:20:00	1
1472	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1592742000077832%0d63f7200d63f720	\N	\N	1	2020-06-21 12:20:00	2020-06-21 12:20:00	1
1473	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1592828400080328%0d63f7200d63f720	\N	\N	1	2020-06-22 12:20:00	2020-06-22 12:20:00	1
1474	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1592914800066048%0d63f7200d63f720	\N	\N	1	2020-06-23 12:20:00	2020-06-23 12:20:00	1
1475	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1593001200086578%0d63f7200d63f720	\N	\N	1	2020-06-24 12:20:00	2020-06-24 12:20:00	1
1476	459	364	cjbUl3ws50qivDvjEBc6Jf:APA91bHmC30c-TV7QVTEPpkqLfYr-SgeEyLPxCC2tNT4HVz_UQ5_RIFfQfyKIgjL60aThvMMIqJtgqVL685mDOGBHJS1KTW56K4wFclr46NW7JMjz6Kn-7KVhVwzwUK9Mub1Uu_MNq7N	1593032400103846	\N	\N	1	2020-06-24 09:00:00	2020-06-24 09:00:00	1
1477	459	357	cm0zU4n030Bap7ZrOuWzlZ:APA91bEZfHPON2x1rmvE7qLmXp449qt2GGqJpwQtrjMGFXbjD3dzzfc9B88FmjV-wKXQc-7NTNehoxMCl_RX3AZp01ZcPIL68mMqBESFhd8D-TTfMve3T9IyhL3ma9Lvqmt8ctFF6N3Y	1593032400094238	\N	\N	1	2020-06-24 09:00:00	2020-06-24 09:00:00	1
1478	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1593087600126619%0d63f7200d63f720	\N	\N	1	2020-06-25 12:20:00	2020-06-25 12:20:00	1
1479	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1593174000068841%0d63f7200d63f720	\N	\N	1	2020-06-26 12:20:00	2020-06-26 12:20:00	1
1480	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1593260400052703%0d63f7200d63f720	\N	\N	1	2020-06-27 12:20:00	2020-06-27 12:20:00	1
1481	459	357	cm0zU4n030Bap7ZrOuWzlZ:APA91bEZfHPON2x1rmvE7qLmXp449qt2GGqJpwQtrjMGFXbjD3dzzfc9B88FmjV-wKXQc-7NTNehoxMCl_RX3AZp01ZcPIL68mMqBESFhd8D-TTfMve3T9IyhL3ma9Lvqmt8ctFF6N3Y	1593291600078318	\N	\N	1	2020-06-27 09:00:00	2020-06-27 09:00:00	1
1482	459	364	cjbUl3ws50qivDvjEBc6Jf:APA91bHmC30c-TV7QVTEPpkqLfYr-SgeEyLPxCC2tNT4HVz_UQ5_RIFfQfyKIgjL60aThvMMIqJtgqVL685mDOGBHJS1KTW56K4wFclr46NW7JMjz6Kn-7KVhVwzwUK9Mub1Uu_MNq7N	1593291600083529	\N	\N	1	2020-06-27 09:00:00	2020-06-27 09:10:38	2
1483	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1593346800058509%0d63f7200d63f720	\N	\N	1	2020-06-28 12:20:00	2020-06-28 12:20:00	1
1484	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1593433200071186%0d63f7200d63f720	\N	\N	1	2020-06-29 12:20:00	2020-06-29 12:20:00	1
1485	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1593519600074491%0d63f7200d63f720	\N	\N	1	2020-06-30 12:20:00	2020-06-30 12:20:00	1
1486	459	357	cm0zU4n030Bap7ZrOuWzlZ:APA91bEZfHPON2x1rmvE7qLmXp449qt2GGqJpwQtrjMGFXbjD3dzzfc9B88FmjV-wKXQc-7NTNehoxMCl_RX3AZp01ZcPIL68mMqBESFhd8D-TTfMve3T9IyhL3ma9Lvqmt8ctFF6N3Y	1593550800059259	\N	\N	1	2020-06-30 09:00:00	2020-06-30 09:00:00	1
1487	459	364	cjbUl3ws50qivDvjEBc6Jf:APA91bHmC30c-TV7QVTEPpkqLfYr-SgeEyLPxCC2tNT4HVz_UQ5_RIFfQfyKIgjL60aThvMMIqJtgqVL685mDOGBHJS1KTW56K4wFclr46NW7JMjz6Kn-7KVhVwzwUK9Mub1Uu_MNq7N	1593550800073311	\N	\N	1	2020-06-30 09:00:00	2020-06-30 09:18:08	2
1488	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1593606000075924%0d63f7200d63f720	\N	\N	1	2020-07-01 12:20:00	2020-07-01 12:20:00	1
1489	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1593692400101500%0d63f7200d63f720	\N	\N	1	2020-07-02 12:20:00	2020-07-02 12:20:00	1
1490	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1593778800068196%0d63f7200d63f720	\N	\N	1	2020-07-03 12:20:00	2020-07-03 12:20:00	1
1491	459	357	cm0zU4n030Bap7ZrOuWzlZ:APA91bEZfHPON2x1rmvE7qLmXp449qt2GGqJpwQtrjMGFXbjD3dzzfc9B88FmjV-wKXQc-7NTNehoxMCl_RX3AZp01ZcPIL68mMqBESFhd8D-TTfMve3T9IyhL3ma9Lvqmt8ctFF6N3Y	1593810000064637	\N	\N	1	2020-07-03 09:00:00	2020-07-03 09:00:00	1
1492	459	364	cjbUl3ws50qivDvjEBc6Jf:APA91bHmC30c-TV7QVTEPpkqLfYr-SgeEyLPxCC2tNT4HVz_UQ5_RIFfQfyKIgjL60aThvMMIqJtgqVL685mDOGBHJS1KTW56K4wFclr46NW7JMjz6Kn-7KVhVwzwUK9Mub1Uu_MNq7N	1593810000115833	\N	\N	1	2020-07-03 09:00:00	2020-07-03 09:00:00	1
1493	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1593865200089680%0d63f7200d63f720	\N	\N	1	2020-07-04 12:20:00	2020-07-04 12:20:00	1
1494	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1593951600068742%0d63f7200d63f720	\N	\N	1	2020-07-05 12:20:00	2020-07-05 12:20:00	1
1495	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1594038000061614%0d63f7200d63f720	\N	\N	1	2020-07-06 12:20:00	2020-07-06 12:20:00	1
1496	459	364	cjbUl3ws50qivDvjEBc6Jf:APA91bHmC30c-TV7QVTEPpkqLfYr-SgeEyLPxCC2tNT4HVz_UQ5_RIFfQfyKIgjL60aThvMMIqJtgqVL685mDOGBHJS1KTW56K4wFclr46NW7JMjz6Kn-7KVhVwzwUK9Mub1Uu_MNq7N	1594069200083668	\N	\N	1	2020-07-06 09:00:00	2020-07-06 09:00:00	1
1497	459	357	cm0zU4n030Bap7ZrOuWzlZ:APA91bEZfHPON2x1rmvE7qLmXp449qt2GGqJpwQtrjMGFXbjD3dzzfc9B88FmjV-wKXQc-7NTNehoxMCl_RX3AZp01ZcPIL68mMqBESFhd8D-TTfMve3T9IyhL3ma9Lvqmt8ctFF6N3Y	1594069200075286	\N	\N	1	2020-07-06 09:00:00	2020-07-06 09:00:00	1
1498	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1594124400074451%0d63f7200d63f720	\N	\N	1	2020-07-07 12:20:00	2020-07-07 12:20:00	1
1499	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1594210800366324%0d63f7200d63f720	\N	\N	1	2020-07-08 12:20:00	2020-07-08 12:20:00	1
1500	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1594297200047379%0d63f7200d63f720	\N	\N	1	2020-07-09 12:20:00	2020-07-09 12:20:00	1
1501	459	364	cjbUl3ws50qivDvjEBc6Jf:APA91bHmC30c-TV7QVTEPpkqLfYr-SgeEyLPxCC2tNT4HVz_UQ5_RIFfQfyKIgjL60aThvMMIqJtgqVL685mDOGBHJS1KTW56K4wFclr46NW7JMjz6Kn-7KVhVwzwUK9Mub1Uu_MNq7N	1594328400065355	\N	\N	1	2020-07-09 09:00:00	2020-07-09 09:00:00	1
1502	459	357	cm0zU4n030Bap7ZrOuWzlZ:APA91bEZfHPON2x1rmvE7qLmXp449qt2GGqJpwQtrjMGFXbjD3dzzfc9B88FmjV-wKXQc-7NTNehoxMCl_RX3AZp01ZcPIL68mMqBESFhd8D-TTfMve3T9IyhL3ma9Lvqmt8ctFF6N3Y	1594328400061510	\N	\N	1	2020-07-09 09:00:00	2020-07-09 09:00:00	1
1503	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1594383600063580%0d63f7200d63f720	\N	\N	1	2020-07-10 12:20:00	2020-07-10 12:20:00	1
1504	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1594470000070383%0d63f7200d63f720	\N	\N	1	2020-07-11 12:20:00	2020-07-11 12:20:00	1
1505	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1594556400089027%0d63f7200d63f720	\N	\N	1	2020-07-12 12:20:00	2020-07-12 12:20:00	1
1506	459	357	cm0zU4n030Bap7ZrOuWzlZ:APA91bEZfHPON2x1rmvE7qLmXp449qt2GGqJpwQtrjMGFXbjD3dzzfc9B88FmjV-wKXQc-7NTNehoxMCl_RX3AZp01ZcPIL68mMqBESFhd8D-TTfMve3T9IyhL3ma9Lvqmt8ctFF6N3Y	1594587600055205	\N	\N	1	2020-07-12 09:00:00	2020-07-12 09:00:00	1
1507	459	364	cjbUl3ws50qivDvjEBc6Jf:APA91bHmC30c-TV7QVTEPpkqLfYr-SgeEyLPxCC2tNT4HVz_UQ5_RIFfQfyKIgjL60aThvMMIqJtgqVL685mDOGBHJS1KTW56K4wFclr46NW7JMjz6Kn-7KVhVwzwUK9Mub1Uu_MNq7N	1594587600058311	\N	\N	1	2020-07-12 09:00:00	2020-07-12 09:00:00	1
1508	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1594642800109713%0d63f7200d63f720	\N	\N	1	2020-07-13 12:20:00	2020-07-13 12:20:00	1
1509	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1594729200073293%0d63f7200d63f720	\N	\N	1	2020-07-14 12:20:00	2020-07-14 12:20:00	1
1510	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1594815600054464%0d63f7200d63f720	\N	\N	1	2020-07-15 12:20:00	2020-07-15 12:20:00	1
1511	459	364	cjbUl3ws50qivDvjEBc6Jf:APA91bHmC30c-TV7QVTEPpkqLfYr-SgeEyLPxCC2tNT4HVz_UQ5_RIFfQfyKIgjL60aThvMMIqJtgqVL685mDOGBHJS1KTW56K4wFclr46NW7JMjz6Kn-7KVhVwzwUK9Mub1Uu_MNq7N	1594846800076388	\N	\N	1	2020-07-15 09:00:00	2020-07-15 09:00:00	1
1512	459	357	cm0zU4n030Bap7ZrOuWzlZ:APA91bEZfHPON2x1rmvE7qLmXp449qt2GGqJpwQtrjMGFXbjD3dzzfc9B88FmjV-wKXQc-7NTNehoxMCl_RX3AZp01ZcPIL68mMqBESFhd8D-TTfMve3T9IyhL3ma9Lvqmt8ctFF6N3Y	1594846800070642	\N	\N	1	2020-07-15 09:00:00	2020-07-15 09:00:00	1
1513	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1594902000074192%0d63f7200d63f720	\N	\N	1	2020-07-16 12:20:00	2020-07-16 12:20:00	1
1514	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1594988400092971%0d63f7200d63f720	\N	\N	1	2020-07-17 12:20:00	2020-07-17 12:20:00	1
1515	458	362	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	0:1595074800080933%0d63f7200d63f720	\N	\N	1	2020-07-18 12:20:00	2020-07-18 12:20:00	1
1516	460	368	cUE-KgjcoUsNlt2fJRwSu0:APA91bGSdysYVm8yjOCTzk5ItyueQpFhimAsVXG8P2zCoAnzNCZqP4aSzA_c_5-AAJ6qN7NIsEmIDWV8WJbsTVc1-8HMoXdIEeeH1qcCpwyVmjm2jVg5M-rD3KJNE0VOPjDgDyGC5QmO	1595250000067721	\N	\N	1	2020-07-20 01:00:00	2020-07-20 01:00:00	1
1517	460	366	c4q-8mzhJ00npVjO21QbvX:APA91bGHIb-Nn_h2EpeEtl77Kfc-qbBUqRFBsJ8K8hhk5Dcfq-pfP3EZT1MbPtiLuRevs_r-AYjnNjZ3dZ-uappdoZWq8Jwu8Y2e73E7P6mKQjdciGgL08wT0LwDAMiEVuJCGnpXASak	1595250000090972	\N	\N	1	2020-07-20 01:00:00	2020-07-20 01:00:00	1
1518	460	368	cUE-KgjcoUsNlt2fJRwSu0:APA91bGSdysYVm8yjOCTzk5ItyueQpFhimAsVXG8P2zCoAnzNCZqP4aSzA_c_5-AAJ6qN7NIsEmIDWV8WJbsTVc1-8HMoXdIEeeH1qcCpwyVmjm2jVg5M-rD3KJNE0VOPjDgDyGC5QmO	1595595600085841	\N	\N	1	2020-07-24 01:00:00	2020-07-24 01:00:00	1
1519	460	366	c4q-8mzhJ00npVjO21QbvX:APA91bGHIb-Nn_h2EpeEtl77Kfc-qbBUqRFBsJ8K8hhk5Dcfq-pfP3EZT1MbPtiLuRevs_r-AYjnNjZ3dZ-uappdoZWq8Jwu8Y2e73E7P6mKQjdciGgL08wT0LwDAMiEVuJCGnpXASak	1595595600109985	\N	\N	1	2020-07-24 01:00:00	2020-07-24 01:00:00	1
\.


--
-- Name: goal_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.goal_notifications_id_seq', 1519, true);


--
-- Data for Name: goal_setting_answers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.goal_setting_answers (id, question_id, answer, status, create_time, update_time, user_id, custom_answer) FROM stdin;
57	12	Option1, option2, option3	1	2020-05-27 02:13:32	2020-05-27 02:13:32	29	\N
58	12	Option3, option1	1	2020-05-27 02:13:32	2020-05-27 02:13:32	29	Hello i good morning 
59	15	Option3, option1	1	2020-05-27 02:13:32	2020-05-27 02:13:32	29	\N
\.


--
-- Name: goal_setting_answers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.goal_setting_answers_id_seq', 59, true);


--
-- Data for Name: goal_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.goal_settings (id, question_descripation, status, create_time, update_time, question_title, iscustom) FROM stdin;
10	Choose all that apply.	1	2020-05-22 06:05:01	2020-05-22 06:05:01	Game                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                	true                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
11	Choose all that apply.	1	2020-05-22 06:09:10	2020-05-22 06:09:10	Partner orgasm                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      	true                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
12	Choose all that apply.	1	2020-05-22 06:10:58	2020-05-22 06:10:58	Seduction                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           	true                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
13	Choose all that apply.	1	2020-05-22 06:12:28	2020-05-22 06:12:28	Spontaneity                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         	true                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
7	Choose all that apply.	1	2020-05-22 05:54:22	2020-05-22 05:54:22	Foreplay                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            	true                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
8	Choose all that apply.	1	2020-05-22 05:58:04	2020-05-22 05:58:04	Positions                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           	true                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
9	Choose all that apply.	1	2020-05-22 06:03:10	2020-05-22 06:03:10	Props                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               	true                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
14	Choose all that apply.	1	2020-05-22 06:14:05	2020-05-22 06:14:05	Creative                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            	true                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
15	Choose all that apply.	1	2020-05-22 06:16:12	2020-05-22 06:16:12	Length of encounter                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 	true                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
16	Choose all that apply.	1	2020-05-22 06:17:48	2020-05-22 06:17:48	Lighting                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            	true                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
17	Choose all that apply.	1	2020-05-22 06:19:45	2020-05-22 06:19:45	Post-sex                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            	true                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
18	Choose all that apply.	1	2020-05-22 06:21:20	2020-05-22 06:21:20	Helpful Reminders!                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  	true                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
\.


--
-- Name: goal_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.goal_settings_id_seq', 21, true);


--
-- Data for Name: info_messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.info_messages (id, title, description, status, create_time, update_time, key, screen) FROM stdin;
2	Intimacy Initiation	How are prefers to have intimacy initiated can be a very personal thing. Don't worry! You'll define what your preference are in a subsequent step.Add some privacy language here.	1	2020-05-22 11:40:25	2020-05-22 06:26:07	intimate_info	\N
3	Accountability	How are prefers to have intimacy initiated can be a very personal thing. Don't worry! You'll define what your preference are in a subsequent step.\r\nAdd some privacy language here.	1	2020-05-22 11:44:30	2020-05-23 11:00:30	account_info	\N
4	Intimacy Request 	How are prefers to have intimacy initiated can be a very personal thing.\r\n\r\nDon't worry!\r\nYou'll define what your preference are in a subsequent step. \r\nAdd some privacy language here.	1	2020-05-22 11:44:38	2020-05-23 11:00:56	request_info	\N
6	Intimacy Initiation	How are prefers to have intimacy initiated can be a very personal thing. Don't worry! You'll define what your preference are in a subsequent step.Add some privacy language here.	1	2020-05-22 02:50:40	2020-05-23 11:03:12	contact_info	\N
\.


--
-- Name: info_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.info_messages_id_seq', 6, true);


--
-- Data for Name: monthly_goals; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.monthly_goals (id, partner_mapping_id, user_id, goal_identifier, month_start, month_end, connect_number, initiator_count, percentage, complete_count, complete_percentage, status, create_time, update_time, intimate_time, intimate_request_time, intimate_account_time, initiator_count1, contribution2, contribution1, hours) FROM stdin;
33	60	61	1587123044542	2020-04-17	2020-05-17	15	12	80	0	0	1	2020-04-16 23:30:44	2020-04-16 23:30:44	\N	\N	\N	\N	0	0	\N
34	60	60	1587123044542	2020-04-17	2020-05-17	15	3	20	0	0	1	2020-04-16 23:30:44	2020-04-16 23:30:44	\N	\N	\N	\N	0	0	\N
35	60	61	1587123089818	2020-04-17	2020-05-17	15	12	80	0	0	1	2020-04-16 23:31:29	2020-04-16 23:31:29	\N	\N	\N	\N	0	0	\N
36	60	60	1587123089818	2020-04-17	2020-05-17	15	3	20	0	0	1	2020-04-16 23:31:29	2020-04-16 23:31:29	\N	\N	\N	\N	0	0	\N
37	60	61	1587123091005	2020-04-17	2020-05-17	15	12	80	0	0	1	2020-04-16 23:31:30	2020-04-16 23:31:30	\N	\N	\N	\N	0	0	\N
38	60	60	1587123091005	2020-04-17	2020-05-17	15	3	20	0	0	1	2020-04-16 23:31:30	2020-04-16 23:31:30	\N	\N	\N	\N	0	0	\N
39	60	61	1587123093457	2020-04-17	2020-05-17	15	12	80	0	0	1	2020-04-16 23:31:32	2020-04-16 23:31:32	\N	\N	\N	\N	0	0	\N
40	60	60	1587123093457	2020-04-17	2020-05-17	15	3	20	0	0	1	2020-04-16 23:31:32	2020-04-16 23:31:32	\N	\N	\N	\N	0	0	\N
7	15	30	1588762676458	2020-05-06	2020-06-05	10	50	\N	0	0	1	2020-05-06 10:57:55	2020-05-06 10:57:55	05:00 AM	06:00 AM	10:00 AM	50	0	0	\N
8	15	31	1588762676458	2020-05-06	2020-06-05	10	\N	\N	0	0	1	2020-05-06 10:57:55	2020-05-06 10:57:55	05:00 AM	06:00 AM	10:00 AM	50	0	0	\N
9	15	30	1588762758782	2020-05-06	2020-06-05	10	35	\N	0	0	1	2020-05-06 10:59:18	2020-05-06 10:59:18	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
10	15	31	1588762758782	2020-05-06	2020-06-05	10	\N	\N	0	0	1	2020-05-06 10:59:18	2020-05-06 10:59:18	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
11	19	34	1588766884747	2020-05-06	2020-06-05	23	66	\N	0	0	1	2020-05-06 12:08:04	2020-05-06 12:08:04	09:00 PM	05:00 PM	10:00 PM	34	0	0	\N
12	19	35	1588766884747	2020-05-06	2020-06-05	23	\N	\N	0	0	1	2020-05-06 12:08:04	2020-05-06 12:08:04	09:00 PM	05:00 PM	10:00 PM	34	0	0	\N
13	37	57	1588767277515	2020-05-06	2020-06-05	12	58	\N	0	0	1	2020-05-06 12:14:36	2020-05-06 12:14:36	10:00 AM	12:00 AM	05:00 PM	42	0	0	\N
14	37	58	1588767277515	2020-05-06	2020-06-05	12	\N	\N	0	0	1	2020-05-06 12:14:36	2020-05-06 12:14:36	10:00 AM	12:00 AM	05:00 PM	42	0	0	\N
15	39	59	1588767708309	2020-05-06	2020-06-05	21	65	\N	0	0	1	2020-05-06 12:21:47	2020-05-06 12:21:47	05:00 PM	06:00 PM	04:00 PM	35	0	0	\N
16	39	62	1588767708309	2020-05-06	2020-06-05	21	\N	\N	0	0	1	2020-05-06 12:21:47	2020-05-06 12:21:47	05:00 PM	06:00 PM	04:00 PM	35	0	0	\N
17	43	66	1588768631994	2020-05-06	2020-06-05	9	49	\N	0	0	1	2020-05-06 12:37:11	2020-05-06 12:37:11	09:00 PM	05:00 PM	10:00 PM	51	0	0	\N
18	43	65	1588768631994	2020-05-06	2020-06-05	9	\N	\N	0	0	1	2020-05-06 12:37:11	2020-05-06 12:37:11	09:00 PM	05:00 PM	10:00 PM	51	0	0	\N
23	45	70	1588769568600	2020-05-06	2020-06-05	8	35	\N	0	0	1	2020-05-06 12:52:47	2020-05-06 12:52:47	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
24	45	69	1588769568600	2020-05-06	2020-06-05	8	\N	\N	0	0	1	2020-05-06 12:52:47	2020-05-06 12:52:47	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
25	49	81	1588770775279	2020-05-06	2020-06-05	10	35	\N	0	0	1	2020-05-06 01:12:55	2020-05-06 01:12:55	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
26	49	80	1588770775279	2020-05-06	2020-06-05	10	\N	\N	0	0	1	2020-05-06 01:12:55	2020-05-06 01:12:55	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
27	53	84	1588771180357	2020-05-06	2020-06-05	10	35	\N	0	0	1	2020-05-06 01:19:39	2020-05-06 01:19:39	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
28	53	85	1588771180357	2020-05-06	2020-06-05	10	\N	\N	0	0	1	2020-05-06 01:19:39	2020-05-06 01:19:39	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
29	55	87	1588771440023	2020-05-06	2020-06-05	7	35	\N	0	0	1	2020-05-06 01:23:59	2020-05-06 01:23:59	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
30	55	86	1588771440023	2020-05-06	2020-06-05	7	\N	\N	0	0	1	2020-05-06 01:23:59	2020-05-06 01:23:59	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
31	57	89	1588771991516	2020-05-06	2020-06-05	10	35	\N	0	0	1	2020-05-06 01:33:11	2020-05-06 01:33:11	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
32	57	88	1588771991516	2020-05-06	2020-06-05	10	\N	\N	0	0	1	2020-05-06 01:33:11	2020-05-06 01:33:11	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
41	64	99	1588850714716	2020-05-07	2020-06-06	2	10	\N	0	0	1	2020-05-07 11:25:13	2020-05-07 11:25:13	10	08:20	20	2	0	0	\N
42	64	98	1588850714716	2020-05-07	2020-06-06	2	10	\N	0	0	1	2020-05-07 11:25:13	2020-05-07 11:25:13	10	08:20	20	2	0	0	\N
43	69	103	1588856304584	2020-05-07	2020-06-06	40	35	\N	0	0	1	2020-05-07 12:58:24	2020-05-07 12:58:24	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
44	69	102	1588856304584	2020-05-07	2020-06-06	40	35	\N	0	0	1	2020-05-07 12:58:24	2020-05-07 12:58:24	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
45	71	105	1588856569322	2020-05-07	2020-06-06	42	44	\N	0	0	1	2020-05-07 01:02:48	2020-05-07 01:02:48	09:00 PM	05:00 PM	10:00 PM	56	0	0	\N
46	71	104	1588856569322	2020-05-07	2020-06-06	42	44	\N	0	0	1	2020-05-07 01:02:48	2020-05-07 01:02:48	09:00 PM	05:00 PM	10:00 PM	56	0	0	\N
47	73	107	1588859887716	2020-05-07	2020-06-06	20	51	\N	0	0	1	2020-05-07 01:58:07	2020-05-07 01:58:07	01:00 AM	04:00 AM	08:00 AM	49	0	0	\N
48	73	109	1588859887716	2020-05-07	2020-06-06	20	51	\N	0	0	1	2020-05-07 01:58:07	2020-05-07 01:58:07	01:00 AM	04:00 AM	08:00 AM	49	0	0	\N
49	75	113	1588862816435	2020-05-07	2020-06-06	19	51	\N	0	0	1	2020-05-07 02:46:55	2020-05-07 02:46:55	09:00 PM	05:00 PM	10:00 PM	49	0	0	\N
50	75	114	1588862816435	2020-05-07	2020-06-06	19	51	\N	0	0	1	2020-05-07 02:46:55	2020-05-07 02:46:55	09:00 PM	05:00 PM	10:00 PM	49	0	0	\N
51	77	116	1588863557009	2020-05-07	2020-06-06	18	35	\N	0	0	1	2020-05-07 02:59:16	2020-05-07 02:59:16	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
52	77	117	1588863557009	2020-05-07	2020-06-06	18	35	\N	0	0	1	2020-05-07 02:59:16	2020-05-07 02:59:16	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
53	79	119	1588864606106	2020-05-07	2020-06-06	16	35	\N	0	0	1	2020-05-07 03:16:45	2020-05-07 03:16:45	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
54	79	118	1588864606106	2020-05-07	2020-06-06	16	35	\N	0	0	1	2020-05-07 03:16:45	2020-05-07 03:16:45	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
55	81	121	1588865303489	2020-05-07	2020-06-06	18	35	\N	0	0	1	2020-05-07 03:28:23	2020-05-07 03:28:23	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
56	81	120	1588865303489	2020-05-07	2020-06-06	18	35	\N	0	0	1	2020-05-07 03:28:23	2020-05-07 03:28:23	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
57	83	122	1588865407608	2020-05-07	2020-06-06	15	47	\N	0	0	1	2020-05-07 03:30:06	2020-05-07 03:30:06	09:00 PM	05:00 PM	10:00 PM	53	0	0	\N
58	83	123	1588865407608	2020-05-07	2020-06-06	15	47	\N	0	0	1	2020-05-07 03:30:06	2020-05-07 03:30:06	09:00 PM	05:00 PM	10:00 PM	53	0	0	\N
59	85	125	1588868526157	2020-05-07	2020-06-06	10	65	\N	0	0	1	2020-05-07 04:22:05	2020-05-07 04:22:05	11:00 PM	10:00 PM	10:00 AM	35	0	0	\N
60	85	124	1588868526157	2020-05-07	2020-06-06	10	65	\N	0	0	1	2020-05-07 04:22:05	2020-05-07 04:22:05	11:00 PM	10:00 PM	10:00 AM	35	0	0	\N
61	84	124	1588868884024	2020-05-07	2020-06-06	15	59	\N	0	0	1	2020-05-07 04:28:03	2020-05-07 04:28:03	05:00 PM	05:00 PM	07:00 AM	41	0	0	\N
62	84	125	1588868884024	2020-05-07	2020-06-06	15	59	\N	0	0	1	2020-05-07 04:28:03	2020-05-07 04:28:03	05:00 PM	05:00 PM	07:00 AM	41	0	0	\N
63	89	131	1588875433060	2020-05-07	2020-06-06	21	76	\N	0	0	1	2020-05-07 06:17:12	2020-05-07 06:17:12	09:00 PM	05:00 PM	10:00 PM	24	0	0	\N
64	89	132	1588875433060	2020-05-07	2020-06-06	21	76	\N	0	0	1	2020-05-07 06:17:12	2020-05-07 06:17:12	09:00 PM	05:00 PM	10:00 PM	24	0	0	\N
65	93	136	1588919493182	2020-05-08	2020-06-07	10	48	\N	0	0	1	2020-05-08 06:31:32	2020-05-08 06:31:32	09:00 PM	05:00 PM	10:00 PM	52	0	0	\N
66	93	135	1588919493182	2020-05-08	2020-06-07	10	48	\N	0	0	1	2020-05-08 06:31:32	2020-05-08 06:31:32	09:00 PM	05:00 PM	10:00 PM	52	0	0	\N
67	95	137	1588919897362	2020-05-08	2020-06-07	16	52	\N	0	0	1	2020-05-08 06:38:16	2020-05-08 06:38:16	09:00 PM	05:00 PM	10:00 PM	48	0	0	\N
68	95	138	1588919897362	2020-05-08	2020-06-07	16	52	\N	0	0	1	2020-05-08 06:38:16	2020-05-08 06:38:16	09:00 PM	05:00 PM	10:00 PM	48	0	0	\N
69	97	139	1588922080345	2020-05-08	2020-06-07	14	44	\N	0	0	1	2020-05-08 07:14:40	2020-05-08 07:14:40	09:00 PM	05:00 PM	10:00 PM	56	0	0	\N
70	97	141	1588922080345	2020-05-08	2020-06-07	14	44	\N	0	0	1	2020-05-08 07:14:40	2020-05-08 07:14:40	09:00 PM	05:00 PM	10:00 PM	56	0	0	\N
71	65	98	1588929099810	2020-05-08	2020-06-07	20	15	\N	0	0	1	2020-05-08 09:11:39	2020-05-08 09:11:39	10	08:20	20	2	0	0	\N
72	65	99	1588929099810	2020-05-08	2020-06-07	20	2	\N	0	0	1	2020-05-08 09:11:39	2020-05-08 09:11:39	10	08:20	20	15	0	0	\N
73	99	142	1588935823041	2020-05-08	2020-06-07	18	56	\N	0	0	1	2020-05-08 11:03:42	2020-05-08 11:03:42	09:00 PM	05:00 PM	10:00 PM	44	0	0	\N
74	99	140	1588935823041	2020-05-08	2020-06-07	18	44	\N	0	0	1	2020-05-08 11:03:42	2020-05-08 11:03:42	09:00 PM	05:00 PM	10:00 PM	56	0	0	\N
75	101	143	1588936540732	2020-05-08	2020-06-07	25	53	\N	0	0	1	2020-05-08 11:15:40	2020-05-08 11:15:40	09:00 PM	05:00 PM	10:00 PM	47	0	0	\N
76	101	144	1588936540732	2020-05-08	2020-06-07	25	47	\N	0	0	1	2020-05-08 11:15:40	2020-05-08 11:15:40	09:00 PM	05:00 PM	10:00 PM	53	0	0	\N
77	102	146	1588942533023	2020-05-08	2020-06-07	15	37	\N	0	0	1	2020-05-08 12:55:32	2020-05-08 12:55:32	06:00 AM	05:00 PM	10:00 PM	63	0	0	\N
78	102	145	1588942533023	2020-05-08	2020-06-07	15	63	\N	0	0	1	2020-05-08 12:55:32	2020-05-08 12:55:32	06:00 AM	05:00 PM	10:00 PM	37	0	0	\N
79	105	147	1588943060564	2020-05-08	2020-06-07	11	53	\N	0	0	1	2020-05-08 01:04:20	2020-05-08 01:04:20	09:00 PM	05:00 PM	10:00 PM	47	0	0	\N
80	105	148	1588943060564	2020-05-08	2020-06-07	11	47	\N	0	0	1	2020-05-08 01:04:20	2020-05-08 01:04:20	09:00 PM	05:00 PM	10:00 PM	53	0	0	\N
81	65	98	1588943621532	2020-05-08	2020-06-07	20	15	\N	0	0	1	2020-05-08 01:13:40	2020-05-08 01:13:40	10	08:20	20	2	0	0	\N
82	65	99	1588943621532	2020-05-08	2020-06-07	20	2	\N	0	0	1	2020-05-08 01:13:40	2020-05-08 01:13:40	10	08:20	20	15	0	0	\N
83	109	151	1588944931160	2020-05-08	2020-06-07	25	51	\N	0	0	1	2020-05-08 01:35:30	2020-05-08 01:35:30	09:00 PM	05:00 PM	10:00 PM	49	0	0	\N
84	109	152	1588944931160	2020-05-08	2020-06-07	25	49	\N	0	0	1	2020-05-08 01:35:30	2020-05-08 01:35:30	09:00 PM	05:00 PM	10:00 PM	51	0	0	\N
85	111	154	1588945141210	2020-05-08	2020-06-07	11	45	\N	0	0	1	2020-05-08 01:39:00	2020-05-08 01:39:00	09:00 PM	05:00 PM	10:00 PM	55	0	0	\N
86	111	153	1588945141210	2020-05-08	2020-06-07	11	55	\N	0	0	1	2020-05-08 01:39:00	2020-05-08 01:39:00	09:00 PM	05:00 PM	10:00 PM	45	0	0	\N
87	113	156	1588945377053	2020-05-08	2020-06-07	18	48	\N	0	0	1	2020-05-08 01:42:56	2020-05-08 01:42:56	09:00 PM	05:00 PM	10:00 PM	52	0	0	\N
88	113	155	1588945377053	2020-05-08	2020-06-07	18	52	\N	0	0	1	2020-05-08 01:42:56	2020-05-08 01:42:56	09:00 PM	05:00 PM	10:00 PM	48	0	0	\N
89	115	158	1588947955349	2020-05-08	2020-06-07	23	52	\N	0	0	1	2020-05-08 02:25:54	2020-05-08 02:25:54	09:00 PM	05:00 PM	10:00 PM	48	0	0	\N
90	115	157	1588947955349	2020-05-08	2020-06-07	23	48	\N	0	0	1	2020-05-08 02:25:54	2020-05-08 02:25:54	09:00 PM	05:00 PM	10:00 PM	52	0	0	\N
91	119	159	1589015211875	2020-05-09	2020-06-08	16	46	\N	0	0	1	2020-05-09 09:06:50	2020-05-09 09:06:50	09:00 PM	05:00 PM	10:00 PM	54	0	0	\N
92	119	160	1589015211875	2020-05-09	2020-06-08	16	54	\N	0	0	1	2020-05-09 09:06:50	2020-05-09 09:06:50	09:00 PM	05:00 PM	10:00 PM	46	0	0	\N
93	121	161	1589015559204	2020-05-09	2020-06-08	2	10	\N	0	0	1	2020-05-09 09:12:38	2020-05-09 09:12:38	10	08:20	20	2	0	0	\N
94	121	162	1589015559204	2020-05-09	2020-06-08	2	2	\N	0	0	1	2020-05-09 09:12:38	2020-05-09 09:12:38	10	08:20	20	10	0	0	\N
95	122	164	1589019290852	2020-05-09	2020-06-08	15	35	\N	0	0	1	2020-05-09 10:14:50	2020-05-09 10:14:50	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
96	122	163	1589019290852	2020-05-09	2020-06-08	15	65	\N	0	0	1	2020-05-09 10:14:50	2020-05-09 10:14:50	09:00 PM	05:00 PM	10:00 PM	35	0	0	\N
97	125	165	1589019610153	2020-05-09	2020-06-08	12	35	\N	0	0	1	2020-05-09 10:20:09	2020-05-09 10:20:09	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
98	125	166	1589019610153	2020-05-09	2020-06-08	12	65	\N	0	0	1	2020-05-09 10:20:09	2020-05-09 10:20:09	09:00 PM	05:00 PM	10:00 PM	35	0	0	\N
99	126	168	1589020273591	2020-05-09	2020-06-08	15	35	\N	0	0	1	2020-05-09 10:31:13	2020-05-09 10:31:13	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
100	126	167	1589020273591	2020-05-09	2020-06-08	15	65	\N	0	0	1	2020-05-09 10:31:13	2020-05-09 10:31:13	09:00 PM	05:00 PM	10:00 PM	35	0	0	\N
101	128	170	1589020464290	2020-05-09	2020-06-08	36	61	\N	0	0	1	2020-05-09 10:34:23	2020-05-09 10:34:23	09:00 PM	05:00 PM	10:00 PM	39	0	0	\N
102	128	169	1589020464290	2020-05-09	2020-06-08	36	39	\N	0	0	1	2020-05-09 10:34:23	2020-05-09 10:34:23	09:00 PM	05:00 PM	10:00 PM	61	0	0	\N
107	114	157	1589025188878	2020-05-09	2020-06-08	20	15	\N	0	0	1	2020-05-09 11:53:08	2020-05-09 11:53:08	10	08:20	20	2	0	0	\N
108	114	158	1589025188878	2020-05-09	2020-06-08	20	2	\N	0	0	1	2020-05-09 11:53:08	2020-05-09 11:53:08	10	08:20	20	15	0	0	\N
109	114	157	1589025923611	2020-05-09	2020-06-08	20	15	\N	0	0	1	2020-05-09 12:05:23	2020-05-09 12:05:23	10	08:20	20	2	0	0	\N
110	114	158	1589025923611	2020-05-09	2020-06-08	20	2	\N	0	0	1	2020-05-09 12:05:23	2020-05-09 12:05:23	10	08:20	20	15	0	0	\N
117	131	183	1589377201419	2020-05-13	2020-06-12	25	51	\N	0	0	1	2020-05-13 01:40:00	2020-05-13 01:40:00	12:15 PM	06:15 PM	10:20 PM	49	0	0	\N
119	139	197	1589379676927	2020-05-13	2020-06-12	28	55	\N	0	0	1	2020-05-13 02:21:15	2020-05-13 02:21:15	09:10 PM	07:00 PM	10:30 PM	45	0	0	\N
120	147	206	1589432020238	2020-05-14	2020-06-13	58	55	\N	0	0	1	2020-05-14 04:53:39	2020-05-14 04:53:39	09:00 PM	05:00 PM	10:00 PM	45	0	0	\N
121	153	213	1589437755550	2020-05-14	2020-06-13	25	54	\N	0	0	1	2020-05-14 06:29:15	2020-05-14 06:29:15	09:20 PM	09:00 PM	12:20 PM	46	0	0	\N
122	155	215	1589437958710	2020-05-14	2020-06-13	45	53	\N	0	0	1	2020-05-14 06:32:38	2020-05-14 06:32:38	09:00 PM	05:00 PM	10:00 PM	47	0	0	\N
118	135	216	1589378268132	2020-05-13	2020-06-12	25	10	\N	0	0	1	2020-05-13 01:57:47	2020-05-14 06:53:32	10	10:22 AM	02:20 PM	5	0	0	\N
123	157	217	1589445995333	2020-05-14	2020-06-13	56	58	\N	0	0	1	2020-05-14 08:46:34	2020-05-14 08:46:34	09:00 PM	08:00 PM	10:00 PM	42	0	0	\N
125	156	218	1589449161432	2020-05-14	2020-06-13	56	58	\N	0	0	1	2020-05-14 09:39:20	2020-05-14 09:39:20	09:00 PM	08:00 PM	10:00 PM	42	0	0	\N
126	156	218	1589449229803	2020-05-14	2020-06-13	56	58	\N	0	0	1	2020-05-14 09:40:29	2020-05-14 09:40:29	09:00 PM	08:00 PM	10:00 PM	42	0	0	\N
139	184	247	1589480937349	2020-05-14	2020-06-13	10	68	\N	0	0	1	2020-05-14 06:28:57	2020-05-14 06:28:57	09:00 PM	05:00 PM	10:00 PM	32	0	0	\N
441	510	345	1591791747455	2020-06-10	2020-07-10	30	35	\N	0	0	1	2020-06-10 12:22:26	2020-06-10 12:22:57	03:30 PM	12:25 PM	04:30 PM	65	0	0	28:05
438	511	346	1591787654833	2020-06-10	2020-07-10	30	35	\N	0	0	1	2020-06-10 11:14:14	2020-06-10 12:27:19	03:30 PM	11:20 AM	04:30 PM	65	0	0	29:10
372	448	311	1591185034170	2020-06-03	2020-07-03	3	65	\N	3	0	1	2020-06-03 11:50:33	2020-06-03 11:53:49	03:30 PM	11:30 AM	04:30 PM	35	0	3	\N
390	449	312	1591188251875	2020-06-03	2020-07-03	2	65	\N	2	0	1	2020-06-03 12:44:11	2020-06-03 12:46:58	03:30 PM	11:30 AM	04:30 PM	35	1	1	\N
378	449	311	1591186765238	2020-06-03	2020-07-03	5	35	\N	5	0	1	2020-06-03 12:19:25	2020-06-03 12:19:25	03:30 PM	11:30 AM	04:30 PM	65	0	5	\N
165	235	256	1589806862067	2020-05-18	2020-06-17	45	35	\N	0	0	1	2020-05-18 01:01:01	2020-05-18 01:01:01	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
374	449	311	1591185570944	2020-06-03	2020-07-03	3	35	\N	3	0	1	2020-06-03 11:59:30	2020-06-03 11:59:30	03:30 PM	11:30 AM	04:30 PM	65	2	1	\N
376	449	311	1591185758886	2020-06-03	2020-07-03	3	35	\N	0	0	1	2020-06-03 12:02:38	2020-06-03 12:02:38	03:30 PM	11:30 AM	04:30 PM	65	0	0	\N
450	510	345	1592303717919	2020-06-12	2020-07-12	30	35	\N	0	0	1	2020-06-16 10:35:17	2020-06-16 10:40:18	03:30 PM	10:45 AM	04:30 PM	65	0	0	29:45
347	449	311	1591018072300	2020-06-01	2020-07-01	4	35	\N	5	0	1	2020-06-01 01:27:51	2020-06-03 11:36:13	03:30 PM	09:00 AM	04:30 PM	65	4	18	\N
386	449	311	1591187898274	2020-06-03	2020-07-03	3	35	\N	0	0	1	2020-06-03 12:38:17	2020-06-03 12:38:17	03:30 PM	11:30 AM	04:30 PM	65	0	0	\N
392	449	311	1591188463358	2020-06-03	2020-07-03	4	35	\N	0	0	1	2020-06-03 12:47:42	2020-06-03 12:47:42	03:30 PM	11:30 AM	04:30 PM	65	0	0	\N
388	448	312	1591188030247	2020-06-03	2020-07-03	5	35	\N	0	0	1	2020-06-03 12:40:30	2020-06-03 12:40:30	03:30 PM	11:30 AM	04:30 PM	65	0	0	\N
309	11	29	1590638604942	2020-05-28	2020-06-27	20	15	\N	0	0	1	2020-05-28 04:03:24	2020-05-28 04:03:24	10	04:26 PM	09:45 AM	2	0	0	\N
311	388	323	1590638652840	2020-05-28	2020-06-27	20	15	\N	0	0	1	2020-05-28 04:04:11	2020-05-28 04:04:11	10	09:35 AM	09:45 AM	2	0	0	\N
444	510	345	1591873251047	2020-06-15	2020-07-11	30	35	\N	0	0	1	2020-06-11 11:00:50	2020-06-11 11:12:01	04:30 PM	11:15 AM	04:30 PM	65	0	0	29:15
395	449	311	1591188816455	2020-06-03	2020-07-03	2	35	\N	2	0	1	2020-06-03 12:53:36	2020-06-03 12:53:36	03:30 PM	11:30 AM	04:30 PM	65	1	1	\N
447	510	345	1592302257581	2020-06-12	2020-07-12	30	35	\N	0	0	1	2020-06-16 10:10:56	2020-06-16 10:10:56	03:30 PM	10:15 AM	04:30 PM	65	0	0	30:15
396	449	311	1591188883447	2020-06-03	2020-07-03	2	35	\N	2	0	1	2020-06-03 12:54:42	2020-06-03 12:57:29	03:30 PM	11:30 AM	04:30 PM	65	1	1	\N
435	511	346	1591783628219	2020-06-10	2020-07-10	30	47	\N	0	0	1	2020-06-10 10:07:07	2020-06-10 11:11:55	03:30 PM	11:10 AM	04:30 PM	53	0	0	29:20
456	510	345	1592312148167	2020-06-16	2020-07-16	30	35	\N	0	0	1	2020-06-16 12:55:47	2020-06-17 04:00:53	03:30 PM	04:05 AM	05:30 PM	65	0	0	37:25
397	448	312	1591189423083	2020-06-03	2020-07-03	4	35	\N	0	0	1	2020-06-03 01:03:42	2020-06-03 01:03:42	03:30 PM	11:30 AM	04:30 PM	65	0	0	\N
398	449	311	1591189429564	2020-06-03	2020-07-03	5	35	\N	0	0	1	2020-06-03 01:03:48	2020-06-03 01:03:48	03:30 PM	11:30 AM	04:30 PM	65	0	0	\N
399	449	311	1591189442593	2020-06-03	2020-07-03	5	35	\N	0	0	1	2020-06-03 01:04:02	2020-06-03 01:04:02	03:30 PM	11:30 AM	04:30 PM	65	0	0	\N
339	432	319	1591003092923	2020-06-01	2020-07-01	10	35	\N	0	0	1	2020-06-01 09:18:12	2020-06-01 09:18:12	09:35 AM	09:35 AM	09:35 AM	65	0	0	\N
439	517	336	1591788136425	2020-06-10	2020-07-10	30	35	\N	0	0	1	2020-06-10 11:22:15	2020-06-10 11:22:15	11:25 AM	11:25 AM	07:30 PM	65	0	0	8:05
442	510	345	1591792080450	2020-06-10	2020-07-10	30	35	\N	0	0	1	2020-06-10 12:27:59	2020-06-10 12:28:56	03:30 PM	12:30 PM	04:30 PM	65	0	0	28:00
373	449	311	1591185275763	2020-06-03	2020-07-03	5	35	\N	0	0	1	2020-06-03 11:54:34	2020-06-03 11:54:34	03:30 PM	11:30 AM	04:30 PM	65	0	0	\N
375	449	311	1591185683046	2020-06-03	2020-07-03	2	35	\N	2	0	1	2020-06-03 12:01:22	2020-06-03 12:01:22	03:30 PM	11:30 AM	04:30 PM	65	1	1	\N
310	388	323	1590638632690	2020-05-28	2020-06-27	20	15	\N	0	0	1	2020-05-28 04:03:51	2020-05-28 04:03:51	10	04:26 PM	09:45 AM	2	0	0	\N
312	388	323	1590641423361	2020-05-28	2020-06-27	10	56	\N	0	0	1	2020-05-28 04:50:23	2020-05-28 04:50:23	09:00 PM	05:00 PM	10:00 PM	44	0	0	\N
377	449	311	1591186165785	2020-06-03	2020-07-03	2	35	\N	2	0	1	2020-06-03 12:09:25	2020-06-03 12:09:25	03:30 PM	11:30 AM	04:30 PM	65	1	1	\N
384	448	312	1591187214897	2020-06-03	2020-07-03	2	35	\N	2	0	1	2020-06-03 12:26:54	2020-06-03 12:26:54	03:30 PM	11:30 AM	04:30 PM	65	1	1	\N
387	449	311	1591187977770	2020-06-03	2020-07-03	3	35	\N	3	0	1	2020-06-03 12:39:37	2020-06-03 12:39:48	03:30 PM	11:30 AM	04:30 PM	65	1	2	\N
389	448	312	1591188154705	2020-06-03	2020-07-03	3	35	\N	3	0	1	2020-06-03 12:42:34	2020-06-03 12:42:34	03:30 PM	11:30 AM	04:30 PM	65	2	1	\N
457	510	345	1592367030080	2020-06-15	2020-07-15	30	35	\N	0	0	1	2020-06-17 04:10:29	2020-06-17 04:10:29	03:30 PM	04:15 AM	04:30 PM	65	0	0	36:15
460	532	368	1594957156238	2020-07-17	2020-08-16	7	66	\N	0	0	1	2020-07-17 03:39:15	2020-07-17 03:39:15	02:00 PM	01:00 PM	03:00 PM	34	0	0	26:00
272	323	301	1590411669467	2020-05-25	2020-06-24	768	35	\N	0	0	1	2020-05-25 01:01:09	2020-05-25 01:01:09	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
235	266	278	1590121129678	2020-05-22	2020-06-21	19	54	\N	0	0	1	2020-05-22 04:18:49	2020-05-22 04:21:04	02:00 PM	09:00 PM	12:00 PM	46	0	0	\N
263	310	307	1590368824523	2020-05-25	2020-06-24	20	49	\N	0	0	1	2020-05-25 01:07:04	2020-05-25 01:08:56	09:00 PM	05:00 PM	10:00 PM	51	0	0	\N
264	307	261	1590387189788	2020-05-25	2020-06-24	41	35	\N	0	0	1	2020-05-25 06:13:09	2020-05-25 06:13:09	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
268	262	268	1590402118011	2020-05-25	2020-06-24	35	35	\N	0	0	1	2020-05-25 10:21:57	2020-05-25 10:21:57	09:00 PM	05:00 PM	10:00 PM	65	0	0	\N
400	449	311	1591189467028	2020-06-03	2020-07-03	5	35	\N	0	0	1	2020-06-03 01:04:26	2020-06-03 01:04:26	03:30 PM	11:30 AM	04:30 PM	65	0	0	\N
401	448	312	1591189487486	2020-06-03	2020-07-03	3	35	\N	0	0	1	2020-06-03 01:04:47	2020-06-03 01:04:47	03:30 PM	11:30 AM	04:30 PM	65	0	0	\N
402	449	311	1591189513066	2020-06-03	2020-07-03	6	35	\N	0	0	1	2020-06-03 01:05:12	2020-06-03 01:05:12	03:30 PM	11:30 AM	04:30 PM	65	0	0	\N
403	449	311	1591189548644	2020-06-03	2020-07-03	6	35	\N	0	0	1	2020-06-03 01:05:48	2020-06-03 01:05:48	03:30 PM	11:30 AM	04:30 PM	65	0	0	\N
404	449	311	1591190030366	2020-06-03	2020-07-03	9	35	\N	0	0	1	2020-06-03 01:13:50	2020-06-03 01:13:50	03:30 PM	11:30 AM	04:30 PM	65	0	0	\N
405	449	311	1591190109895	2020-06-03	2020-07-03	57	35	\N	0	0	1	2020-06-03 01:15:09	2020-06-03 01:15:09	03:30 PM	11:30 AM	04:30 PM	65	0	0	\N
406	448	312	1591190178035	2020-06-03	2020-07-03	6	35	\N	0	0	1	2020-06-03 01:16:17	2020-06-03 01:16:17	03:30 PM	11:30 AM	04:30 PM	65	0	0	\N
407	449	311	1591190251408	2020-06-03	2020-07-03	9	35	\N	0	0	1	2020-06-03 01:17:31	2020-06-03 01:17:31	03:30 PM	11:30 AM	04:30 PM	65	0	0	\N
408	449	311	1591190395174	2020-06-03	2020-07-03	20	15	\N	0	0	1	2020-06-03 01:19:54	2020-06-03 01:19:54	10	11:31 AM	09:45 AM	2	0	0	\N
412	449	311	1591190957299	2020-06-03	2020-07-03	20	15	\N	0	0	1	2020-06-03 01:29:17	2020-06-03 01:29:17	10	11:31 AM	09:45 AM	2	0	0	\N
413	449	311	1591190966875	2020-06-03	2020-07-03	20	15	\N	0	0	1	2020-06-03 01:29:26	2020-06-03 01:29:26	10	11:31 AM	09:45 AM	2	0	0	\N
414	449	311	1591190968094	2020-06-03	2020-07-03	20	15	\N	0	0	1	2020-06-03 01:29:27	2020-06-03 01:29:27	10	11:31 AM	09:45 AM	2	0	0	\N
458	527	363	1592567727628	2020-06-19	2020-07-19	30	36	\N	0	0	1	2020-06-19 11:55:26	2020-06-19 12:06:25	03:30 PM	12:20 PM	05:00 PM	64	0	0	28:40
443	521	349	1591864748715	2020-06-11	2020-07-11	30	47	\N	0	0	1	2020-06-11 08:39:08	2020-06-12 10:49:53	03:30 PM	09:30 AM	07:30 PM	53	0	0	10:00
455	510	345	1592310557891	2020-06-12	2020-07-12	30	35	\N	0	0	1	2020-06-16 12:29:17	2020-06-16 12:29:17	03:30 PM	12:30 PM	04:30 PM	65	0	0	28:00
322	409	326	1590739962095	2020-05-29	2020-06-28	20	21	\N	0	0	1	2020-05-29 08:12:41	2020-06-04 02:10:55	10:00 AM	08:40 AM	02:20 PM	79	0	0	\N
432	505	335	1591702189929	2020-06-09	2020-07-09	3	35	\N	0	0	1	2020-06-09 11:29:49	2020-06-09 11:40:52	03:30 PM	11:50 AM	04:30 PM	65	0	0	28:40
446	525	342	1592211735777	2020-06-15	2020-07-15	30	44	\N	0	0	1	2020-06-15 09:02:15	2020-06-19 11:48:17	03:30 PM	09:20 AM	04:30 PM	56	0	0	31:10
433	507	343	1591703411802	2020-06-09	2020-07-09	30	35	\N	0	0	1	2020-06-09 11:50:11	2020-06-09 12:00:21	03:30 PM	12:10 PM	04:30 PM	65	0	0	28:20
431	503	339	1591599900652	2020-06-08	2020-07-08	30	35	\N	0	0	1	2020-06-08 07:05:00	2020-06-09 09:38:59	03:30 PM	09:40 AM	07:30 PM	65	0	0	9:50
\.


--
-- Name: monthly_goals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.monthly_goals_id_seq', 461, true);


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications (id, question, status, create_time, update_time) FROM stdin;
\.


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notifications_id_seq', 1, false);


--
-- Data for Name: pages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pages (id, title, description, status, create_time, update_time) FROM stdin;
4	Where can I get some?	There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.	1	2020-01-14 00:00:00	2020-01-14 00:00:00
1	What is Lorem Ipsum?	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.	0	2020-01-14 00:00:00	2020-01-14 00:00:00
3	Where does it come from?	Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.	0	2020-01-14 00:00:00	2020-05-14 07:08:30
2	Why do we use it?	It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).	0	2020-01-14 00:00:00	2020-05-19 10:25:22
\.


--
-- Name: pages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pages_id_seq', 4, true);


--
-- Data for Name: partner_mappings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.partner_mappings (id, partner_one_id, partner_two_id, status, create_time, update_time, uniqe_id) FROM stdin;
14	60	61	1	2020-04-16 22:53:16	2020-04-16 22:53:16	\N
14	60	61	1	2020-04-16 22:53:16	2020-04-16 22:53:16	\N
1	5	8	1	2020-05-05 06:53:05	2020-05-05 06:53:05	\N
2	8	5	1	2020-05-05 06:58:04	2020-05-05 06:58:04	\N
5	22	4	1	2020-05-05 07:19:42	2020-05-05 07:19:42	\N
6	4	22	1	2020-05-05 07:20:57	2020-05-05 07:20:57	\N
7	27	22	1	2020-05-05 07:24:24	2020-05-05 07:24:24	\N
8	23	22	1	2020-05-05 07:24:47	2020-05-05 07:24:47	\N
9	27	23	1	2020-05-05 07:25:04	2020-05-05 07:25:04	\N
10	23	27	1	2020-05-05 07:25:43	2020-05-05 07:25:43	\N
11	29	27	1	2020-05-05 07:28:23	2020-05-05 07:28:23	\N
12	29	28	1	2020-05-05 07:28:35	2020-05-05 07:28:35	\N
13	28	29	1	2020-05-05 07:29:41	2020-05-05 07:29:41	\N
14	31	30	1	2020-05-05 07:30:58	2020-05-05 07:30:58	\N
15	30	31	1	2020-05-05 07:31:47	2020-05-05 07:31:47	\N
16	32	33	1	2020-05-05 09:24:41	2020-05-05 09:24:41	\N
17	33	32	1	2020-05-05 09:25:42	2020-05-05 09:25:42	\N
18	35	34	1	2020-05-05 09:41:52	2020-05-05 09:41:52	\N
19	34	35	1	2020-05-05 09:42:18	2020-05-05 09:42:18	\N
20	36	37	1	2020-05-05 09:45:42	2020-05-05 09:45:42	\N
21	37	36	1	2020-05-05 09:46:10	2020-05-05 09:46:10	\N
22	38	39	1	2020-05-05 09:48:53	2020-05-05 09:48:53	\N
23	39	38	1	2020-05-05 09:49:04	2020-05-05 09:49:04	\N
24	40	41	1	2020-05-05 10:14:08	2020-05-05 10:14:08	\N
25	41	40	1	2020-05-05 10:14:29	2020-05-05 10:14:29	\N
26	42	43	1	2020-05-05 10:49:37	2020-05-05 10:49:37	\N
27	43	42	1	2020-05-05 10:49:47	2020-05-05 10:49:47	\N
28	45	44	1	2020-05-05 12:14:16	2020-05-05 12:14:16	\N
29	44	45	1	2020-05-05 12:14:35	2020-05-05 12:14:35	\N
30	46	47	1	2020-05-05 12:16:56	2020-05-05 12:16:56	\N
31	47	46	1	2020-05-05 12:17:19	2020-05-05 12:17:19	\N
32	49	48	1	2020-05-05 12:31:44	2020-05-05 12:31:44	\N
33	48	49	1	2020-05-05 12:32:13	2020-05-05 12:32:13	\N
34	50	54	1	2020-05-05 01:04:00	2020-05-05 01:04:00	\N
35	54	50	1	2020-05-05 01:04:08	2020-05-05 01:04:08	\N
36	58	57	1	2020-05-06 12:13:43	2020-05-06 12:13:43	\N
37	57	58	1	2020-05-06 12:13:53	2020-05-06 12:13:53	\N
38	62	59	1	2020-05-06 12:21:06	2020-05-06 12:21:06	\N
39	59	62	1	2020-05-06 12:21:15	2020-05-06 12:21:15	\N
40	64	63	1	2020-05-06 12:32:53	2020-05-06 12:32:53	\N
41	63	64	1	2020-05-06 12:33:01	2020-05-06 12:33:01	\N
42	65	66	1	2020-05-06 12:36:42	2020-05-06 12:36:42	\N
43	66	65	1	2020-05-06 12:36:49	2020-05-06 12:36:49	\N
44	69	70	1	2020-05-06 12:49:14	2020-05-06 12:49:14	\N
45	70	69	1	2020-05-06 12:49:25	2020-05-06 12:49:25	\N
46	71	72	1	2020-05-06 01:00:57	2020-05-06 01:00:57	\N
47	72	71	1	2020-05-06 01:01:31	2020-05-06 01:01:31	\N
48	80	81	1	2020-05-06 01:11:44	2020-05-06 01:11:44	\N
49	81	80	1	2020-05-06 01:11:57	2020-05-06 01:11:57	\N
50	82	83	1	2020-05-06 01:15:39	2020-05-06 01:15:39	\N
51	83	82	1	2020-05-06 01:15:46	2020-05-06 01:15:46	\N
52	85	84	1	2020-05-06 01:19:07	2020-05-06 01:19:07	\N
53	84	85	1	2020-05-06 01:19:18	2020-05-06 01:19:18	\N
54	86	87	1	2020-05-06 01:23:24	2020-05-06 01:23:24	\N
55	87	86	1	2020-05-06 01:23:39	2020-05-06 01:23:39	\N
56	88	89	1	2020-05-06 01:32:25	2020-05-06 01:32:25	\N
57	89	88	1	2020-05-06 01:32:32	2020-05-06 01:32:32	\N
58	91	90	1	2020-05-06 01:35:50	2020-05-06 01:35:50	\N
59	90	91	1	2020-05-06 01:36:02	2020-05-06 01:36:02	\N
60	92	93	1	2020-05-06 01:38:29	2020-05-06 01:38:29	\N
61	93	92	1	2020-05-06 01:38:35	2020-05-06 01:38:35	\N
62	94	95	1	2020-05-06 01:40:44	2020-05-06 01:40:44	\N
63	95	94	1	2020-05-06 01:40:49	2020-05-06 01:40:49	\N
64	99	98	1	2020-05-07 09:51:24	2020-05-07 09:51:24	\N
65	98	99	1	2020-05-07 09:51:48	2020-05-07 09:51:48	\N
66	101	100	1	2020-05-07 10:42:06	2020-05-07 10:42:06	\N
67	100	101	1	2020-05-07 10:42:11	2020-05-07 10:42:11	\N
68	102	103	1	2020-05-07 12:50:34	2020-05-07 12:50:34	\N
69	103	102	1	2020-05-07 12:50:40	2020-05-07 12:50:40	\N
70	104	105	1	2020-05-07 01:02:22	2020-05-07 01:02:22	\N
71	105	104	1	2020-05-07 01:02:27	2020-05-07 01:02:27	\N
72	109	107	1	2020-05-07 01:55:13	2020-05-07 01:55:13	\N
73	107	109	1	2020-05-07 01:55:28	2020-05-07 01:55:28	\N
74	114	113	1	2020-05-07 02:46:15	2020-05-07 02:46:15	\N
75	113	114	1	2020-05-07 02:46:41	2020-05-07 02:46:41	\N
76	117	116	1	2020-05-07 02:59:00	2020-05-07 02:59:00	\N
77	116	117	1	2020-05-07 02:59:06	2020-05-07 02:59:06	\N
78	118	119	1	2020-05-07 03:16:19	2020-05-07 03:16:19	\N
79	119	118	1	2020-05-07 03:16:25	2020-05-07 03:16:25	\N
80	120	121	1	2020-05-07 03:27:45	2020-05-07 03:27:45	\N
81	121	120	1	2020-05-07 03:27:57	2020-05-07 03:27:57	\N
82	123	122	1	2020-05-07 03:29:46	2020-05-07 03:29:46	\N
83	122	123	1	2020-05-07 03:29:53	2020-05-07 03:29:53	\N
84	124	125	1	2020-05-07 04:20:03	2020-05-07 04:20:03	\N
85	125	124	1	2020-05-07 04:20:26	2020-05-07 04:20:26	\N
86	130	128	1	2020-05-07 06:03:09	2020-05-07 06:03:09	\N
87	128	130	1	2020-05-07 06:03:47	2020-05-07 06:03:47	\N
88	132	131	1	2020-05-07 06:16:09	2020-05-07 06:16:09	\N
89	131	132	1	2020-05-07 06:16:46	2020-05-07 06:16:46	\N
90	133	134	1	2020-05-08 05:47:31	2020-05-08 05:47:31	\N
91	134	133	1	2020-05-08 05:47:46	2020-05-08 05:47:46	\N
92	135	136	1	2020-05-08 06:31:02	2020-05-08 06:31:02	\N
93	136	135	1	2020-05-08 06:31:08	2020-05-08 06:31:08	\N
94	138	137	1	2020-05-08 06:37:54	2020-05-08 06:37:54	\N
95	137	138	1	2020-05-08 06:38:00	2020-05-08 06:38:00	\N
96	141	139	1	2020-05-08 07:14:05	2020-05-08 07:14:05	\N
97	139	141	1	2020-05-08 07:14:10	2020-05-08 07:14:10	\N
98	140	142	1	2020-05-08 11:01:26	2020-05-08 11:01:26	\N
99	142	140	1	2020-05-08 11:01:37	2020-05-08 11:01:37	\N
100	144	143	1	2020-05-08 11:13:01	2020-05-08 11:13:01	\N
101	143	144	1	2020-05-08 11:13:09	2020-05-08 11:13:09	\N
102	146	145	1	2020-05-08 12:53:31	2020-05-08 12:53:31	\N
103	145	146	1	2020-05-08 12:53:56	2020-05-08 12:53:56	\N
104	148	147	1	2020-05-08 01:03:52	2020-05-08 01:03:52	\N
105	147	148	1	2020-05-08 01:04:01	2020-05-08 01:04:01	\N
106	150	149	1	2020-05-08 01:26:25	2020-05-08 01:26:25	\N
107	149	150	1	2020-05-08 01:26:36	2020-05-08 01:26:36	\N
108	152	151	1	2020-05-08 01:34:05	2020-05-08 01:34:05	\N
109	151	152	1	2020-05-08 01:34:17	2020-05-08 01:34:17	\N
110	153	154	1	2020-05-08 01:38:11	2020-05-08 01:38:11	\N
111	154	153	1	2020-05-08 01:38:22	2020-05-08 01:38:22	\N
112	155	156	1	2020-05-08 01:42:03	2020-05-08 01:42:03	\N
113	156	155	1	2020-05-08 01:42:10	2020-05-08 01:42:10	\N
114	157	158	1	2020-05-08 02:22:47	2020-05-08 02:22:47	\N
115	158	157	1	2020-05-08 02:23:25	2020-05-08 02:23:25	\N
517	336	337	1	2020-06-10 11:21:30	2020-06-10 11:21:30	PbQ2dZWy4QZCy5VjmHXeSwO1yLJmMu
516	337	336	1	2020-06-10 11:21:21	2020-06-10 11:21:21	PbQ2dZWy4QZCy5VjmHXeSwO1yLJmMu
118	160	159	1	2020-05-09 09:06:20	2020-05-09 09:06:20	\N
119	159	160	1	2020-05-09 09:06:25	2020-05-09 09:06:25	\N
120	162	161	1	2020-05-09 09:09:28	2020-05-09 09:09:28	\N
121	161	162	1	2020-05-09 09:09:35	2020-05-09 09:09:35	\N
122	164	163	1	2020-05-09 10:08:06	2020-05-09 10:08:06	\N
123	163	164	1	2020-05-09 10:08:40	2020-05-09 10:08:40	\N
124	166	165	1	2020-05-09 10:17:47	2020-05-09 10:17:47	\N
125	165	166	1	2020-05-09 10:18:05	2020-05-09 10:18:05	\N
126	168	167	1	2020-05-09 10:29:44	2020-05-09 10:29:44	\N
127	167	168	1	2020-05-09 10:30:02	2020-05-09 10:30:02	\N
128	170	169	1	2020-05-09 10:33:40	2020-05-09 10:33:40	\N
129	169	170	1	2020-05-09 10:33:48	2020-05-09 10:33:48	\N
130	189	183	1	2020-05-13 01:39:16	2020-05-13 01:39:16	\N
131	183	189	1	2020-05-13 01:39:21	2020-05-13 01:39:21	\N
132	191	190	1	2020-05-13 01:52:10	2020-05-13 01:52:10	\N
133	190	191	1	2020-05-13 01:52:22	2020-05-13 01:52:22	\N
134	193	192	1	2020-05-13 01:57:04	2020-05-13 01:57:04	\N
135	192	193	1	2020-05-13 01:57:10	2020-05-13 01:57:10	\N
136	196	195	1	2020-05-13 02:16:41	2020-05-13 02:16:41	\N
137	195	196	1	2020-05-13 02:17:11	2020-05-13 02:17:11	\N
138	198	197	1	2020-05-13 02:20:15	2020-05-13 02:20:15	\N
139	197	198	1	2020-05-13 02:20:22	2020-05-13 02:20:22	\N
140	200	199	1	2020-05-14 04:20:59	2020-05-14 04:20:59	\N
141	199	200	1	2020-05-14 04:21:17	2020-05-14 04:21:17	\N
142	202	201	1	2020-05-14 04:25:17	2020-05-14 04:25:17	\N
143	201	202	1	2020-05-14 04:25:34	2020-05-14 04:25:34	\N
144	204	203	1	2020-05-14 04:28:51	2020-05-14 04:28:51	\N
145	203	204	1	2020-05-14 04:29:05	2020-05-14 04:29:05	\N
146	205	206	1	2020-05-14 04:52:54	2020-05-14 04:52:54	\N
147	206	205	1	2020-05-14 04:53:00	2020-05-14 04:53:00	\N
148	208	209	1	2020-05-14 05:16:45	2020-05-14 05:16:45	\N
149	209	208	1	2020-05-14 05:16:52	2020-05-14 05:16:52	\N
150	211	210	1	2020-05-14 05:19:55	2020-05-14 05:19:55	\N
151	210	211	1	2020-05-14 05:20:05	2020-05-14 05:20:05	\N
152	214	213	1	2020-05-14 06:28:26	2020-05-14 06:28:26	\N
153	213	214	1	2020-05-14 06:28:32	2020-05-14 06:28:32	\N
154	216	215	1	2020-05-14 06:32:12	2020-05-14 06:32:12	\N
155	215	216	1	2020-05-14 06:32:20	2020-05-14 06:32:20	\N
156	218	217	1	2020-05-14 08:46:03	2020-05-14 08:46:03	\N
157	217	218	1	2020-05-14 08:46:09	2020-05-14 08:46:09	\N
262	268	267	1	2020-05-21 07:14:30	2020-05-21 07:14:30	\N
263	267	268	1	2020-05-21 07:14:35	2020-05-21 07:14:35	\N
266	278	280	1	2020-05-22 04:16:21	2020-05-22 04:16:21	\N
267	280	278	1	2020-05-22 04:18:20	2020-05-22 04:18:20	\N
432	319	320	1	2020-06-01 09:17:29	2020-06-01 09:17:29	j4XPrwBWFXS0HvCa45xbL4AEF5LOl6
433	320	319	1	2020-06-01 09:17:37	2020-06-01 09:17:37	j4XPrwBWFXS0HvCa45xbL4AEF5LOl6
180	244	240	1	2020-05-14 06:08:34	2020-05-14 06:08:34	\N
181	240	244	1	2020-05-14 06:08:41	2020-05-14 06:08:41	\N
184	247	246	1	2020-05-14 06:27:41	2020-05-14 06:27:41	\N
185	246	247	1	2020-05-14 06:27:52	2020-05-14 06:27:52	\N
448	312	311	1	2020-06-01 01:26:47	2020-06-01 01:26:47	jPGR5aNjlDVAM8OeCX8D7xXhcZ58Re
449	311	312	1	2020-06-01 01:27:16	2020-06-01 01:27:16	jPGR5aNjlDVAM8OeCX8D7xXhcZ58Re
306	264	261	1	2020-05-23 10:32:05	2020-05-23 10:32:05	\N
307	261	264	1	2020-05-23 10:32:14	2020-05-23 10:32:14	\N
310	307	289	1	2020-05-25 01:05:31	2020-05-25 01:05:31	\N
311	289	307	1	2020-05-25 01:06:29	2020-05-25 01:06:29	\N
388	323	324	1	2020-05-28 03:58:01	2020-05-28 03:58:01	MlFgzOyUvTRcj931x88nFMEg2wl9g7
389	324	323	1	2020-05-28 03:58:20	2020-05-28 03:58:20	MlFgzOyUvTRcj931x88nFMEg2wl9g7
234	255	256	1	2020-05-18 01:00:46	2020-05-18 01:00:46	\N
235	256	255	1	2020-05-18 01:00:51	2020-05-18 01:00:51	\N
322	302	301	1	2020-05-25 01:00:44	2020-05-25 01:00:44	UVmhcodU11juMlMWqMwiogfH5SJ4s3
323	301	302	1	2020-05-25 01:00:54	2020-05-25 01:00:54	UVmhcodU11juMlMWqMwiogfH5SJ4s3
242	254	249	1	2020-05-19 12:53:01	2020-05-19 12:53:01	\N
243	249	254	1	2020-05-19 12:53:05	2020-05-19 12:53:05	\N
409	325	326	1	2020-05-29 08:11:05	2020-05-29 08:11:05	UuYFszHp4wAJ9yDEFVPKuCCxJfFB02
410	326	325	1	2020-05-29 08:11:35	2020-05-29 08:11:35	UuYFszHp4wAJ9yDEFVPKuCCxJfFB02
414	328	327	1	2020-05-29 10:16:42	2020-05-29 10:16:42	WYmCL6Zf6oyNHd81LCIufctJ78MiMB
415	327	328	1	2020-05-29 10:17:03	2020-05-29 10:17:03	WYmCL6Zf6oyNHd81LCIufctJ78MiMB
500	126	275	1	2020-06-05 04:51:12	2020-06-05 04:51:12	p0sB584b4YIDHDDSq7PdwarIoXDaVE
501	275	126	1	2020-06-05 04:51:26	2020-06-05 04:51:26	p0sB584b4YIDHDDSq7PdwarIoXDaVE
502	340	339	1	2020-06-08 07:03:47	2020-06-08 07:03:47	DCgIYik24PBONO08M9gPkF19m585z8
503	339	340	1	2020-06-08 07:03:54	2020-06-08 07:03:54	DCgIYik24PBONO08M9gPkF19m585z8
504	334	335	1	2020-06-09 11:29:08	2020-06-09 11:29:08	UWvEbo0wjgQtdVMqUJyXJXXT9nPIaj
505	335	334	1	2020-06-09 11:29:16	2020-06-09 11:29:16	UWvEbo0wjgQtdVMqUJyXJXXT9nPIaj
506	344	343	1	2020-06-09 11:49:41	2020-06-09 11:49:41	XQPEcnXewoTb0nnCXWzyVsn5YCVw86
507	343	344	1	2020-06-09 11:49:48	2020-06-09 11:49:48	XQPEcnXewoTb0nnCXWzyVsn5YCVw86
510	345	346	1	2020-06-10 10:06:13	2020-06-10 10:06:13	grVxm0nYGHjTC3tJ2wjVoApd0ltkBi
511	346	345	1	2020-06-10 10:06:25	2020-06-10 10:06:25	grVxm0nYGHjTC3tJ2wjVoApd0ltkBi
520	349	348	1	2020-06-11 08:38:19	2020-06-11 08:38:19	OlEKtVfgZf0oqbavMMyPdMlno1rVIB
521	348	349	1	2020-06-11 08:38:20	2020-06-11 08:38:20	OlEKtVfgZf0oqbavMMyPdMlno1rVIB
524	342	341	1	2020-06-15 09:01:15	2020-06-15 09:01:15	uIzVYL1vieZiYEPKUJy1CSbHm6WEqA
525	341	342	1	2020-06-15 09:01:28	2020-06-15 09:01:28	uIzVYL1vieZiYEPKUJy1CSbHm6WEqA
526	363	362	1	2020-06-19 11:54:45	2020-06-19 11:54:45	ARA6Pc71FJcppjieMUDx91OvJNainf
527	362	363	1	2020-06-19 11:55:01	2020-06-19 11:55:01	ARA6Pc71FJcppjieMUDx91OvJNainf
530	366	127	1	2020-07-14 04:13:21	2020-07-14 04:13:21	\N
531	366	367	1	2020-07-14 04:19:59	2020-07-14 04:19:59	\N
532	368	366	1	2020-07-17 03:36:24	2020-07-17 03:36:24	lZIYrQBL6poQ3jZvaMTGLmRo5h9gMy
\.


--
-- Name: partner_mappings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.partner_mappings_id_seq', 532, true);


--
-- Data for Name: quickies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quickies (id, user_id, partner_mapping_id, partner_response, "when", "where", create_time, update_time, partner1_intrest, partner2_intrest, partner1_answer1, partner1_answer2, partner2_answer1, partner2_answer2, contribution) FROM stdin;
58	249	224	\N	10:00 AM	xhchchfh	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
43	249	225	t	10:25 AM	Dfgbdigigjvibic	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
3	249	224	\N	10:00 AM	Szdfdf	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
4	249	224	\N	10:00 AM	Szdfdf	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
5	249	224	\N	10:00 AM		2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
6	249	224	\N	10:00 AM		2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
7	249	224	\N	10:00 AM		2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
8	249	224	\N	10:00 AM		2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
9	249	224	\N	10:00 AM		2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
10	249	224	\N	10:00 AM		2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
12	254	225	\N	10:00 AM	Asdfsadas	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
13	254	225	\N	10:00 AM	Sdfdsfdsf	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
14	254	225	\N	10:00 AM	Sdasdasd	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
15	254	225	\N	10:00 AM	Jkhnjkhn	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
16	254	225	\N	10:00 AM	Dszfszf	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
17	254	225	\N	10:00 AM	Dszfszf	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
18	254	225	\N	10:00 AM	Gsg	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
19	254	225	\N	10:00 AM	Dzgvdxgv	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
20	254	225	\N	10:00 AM	Sfazfzf	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
21	254	225	\N	10:00 AM	Dgsxg	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
22	254	225	\N	10:00 AM	Szfszfzf	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
23	254	225	\N	10:00 AM	Asfasfa	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
24	254	225	\N	10:00 AM	Sgdsgdxg	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
25	254	225	\N	10:00 AM	Sdegsdzg	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
26	254	225	\N	10:00 AM	Asfasf	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
27	254	225	\N	10:00 AM	Sfgsfg	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
28	254	225	\N	10:00 AM	Dszfsdgsdg	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
29	254	225	\N	10:00 AM	Sgsdg	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
30	254	225	\N	10:00 AM	Sfsf	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
31	254	225	\N	10:00 AM	Fszfs	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
32	254	225	\N	10:00 AM	Zdzfszf	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
33	254	225	\N	08:10 PM	Sdfgsfgdsgdsgs	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
34	51	226	\N	Master Room	10:12 PM	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
35	254	225	\N	10:00 AM	Esdxgsdg	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
36	254	225	\N	10:00 AM	Dgdfgd	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
2	51	226	t	Master	12:29 PM	2020-05-16 08:23:34	2020-05-28 12:12:33	t	\N	\N	\N	\N	\N	\N
59	249	224	\N	10:00 AM	hjcjgjv	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
60	249	224	\N	10:00 AM	xhfhfjv	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
61	249	224	\N	10:00 AM	chfhjgj	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
62	249	224	\N	10:00 AM	xhfhfjvj	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
63	249	224	\N	10:00 AM	hfjgj	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
44	249	225	t	10:00 AM	Dgdghjjk	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
45	249	225	t	10:20 AM	Fgdfg	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
38	254	225	\N	10:00 AM	Dfghdfcgd	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
64	249	224	\N	10:00 AM	chfjv	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
65	249	224	\N	10:00 AM	hfjgjgjgj	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
66	249	224	\N	10:00 AM	chfjgjv	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
77	254	224	f	10:00 AM	gugjg	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
39	254	225	\N	10:00 AM	Sdgdsxg	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
41	254	225	\N	10:00 AM	Fhbcd	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
42	254	225	\N	10:00 AM	Sgdg	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
67	249	224	\N	10:00 AM	hgjvjv	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
68	249	224	\N	10:00 AM	jgjvjv	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
46	249	225	t	10:05 AM	Vjbkkbmnlnln	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
47	249	224	\N	10:00 AM	Scacac	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
48	249	224	\N	10:00 AM	Dbsbsvs	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
49	249	224	\N	10:00 AM	Dzbsbbsbsbsbsbdndndndndndndndndn	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
50	254	225	\N	10:00 AM	xhchggjihi	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
51	254	224	f	10:00 AM	Sbwbsbs	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
69	254	225	\N	10:00 AM	jvuvu	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
70	249	224	\N	10:00 AM	ghhjkk	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
71	249	224	\N	10:00 AM	gugugu	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
52	254	224	t	10:15 AM	Rhrhehehxjgjgjgjvjgjgugjgjg	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
72	249	224	f	10:00 AM	uguvjbjb	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
53	254	224	t	10:00 AM	xfhfhfu	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
73	249	224	f	10:00 AM	ugyugjg	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
54	254	224	f	10:00 AM	fhjfhf	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
55	249	224	\N	10:00 AM	chfhfjfj	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
56	249	224	\N	10:00 AM	fhfhfjf	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
57	249	224	\N	10:00 AM	vcchg	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
74	51	226	\N	Master Room	10:12 PM	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
78	249	224	\N	10:00 AM	jgjgjg	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
37	51	225	f	Master	10:12 PM	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
75	249	224	\N	10:00 AM	Hsjjs	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
76	249	225	f	10:00 AM	Bsjjs	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
79	254	224	f	10:00 AM	gugug	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
80	254	224	f	10:00 AM	gigjbih	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
81	249	224	\N	10:00 AM	gugugjg	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
82	249	225	f	10:00 AM	Jxjjs	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
83	254	225	\N	10:00 AM	Jxjjs	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
84	249	225	f	10:00 AM	Igvjb	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
85	249	225	t	10:00 AM	Igvjb	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
86	249	225	t	10:00 AM	Igvjb	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
87	249	225	f	10:00 AM	Igvjb	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
88	249	225	f	10:00 AM	Hsjjs	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
89	249	225	t	10:00 AM	Hsjjs	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
1	268	226	t	Master	10:12 PM	2020-05-15 02:03:35	2020-05-20 09:36:44	\N	\N	\N	\N	\N	\N	\N
11	254	225	\N	10:00 AM	Asasfaf	2020-05-16 08:23:34	2020-05-29 11:54:42	\N	\N	\N	\N	t	t	\N
40	52	225	t	10:11 AM	03:50 AM	2020-05-16 08:23:34	2020-06-04 09:51:11	\N	\N	\N	\N	\N	\N	\N
90	249	225	t	10:00 AM	Hsjjsvjvkbi	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
91	249	225	f	10:00 AM	Hsjjsvjvkbi	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
92	249	225	f	10:00 AM	Jdjdk	2020-05-16 08:23:34	2020-05-16 08:23:34	\N	\N	\N	\N	\N	\N	\N
93	255	233	f	10:00 AM	Hjgjg	2020-05-18 10:16:20	2020-05-18 10:16:20	\N	\N	\N	\N	\N	\N	\N
94	256	234	f	03:25 AM	Hsjjs	2020-05-18 01:14:03	2020-05-18 01:14:03	\N	\N	\N	\N	\N	\N	\N
95	256	234	t	03:25 AM	Hsjjs	2020-05-18 01:14:03	2020-05-18 01:14:03	\N	\N	\N	\N	\N	\N	\N
96	256	234	t	07:25 AM	Hsjjsvjvkbk	2020-05-18 01:14:03	2020-05-18 01:14:03	\N	\N	\N	\N	\N	\N	\N
97	256	234	f	07:25 AM	Hsjjsvjvkbkjvvjv	2020-05-18 01:14:03	2020-05-18 01:14:03	\N	\N	\N	\N	\N	\N	\N
98	256	234	f	01:25 AM	Hsjjsvjvkbkjvvjv	2020-05-18 01:14:03	2020-05-18 01:14:03	\N	\N	\N	\N	\N	\N	\N
99	256	234	f	01:25 AM	Hsjjsvjvkbkjvvjv	2020-05-18 01:14:03	2020-05-18 01:14:03	\N	\N	\N	\N	\N	\N	\N
100	256	234	t	05:25 AM	Hsjjsvjv	2020-05-18 01:14:03	2020-05-18 01:14:03	\N	\N	\N	\N	\N	\N	\N
101	256	234	t	05:25 AM	Hsjjsvjv	2020-05-18 01:14:03	2020-05-18 01:14:03	\N	\N	\N	\N	\N	\N	\N
102	256	234	t	05:25 AM	Hsjjsvjv	2020-05-18 01:14:03	2020-05-18 01:14:03	\N	\N	\N	\N	\N	\N	\N
103	256	234	t	07:25 AM	Hsjjsvjv	2020-05-18 01:14:03	2020-05-18 01:14:03	\N	\N	\N	\N	\N	\N	\N
104	256	234	f	04:25 AM	Hsjjsvjv	2020-05-18 01:14:03	2020-05-18 01:14:03	\N	\N	\N	\N	\N	\N	\N
105	255	234	\N	08:25 AM	Hsjjsvjv	2020-05-18 01:14:03	2020-05-18 01:14:03	\N	\N	\N	\N	\N	\N	\N
106	264	255	\N	Master Room	10:12 PM	2020-05-20 05:26:05	2020-05-20 05:26:05	\N	\N	\N	\N	\N	\N	\N
107	52	227	\N	Master Room	10:12 PM	2020-05-20 06:52:10	2020-05-20 06:52:10	\N	\N	\N	\N	\N	\N	\N
108	267	259	f	10:00 AM	Hsjjs	2020-05-20 07:32:36	2020-05-20 07:32:36	\N	\N	\N	\N	\N	\N	\N
109	268	258	t	03:25 AM	ygygug	2020-05-20 09:36:44	2020-05-20 09:36:44	\N	\N	\N	\N	\N	\N	\N
110	267	259	t	03:35 PM	Gjvkbkb	2020-05-20 09:36:44	2020-05-20 09:36:44	\N	\N	\N	\N	\N	\N	\N
111	267	259	t	03:45 AM	Gugkbln	2020-05-20 09:36:44	2020-05-20 09:36:44	\N	\N	\N	\N	\N	\N	\N
112	267	258	\N	10:00 AM	vjbu	2020-05-20 10:15:50	2020-05-20 10:15:50	\N	\N	\N	\N	\N	\N	\N
113	268	258	t	12:00 AM	igibi	2020-05-20 10:15:50	2020-05-20 10:15:50	\N	\N	\N	\N	\N	\N	\N
114	267	258	\N	12:00 AM	igibi	2020-05-20 10:15:50	2020-05-20 10:15:50	\N	\N	\N	\N	\N	\N	\N
115	268	258	t	10:00 AM	uguguhih	2020-05-20 10:15:50	2020-05-20 10:15:50	\N	\N	\N	\N	\N	\N	\N
116	267	259	t	10:00 AM	jgjbjb	2020-05-20 10:15:50	2020-05-20 10:15:50	\N	\N	\N	\N	\N	\N	\N
117	267	259	t	10:00 AM	ubuhuh	2020-05-20 10:15:50	2020-05-20 10:15:50	\N	\N	\N	\N	\N	\N	\N
118	267	259	t	10:00 AM	jvhvjvu	2020-05-20 10:15:50	2020-05-20 10:15:50	\N	\N	\N	\N	\N	\N	\N
119	267	259	t	10:00 AM	hvuv	2020-05-20 10:15:50	2020-05-20 10:15:50	\N	\N	\N	\N	\N	\N	\N
120	268	258	t	10:00 AM	Fff	2020-05-20 10:15:50	2020-05-20 10:15:50	\N	\N	\N	\N	\N	\N	\N
121	257	256	\N	10:00 AM	Hdhbdjdhd	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
122	257	256	\N	10:00 AM	Hdhbdjdhd	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
123	126	264	\N	10:00 AM	Home	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
124	257	256	\N	01:00 AM	     	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
125	266	256	f	01:00 AM	@	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
126	266	256	t	02:00 AM	@	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
127	266	256	f	02:00 AM	@	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
128	257	257	f	10:00 AM	T	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
129	257	256	\N	10:00 AM	Test	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
130	261	254	\N	10:00 AM	 	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
131	261	254	\N	10:00 AM	 	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
132	261	254	\N	10:00 AM	 Faesfa	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
133	280	267	\N	10:00 AM	Bathroom	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
134	280	267	\N	10:00 AM	Bathroom	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
135	280	267	\N	11:00 AM	Bathroom	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
136	278	266	\N	12:00 AM	Vath	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
137	261	254	\N	10:14 AM	Kjk	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
138	261	254	\N	11:19 AM	Adcfadsf	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
139	261	254	\N	11:19 AM	Sdfds	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
140	261	254	\N	12:00 AM	Rgg	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
141	261	271	\N	12:32 PM	Sfsf	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
142	289	275	\N	10:00 AM	T	2020-05-21 12:38:49	2020-05-21 12:38:49	\N	\N	\N	\N	\N	\N	\N
143	289	275	\N	12:00 AM	T	2020-05-22 08:52:23	2020-05-22 08:52:23	\N	\N	\N	\N	\N	\N	\N
144	285	276	\N	10:00 AM	Flat	2020-05-22 08:52:23	2020-05-22 08:52:23	\N	\N	\N	\N	\N	\N	\N
145	285	276	\N	12:00 AM	Flat	2020-05-22 08:52:23	2020-05-22 08:52:23	\N	\N	\N	\N	\N	\N	\N
146	285	276	\N	12:00 AM	Flat	2020-05-22 08:52:23	2020-05-22 08:52:23	\N	\N	\N	\N	\N	\N	\N
147	285	276	\N	12:00 AM	Flat	2020-05-22 08:52:23	2020-05-22 08:52:23	\N	\N	\N	\N	\N	\N	\N
148	293	277	\N	10:00 AM	Flat	2020-05-22 08:52:23	2020-05-22 08:52:23	\N	\N	\N	\N	\N	\N	\N
149	285	276	\N	12:00 AM	Flat	2020-05-22 08:52:23	2020-05-22 08:52:23	\N	\N	\N	\N	\N	\N	\N
150	285	276	\N	01:00 AM	Flat	2020-05-22 08:52:23	2020-05-22 08:52:23	\N	\N	\N	\N	\N	\N	\N
151	285	276	\N	01:00 AM	Flat	2020-05-22 08:52:23	2020-05-22 08:52:23	\N	\N	\N	\N	\N	\N	\N
152	52	227	\N	Master Room	10:12 PM	2020-05-22 10:17:43	2020-05-22 10:17:43	\N	\N	\N	\N	\N	\N	\N
153	257	257	f	01:00 AM	Flat	2020-05-22 10:17:43	2020-05-22 10:17:43	\N	\N	\N	\N	\N	\N	\N
154	266	256	f	10:00 AM	Test	2020-05-22 10:17:43	2020-05-22 10:17:43	\N	\N	\N	\N	\N	\N	\N
155	266	256	t	01:00 AM	Testhuuh	2020-05-22 10:17:43	2020-05-22 10:17:43	\N	\N	\N	\N	\N	\N	\N
156	257	256	\N	01:00 AM	Testhuuh	2020-05-22 10:17:43	2020-05-22 10:17:43	\N	\N	\N	\N	\N	\N	\N
157	264	291	t	10:00 AM	Efreawrghjh	2020-05-22 10:17:43	2020-05-22 10:17:43	\N	\N	\N	\N	\N	\N	\N
158	264	291	f	10:00 AM	Sdfs	2020-05-22 10:17:43	2020-05-22 10:17:43	\N	\N	\N	\N	\N	\N	\N
159	261	290	f	10:00 AM	Jkgh	2020-05-22 10:17:43	2020-05-22 10:17:43	\N	\N	\N	\N	\N	\N	\N
161	289	293	\N	10:00 AM	F	2020-05-22 10:17:43	2020-05-22 10:17:43	\N	\N	\N	\N	\N	\N	\N
160	298	293	f	10:00 AM	F	2020-05-22 10:17:43	2020-05-22 10:17:43	\N	\N	\N	\N	\N	\N	\N
162	298	293	t	10:00 AM	Fa	2020-05-22 10:17:43	2020-05-22 10:17:43	\N	\N	\N	\N	\N	\N	\N
163	298	293	t	10:00 AM	Fa	2020-05-22 10:17:43	2020-05-22 10:17:43	\N	\N	\N	\N	\N	\N	\N
164	298	293	t	10:00 AM	Fa	2020-05-22 10:17:43	2020-05-22 10:17:43	\N	\N	\N	\N	\N	\N	\N
165	298	293	t	10:00 AM	Faa	2020-05-22 10:17:43	2020-05-22 10:17:43	\N	\N	\N	\N	\N	\N	\N
166	298	293	t	10:00 AM	Faa	2020-05-22 10:17:43	2020-05-22 10:17:43	\N	\N	\N	\N	\N	\N	\N
167	298	293	t	10:00 AM	Faa	2020-05-22 10:17:43	2020-05-22 10:17:43	\N	\N	\N	\N	\N	\N	\N
168	298	293	t	10:00 AM	Faa	2020-05-22 10:17:43	2020-05-22 10:17:43	\N	\N	\N	\N	\N	\N	\N
169	298	293	t	10:00 AM	Faa	2020-05-22 10:17:43	2020-05-22 10:17:43	\N	\N	\N	\N	\N	\N	\N
170	298	293	t	10:00 AM	Faa	2020-05-22 10:17:43	2020-05-22 10:17:43	\N	\N	\N	\N	\N	\N	\N
171	298	293	t	10:00 AM	Faa	2020-05-22 10:17:43	2020-05-22 10:17:43	\N	\N	\N	\N	\N	\N	\N
172	289	293	\N	10:00 AM	Faa	2020-05-22 01:16:18	2020-05-22 01:16:18	\N	\N	\N	\N	\N	\N	\N
173	261	295	\N	10:00 AM	Dfsdf	2020-05-22 01:16:18	2020-05-22 01:16:18	\N	\N	\N	\N	\N	\N	\N
174	261	295	\N	10:00 AM	Fdeaf	2020-05-22 01:16:18	2020-05-22 01:16:18	\N	\N	\N	\N	\N	\N	\N
175	289	298	t	10:00 AM	Q	2020-05-22 04:20:34	2020-05-22 04:20:34	\N	\N	\N	\N	\N	\N	\N
176	289	298	f	10:00 AM	Q	2020-05-22 04:20:34	2020-05-22 04:20:34	\N	\N	\N	\N	\N	\N	\N
177	289	298	f	10:00 AM	Q	2020-05-22 04:20:34	2020-05-22 04:20:34	\N	\N	\N	\N	\N	\N	\N
179	300	298	\N	10:00 AM	Bathroom	2020-05-22 04:20:34	2020-05-22 04:20:34	\N	\N	\N	\N	\N	\N	\N
178	289	298	f	10:00 AM	Q	2020-05-22 04:20:34	2020-05-22 04:20:34	\N	\N	\N	\N	\N	\N	\N
180	289	298	t	10:00 AM	Bathroom	2020-05-22 04:20:34	2020-05-22 04:20:34	\N	\N	\N	\N	\N	\N	\N
181	289	298	t	10:00 AM	Bathroom	2020-05-22 04:20:34	2020-05-22 04:20:34	\N	\N	\N	\N	\N	\N	\N
182	266	256	t	10:00 AM	Ths	2020-05-22 04:20:34	2020-05-22 04:20:34	\N	\N	\N	\N	\N	\N	\N
183	261	296	f	10:00 AM	rcrcr	2020-05-22 04:20:34	2020-05-22 04:20:34	\N	\N	\N	\N	\N	\N	\N
184	261	296	t	11:00 AM	jfhg	2020-05-22 04:20:34	2020-05-22 04:20:34	\N	\N	\N	\N	\N	\N	\N
185	261	296	f	10:00 AM	jvkvkg	2020-05-22 04:20:34	2020-05-22 04:20:34	\N	\N	\N	\N	\N	\N	\N
196	289	310	t	10:00 AM	U	2020-05-23 09:56:11	2020-05-23 09:56:11	\N	\N	\N	\N	\N	\N	\N
186	264	296	f	10:00 AM	vjgigkhkb	2020-05-22 04:20:34	2020-05-22 04:20:34	\N	\N	\N	\N	\N	\N	\N
187	264	296	t	11:00 AM	gugih	2020-05-22 04:20:34	2020-05-22 04:20:34	\N	\N	\N	\N	\N	\N	\N
188	301	305	f	09:05 AM	Vjgjg	2020-05-22 04:20:34	2020-05-22 04:20:34	\N	\N	\N	\N	\N	\N	\N
189	302	304	t	04:00 AM	vjvjh	2020-05-22 04:20:34	2020-05-22 04:20:34	\N	\N	\N	\N	\N	\N	\N
190	302	305	t	08:00 AM	Hfjfughh	2020-05-22 04:20:34	2020-05-22 04:20:34	\N	\N	\N	\N	\N	\N	\N
191	301	304	f	09:00 AM	jhihi	2020-05-22 04:20:34	2020-05-22 04:20:34	\N	\N	\N	\N	\N	\N	\N
192	301	305	t	10:00 AM	Igjgj	2020-05-22 04:20:34	2020-05-22 04:20:34	\N	\N	\N	\N	\N	\N	\N
193	301	305	f	10:00 AM	Hchfhv	2020-05-22 04:20:34	2020-05-22 04:20:34	\N	\N	\N	\N	\N	\N	\N
197	308	313	f	10:00 AM	Bathroom	2020-05-23 09:56:11	2020-05-23 09:56:11	\N	\N	\N	\N	\N	\N	\N
194	302	305	t	08:00 AM	Gjgjhhjjk	2020-05-22 04:20:34	2020-05-22 04:20:34	\N	\N	\N	\N	\N	\N	\N
195	289	310	t	10:00 AM	T	2020-05-23 09:56:11	2020-05-23 09:56:11	\N	\N	\N	\N	\N	\N	\N
215	312	333	t	11:00 AM	jgjghcghjj	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
199	308	316	\N	10:00 AM	Hyfb	2020-05-23 09:56:11	2020-05-23 09:56:11	\N	\N	\N	\N	\N	\N	\N
198	308	313	t	10:00 AM	Bathroom	2020-05-23 09:56:11	2020-05-23 09:56:11	\N	\N	\N	\N	\N	\N	\N
200	266	316	t	10:00 AM	Sff	2020-05-23 09:56:11	2020-05-23 09:56:11	\N	\N	\N	\N	\N	\N	\N
201	308	317	t	10:00 AM	Changes	2020-05-23 09:56:11	2020-05-23 09:56:11	\N	\N	\N	\N	\N	\N	\N
202	313	326	t	10:00 AM	E	2020-05-25 01:48:57	2020-05-25 01:48:57	\N	\N	\N	\N	\N	\N	\N
203	309	327	f	10:00 AM	T	2020-05-25 01:48:57	2020-05-25 01:48:57	\N	\N	\N	\N	\N	\N	\N
204	309	327	f	10:00 AM	G	2020-05-25 01:48:57	2020-05-25 01:48:57	\N	\N	\N	\N	\N	\N	\N
216	312	333	t	11:00 AM	jgjghcghjj	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
205	309	326	t	10:00 AM	Rr	2020-05-25 01:48:57	2020-05-25 01:48:57	\N	\N	\N	\N	\N	\N	\N
206	51	226	\N	12:10 AM	Vhk	2020-05-25 01:48:57	2020-05-25 01:48:57	\N	\N	\N	\N	\N	\N	\N
207	51	226	t	12:35 AM	Njs	2020-05-26 10:23:35	2020-05-26 10:23:35	\N	\N	\N	\N	\N	\N	\N
208	314	328	\N	10:00 AM	Test	2020-05-26 10:23:35	2020-05-26 10:23:35	\N	\N	\N	\N	\N	\N	\N
209	285	328	f	10:00 AM	Thf	2020-05-26 10:23:35	2020-05-26 10:23:35	\N	\N	\N	\N	\N	\N	\N
210	314	331	f	10:00 AM	Hcfv	2020-05-26 10:23:35	2020-05-26 10:23:35	\N	\N	\N	\N	\N	\N	\N
211	314	328	t	12:00 AM	Ghh CC cdsy	2020-05-26 10:23:35	2020-05-26 10:23:35	\N	\N	\N	\N	\N	\N	\N
212	311	332	f	10:00 AM	Hkjhkjh	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
213	311	332	t	10:00 AM	jgjgjvj	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
217	312	333	f	10:00 AM	Hfhfj	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
214	312	332	f	11:00 AM	jgjghc	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
218	312	333	t	10:00 AM	Hfhfjhfhdjf	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
219	312	333	f	10:00 AM	Xnndk	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
220	312	333	t	10:00 AM	Xnndkjdjdjd	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
221	311	332	f	10:00 AM	jgjjgjv	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
222	311	332	f	10:00 AM	igibjv	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
223	311	332	f	10:00 AM	ugigjgjg	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
224	311	332	f	10:00 AM	gugkhk	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
225	311	332	t	08:00 AM	gugkhkhhjjkkk	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
226	311	332	f	10:00 AM	nvjgjg	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
227	312	333	f	10:00 AM	Jsjsj	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
228	312	333	t	09:00 AM	Jsjsjhzbbs	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
229	311	332	f	10:00 AM	fhfhfj	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
231	311	333	t	10:00 AM	fhfhfj	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
230	312	332	f	08:00 AM	fhfhfj	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
232	312	333	f	10:00 AM	Hdhfhd	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
233	312	333	f	09:00 AM	Hdhfhdhcjdjf	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
234	311	333	t	09:00 AM	Hdhfhdhcjdjf	2020-05-26 01:00:59	2020-05-26 01:00:59	\N	\N	\N	\N	\N	\N	\N
235	317	335	t	10:00 AM	G	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
237	319	341	\N	10:00 AM	Test	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
236	309	335	t	10:00 AM	 Tq	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
238	319	354	t	12:00 AM	In public	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
239	320	354	f	10:00 AM	In shop	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
240	320	354	t	10:00 AM	In shop	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
241	320	354	f	10:00 AM	Ohe	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
242	320	354	t	10:00 AM	Icuf	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
290	311	383	t	10:00 AM	Ugibnk	2020-05-27 02:11:34	2020-05-27 02:11:34	\N	\N	\N	\N	\N	\N	\N
243	319	354	f	12:00 AM	Oysoyd	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
244	319	355	t	01:00 AM	Oysoyd	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
245	320	354	f	10:00 AM	Vyg	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
246	320	354	f	10:00 AM	Vyg	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
247	319	355	f	10:00 AM	Cxcd	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
248	311	353	\N	10:00 AM	Rsdfsff	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
249	311	353	\N	10:00 AM	Sfaszfaszf	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
250	312	357	f	10:00 AM	Fsgdsg	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
251	311	357	\N	10:00 AM	Sdfsfdf	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
252	312	364	f	10:00 AM	Jgkgkvjjv	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
253	312	364	f	10:00 AM	Jfjgjvm	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
254	312	364	t	10:00 AM	Jgjgjvk	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
255	312	364	t	10:00 AM	Jgkgkv	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
256	312	364	t	09:00 AM	Jgjvjv	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
257	312	364	t	11:00 AM	Fjvmvmv	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
291	311	391	\N	10:00 AM	Efsfsff	2020-05-27 02:11:34	2020-05-27 02:11:34	\N	\N	\N	\N	\N	\N	\N
258	312	365	f	09:00 AM	nvnvnv	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
259	312	365	f	09:00 AM	fhfhf	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
292	311	390	t	05:35 AM	Awfafaf	2020-05-28 11:31:04	2020-05-28 11:31:04	\N	\N	\N	\N	\N	\N	\N
260	312	365	t	10:00 AM	vngjvhfjgjg	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
293	312	390	\N	05:40 AM	Asfafasdf	2020-05-28 11:31:04	2020-05-28 11:31:04	\N	\N	\N	\N	\N	\N	\N
261	312	365	t	08:00 AM	ncngng	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
262	312	364	f	10:00 AM	Kgkbkv	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
263	311	364	\N	10:00 AM	Kgkbkv	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
264	311	365	f	10:00 AM	jfjgjv	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
265	312	365	\N	10:00 AM	jfjgjv	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
266	312	365	\N	10:00 AM	jfjgjv	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
267	311	365	f	10:00 AM	hfjgj	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
268	312	365	\N	10:00 AM	hfjgj	2020-05-26 05:40:55	2020-05-26 05:40:55	\N	\N	\N	\N	\N	\N	\N
269	312	365	\N	10:00 AM	Rffghh	2020-05-27 01:24:42	2020-05-27 01:24:42	\N	\N	\N	\N	\N	\N	\N
270	312	365	\N	10:00 AM	Sfsdfsdfg	2020-05-27 01:24:42	2020-05-27 01:24:42	\N	\N	\N	\N	\N	\N	\N
271	312	365	\N	10:00 AM	Fdsff	2020-05-27 01:24:42	2020-05-27 01:24:42	\N	\N	\N	\N	\N	\N	\N
272	312	365	\N	10:00 AM	Faszfazf	2020-05-27 01:24:42	2020-05-27 01:24:42	\N	\N	\N	\N	\N	\N	\N
273	312	365	\N	10:00 AM	Sdfsfsf	2020-05-27 01:24:42	2020-05-27 01:24:42	\N	\N	\N	\N	\N	\N	\N
274	311	376	f	10:00 AM	nvkgjg	2020-05-27 02:11:34	2020-05-27 02:11:34	\N	\N	\N	\N	\N	\N	\N
275	311	376	f	10:00 AM	vnvkgkg	2020-05-27 02:11:34	2020-05-27 02:11:34	\N	\N	\N	\N	\N	\N	\N
276	311	378	\N	10:00 AM	Jgjgjvjvv	2020-05-27 02:11:34	2020-05-27 02:11:34	\N	\N	\N	\N	\N	\N	\N
277	311	379	f	10:00 AM	fhfnvnvncn	2020-05-27 02:11:34	2020-05-27 02:11:34	\N	\N	\N	\N	\N	\N	\N
278	311	378	\N	10:00 AM	Jfjgkgj	2020-05-27 02:11:34	2020-05-27 02:11:34	\N	\N	\N	\N	\N	\N	\N
279	312	379	\N	10:00 AM	fjncncnc	2020-05-27 02:11:34	2020-05-27 02:11:34	\N	\N	\N	\N	\N	\N	\N
280	312	378	f	10:00 AM	Kgkgkggj	2020-05-27 02:11:34	2020-05-27 02:11:34	\N	\N	\N	\N	\N	\N	\N
281	311	378	\N	10:00 AM	Jgjvjv	2020-05-27 02:11:34	2020-05-27 02:11:34	\N	\N	\N	\N	\N	\N	\N
282	322	387	t	10:00 AM	V	2020-05-27 02:11:34	2020-05-27 02:11:34	\N	\N	\N	\N	\N	\N	\N
283	317	386	f	11:00 AM	R	2020-05-27 02:11:34	2020-05-27 02:11:34	\N	\N	\N	\N	\N	\N	\N
284	317	386	t	11:00 AM	Rq	2020-05-27 02:11:34	2020-05-27 02:11:34	\N	\N	\N	\N	\N	\N	\N
285	317	386	t	11:00 PM	Q	2020-05-27 02:11:34	2020-05-27 02:11:34	\N	\N	\N	\N	\N	\N	\N
286	311	382	\N	10:00 AM	Hcvnvkb	2020-05-27 02:11:34	2020-05-27 02:11:34	\N	\N	\N	\N	\N	\N	\N
287	312	383	\N	10:00 AM	Hcjbkb	2020-05-27 02:11:34	2020-05-27 02:11:34	\N	\N	\N	\N	\N	\N	\N
288	311	383	f	10:00 AM	Jgjv in	2020-05-27 02:11:34	2020-05-27 02:11:34	\N	\N	\N	\N	\N	\N	\N
289	312	383	\N	10:00 AM	Hfjvjjb	2020-05-27 02:11:34	2020-05-27 02:11:34	\N	\N	\N	\N	\N	\N	\N
294	311	390	t	05:40 PM	Fafaf	2020-05-28 11:31:04	2020-05-28 11:31:04	\N	\N	\N	\N	\N	\N	\N
295	311	390	t	05:45 PM	Sdadad	2020-05-28 11:31:04	2020-05-28 11:31:04	\N	\N	\N	\N	\N	\N	\N
306	311	391	\N	12:50 PM	Afssafas	2020-05-28 12:14:12	2020-05-28 12:14:12	\N	\N	\N	\N	\N	\N	\N
296	312	391	t	12:30 PM	Fadsfsdf	2020-05-28 12:08:28	2020-05-28 12:08:28	\N	\N	\N	\N	\N	\N	\N
297	311	391	\N	12:35 PM	Asfafaf	2020-05-28 12:14:12	2020-05-28 12:14:12	\N	\N	\N	\N	\N	\N	\N
298	311	391	\N	12:40 PM	Afafaf	2020-05-28 12:14:12	2020-05-28 12:14:12	\N	\N	\N	\N	\N	\N	\N
299	320	354	f	10:00 AM	Rdsx	2020-05-28 12:14:12	2020-05-28 12:14:12	\N	\N	\N	\N	\N	\N	\N
300	312	391	t	12:40 PM	Asfsafasf	2020-05-28 12:14:12	2020-05-28 12:14:12	\N	\N	\N	\N	\N	\N	\N
301	320	354	f	12:00 PM	Rdsxjshshsbnsysgshsbsjsksisjsgegbensjshsshhehejsisyshebsjsjusuddhbsnsnsjxjzjssbshshshehehsbsbsbhshshshdyhxbdnsnsjzjzhzhdbsbshshshsjsushhehshshshshhshshshsbsbsbsb	2020-05-28 12:14:12	2020-05-28 12:14:12	\N	\N	\N	\N	\N	\N	\N
302	311	391	\N	12:40 PM	Adfrafrafr	2020-05-28 12:14:12	2020-05-28 12:14:12	\N	\N	\N	\N	\N	\N	\N
303	311	391	\N	12:45 PM	Sdgsgg	2020-05-28 12:14:12	2020-05-28 12:14:12	\N	\N	\N	\N	\N	\N	\N
305	311	391	\N	12:45 PM	Asfasf	2020-05-28 12:14:12	2020-05-28 12:14:12	\N	\N	\N	\N	\N	\N	\N
307	312	391	t	12:50 PM	Dadasd	2020-05-28 12:14:12	2020-05-28 12:14:12	\N	\N	\N	\N	\N	\N	\N
304	319	354	f	10:00 AM	Testtesrtrefstrvdhtvdhyvdhvjfu	2020-05-28 12:14:12	2020-05-28 12:14:12	\N	\N	\N	\N	\N	\N	\N
315	312	391	t	01:10 PM	Gtsgtsgt	2020-05-28 12:55:52	2020-06-03 10:39:50	t	\N	t	f	\N	\N	\N
308	320	354	f	10:00 AM	Hsgdnehdjshshdjsbejdhejdbejebe	2020-05-28 12:14:12	2020-05-28 12:43:28	\N	\N	\N	\N	\N	\N	\N
310	312	391	t	01:05 PM	Safaf	2020-05-28 12:43:28	2020-05-28 12:43:28	\N	\N	\N	\N	\N	\N	\N
311	312	391	t	01:00 PM	Afadsf	2020-05-28 12:47:10	2020-05-28 12:47:10	\N	\N	\N	\N	\N	\N	\N
312	312	391	t	01:05 PM	Afafg	2020-05-28 12:50:08	2020-05-28 12:50:08	\N	\N	\N	\N	\N	\N	\N
313	312	391	t	01:10 PM	Fbhdfbh	2020-05-28 12:50:58	2020-05-28 12:50:58	\N	\N	\N	\N	\N	\N	\N
314	312	391	t	01:10 PM	Afafrafr	2020-05-28 12:55:52	2020-05-28 12:55:52	t	\N	\N	\N	\N	\N	\N
309	312	391	t	01:00 PM	Asfasfas	2020-05-28 12:14:12	2020-06-09 10:48:42	\N	t	t	t	t	f	1
316	312	391	t	01:05 PM	Dgsgs	2020-05-28 12:55:52	2020-05-28 12:55:52	f	\N	\N	\N	\N	\N	\N
317	311	390	t	01:20 PM	jvjvjv	2020-05-28 12:55:52	2020-05-28 12:55:52	t	\N	\N	\N	\N	\N	\N
318	311	390	t	01:25 PM	jvkgkh	2020-05-28 12:55:52	2020-05-28 12:55:52	\N	\N	\N	\N	\N	\N	\N
319	312	391	f	04:30 AM	Hxjxjxj	2020-05-28 12:55:52	2020-05-28 12:55:52	\N	\N	\N	\N	\N	\N	\N
320	312	391	t	04:30 AM	Hxjxjxj	2020-05-28 12:55:52	2020-05-28 12:55:52	\N	\N	\N	\N	\N	\N	\N
321	312	391	t	04:30 AM	Hxjdjd	2020-05-28 12:55:52	2020-05-28 12:55:52	\N	\N	\N	\N	\N	\N	\N
322	312	391	t	04:30 PM	Hfjcn	2020-05-28 12:55:52	2020-05-28 12:55:52	\N	\N	\N	\N	\N	\N	\N
323	312	391	f	04:30 PM	Udjdndj	2020-05-28 12:55:52	2020-05-28 12:55:52	\N	\N	\N	\N	\N	\N	\N
324	311	391	t	05:30 PM	Uejdnd	2020-05-28 12:55:52	2020-05-28 12:55:52	\N	\N	\N	\N	\N	\N	\N
371	330	464	t	07:00 AM	Bathroom	2020-06-03 06:24:18	2020-06-03 06:24:18	\N	\N	\N	\N	\N	\N	\N
325	312	391	t	01:30 PM	Hcjcjc	2020-05-28 12:55:52	2020-05-28 12:55:52	t	f	\N	\N	\N	\N	\N
326	326	409	t	08:20 AM	Q	2020-05-28 01:17:52	2020-05-28 01:17:52	\N	\N	\N	\N	\N	\N	\N
356	312	440	t	06:30 AM	Ihknkn	2020-06-01 11:11:54	2020-06-01 11:11:54	t	\N	\N	\N	\N	\N	\N
328	325	409	t	01:30 PM	Aaaaa	2020-05-28 01:17:52	2020-05-28 01:17:52	\N	\N	\N	\N	\N	\N	\N
327	326	409	t	08:45 AM	Q	2020-05-28 01:17:52	2020-05-28 01:17:52	t	t	\N	\N	\N	\N	\N
329	52	227	\N	Master Room	10:12 PM	2020-05-29 11:52:51	2020-05-29 11:52:51	\N	\N	\N	\N	\N	\N	\N
330	320	424	f	09:30 PM	Hfhv	2020-05-30 07:26:11	2020-05-30 07:26:11	\N	\N	\N	\N	\N	\N	\N
331	320	424	t	09:45 AM	Hfhv	2020-05-30 07:26:11	2020-05-30 07:26:11	\N	\N	\N	\N	\N	\N	\N
357	311	447	t	12:40 PM	Hzhz	2020-06-01 11:11:54	2020-06-01 11:11:54	f	\N	\N	\N	\N	\N	\N
332	312	429	t	09:20 AM	Sdgdgdgd	2020-05-30 07:26:11	2020-05-30 07:26:11	t	\N	t	f	\N	\N	\N
358	311	449	\N	02:00 AM	hfhfhf	2020-06-01 11:11:54	2020-06-01 11:11:54	\N	\N	\N	\N	\N	\N	\N
333	312	441	t	10:25 AM	Gdfxgdfg	2020-05-30 07:26:11	2020-05-30 07:26:11	t	\N	\N	\N	\N	\N	\N
334	311	440	t	10:40 AM	fjgjvnvnnvjv	2020-05-30 07:26:11	2020-05-30 07:26:11	\N	\N	\N	\N	\N	\N	\N
335	311	440	t	10:40 AM	jgjgjv	2020-05-30 07:26:11	2020-05-30 07:26:11	\N	\N	\N	\N	\N	\N	\N
336	311	440	f	10:40 AM	gjgjv	2020-05-30 07:26:11	2020-05-30 07:26:11	\N	\N	\N	\N	\N	\N	\N
337	311	440	f	10:45 AM	gjgjv	2020-05-30 07:26:11	2020-05-30 07:26:11	\N	\N	\N	\N	\N	\N	\N
339	311	440	t	04:30 AM	bfbchc	2020-05-30 07:26:11	2020-05-30 07:26:11	t	\N	\N	\N	\N	\N	\N
340	312	440	t	05:30 AM	cjgjv	2020-05-30 07:26:11	2020-05-30 07:26:11	\N	\N	\N	\N	\N	\N	\N
359	312	449	t	02:00 AM	bfbfjg	2020-06-01 11:11:54	2020-06-01 11:11:54	t	t	\N	\N	\N	\N	\N
341	312	440	f	04:30 PM	jghvbc	2020-05-30 07:26:11	2020-05-30 07:26:11	\N	\N	\N	\N	\N	\N	\N
342	311	440	t	10:40 AM	jfjgjv	2020-05-30 07:26:11	2020-05-30 07:26:11	\N	\N	\N	\N	\N	\N	\N
360	332	452	\N	04:30 AM	Test	2020-06-02 08:44:28	2020-06-02 08:44:28	\N	\N	\N	\N	\N	\N	\N
338	311	440	t	10:45 AM	gjgjv	2020-05-30 07:26:11	2020-05-30 07:26:11	t	t	\N	\N	\N	\N	\N
343	312	440	\N	05:30 PM	gugjc	2020-06-01 10:53:11	2020-06-01 10:53:11	\N	\N	\N	\N	\N	\N	\N
344	312	440	\N	04:30 PM	bcfbc	2020-06-01 10:56:07	2020-06-01 10:56:07	\N	\N	\N	\N	\N	\N	\N
345	312	440	\N	04:30 PM	nvnvnv	2020-06-01 10:56:07	2020-06-01 10:56:07	\N	\N	\N	\N	\N	\N	\N
346	312	440	\N	04:30 PM	bcnvnv	2020-06-01 10:56:07	2020-06-01 10:56:07	\N	\N	\N	\N	\N	\N	\N
348	311	440	f	04:30 PM	ufhfhf	2020-06-01 11:11:54	2020-06-01 11:11:54	\N	\N	\N	\N	\N	\N	\N
349	312	441	t	04:30 PM	Hxjdjd	2020-06-01 11:11:54	2020-06-01 11:11:54	\N	\N	\N	\N	\N	\N	\N
350	312	441	f	04:30 PM	Jvjbb	2020-06-01 11:11:54	2020-06-01 11:11:54	\N	\N	\N	\N	\N	\N	\N
351	312	441	t	04:30 PM	Jvjbb	2020-06-01 11:11:54	2020-06-01 11:11:54	\N	\N	\N	\N	\N	\N	\N
361	330	453	\N	11:50 AM	Bathroom	2020-06-02 09:30:22	2020-06-02 09:30:22	\N	\N	\N	\N	\N	\N	\N
352	311	441	t	05:30 PM	Cvhj	2020-06-01 11:11:54	2020-06-01 11:11:54	\N	\N	\N	\N	\N	\N	\N
362	332	452	\N	11:50 AM	Bathroom	2020-06-02 09:30:22	2020-06-02 09:30:22	\N	\N	\N	\N	\N	\N	\N
363	330	453	\N	11:55 AM	Hfvhgv	2020-06-02 09:30:22	2020-06-02 09:30:22	\N	\N	\N	\N	\N	\N	\N
353	312	441	t	12:00 PM	jfgjv	2020-06-01 11:11:54	2020-06-01 11:11:54	t	t	\N	\N	\N	\N	\N
354	312	441	t	04:30 PM	cjfhf	2020-06-01 11:11:54	2020-06-01 11:11:54	\N	\N	\N	\N	\N	\N	\N
355	311	440	f	04:30 PM	Ihknkn	2020-06-01 11:11:54	2020-06-01 11:11:54	\N	\N	\N	\N	\N	\N	\N
386	332	478	t	10:10 AM	Bdhdbd	2020-06-03 08:24:50	2020-06-03 08:24:50	t	t	\N	\N	\N	\N	\N
364	332	453	t	12:30 PM	Vfuc g	2020-06-02 09:30:22	2020-06-02 09:30:22	\N	t	\N	\N	t	t	\N
378	311	448	t	09:20 AM	dhfbcbc	2020-06-03 08:24:50	2020-06-03 08:24:50	f	t	\N	\N	\N	\N	\N
372	332	467	t	07:40 AM	Bathroom	2020-06-03 06:24:18	2020-06-03 06:24:18	t	t	\N	\N	\N	\N	\N
365	330	452	t	03:30 AM	Test	2020-06-02 09:30:22	2020-06-02 09:30:22	f	t	\N	\N	\N	\N	\N
373	311	448	t	07:45 AM	ngnfjg	2020-06-03 06:24:18	2020-06-03 06:24:18	\N	t	\N	\N	\N	\N	\N
366	332	453	t	04:15 AM	Hctbbc	2020-06-02 09:30:22	2020-06-02 09:30:22	\N	t	\N	\N	\N	\N	\N
367	332	454	t	04:30 AM	Bathroom	2020-06-02 09:30:22	2020-06-02 09:30:22	\N	\N	\N	\N	\N	\N	\N
374	311	448	t	07:45 AM	cjvnvnv	2020-06-03 06:24:18	2020-06-03 06:24:18	t	\N	\N	\N	\N	\N	\N
368	52	226	t	Master	12:29 PM	2020-06-03 05:46:12	2020-06-03 05:46:12	t	\N	\N	\N	\N	\N	\N
369	332	463	t	06:35 AM	Bathroom	2020-06-03 06:01:48	2020-06-03 06:24:18	t	t	\N	\N	\N	\N	\N
383	311	448	t	09:20 AM	hfhcbc	2020-06-03 08:24:50	2020-06-03 08:24:50	t	t	\N	\N	\N	\N	\N
375	332	468	t	08:20 AM	Bathroom	2020-06-03 07:59:35	2020-06-03 07:59:35	t	t	\N	\N	\N	\N	\N
379	312	449	t	09:25 AM	Ihhkbkn	2020-06-03 08:24:50	2020-06-03 08:24:50	t	t	\N	\N	\N	\N	\N
376	332	471	t	08:50 AM	Hsvshsb	2020-06-03 08:24:50	2020-06-03 08:24:50	f	f	\N	\N	\N	\N	\N
377	332	472	t	09:10 AM	Bshsvs	2020-06-03 08:24:50	2020-06-03 08:24:50	\N	f	\N	\N	\N	\N	\N
381	311	448	t	09:15 PM	vdbfnc	2020-06-03 08:24:50	2020-06-03 08:24:50	\N	\N	\N	\N	\N	\N	\N
384	332	477	f	09:40 AM	Hftv	2020-06-03 08:24:50	2020-06-03 08:24:50	\N	\N	\N	\N	\N	\N	\N
380	332	475	t	09:30 AM	Bshsb	2020-06-03 08:24:50	2020-06-03 08:24:50	f	t	\N	\N	\N	\N	\N
389	330	489	t	02:00 PM	Hfuh	2020-06-03 01:37:02	2020-06-03 01:37:02	\N	\N	\N	\N	\N	\N	\N
385	332	477	t	09:40 AM	Hftv	2020-06-03 08:24:50	2020-06-03 08:24:50	\N	t	\N	\N	\N	\N	\N
390	332	490	t	02:15 PM	Gsbsbbx	2020-06-03 01:52:11	2020-06-03 01:52:11	\N	\N	\N	\N	\N	\N	\N
382	311	448	t	09:15 AM	vcbcb	2020-06-03 08:24:50	2020-06-03 01:52:11	t	t	\N	\N	\N	\N	\N
387	52	227	\N	4:28 PM	room	2020-06-03 10:39:50	2020-06-03 10:39:50	\N	\N	t	f	t	t	1
388	330	488	\N	01:55 PM	In public	2020-06-03 01:37:02	2020-06-03 01:37:02	\N	\N	\N	\N	\N	\N	\N
392	51	226	t	2:25 PM	5:22 PM	2020-06-03 01:52:11	2020-06-03 01:52:11	\N	\N	\N	\N	\N	\N	\N
393	332	490	t	04:20 PM	Test	2020-06-03 01:52:11	2020-06-03 01:52:11	\N	\N	\N	\N	\N	\N	\N
391	330	491	t	02:20 PM	Hsgshs	2020-06-03 01:52:11	2020-06-03 01:52:11	t	t	\N	\N	\N	\N	\N
394	332	490	t	03:25 PM	Test	2020-06-03 01:52:11	2020-06-03 01:52:11	\N	\N	\N	\N	\N	\N	\N
395	332	490	t	03:45 PM	Bathroom	2020-06-03 01:52:11	2020-06-03 01:52:11	t	t	\N	\N	\N	\N	\N
396	332	490	t	04:00 PM	Bathroom	2020-06-03 01:52:11	2020-06-03 01:52:11	\N	\N	\N	\N	\N	\N	\N
370	52	226	t	Master	08:02 AM	2020-06-03 06:24:18	2020-06-04 05:18:49	t	t	\N	\N	\N	\N	\N
397	52	227	t	07:20 AM	03:50 AM	2020-06-03 01:52:11	2020-06-04 07:08:10	t	\N	\N	\N	\N	\N	\N
398	332	490	t	05:05 AM	Test	2020-06-03 01:52:11	2020-06-03 01:52:11	\N	\N	\N	\N	\N	\N	\N
399	332	490	t	08:45 AM	Bathroom	2020-06-04 07:26:43	2020-06-04 07:26:43	t	t	\N	\N	\N	\N	\N
478	343	506	t	01:40 PM	jgjvjv	2020-06-09 01:16:26	2020-06-09 01:16:26	\N	\N	\N	\N	\N	\N	\N
479	343	506	t	01:35 AM	jfgjv	2020-06-09 01:16:26	2020-06-09 01:16:26	\N	\N	\N	\N	\N	\N	\N
456	336	494	t	09:25 AM	Chc	2020-06-09 08:54:31	2020-06-09 08:54:31	\N	\N	\N	\N	\N	\N	\N
452	336	494	t	07:35 AM	Test	2020-06-09 07:02:36	2020-06-09 07:02:36	t	f	\N	\N	\N	\N	\N
432	51	226	\N	11:15 AM	Jkkk	2020-06-08 10:57:44	2020-06-08 10:57:44	\N	\N	\N	\N	\N	\N	\N
400	52	227	t	08:58 AM	03:50 AM	2020-06-04 08:39:20	2020-06-04 08:57:53	t	t	\N	\N	\N	\N	\N
419	337	495	t	05:45 PM	Gdxv	2020-06-05 12:31:15	2020-06-05 12:31:15	\N	\N	\N	\N	\N	\N	\N
401	52	227	t	09:20 AM	03:50 AM	2020-06-04 09:02:11	2020-06-04 09:04:05	\N	t	\N	\N	\N	\N	\N
411	336	494	t	11:05 AM	Ttttr	2020-06-04 10:35:41	2020-06-04 10:35:41	t	t	\N	\N	\N	\N	\N
402	52	227	t	09:20 AM	03:50 AM	2020-06-04 09:04:05	2020-06-04 09:04:05	t	t	\N	\N	\N	\N	\N
420	337	495	t	05:50 PM	Rec	2020-06-05 12:31:15	2020-06-05 12:31:15	\N	\N	\N	\N	\N	\N	\N
433	51	226	\N	11:15 AM	Hhjj	2020-06-08 10:57:44	2020-06-08 10:57:44	\N	\N	\N	\N	\N	\N	\N
412	336	494	t	11:30 AM	Test	2020-06-04 11:05:14	2020-06-04 11:05:14	t	t	\N	\N	\N	\N	\N
421	336	494	t	04:55 PM	Deccd	2020-06-05 12:31:15	2020-06-05 12:31:15	t	t	\N	\N	\N	\N	\N
434	339	502	t	04:30 AM	Dffg	2020-06-08 10:57:44	2020-06-08 10:57:44	\N	\N	\N	\N	\N	\N	\N
403	52	227	t	09:25 AM	03:50 AM	2020-06-04 09:06:58	2020-06-04 09:06:58	t	\N	\N	\N	\N	\N	\N
404	52	494	t	10:11 AM	03:50 AM	2020-06-04 09:06:58	2020-06-04 09:51:11	t	t	\N	\N	\N	\N	\N
423	337	495	t	09:10 AM	Test	2020-06-05 12:31:15	2020-06-05 12:31:15	\N	\N	\N	\N	\N	\N	\N
413	336	494	t	12:15 PM	Tt	2020-06-04 11:20:11	2020-06-04 11:20:11	t	t	\N	\N	\N	\N	\N
414	337	495	t	04:50 AM	Bathroom	2020-06-04 12:32:48	2020-06-04 12:32:48	\N	\N	\N	\N	\N	\N	\N
415	337	494	\N	04:45 AM	Bathroom	2020-06-04 12:32:48	2020-06-04 12:32:48	\N	\N	\N	\N	\N	\N	\N
424	336	494	t	09:10 AM	Test	2020-06-05 12:31:15	2020-06-05 12:31:15	\N	\N	\N	\N	\N	\N	\N
435	339	502	t	11:35 AM	Ccc	2020-06-08 10:57:44	2020-06-08 10:57:44	\N	\N	\N	\N	\N	\N	\N
416	336	494	t	04:40 AM	Bzhdd	2020-06-05 04:22:28	2020-06-05 04:22:28	t	t	\N	\N	\N	\N	\N
405	52	227	t	10:20 AM	03:50 AM	2020-06-04 09:51:11	2020-06-04 10:17:40	t	t	\N	\N	\N	\N	\N
422	337	495	t	09:10 AM	Couch	2020-06-05 12:31:15	2020-06-05 12:31:15	f	\N	\N	\N	\N	\N	\N
436	340	503	t	11:40 AM	Ccc	2020-06-08 11:17:15	2020-06-08 11:17:15	\N	\N	\N	\N	\N	\N	\N
407	52	227	t	10:25 AM	03:50 AM	2020-06-04 10:23:00	2020-06-04 10:23:00	\N	\N	\N	\N	\N	\N	\N
437	339	503	\N	04:30 AM	Vvb	2020-06-08 11:24:19	2020-06-08 11:24:19	\N	\N	\N	\N	\N	\N	\N
425	337	495	t	09:30 AM	Test	2020-06-05 12:31:15	2020-06-05 12:31:15	t	t	\N	\N	\N	\N	\N
426	336	495	\N	01:00 PM	Yfv	2020-06-05 12:31:15	2020-06-05 12:31:15	\N	\N	\N	\N	\N	\N	\N
406	52	227	t	10:25 AM	03:50 AM	2020-06-04 10:20:57	2020-06-04 10:23:00	t	t	\N	\N	\N	\N	\N
438	340	503	f	04:30 AM	Bbh	2020-06-08 11:24:19	2020-06-08 11:24:19	\N	\N	\N	\N	\N	\N	\N
408	52	227	t	10:30 AM	03:50 AM	2020-06-04 10:23:00	2020-06-04 10:26:35	t	t	\N	\N	\N	\N	\N
427	336	494	t	01:00 PM	Bfb	2020-06-05 12:31:15	2020-06-05 12:31:15	t	t	\N	\N	\N	\N	\N
417	337	495	t	05:05 AM	Bathroom	2020-06-05 04:39:44	2020-06-05 04:39:44	t	t	\N	\N	\N	\N	\N
409	52	227	t	10:30 AM	03:50 AM	2020-06-04 10:26:35	2020-06-04 10:28:39	t	t	\N	\N	\N	\N	\N
439	340	503	f	04:30 AM	Bbh	2020-06-08 11:24:19	2020-06-08 11:24:19	\N	\N	\N	\N	\N	\N	\N
446	337	495	t	04:55 AM	Bathroom	2020-06-08 11:24:19	2020-06-08 11:24:19	f	f	\N	\N	\N	\N	\N
429	336	494	t	01:35 PM	Test	2020-06-05 12:31:15	2020-06-05 12:31:15	\N	t	\N	\N	t	t	\N
428	337	495	t	01:30 PM	Test	2020-06-05 12:31:15	2020-06-05 12:31:15	t	\N	t	t	\N	\N	\N
440	340	503	t	12:15 PM	Bbh	2020-06-08 11:24:19	2020-06-08 11:24:19	t	f	\N	\N	\N	\N	\N
410	52	227	t	10:45 AM	03:50 AM	2020-06-04 10:28:39	2020-06-05 06:34:41	t	\N	\N	\N	\N	\N	\N
447	336	494	t	05:25 AM	Bathrom	2020-06-08 11:24:19	2020-06-08 11:24:19	f	t	\N	\N	\N	\N	\N
431	340	503	t	07:30 AM	Ggg	2020-06-08 04:22:51	2020-06-08 04:22:51	\N	t	\N	\N	\N	\N	\N
430	340	503	t	04:30 AM	Bedroom	2020-06-08 04:22:51	2020-06-08 04:22:51	t	\N	\N	\N	t	t	\N
441	339	502	t	12:20 PM	Cvv	2020-06-08 11:24:19	2020-06-08 11:24:19	t	t	t	t	\N	\N	\N
442	51	226	t	03:45 AM	03:50 AM	2020-06-08 11:24:19	2020-06-08 11:24:19	t	\N	\N	\N	\N	\N	\N
453	336	494	t	08:10 AM	Bsgavs	2020-06-09 07:02:36	2020-06-09 07:02:36	\N	t	\N	\N	\N	\N	\N
448	337	495	t	05:40 AM	Bathroom	2020-06-08 11:24:19	2020-06-08 11:24:19	t	f	\N	\N	\N	\N	\N
444	51	226	t	04:30 AM	Fggj	2020-06-08 11:24:19	2020-06-08 11:24:19	\N	\N	\N	\N	\N	\N	\N
443	51	226	t	04:09 AM	03:50 AM	2020-06-08 11:24:19	2020-06-08 11:24:19	t	t	\N	\N	\N	\N	\N
454	336	494	t	08:45 AM	Dac	2020-06-09 07:02:36	2020-06-09 07:02:36	\N	f	\N	\N	\N	\N	\N
445	336	494	t	04:30 AM	Test	2020-06-08 11:24:19	2020-06-08 11:24:19	t	t	\N	\N	\N	\N	\N
418	52	227	t	08:55 AM	03:50 AM	2020-06-05 11:49:14	2020-06-09 08:34:48	t	t	\N	\N	\N	\N	\N
449	336	494	t	06:15 AM	Bathroom	2020-06-08 11:24:19	2020-06-08 11:24:19	f	f	\N	\N	\N	\N	\N
450	336	494	f	07:10 AM	Bsbsb	2020-06-08 11:24:19	2020-06-08 11:24:19	\N	\N	\N	\N	\N	\N	\N
457	336	494	t	09:55 AM	Bath	2020-06-09 08:54:31	2020-06-09 08:54:31	t	f	\N	\N	\N	\N	\N
451	336	494	t	07:10 AM	Bsbsb	2020-06-08 11:24:19	2020-06-08 11:24:19	t	t	\N	\N	\N	\N	\N
458	340	503	f	09:55 AM	Bbv	2020-06-09 08:54:31	2020-06-09 08:54:31	\N	\N	\N	\N	\N	\N	\N
459	340	503	f	09:55 AM	Bbv	2020-06-09 08:54:31	2020-06-09 08:54:31	\N	\N	\N	\N	\N	\N	\N
460	336	494	t	09:50 AM	Bath	2020-06-09 08:54:31	2020-06-09 08:54:31	\N	\N	\N	\N	\N	\N	\N
455	52	226	t	08:50 AM	03:50 AM	2020-06-09 08:34:48	2020-06-09 08:49:04	\N	t	\N	\N	\N	\N	\N
462	340	503	t	10:20 AM	Ccg	2020-06-09 09:51:39	2020-06-09 09:51:39	\N	\N	\N	\N	\N	\N	\N
463	336	494	t	11:15 AM	Bath	2020-06-09 10:48:42	2020-06-09 10:48:42	\N	\N	\N	\N	\N	\N	\N
465	336	494	t	11:35 AM	Bath	2020-06-09 11:21:32	2020-06-09 11:21:32	\N	t	\N	\N	\N	\N	\N
464	336	494	t	11:15 AM	Test	2020-06-09 10:48:42	2020-06-09 10:48:42	f	t	\N	\N	\N	\N	\N
466	344	507	t	12:45 PM	Dfsszfsf	2020-06-09 11:37:47	2020-06-09 11:37:47	\N	\N	\N	\N	\N	\N	\N
467	344	507	t	12:35 PM	Dada	2020-06-09 11:37:47	2020-06-09 11:37:47	\N	\N	\N	\N	\N	\N	\N
469	344	506	\N	04:30 AM	bchfjg	2020-06-09 11:37:47	2020-06-09 11:37:47	\N	\N	\N	\N	\N	\N	\N
468	344	507	t	12:40 PM	Dszfsf	2020-06-09 11:37:47	2020-06-09 11:37:47	f	\N	\N	\N	\N	\N	\N
471	344	506	\N	04:30 AM	fhfjcj	2020-06-09 01:00:19	2020-06-09 01:00:19	\N	\N	\N	\N	\N	\N	\N
470	343	506	t	04:30 AM	jfjghv	2020-06-09 01:00:19	2020-06-09 01:00:19	\N	\N	\N	\N	\N	\N	\N
472	343	506	t	04:30 AM	kgjgjg	2020-06-09 01:04:20	2020-06-09 01:04:20	\N	\N	\N	\N	\N	\N	\N
473	344	506	\N	04:30 AM	jgngj	2020-06-09 01:04:20	2020-06-09 01:04:20	\N	\N	\N	\N	\N	\N	\N
474	343	506	t	04:30 AM	igigjv	2020-06-09 01:04:20	2020-06-09 01:04:20	\N	\N	\N	\N	\N	\N	\N
475	343	506	t	01:10 PM	fjgkv	2020-06-09 01:04:20	2020-06-09 01:04:20	\N	\N	\N	\N	\N	\N	\N
476	343	506	t	01:15 PM	fjgjgjg	2020-06-09 01:04:20	2020-06-09 01:04:20	\N	\N	\N	\N	\N	\N	\N
477	343	506	t	01:30 PM	gjgkgj	2020-06-09 01:04:20	2020-06-09 01:04:20	\N	\N	\N	\N	\N	\N	\N
502	344	507	t	04:30 AM	Jxjdjd	2020-06-09 01:53:02	2020-06-09 01:53:02	\N	\N	\N	\N	\N	\N	\N
503	52	226	t	09:30 AM	Bhh	2020-06-09 01:53:02	2020-06-09 01:53:02	\N	\N	\N	\N	\N	\N	\N
504	52	226	t	09:35 AM	Cvg	2020-06-10 09:31:03	2020-06-10 09:31:03	\N	\N	\N	\N	\N	\N	\N
505	52	226	t	09:35 AM	Vbh	2020-06-10 09:31:03	2020-06-10 09:31:03	\N	t	\N	\N	\N	\N	\N
506	52	226	t	09:40 AM	Gbh	2020-06-10 09:31:03	2020-06-10 09:31:03	\N	\N	\N	\N	\N	\N	\N
507	52	226	t	09:40 AM	Bhj	2020-06-10 09:31:03	2020-06-10 09:31:03	\N	\N	\N	\N	\N	\N	\N
480	343	506	t	01:50 PM	hfjgjv	2020-06-09 01:16:26	2020-06-09 01:16:26	\N	\N	\N	\N	\N	\N	\N
521	336	513	t	12:30 PM	Fvg	2020-06-10 09:49:30	2020-06-10 09:49:30	\N	\N	\N	\N	\N	\N	\N
508	52	226	t	09:40 AM	Vvh	2020-06-10 09:31:03	2020-06-10 09:31:03	t	t	\N	\N	\N	\N	\N
522	336	513	t	05:30 AM	Dfg	2020-06-10 09:49:30	2020-06-10 09:49:30	\N	\N	\N	\N	\N	\N	\N
347	311	440	f	04:30 PM	jfjgj	2020-06-01 11:03:49	2020-06-09 01:37:36	\N	f	\N	\N	\N	\N	\N
481	343	507	\N	01:55 PM	hfjgj	2020-06-09 01:37:36	2020-06-09 01:37:36	\N	\N	\N	\N	\N	\N	\N
482	343	507	\N	01:50 AM	gjgj	2020-06-09 01:37:36	2020-06-09 01:37:36	\N	\N	\N	\N	\N	\N	\N
483	343	506	t	01:50 PM	cjgjv	2020-06-09 01:37:36	2020-06-09 01:37:36	\N	\N	\N	\N	\N	\N	\N
461	52	226	t	01:55 PM	03:50 AM	2020-06-09 09:51:39	2020-06-09 01:37:36	f	t	\N	\N	\N	\N	\N
484	343	506	t	02:05 PM	fjgkv	2020-06-09 01:37:36	2020-06-09 01:37:36	\N	\N	\N	\N	\N	\N	\N
509	52	226	t	09:45 AM	Hhgg	2020-06-10 09:31:03	2020-06-10 09:31:03	t	t	\N	\N	\N	\N	\N
485	343	506	t	01:55 PM	fjgjv	2020-06-09 01:37:36	2020-06-09 01:37:36	t	f	\N	\N	\N	\N	\N
486	344	507	t	02:25 PM	jfjgj	2020-06-09 01:53:02	2020-06-09 01:53:02	f	t	\N	\N	\N	\N	\N
510	52	226	t	09:50 AM	Gg	2020-06-10 09:49:30	2020-06-10 09:49:30	\N	t	\N	\N	\N	\N	\N
487	344	507	t	02:25 PM	hfbc	2020-06-09 01:53:02	2020-06-09 01:53:02	t	f	\N	\N	\N	\N	\N
523	336	513	t	06:30 AM	Vvg	2020-06-10 09:49:30	2020-06-10 09:49:30	\N	t	\N	\N	\N	\N	\N
511	52	226	t	09:55 AM	Ghhh	2020-06-10 09:49:30	2020-06-10 09:49:30	\N	t	\N	\N	\N	\N	\N
488	336	508	t	08:05 AM	Hh	2020-06-09 01:53:02	2020-06-09 01:53:02	t	t	\N	\N	\N	\N	\N
489	336	508	t	08:10 AM	Test	2020-06-09 01:53:02	2020-06-09 01:53:02	\N	\N	\N	\N	\N	\N	\N
490	336	508	t	08:20 AM	Test	2020-06-09 01:53:02	2020-06-09 01:53:02	\N	\N	\N	\N	\N	\N	\N
491	336	508	t	08:20 AM	Dx	2020-06-09 01:53:02	2020-06-09 01:53:02	\N	\N	\N	\N	\N	\N	\N
492	336	508	t	08:40 AM	Resc	2020-06-09 01:53:02	2020-06-09 01:53:02	f	t	\N	\N	\N	\N	\N
512	51	227	t	10:00 AM	Ghhhj	2020-06-10 09:49:30	2020-06-10 09:49:30	\N	t	\N	\N	\N	\N	\N
493	336	508	t	09:00 AM	Test	2020-06-09 01:53:02	2020-06-09 01:53:02	f	t	\N	\N	\N	\N	\N
494	336	508	t	08:55 AM	Tedt	2020-06-09 01:53:02	2020-06-09 01:53:02	\N	\N	\N	\N	\N	\N	\N
495	337	508	\N	09:15 AM	Baha	2020-06-09 01:53:02	2020-06-09 01:53:02	\N	\N	\N	\N	\N	\N	\N
496	337	508	\N	09:15 AM	Bahsb	2020-06-09 01:53:02	2020-06-09 01:53:02	\N	\N	\N	\N	\N	\N	\N
524	336	515	t	11:30 AM	Cjfj	2020-06-10 09:49:30	2020-06-10 09:49:30	\N	\N	\N	\N	\N	\N	\N
498	52	226	t	09:09 AM	03:50 AM	2020-06-09 01:53:02	2020-06-09 01:53:02	\N	\N	\N	\N	\N	\N	\N
525	347	518	\N	04:30 AM	Ee	2020-06-10 12:25:13	2020-06-10 12:25:13	\N	\N	\N	\N	\N	\N	\N
497	337	509	t	09:20 AM	Tfhc	2020-06-09 01:53:02	2020-06-09 01:53:02	f	t	\N	\N	\N	\N	\N
499	51	226	t	09:10 AM	Hhh	2020-06-09 01:53:02	2020-06-09 01:53:02	\N	\N	\N	\N	\N	\N	\N
500	52	226	t	09:20 AM	Vvb	2020-06-09 01:53:02	2020-06-09 01:53:02	\N	\N	\N	\N	\N	\N	\N
501	52	226	t	09:30 AM	Hhjj	2020-06-09 01:53:02	2020-06-09 01:53:02	\N	\N	\N	\N	\N	\N	\N
513	336	508	t	10:15 AM	Test	2020-06-10 09:49:30	2020-06-10 09:49:30	f	f	\N	\N	\N	\N	\N
514	345	511	t	10:25 AM	Hhj	2020-06-10 09:49:30	2020-06-10 09:49:30	\N	\N	\N	\N	\N	\N	\N
541	364	529	f	04:30 PM	Test	2020-06-19 11:09:02	2020-06-19 11:09:02	\N	\N	\N	\N	\N	\N	\N
515	346	510	t	10:30 AM	Hhhj	2020-06-10 09:49:30	2020-06-10 09:49:30	t	t	\N	\N	\N	\N	\N
516	336	508	f	10:35 AM	Test	2020-06-10 09:49:30	2020-06-10 09:49:30	\N	\N	\N	\N	\N	\N	\N
533	345	510	t	11:55 AM	Go to heaven	2020-06-16 11:07:20	2020-06-16 12:18:18	t	\N	\N	\N	\N	\N	\N
526	348	520	t	10:20 AM	Qa	2020-06-10 12:25:13	2020-06-10 12:25:13	t	t	\N	\N	\N	\N	\N
517	336	508	t	10:35 AM	Test	2020-06-10 09:49:30	2020-06-10 09:49:30	t	t	\N	\N	\N	\N	\N
518	336	513	t	10:35 AM	Test	2020-06-10 09:49:30	2020-06-10 09:49:30	\N	t	\N	\N	\N	\N	\N
519	336	513	t	10:55 AM	Q	2020-06-10 09:49:30	2020-06-10 09:49:30	\N	\N	\N	\N	\N	\N	\N
520	336	513	t	11:30 AM	Fgbf	2020-06-10 09:49:30	2020-06-10 09:49:30	\N	\N	\N	\N	\N	\N	\N
534	345	510	t	12:50 AM	Ghare	2020-06-16 12:24:20	2020-06-16 12:24:20	\N	\N	\N	\N	\N	\N	\N
527	358	522	t	12:30 PM	Wdd	2020-06-11 12:13:26	2020-06-11 12:13:26	t	f	\N	\N	\N	\N	\N
528	342	525	t	09:25 AM	sdxadas	2020-06-11 12:13:26	2020-06-11 12:13:26	t	\N	\N	\N	\N	\N	\N
529	345	510	t	11:00 AM	Ghare	2020-06-16 10:34:35	2020-06-16 10:34:35	\N	\N	\N	\N	\N	\N	\N
530	345	510	t	11:05 AM	Ghare	2020-06-16 10:44:45	2020-06-16 10:44:45	\N	\N	\N	\N	\N	\N	\N
531	345	510	t	11:10 PM	Ghare	2020-06-16 10:52:31	2020-06-16 10:52:31	\N	\N	\N	\N	\N	\N	\N
535	345	510	t	12:50 PM	Ghare	2020-06-16 12:31:16	2020-06-16 12:31:16	\N	\N	\N	\N	\N	\N	\N
532	345	510	t	11:35 AM	Ghare	2020-06-16 11:07:20	2020-06-16 11:07:20	t	\N	\N	\N	\N	\N	\N
536	345	510	t	12:50 PM	Gh J	2020-06-16 12:32:54	2020-06-16 12:32:54	\N	\N	\N	\N	\N	\N	\N
537	345	510	t	01:00 PM	Gjgj	2020-06-16 12:54:39	2020-06-16 12:54:39	t	\N	\N	\N	\N	\N	\N
538	345	510	t	04:35 AM	Ghare	2020-06-17 04:08:42	2020-06-17 04:08:42	t	\N	\N	\N	\N	\N	\N
539	342	524	\N	04:30 AM	Ghhhj	2020-06-19 11:09:02	2020-06-19 11:09:02	\N	\N	\N	\N	\N	\N	\N
540	363	527	t	04:30 AM	Gjgjg	2020-06-19 11:09:02	2020-06-19 11:09:02	t	\N	\N	\N	\N	\N	\N
542	364	529	t	04:30 PM	Test	2020-06-19 11:09:02	2020-06-19 11:09:02	\N	t	\N	\N	t	f	\N
543	357	529	t	04:50 PM	Test2	2020-06-19 11:09:02	2020-06-19 11:09:02	\N	t	t	t	\N	\N	\N
544	364	528	\N	02:00 AM	Test June 27	2020-06-19 11:09:02	2020-06-19 11:09:02	\N	\N	\N	\N	\N	\N	\N
545	368	532	\N	04:00 PM	Bedroom	2020-06-19 11:09:02	2020-06-19 11:09:02	\N	\N	\N	\N	\N	\N	\N
\.


--
-- Name: quickies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quickies_id_seq', 545, true);


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, role_title, status, create_time, update_time) FROM stdin;
1	Admin	1	2020-01-14 00:00:00	2020-01-14 00:00:00
2	User	1	2020-01-14 00:00:00	2020-01-14 00:00:00
\.


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 1, false);


--
-- Data for Name: subscripations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subscripations (id, user_id, partner_mapping_id, purchase_plan_id, amount, device_name, subscripation_plan, receipt, status, create_time, update_time, expiry_date) FROM stdin;
1	52	227	123456dfsf	1234	apple	yearly	sasassas1212	1	2020-05-21 04:42:47	2020-05-21 04:42:47	\N
2	52	227	123456dfsf	1234	apple	monthly	sasassas1212	1	2020-05-21 12:35:58	2020-05-21 12:35:58	2020-06-20 12:35:58.684
3	52	227	123456dfsf	1234	apple	monthly	sasassas1212	1	2020-05-22 04:20:34	2020-05-22 04:20:34	2020-06-21 16:20:34.697
4	52	227	123456dfsf	1234	apple	monthly	sasassas1212	1	2020-05-25 01:48:59	2020-05-25 01:48:59	2020-06-24 13:48:59.033
5	52	227	123456dfsf	1234	apple	monthly	sasassas1212	1	2020-05-25 01:48:59	2020-05-25 01:48:59	2020-06-24 13:48:59.033
\.


--
-- Name: subscripations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subscripations_id_seq', 5, true);


--
-- Data for Name: unavailabilities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.unavailabilities (id, user_id, unavailability_start, unavailability_end, status, create_time, update_time) FROM stdin;
1	6	2020-01-25 00:00:00	2020-01-30 00:00:00	1	2020-01-21 00:50:50	2020-01-21 00:50:50
2	6	2020-01-25 00:00:00	2020-01-30 00:00:00	1	2020-01-21 00:51:08	2020-01-21 00:51:08
3	6	2020-01-25 00:00:00	2020-01-30 00:00:00	1	2020-01-21 00:53:57	2020-01-21 00:53:57
4	6	2020-01-25 00:00:00	2020-01-30 00:00:00	1	2020-01-21 00:54:28	2020-01-21 00:54:28
5	6	2020-01-25 00:00:00	2020-01-30 00:00:00	1	2020-01-21 00:54:28	2020-01-21 00:54:28
6	6	2020-01-25 00:00:00	2020-01-30 00:00:00	1	2020-01-21 00:54:29	2020-01-21 00:54:29
7	6	2020-01-25 00:00:00	2020-01-30 00:00:00	1	2020-01-21 00:54:30	2020-01-21 00:54:30
8	6	2020-01-25 00:00:00	2020-01-30 00:00:00	1	2020-01-21 00:54:31	2020-01-21 00:54:31
9	6	2020-01-25 00:00:00	2020-01-30 00:00:00	1	2020-01-21 00:54:31	2020-01-21 00:54:31
10	6	2020-01-25 00:00:00	2020-01-30 00:00:00	1	2020-01-21 00:54:32	2020-01-21 00:54:32
11	6	2020-01-23 00:00:00	2020-01-30 00:00:00	1	2020-01-21 00:54:37	2020-01-21 00:54:37
12	6	2020-01-23 00:00:00	2020-01-30 00:00:00	1	2020-01-21 00:54:38	2020-01-21 00:54:38
13	6	2020-01-22 00:00:00	2020-01-30 00:00:00	1	2020-01-21 00:54:42	2020-01-21 00:54:42
14	6	2020-01-22 00:00:00	2020-01-30 00:00:00	1	2020-01-21 00:54:43	2020-01-21 00:54:43
15	6	2020-01-21 00:00:00	2020-01-30 00:00:00	1	2020-01-21 00:54:46	2020-01-21 00:54:46
16	6	2020-01-21 00:00:00	2020-01-30 00:00:00	1	2020-01-21 00:54:47	2020-01-21 00:54:47
17	6	2020-01-21 00:00:00	2020-01-30 00:00:00	1	2020-01-21 00:54:48	2020-01-21 00:54:48
18	6	2020-01-21 00:00:00	2020-01-30 00:00:00	1	2020-01-21 00:55:02	2020-01-21 00:55:02
19	6	2020-01-22 00:00:00	2020-01-30 00:00:00	1	2020-01-21 00:56:00	2020-01-21 00:56:00
\.


--
-- Name: unavailabilities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.unavailabilities_id_seq', 1, false);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, role_id, first_name, last_name, gender, email, password, profile_image, face_id, touch_id, access_token, unique_code, notification_mute_status, notification_mute_end, status, create_time, update_time, fcmid, stage, device_name, receipt, expiry_time, notification_mute_start) FROM stdin;
61	2	Partner	One	Male	partnerone@yopmail.com	$2a$10$hcNkREvxZOBIEYPChiPBSuc6pf57Py.UU57pLA0tiW64AVm11nycy	\N	\N	\N	\N		\N	\N	1	2020-04-16 22:47:49	2020-04-16 22:47:49	\N	1	\N	\N	\N	\N
60	2	Partner	One	Male	partnertwo@yopmail.com	$2a$10$Zgok9DwQrS2.148le0P44.xfcd.iDwJt92Pg2E6TNYDAh8W5S4IwG	\N	\N	\N	\N		\N	\N	1	2020-04-16 22:46:50	2020-04-16 23:24:09	BDSPK6589G	1	\N	\N	\N	\N
25	2	Neha	Sharma	Female	neha.sharma@subcodevs.com	$2a$10$UWZKK/Ikhpw9aUHU/OIwre0huVAHtERMSyrJf/fnyJBcHJSPEkR2a	\N	\N		\N		\N	\N	1	2020-01-27 05:41:55	2020-04-15 23:09:33	BDSPK6589G	1	\N	\N	\N	\N
24	2	Balwant	Singh	Male	balwant.singh@subcodevs.com	$2a$10$HxYIMqZxtZsN.7mCUJXGa.k.LGEHT6FcIJR7iGs8GZHjyo1IEaWzC	1587019912809.jpeg	\N	\N	\N		\N	\N	1	2020-01-27 05:37:42	2020-04-15 23:10:59	eyJhbGciOiJIUzI1NiIsInRNNYUI	1	\N	\N	\N	\N
1	1	Navneet	Kumar	Male	navneet.kumar@subcodevs.com	$2a$10$VEwSlOIYPfnDYG5nX4zrE.g7vDujZmpaBfcS/5mAuncC/jz1WKePa	\N	\N	\N	\N		\N	\N	1	2020-01-15 00:00:00	2020-01-22 05:57:29	\N	1	\N	\N	\N	\N
26	2	Monika	Sharma	Female	monika.sharma@subcodevs.com	$2a$10$YGJsRqXRXsxfcj8fLUIcTO2FArzUeq6wNhK3WuMmBUAqne5XRiQwC	\N	\N	\N	\N		\N	\N	1	2020-02-10 21:32:38	2020-02-17 06:53:35	\N	1	\N	\N	\N	\N
338	2	mka	mka	female	mka1@yopmail.com	$2a$10$P/mNOTzK4KIBgToYJuHM2OuC79i4mmhhRvtWuIocMaAADg4ImHUnu	\N	\N	\N	\N	FEAR	\N	\N	1	2020-06-08 05:45:36	2020-06-08 05:45:36	\N	1	\N	\N	\N	\N
310	2	tests	users	Female	testing@gmail.com	$2a$10$Ec0JVYoljF0VGt/jSn5dlO/8hvqFgZUa5ioGiR2Z16qMZBB3mLhwq	\N	\N	\N	\N	RKOM	\N	\N	1	2020-05-25 01:45:43	2020-05-25 01:45:43	\N	1	\N	\N	\N	\N
3	2	Hsjs	Hshhs	female	bsjjs@hdjis.hsjks	$2a$10$w35qD.lAZ3l5x/Tx8Q0zku6FLRnLfg26thR962uWCRwdUjl1ZNbxm	\N	\N	\N	\N	ECZY	\N	\N	1	2020-05-05 06:43:29	2020-05-05 06:43:29	\N	1	\N	\N	\N	\N
13	2	dsfsdf	sgsfg	female	sgsfg@efewfr.weg	$2a$10$F95qn8gOAGDztQWHH0rrs.4FDohb8kPCa/JbZJ7eTRmMEQNOvqGg2	\N	\N	\N	\N	OJFT	\N	\N	1	2020-05-05 06:57:55	2020-05-05 06:57:55	\N	1	\N	\N	\N	\N
28	2	Test	User	Female	tester5@yopmail.com	$2a$10$kNdeyBEZCrffYkdyMKDfrebIAcwj3I44QQx5TOwqIKmhIzsO6L8wK	\N	\N	\N	\N	ZAHV	\N	\N	1	2020-05-05 07:26:47	2020-05-06 09:51:22	fJdaNn10TJedC7-L3wYBxG:APA91bHZyC-hvENtlYiAfW-Jyk...	5	\N	\N	\N	\N
14	2	sfsdf	sdgdsg	female	sgsdg@egsdg.srgrsg	$2a$10$p7pvSgc9d0eEeuAXKixAzecpvMs.mg8JK4Kl4BS4E9oTAVm0EJoeu	\N	\N	\N	\N	WHDC	\N	\N	1	2020-05-05 06:59:14	2020-05-05 06:59:14	\N	1	\N	\N	\N	\N
6	2	Jsjka	Jdjdj	female	jsjjs@jskks.hsjsj	$2a$10$JqJ0frQDv75H4QTRGdqEs.8eirtzqPXARE0SPRDBx/Ddf9zjXBrHq	\N	\N	\N	\N	KGEM	\N	\N	1	2020-05-05 06:47:21	2020-05-05 06:47:21	\N	1	\N	\N	\N	\N
7	2	sdfgsdf	sdgsdfg	female	sdgfsf@faesf.aefaf	$2a$10$7hKO4vaNlKpY743UDS.u7.j3WHHhfLhoxT7yzQARUPAYjh4YsIOlu	1588661306543.jpeg	\N	\N	\N	IEWN	\N	\N	1	2020-05-05 06:48:10	2020-05-05 06:48:26	\N	1	\N	\N	\N	\N
355	2	Vhhuj	Gggh	female	an.globaliasoft@gmail.com	$2a$10$mIhWPUzV2kzUPlSSNcfYru3hpv445TkShdVcmTeWcNhjq6UeWhFT6	\N	\N	\N	\N	FNAD	\N	\N	1	2020-06-11 12:08:04	2020-06-11 12:08:04	\N	1	\N	\N	\N	\N
9	2	test	users	male	testusers3@gmail.com	$2a$10$rRUHmclVF1Uwl4LESwPMfu/j7qnzM0FpSPalszvBRnzGjEnu7GlN6	\N	\N	\N	\N	FNEU	\N	\N	1	2020-05-05 06:50:31	2020-05-05 06:50:31	\N	1	\N	\N	\N	\N
10	2	Hsjjs	Jzjjs	female	hsjjs@jskks.jsks	$2a$10$bi9TbifTF.5sA91SWKTNYee5Iw5K015SV/zGavt0ikX4qV0PCL5F2	\N	\N	\N	\N	XVBD	\N	\N	1	2020-05-05 06:52:12	2020-05-05 06:52:12	\N	1	\N	\N	\N	\N
15	2	sgsfg	sgsdg	female	sdgdsg@aegsg.sgs	$2a$10$0gy6OWKdHsVLw7XYvOc3JOMchDzdf9KUJgjVdJutYkFSHrX0.C1zO	\N	\N	\N	\N	UYHG	\N	\N	1	2020-05-05 07:01:50	2020-05-05 07:01:50	\N	1	\N	\N	\N	\N
16	2	sdfdsf	sdgs	female	sdgsdfg@afasf.rggerg	$2a$10$taqcEoGeRerKQEmIHhvhpulO9y1FBqrnYSiNxKy2pQsIPIi.lLrui	\N	\N	\N	\N	LXEX	\N	\N	1	2020-05-05 07:02:14	2020-05-05 07:02:14	\N	1	\N	\N	\N	\N
11	2	dvdzxfv	dsfvdsfv	female	sdfdsf@wfaf.aefsf	$2a$10$jbSSN1.uAqK1sGTJEEK9YusHlF1kh8Y.9UXc7zestlm9GVdE6CmjC	1588661740356.jpeg	\N	\N	\N	XOOF	\N	\N	1	2020-05-05 06:55:35	2020-05-05 06:55:40	\N	1	\N	\N	\N	\N
17	2	Jsjs	Jsjs	female	jsjjs@jsjj.nskjs	$2a$10$krbCGiXgtd5bGJcJVggQK.z0UjEDrNSLWD/Hymisxkkj3DEKvML.a	\N	\N	\N	\N	OCZZ	\N	\N	1	2020-05-05 07:02:57	2020-05-05 07:02:57	\N	1	\N	\N	\N	\N
18	2	dsfdsf	sdfdsf	female	fsf@fgeesf.aefgaf	$2a$10$RjmM/BChFhZHd.Mr1MMPYOQKxS3ZsVxObFvt4Bt6W1tfWEQwe3o8O	\N	\N	\N	\N	RLCW	\N	\N	1	2020-05-05 07:04:28	2020-05-05 07:04:28	\N	1	\N	\N	\N	\N
318	2	AKHILESH	SINGH	male	akhilesh@yopmail.com	$2a$10$EZLAwJcz8l8Tc0hVZPWZ4OfHRD8AVtaPj/bOONGobciWlrmI2qCJO	1590528717265.jpeg	\N	\N	\N	XZID	\N	\N	1	2020-05-26 09:31:24	2020-05-26 09:33:02	fRcm_o67Qbq23swBOMeyhJ:APA91bFr9OXIJh6Y-ufDejWGnlZnZ_CuiMmDKSF5KXusdDpvId3O_79NZsG2BuPJBM8_Nkfm5bwSABaYJDGVLIye3MATpGx3HsgAmmUQ--U7L3wmQN7cK5rAgeriYK5yVVvENXH9bmCR	1	\N	\N	\N	\N
31	2	Test	User	Female	tester8@yopmail.com	$2a$10$jJolY7wgMx2CoXpARA2PYewtfi5zKtnlpFEO3gGpZOPgL.4fKlASu	\N	\N	\N	\N	DVBZ	\N	\N	1	2020-05-05 07:30:47	2020-05-06 11:52:10	fJdaNn10TJedC7-L3wYBxG:APA91bHZyC-hvENtlYiAfW-Jyk...	6	\N	\N	\N	\N
2	2	Test	User	Female	tester34@yopmail.com	$2a$10$AiCxq2ah9gJsOWjh2S4kHObMYVCPhOIugITChh.l/w.TEoHIpEF1.	\N	\N	\N	\N	NAHJ	\N	\N	1	2020-05-05 06:04:16	2020-05-05 06:57:30	fJdaNn10TJedC7-L3wYBxG:APA91bHZyC-hvENtlYiAfW-Jyk...	1	\N	\N	\N	\N
19	2	afseaf	afasf	female	asfasf@afasf.asfasf	$2a$10$marsDSYwK6JbnmvEZENOz.QpCRVAKDxO/D2Yg2GH1e/EcRuhXdl2y	1588662301297.jpeg	\N	\N	\N	NCYD	\N	\N	1	2020-05-05 07:04:47	2020-05-05 07:05:01	\N	1	\N	\N	\N	\N
20	2	Jsjs	Hsjs	female	bsjjs@jdjs.ksoos	$2a$10$qsexsE9p7DYyvxvcbdVFZO9GG8/noLYTt/6ZouWZKoXp0qW8sP5mS	\N	\N	\N	\N	NJGK	\N	\N	1	2020-05-05 07:05:17	2020-05-05 07:05:17	\N	1	\N	\N	\N	\N
21	2	Jzjs	Jdjsj	female	ksjs@jsks.jzkks	$2a$10$XwkcE.Y464EsZ5piK54JiOctUt8OQ0gzL/.yc/v5PSW/1N/3O2aES	\N	\N	\N	\N	MQEQ	\N	\N	1	2020-05-05 07:06:29	2020-05-05 07:06:29	\N	1	\N	\N	\N	\N
22	2	Test	User	Female	tester2@yopmail.com	$2a$10$LJNMoDU/j88/I6ts3/5evOCokru8NgcuWqfo6bFgbJSc2qyOsy/RG	\N	\N	\N	\N	VWMR	\N	\N	1	2020-05-05 07:18:16	2020-05-06 10:03:30	fJdaNn10TJedC7-L3wYBxG:APA91bHZyC-hvENtlYiAfW-Jyk...	5	\N	\N	\N	\N
27	2	Test	User	Female	testusers12@gmail.com	$2y$12$8gHAAkwN.94SSQDIZqociOi8obGlXALDmMpeYJEEMKPt.BtY7QAGO	\N	\N	\N	\N	BHRJ	\N	\N	1	2020-05-05 07:23:59	2020-05-09 06:22:12	1234567894dsd	6	\N	\N	\N	\N
12	2	test	user	male	testuser111@gmail.com	$2y$12$8gHAAkwN.94SSQDIZqociOi8obGlXALDmMpeYJEEMKPt.BtY7QAGO\n	\N	\N	\N	\N	\N	\N	\N	0	2020-04-16 22:47:49	2020-04-16 22:47:49	\N	1	\N	\N	\N	\N
32	2	Test	User	Female	tester9@yopmail.com	$2a$10$G.b7D7uBfoWMb/UWEaO/7.2DZMNCkteF3mb5NSJ7K1GFLyrhm7R1q	\N	\N	\N	\N	YYQE	\N	\N	1	2020-05-05 09:20:32	2020-05-06 12:06:30	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	5	\N	\N	\N	\N
30	2	Test	User	Female	tester7@yopmail.com	$2a$10$rcJy4wn2aI3lCb.Fy6VMueqZZhGGMUBxQOPEZNlsmH4afN6Swz1Bu	\N	\N	\N	\N	LGGH	\N	\N	1	2020-05-05 07:30:11	2020-05-06 11:52:15	fJdaNn10TJedC7-L3wYBxG:APA91bHZyC-hvENtlYiAfW-Jyk...	6	\N	\N	\N	\N
23	2	Test	User	Female	tester3@yopmail.com	$2a$10$8uIR2eBzi4OtePKIsQS6ie8Vo6oJE5HZ.2YEriaedWSC76q57lIJO	\N	\N	\N	\N	DQGV	\N	\N	1	2020-05-05 07:22:19	2020-05-06 09:11:06	fJdaNn10TJedC7-L3wYBxG:APA91bHZyC-hvENtlYiAfW-Jyk...	3	\N	\N	\N	\N
4	2	Test	User	Female	tester1@yopmail.com	$2a$10$buAzlJ1ojiqbqyt1vCk73OvAsznI0gjs4lLWd5Mg.sRohpyamWDIS	1588661836627.jpeg	\N	\N	\N	JOWA	\N	\N	1	2020-05-05 06:44:37	2020-05-05 09:13:27	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	4	\N	\N	\N	\N
47	2	Test	User	Female	tester24@yopmail.com	$2a$10$OZmTo2OdPCVgsjZy8TCHM.WmLvAFCfGdtNwJxhSsbJSO9GQpS2ErC	\N	\N	\N	\N	JLFN	\N	\N	1	2020-05-05 12:09:30	2020-05-05 12:20:48	cP7o-75PCUjAlbV4M-eU4X:APA91bHP1nLLKBZ5OLHBD7Kt3muGAfMjBZSScIjiqdjTI7f4xpCE_n3Dd2HFDbBW98C8aetCGFjIEG2NKNvN3kLOs_M9kypRTFRWJPfnvF6iFUV6ALKHH1XzMjPX_xePJlhY2yFOKytG	4	\N	\N	\N	\N
38	2	Test	User	Female	tester15@yopmail.com	$2a$10$ZU71bgihSLJVx7wkAbUbKu/aMCQL.pjC28QrfEvsNX42Ntkj542ym	\N	\N	\N	\N	BPJN	\N	\N	1	2020-05-05 09:47:38	2020-05-05 09:47:56	fUTYBQHkRuCbgLDwTCjOcr:APA91bF9-gSDXPNH3c395JEFy3BG9kRXzpZQKsmGyQRIOjXhWsjfqEBbcjH1T8CDA7ASIx0C9BiV6Bngr4mn2YjuT99Ca1FCT9-VRrM-mbCJZNS7FjaajyTu4OsTDgxcnk4oz3m4UoDf	4	\N	\N	\N	\N
50	2	Test	User	Female	tester27@yopmail.com	$2a$10$fs9r.KwcdBj5ycSx0GSTWeejjVEuSK2.Q.CH.wTx.z0yFR5ELma6q	\N	\N	\N	\N	TTCQ	\N	\N	1	2020-05-05 01:00:59	2020-05-05 01:01:20	fUTYBQHkRuCbgLDwTCjOcr:APA91bF9-gSDXPNH3c395JEFy3BG9kRXzpZQKsmGyQRIOjXhWsjfqEBbcjH1T8CDA7ASIx0C9BiV6Bngr4mn2YjuT99Ca1FCT9-VRrM-mbCJZNS7FjaajyTu4OsTDgxcnk4oz3m4UoDf	4	\N	\N	\N	\N
37	2	Test	User	Female	tester14@yopmail.com	$2a$10$hjVw2kM6G8vBkdef/H6wf.2XwOp7zfDuevHkwxqWHiq63EGW4xGky	\N	\N	\N	\N	TVAI	\N	\N	1	2020-05-05 09:44:52	2020-05-05 09:45:12	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	4	\N	\N	\N	\N
36	2	Test	User	Female	tester13@yopmail.com	$2a$10$SPtpHXDRBCVICSlXLEhmj.pURh8YJaocu7RfuUXv2SyT5j2dMImeK	\N	\N	\N	\N	KSRV	\N	\N	1	2020-05-05 09:44:26	2020-05-05 09:44:46	fUTYBQHkRuCbgLDwTCjOcr:APA91bF9-gSDXPNH3c395JEFy3BG9kRXzpZQKsmGyQRIOjXhWsjfqEBbcjH1T8CDA7ASIx0C9BiV6Bngr4mn2YjuT99Ca1FCT9-VRrM-mbCJZNS7FjaajyTu4OsTDgxcnk4oz3m4UoDf	4	\N	\N	\N	\N
39	2	Test	User	Female	tester16@yopmail.com	$2a$10$xxZfvdwkOZ5HbkXICnisMu4YVxGJ4.I42ABTOllPgs8Q7iVE4/Cq6	\N	\N	\N	\N	OJDU	\N	\N	1	2020-05-05 09:48:06	2020-05-05 10:00:03	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	4	\N	\N	\N	\N
43	2	Test	User	Female	tester20@yopmail.com	$2a$10$KN2AUIPI9g3UG0Dcd8RxNO5V1zZWwnYTIV5QZlhkXd41g6sXvl51u	\N	\N	\N	\N	TRMO	\N	\N	1	2020-05-05 10:48:39	2020-05-05 10:49:02	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	4	\N	\N	\N	\N
34	2	Test	User	Female	tester11@yopmail.com	$2a$10$dAprwjll5pxBEU/7mqwvCeCsj7T2DSv0fMDHlcWlrjG0bH1xD2YXW	\N	\N	\N	\N	UFOZ	\N	\N	1	2020-05-05 09:39:56	2020-05-06 12:08:23	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
57	2	Test	User	Female	tester30@yopmail.com	$2a$10$rctPref9237gr22F6d3HhOEGfpbi.J1zo3dYZjwaPMZHLKmezhPNm	\N	\N	\N	\N	HEMC	\N	\N	1	2020-05-06 05:22:49	2020-05-06 12:42:40	fJdaNn10TJedC7-L3wYBxG:APA91bHZyC-hvENtlYiAfW-Jyk...	6	\N	\N	\N	\N
42	2	Test	User	Female	tester19@yopmail.com	$2a$10$b4D2CvdfGJIjj7EZjhQ6Le8nxFDgXQz3ZIIUgAL5HJQ9Kix2I7HLO	\N	\N	\N	\N	CJSZ	\N	\N	1	2020-05-05 10:48:16	2020-05-05 10:48:34	fUTYBQHkRuCbgLDwTCjOcr:APA91bF9-gSDXPNH3c395JEFy3BG9kRXzpZQKsmGyQRIOjXhWsjfqEBbcjH1T8CDA7ASIx0C9BiV6Bngr4mn2YjuT99Ca1FCT9-VRrM-mbCJZNS7FjaajyTu4OsTDgxcnk4oz3m4UoDf	4	\N	\N	\N	\N
44	2	Test	User	Female	tester21@yopmail.com	$2a$10$NoCJulSLle13D.ZTXkCiw.17di4C0tKF0hsZ5KaIPa1Tds7c.h/QC	\N	\N	\N	\N	CMBH	\N	\N	1	2020-05-05 10:53:07	2020-05-05 12:09:51	fUTYBQHkRuCbgLDwTCjOcr:APA91bF9-gSDXPNH3c395JEFy3BG9kRXzpZQKsmGyQRIOjXhWsjfqEBbcjH1T8CDA7ASIx0C9BiV6Bngr4mn2YjuT99Ca1FCT9-VRrM-mbCJZNS7FjaajyTu4OsTDgxcnk4oz3m4UoDf	4	\N	\N	\N	\N
45	2	Test	User	Female	tester22@yopmail.com	$2a$10$iaMo3zKaT1LSV7wPe0Q5uu1584L38EUMUxZvXfLc0JB1kMn2MLzFS	\N	\N	\N	\N	NFJI	\N	\N	1	2020-05-05 10:53:33	2020-05-05 12:11:33	cP7o-75PCUjAlbV4M-eU4X:APA91bHP1nLLKBZ5OLHBD7Kt3muGAfMjBZSScIjiqdjTI7f4xpCE_n3Dd2HFDbBW98C8aetCGFjIEG2NKNvN3kLOs_M9kypRTFRWJPfnvF6iFUV6ALKHH1XzMjPX_xePJlhY2yFOKytG	4	\N	\N	\N	\N
40	2	Test	User	Female	tester17@yopmail.com	$2a$10$6xE2YjCyNZ2yZUXba/4kmuHDXU2ZreYPRLVkeXNVGBbLBw4ulF8/m	\N	\N	\N	\N	YZRK	\N	\N	1	2020-05-05 10:12:28	2020-05-05 10:45:54	fUTYBQHkRuCbgLDwTCjOcr:APA91bF9-gSDXPNH3c395JEFy3BG9kRXzpZQKsmGyQRIOjXhWsjfqEBbcjH1T8CDA7ASIx0C9BiV6Bngr4mn2YjuT99Ca1FCT9-VRrM-mbCJZNS7FjaajyTu4OsTDgxcnk4oz3m4UoDf	4	\N	\N	\N	\N
48	2	Test	User	Female	tester25@yopmail.com	$2a$10$w4SOdlxQHtTnWA3cLdLjOeY1GrDDvyteK1A8GQCCUCri0ZnqB.XK6	\N	\N	\N	\N	VUJR	\N	\N	1	2020-05-05 12:29:48	2020-05-05 12:58:48	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	3	\N	\N	\N	\N
46	2	Test	User	Female	tester23@yopmail.com	$2a$10$5Wlall.xtaHWzYROQBoAcu9JUgbBa/cYcRoTB4WtxHwA2QNLD693q	\N	\N	\N	\N	XDYP	\N	\N	1	2020-05-05 12:05:44	2020-05-05 12:15:39	fUTYBQHkRuCbgLDwTCjOcr:APA91bF9-gSDXPNH3c395JEFy3BG9kRXzpZQKsmGyQRIOjXhWsjfqEBbcjH1T8CDA7ASIx0C9BiV6Bngr4mn2YjuT99Ca1FCT9-VRrM-mbCJZNS7FjaajyTu4OsTDgxcnk4oz3m4UoDf	4	\N	\N	\N	\N
49	2	Test	User	Female	tester26@yopmail.com	$2a$10$Bsda0auXrTlt9VQNeQAzb.k.ud89qqw6rPQdtW2nHVlDEHm3fBS9q	\N	\N	\N	\N	IASV	\N	\N	1	2020-05-05 12:30:21	2020-05-05 12:31:14	dzRpPkJbDk7OgEIvDMdO8a:APA91bGbgslSWr6Bpb99bhNZavZvWrUZL1vRWCIfxrwCP6y80d04fk19ne5V3hT1dV5Cbx9aNvey60x1DViQ37buj18etU1VvXh4gSb06PZvDeQXKAqhDl6kjAigR1M-XKLxl-S2OMNK	4	\N	\N	\N	\N
29	2	Test	User	Female	tester6@yopmail.com	$2a$10$NEeyTcRM2eWfNKSHoPOCH.XPG9pCSMFiR/7Yi9jDQ0gV7fjPtlK7G	\N	\N	\N	\N	KCRF	\N	\N	1	2020-05-05 07:28:12	2020-05-06 09:51:38	fJdaNn10TJedC7-L3wYBxG:APA91bHZyC-hvENtlYiAfW-Jyk...	5	\N	\N	\N	\N
55	2	sdxds	sdfsdf	female	sdfsdf2efef@dghd.sdgfsdf	$2a$10$fPV67W0LJaHIeMfz.XeGW.tVwNKoIhAeTXcJE0jbCsC.Xvu8Z.Jxm	\N	\N	\N	\N	JGCK	\N	\N	1	2020-05-05 01:11:42	2020-05-05 01:11:42	\N	1	\N	\N	\N	\N
41	2	Test	User	Female	tester18@yopmail.com	$2a$10$Ok0by2XTRV2Aj6kJPEn/COSelKDrQw.tjJtGPAP6a26MDJSfXk87O	\N	\N	\N	\N	YXXJ	\N	\N	1	2020-05-05 10:12:58	2020-05-05 01:02:07	fJdaNn10TJedC7-L3wYBxG:APA91bHZyC-hvENtlYiAfW-Jyk...	4	\N	\N	\N	\N
53	2	Test	User	Female	tester28@yopmail.com	$2a$10$VxXr4L8JrD55785mMav6sOawttWwwfmdA1f/i31814zl/SLzduSN6	\N	\N	\N	\N	EGXO	\N	\N	1	2020-05-05 01:02:18	2020-05-05 01:02:18	\N	1	\N	\N	\N	\N
56	2	David	nibley	male	dave@dave.com	$2a$10$roLrMMUVrC/7q6qFn374y.W.0Jxeq5VMNb7dJKL/uBwyxvqZYJLgu	\N	\N	\N	\N	NDEL	\N	\N	1	2020-05-05 02:04:01	2020-05-05 02:04:01	\N	1	\N	\N	\N	\N
54	2	Test	User	Female	tester29@yopmail.com	$2a$10$f8NJKhJ4vMmdUUAJmSMFWulPb5zNtBsmwF.cUP.S2GbBEqmbpE9dG	\N	\N	\N	\N	ZQLO	\N	\N	1	2020-05-05 01:03:10	2020-05-05 01:03:30	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	4	\N	\N	\N	\N
339	2	mka	mka	female	mk1@yopmail.com	$2a$10$69EnDC6eToFmqvexiJHKOe3MRjE9qNAExH.y89SY46Hs6dlX9rsJK	\N	\N	\N	\N	KDTP	0	2020-06-11 07:50:14	1	2020-06-08 05:47:14	2020-06-10 07:48:49	cBGUBvLg3UkCvIyOVaEWgE:APA91bGd17wyo3qilgVfI6KCFWlCBS8DvqnW8en68TCPtgvAb8nLKVCQobnovbWL2aX76zwFYoCXomycf3b8RwzIASz-UJLRVLY337twfgU-GB6eHXgWwHqQs-z8ogGWnhtznrbpn4tM	7	\N	\N	\N	2020-06-10 07:50:14
365	2	Aaa	Abc	female	abc1@yopmail.com	$2a$10$yg9lSld0iS.8UTO.BKjXhuJk/rnVO5OBWdeBU9kBufmMgqs/QUoja	\N	\N	\N	\N	NTJQ	\N	\N	1	2020-06-30 04:29:00	2020-07-01 04:26:34	dAWo1eAZR7a0v8xE19aj4o:APA91bFCoZUC1ICfdzgXcEXIJkRDM7F__WpxpHfeV9kWhimH6RPLiMq606W4lbydTflMHwKUJEaaZL4Z6AlpKpLIniSDeCuzqvRH3BCdnoI9VK15LTfl7drcEDw26FV8CAXiS9oC5qyp	1	\N	\N	\N	\N
70	2	Test	User	Female	tester41@yopmail.com	$2a$10$QfkXLr6dKs7Ppmf1FJnbWuyz3QFiN1n3yf19.E0hn7fiJn20OzLJa	\N	\N	\N	\N	DYEV	\N	\N	1	2020-05-06 12:47:42	2020-05-06 12:50:49	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
64	2	Test	User	Female	tester37@yopmail.com	$2a$10$B1gG7.4R8wqeIoGkIodHOen/Isx8b53H2o1/8N7V0hczc8eOd9GHC	\N	\N	\N	\N	SJGP	\N	\N	1	2020-05-06 12:31:56	2020-05-06 12:32:36	ef_3W_0uSp-SgyBseyU7hw:APA91bEU4kjdhMn0ppVBE4ipXBovKzCFpYAKLFsev_uFjta4SxgDGl4c5LU9kbQTbl9yWwAAyLLFws-7GfaNx_1kyuST8yMSqVs0k6D8YGMD7BP11Bx86yByDSrmLVaWmYbDvca_CLfq	4	\N	\N	\N	\N
63	2	Test	User	Female	tester36@yopmail.com	$2a$10$w8BedfjXlegj8FnHwPjLH.Pkn9e2OvoQS4n61XGE1Ur9dbmNNjkbe	\N	\N	\N	\N	IFDV	\N	\N	1	2020-05-06 12:31:37	2020-05-06 12:32:14	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	5	\N	\N	\N	\N
33	2	Test	User	Female	tester10@yopmail.com	$2a$10$sL/NWcTan28MA0DuSh0cE.SbHJiFoHOZhu.T9RXOoZzQIkI587md6	\N	\N	\N	\N	ZDVP	\N	\N	1	2020-05-05 09:21:17	2020-05-06 12:07:00	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	5	\N	\N	\N	\N
35	2	Test	User	Female	tester12@yopmail.com	$2a$10$/gq6qfmFwyHL5N0.2PNDkudT8afFXeZULdiCcCYVU.v7UISgsdPMC	\N	\N	\N	\N	JNHH	\N	\N	1	2020-05-05 09:40:31	2020-05-06 12:08:49	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
66	2	Test	User	Female	tester39@yopmail.com	$2a$10$YkqAAsdxcnU4c4wLS9F.rOs4FeOyHjtQS7r3nRfyFp0/tGD3fUrAq	\N	\N	\N	\N	MQET	\N	\N	1	2020-05-06 12:35:32	2020-05-06 12:36:18	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
58	2	Test	User	Female	tester31@yopmail.com	$2a$10$fEXkJRUVBPFg.8wSn5Vl.efLaz05kW2hxISZia.qQYT/AbhFwwb5C	\N	\N	\N	\N	IOJU	\N	\N	1	2020-05-06 12:09:07	2020-05-06 12:13:05	ef_3W_0uSp-SgyBseyU7hw:APA91bEU4kjdhMn0ppVBE4ipXBovKzCFpYAKLFsev_uFjta4SxgDGl4c5LU9kbQTbl9yWwAAyLLFws-7GfaNx_1kyuST8yMSqVs0k6D8YGMD7BP11Bx86yByDSrmLVaWmYbDvca_CLfq	6	\N	\N	\N	\N
59	2	Test	User	Female	tester32@yopmail.com	$2a$10$du4wHr4XsteSiJFWwdLDGeBqrOnUEM2qUW8nq9v6ZJLSf.ot/H8zG	\N	\N	\N	\N	UMWL	\N	\N	1	2020-05-06 12:18:44	2020-05-06 12:30:10	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
62	2	Test	User	Female	tester35@yopmail.com	$2a$10$oVgS5Npqnf6nfy0OhKimxeyYU8OtTbzt5X2VImlGCD2bpm11Wl5m.	\N	\N	\N	\N	GONE	\N	\N	1	2020-05-06 12:20:15	2020-05-06 12:31:01	ef_3W_0uSp-SgyBseyU7hw:APA91bEU4kjdhMn0ppVBE4ipXBovKzCFpYAKLFsev_uFjta4SxgDGl4c5LU9kbQTbl9yWwAAyLLFws-7GfaNx_1kyuST8yMSqVs0k6D8YGMD7BP11Bx86yByDSrmLVaWmYbDvca_CLfq	5	\N	\N	\N	\N
65	2	Test	User	Female	tester38@yopmail.com	$2a$10$NcWaw1Sx/wZwHTQCLceueeYZpwEl00oWdCWHr54NeR0HgD.xa34Am	\N	\N	\N	\N	SFLN	\N	\N	1	2020-05-06 12:35:29	2020-05-06 12:35:55	ef_3W_0uSp-SgyBseyU7hw:APA91bEU4kjdhMn0ppVBE4ipXBovKzCFpYAKLFsev_uFjta4SxgDGl4c5LU9kbQTbl9yWwAAyLLFws-7GfaNx_1kyuST8yMSqVs0k6D8YGMD7BP11Bx86yByDSrmLVaWmYbDvca_CLfq	5	\N	\N	\N	\N
67	2	skkdkx	skkcck	female	atw@yopmail.com	$2a$10$3Y92er0Vpirm3c0e5nhCJucNQFQ0eEIFLF2imR4NtbmLVVybnKEmq	\N	\N	\N	\N	TOOK	\N	\N	1	2020-05-06 12:45:23	2020-05-06 12:45:23	\N	1	\N	\N	\N	\N
68	2	bush	Kay	male	if@yopmail.com	$2a$10$rn3dtF7//qz35/5eIJtZa.kxmvU2bOM9xDcvPwqgM.Wvi6379g17m	1588769274214.jpeg	\N	\N	\N	TGFY	\N	\N	1	2020-05-06 12:47:38	2020-05-06 12:47:54	\N	1	\N	\N	\N	\N
71	2	ajsj	skjd	female	ak@yopmail.com	$2a$10$evcqRl2Kf5L8hBPb4wphx.mItNIKrTYpP6GH4sRhWPGqfFwT/pWWS	1588769373467.jpeg	\N	\N	\N	LGDR	\N	\N	1	2020-05-06 12:49:14	2020-05-06 12:50:41	fy-PIK2y_Uunk8QEBtTRUn:APA91bFO5xOPVlmuD6t8Yurh5oYZttXGXzOjGAj3If_LViD-piQ3iY4AZzhQGYdI6SBJ3BycTfi76OXQxLHBJQZmSMlGCzvMOUfhSaSNKLu56cN-nOjYBr1y7NsO17ZlJKHl7QRUpcpy	4	\N	\N	\N	\N
73	2	sgvsxgs	sdgvdsxg	female	dsgdsgv@afaf.afaf	$2a$10$bg5hOomEsWbViTpnPpWTLucqJJLmEjOleyOIi2VBdCr5m6pk5QtBO	\N	\N	\N	\N	EZLW	\N	\N	1	2020-05-06 01:03:37	2020-05-06 01:03:37	\N	1	\N	\N	\N	\N
74	2	sdfgdfg	sgg	female	sdgdsg@awf.af	$2a$10$lEm.jbQJxo7Nhkuni1UeV.moy6NdXVdFaFuyvy98tPwnb/YUtGlEO	\N	\N	\N	\N	XQNP	\N	\N	1	2020-05-06 01:04:19	2020-05-06 01:04:19	\N	1	\N	\N	\N	\N
75	2	dfsf	sdfsdf	female	sgsdf@af.afs	$2a$10$XeGVWoWR7y6f4kH.hG3AFuJPvTjZm8sWzQdjEmESRKPXjnl1MoUou	\N	\N	\N	\N	RYPM	\N	\N	1	2020-05-06 01:05:07	2020-05-06 01:05:07	\N	1	\N	\N	\N	\N
76	2	sfsdf	sdfsf	female	sdfsf@af.aszf	$2a$10$XW7ndyZr5b.mvbekuEOOueLtsxZjBONARY8TsEaTBWLTVNz.p51la	\N	\N	\N	\N	XYWJ	\N	\N	1	2020-05-06 01:06:14	2020-05-06 01:06:14	\N	1	\N	\N	\N	\N
69	2	Test	User	Female	tester40@yopmail.com	$2a$10$0cC44vYR/Plfz7nDN883s.cEE9j5/ql03pfxWDW0GP3c3/VIkvu2q	\N	\N	\N	\N	IYUQ	\N	\N	1	2020-05-06 12:47:38	2020-05-06 12:50:40	ef_3W_0uSp-SgyBseyU7hw:APA91bEU4kjdhMn0ppVBE4ipXBovKzCFpYAKLFsev_uFjta4SxgDGl4c5LU9kbQTbl9yWwAAyLLFws-7GfaNx_1kyuST8yMSqVs0k6D8YGMD7BP11Bx86yByDSrmLVaWmYbDvca_CLfq	6	\N	\N	\N	\N
80	2	Test	User	Female	tester42@yopmail.com	$2a$10$y6lwYDnrSIYUKHwSWSUQHuKFarHlMr3xK8yvWuzKhgr/vC.LTR52W	\N	\N	\N	\N	ANDM	\N	\N	1	2020-05-06 01:09:11	2020-05-06 01:10:59	ef_3W_0uSp-SgyBseyU7hw:APA91bEU4kjdhMn0ppVBE4ipXBovKzCFpYAKLFsev_uFjta4SxgDGl4c5LU9kbQTbl9yWwAAyLLFws-7GfaNx_1kyuST8yMSqVs0k6D8YGMD7BP11Bx86yByDSrmLVaWmYbDvca_CLfq	5	\N	\N	\N	\N
72	2	Ana	Hathaway	female	ana@yopmail.com	$2a$10$uVoSo0FGllRE6ohBWky5vubQM7kGKaGuE0L/8P1p96vNefYA.8s4u	1588769863809.jpeg	\N	\N	\N	QIKA	\N	\N	1	2020-05-06 12:57:23	2020-05-07 08:26:22	eTCwc_kts00kmi-8P9jIUZ:APA91bGRtRBixfJy7X8n0EWuU3SEn7CMw9MV4N2J4KuoxF-ujjZL6f8yAFgw7v1yhc-mRCUr3yXJX_chmOVtamv_fqYbvWM3cgFT90vr-NYwvIMvY-m0P5A0tE5CgaI2Wkz6YxYKsmpK	4	\N	\N	\N	\N
77	2	Jsjd	Jsjs	female	jsjd@jdkd.jdkd	$2a$10$8dS3YngyT3PI3/NGALfODe4pJ4.eBXQS2y8VXCeAvsVr5u81CifLm	\N	\N	\N	\N	QWHL	\N	\N	1	2020-05-06 01:07:35	2020-05-06 01:07:35	\N	1	\N	\N	\N	\N
78	2	Hzjs	Hsjs	female	hsjs@hsks.jdkd	$2a$10$3mwFyoxr9Dao.7DQAvVfH.z04TtXprCMtxLw7kMYiqeVrT6kQeNhW	\N	\N	\N	\N	YCFE	\N	\N	1	2020-05-06 01:08:07	2020-05-06 01:08:07	\N	1	\N	\N	\N	\N
79	2	adszf	dsdfv	female	sdvdszfv@fa.aef	$2a$10$ivPeJIv/OvbGbFYlCmRK2OagTAnxORNv7XjNWeKcyivpdhCwOT3m.	\N	\N	\N	\N	OZNX	\N	\N	1	2020-05-06 01:08:35	2020-05-06 01:08:35	\N	1	\N	\N	\N	\N
81	2	Test	User	Female	tester43@yopmail.com	$2a$10$PsX/ED41q/SLtB9lLN4W9.xo/q/QOclaGFRkWiS3flZ7/PWZvunOK	\N	\N	\N	\N	KAUM	\N	\N	1	2020-05-06 01:09:14	2020-05-06 01:11:24	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
82	2	Test	User	Female	tester44@yopmail.com	$2a$10$GldZkhKod3oYm3SjHr5Ztek6B1QSejI1GggOyYrJrgEi47fUubuS6	\N	\N	\N	\N	FNPL	\N	\N	1	2020-05-06 01:14:28	2020-05-06 01:14:50	ef_3W_0uSp-SgyBseyU7hw:APA91bEU4kjdhMn0ppVBE4ipXBovKzCFpYAKLFsev_uFjta4SxgDGl4c5LU9kbQTbl9yWwAAyLLFws-7GfaNx_1kyuST8yMSqVs0k6D8YGMD7BP11Bx86yByDSrmLVaWmYbDvca_CLfq	4	\N	\N	\N	\N
83	2	Test	User	Female	tester45@yopmail.com	$2a$10$MfAY9B4BFgrn0wY6tbsBU.kP.9akq7qRuRCkwTMzdE9.7e1wLfPfC	\N	\N	\N	\N	IFMS	\N	\N	1	2020-05-06 01:14:31	2020-05-06 01:15:20	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	4	\N	\N	\N	\N
94	2	Test	User	Female	tester56@yopmail.com	$2a$10$1ynsfr8Qn5mj0r6UW8mWXuK8t3VBhb1Ir60RMY5hP54XF3473NceG	\N	\N	\N	\N	FFHB	\N	\N	1	2020-05-06 01:39:47	2020-05-07 08:51:58	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
95	2	Test	User	Female	tester57@yopmail.com	$2a$10$HAqN1Ti7VQanGHMqN8ssje6aFk2fC3tdvbFeSI1drJtOTpAGjbI8q	\N	\N	\N	\N	PNBP	\N	\N	1	2020-05-06 01:39:51	2020-05-07 08:31:44	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
91	2	Test	User	Female	tester53@yopmail.com	$2a$10$3zcg.1BKRLSbTprbNkkueu.TX4Ssf2SLvGGZsBWQTlZDysHSC.6LC	\N	\N	\N	\N	QUDP	\N	\N	1	2020-05-06 01:34:12	2020-05-06 01:35:36	ef_3W_0uSp-SgyBseyU7hw:APA91bEU4kjdhMn0ppVBE4ipXBovKzCFpYAKLFsev_uFjta4SxgDGl4c5LU9kbQTbl9yWwAAyLLFws-7GfaNx_1kyuST8yMSqVs0k6D8YGMD7BP11Bx86yByDSrmLVaWmYbDvca_CLfq	6	\N	\N	\N	\N
87	2	Test	User	Female	tester49@yopmail.com	$2a$10$49mfG9HaEim1VgkOp4lEK.g09gYIJ9hhbvEcnLIGVZ9lqym19t6Ba	\N	\N	\N	\N	BXPZ	\N	\N	1	2020-05-06 01:22:12	2020-05-06 01:22:58	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
88	2	Test	User	Female	tester50@yopmail.com	$2a$10$0DJKRIzcwiQRM/PzZD6g3OK4JFwQjgrYg0pgUb/XrBkGsjXxFVBBO	\N	\N	\N	\N	APQC	\N	\N	1	2020-05-06 01:31:25	2020-05-06 01:31:51	ef_3W_0uSp-SgyBseyU7hw:APA91bEU4kjdhMn0ppVBE4ipXBovKzCFpYAKLFsev_uFjta4SxgDGl4c5LU9kbQTbl9yWwAAyLLFws-7GfaNx_1kyuST8yMSqVs0k6D8YGMD7BP11Bx86yByDSrmLVaWmYbDvca_CLfq	6	\N	\N	\N	\N
89	2	Test	User	Female	tester51@yopmail.com	$2a$10$RVQn2QHdwoSxAN.YdkG8VeQMwv8iF7HWdSp2kpNQnX9vzFCRn5U..	\N	\N	\N	\N	JXXR	\N	\N	1	2020-05-06 01:31:28	2020-05-06 01:32:07	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
86	2	Test	User	Female	tester48@yopmail.com	$2a$10$3P2.S8Z3o0nWfMA13mJrl.tSzkUGOx2ThjUKgtCoJqtejv16.LPGa	\N	\N	\N	\N	RFKR	\N	\N	1	2020-05-06 01:22:08	2020-05-06 01:22:35	ef_3W_0uSp-SgyBseyU7hw:APA91bEU4kjdhMn0ppVBE4ipXBovKzCFpYAKLFsev_uFjta4SxgDGl4c5LU9kbQTbl9yWwAAyLLFws-7GfaNx_1kyuST8yMSqVs0k6D8YGMD7BP11Bx86yByDSrmLVaWmYbDvca_CLfq	5	\N	\N	\N	\N
85	2	Test	User	Female	tester47@yopmail.com	$2a$10$AOY4o38MaVX5vUyUBUbbi.yGF1VMBsfko7L.xw81Gwc9TXggjNFoS	\N	\N	\N	\N	MCMP	\N	\N	1	2020-05-06 01:17:22	2020-05-06 01:18:48	ef_3W_0uSp-SgyBseyU7hw:APA91bEU4kjdhMn0ppVBE4ipXBovKzCFpYAKLFsev_uFjta4SxgDGl4c5LU9kbQTbl9yWwAAyLLFws-7GfaNx_1kyuST8yMSqVs0k6D8YGMD7BP11Bx86yByDSrmLVaWmYbDvca_CLfq	6	\N	\N	\N	\N
84	2	Test	User	Female	tester46@yopmail.com	$2a$10$FkopihKFc/ilMYKoH.99VOJ3AJsQU8A.gMWrNGiZ.PvndN2NM9AF6	\N	\N	\N	\N	AGPH	\N	\N	1	2020-05-06 01:17:18	2020-05-06 01:18:46	ef_3W_0uSp-SgyBseyU7hw:APA91bEU4kjdhMn0ppVBE4ipXBovKzCFpYAKLFsev_uFjta4SxgDGl4c5LU9kbQTbl9yWwAAyLLFws-7GfaNx_1kyuST8yMSqVs0k6D8YGMD7BP11Bx86yByDSrmLVaWmYbDvca_CLfq	6	\N	\N	\N	\N
90	2	Test	User	Female	tester52@yopmail.com	$2a$10$zsnKhjVwGSximueBNe3x5Ob0z5Bdy2X.X492jbT74Em6n0abBdWkS	\N	\N	\N	\N	OUEX	\N	\N	1	2020-05-06 01:34:08	2020-05-06 01:35:02	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
92	2	Test	User	Female	tester54@yopmail.com	$2a$10$fma8udAvgk61/rS0xz5dxeJWAPHuUIBoSb0VL7wIpJLvAE3cnayua	\N	\N	\N	\N	ESWW	\N	\N	1	2020-05-06 01:37:18	2020-05-06 01:37:52	ef_3W_0uSp-SgyBseyU7hw:APA91bEU4kjdhMn0ppVBE4ipXBovKzCFpYAKLFsev_uFjta4SxgDGl4c5LU9kbQTbl9yWwAAyLLFws-7GfaNx_1kyuST8yMSqVs0k6D8YGMD7BP11Bx86yByDSrmLVaWmYbDvca_CLfq	6	\N	\N	\N	\N
93	2	Test	User	Female	tester55@yopmail.com	$2a$10$g9lF.bi/QS8.TrcXoO.7PeEMRDB8w1l6gq1PIDnb655NL8sdQc2am	\N	\N	\N	\N	DOGU	\N	\N	1	2020-05-06 01:37:22	2020-05-06 01:38:07	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
100	2	tester	users	female	testuser@yopmail.com	$2a$10$CgTk/FEDbyfex4GnxI1kNOixw4nCDLo26IVcdKHRNNGDqXwL79AAa	1588846491539.jpeg	\N	\N	\N	ZHVW	\N	\N	1	2020-05-07 10:14:37	2020-05-07 10:43:57	fJdaNn10TJedC7-L3wYBxG:APA91bHZyC-hvENtlYiAfW-Jyk...	6	\N	\N	\N	\N
96	2	af	SZC	female	axd@af.sf	$2a$10$YA.vxu18ebURvJBosurEDeRqcTbVIXjuXbUdu.N0dKwEp6cnLGCsO	\N	\N	\N	\N	OUBP	\N	\N	1	2020-05-07 08:49:24	2020-05-07 08:49:24	\N	1	\N	\N	\N	\N
97	2	ESDF	SF	female	sdf@af.sg	$2a$10$ylsl9yqlfxs2nG.P0J54LelctYPFuNIz54Y6vdi7hsPAaenzFxQUS	\N	\N	\N	\N	RDDU	\N	\N	1	2020-05-07 08:51:30	2020-05-07 08:51:30	\N	1	\N	\N	\N	\N
103	2	Test	User	Female	tester62@yopmail.com	$2a$10$O0qDlaDCC/.xXL4YSs9hEOH76VC9A498ufajqdpHQgPih3mBDPa62	\N	\N	\N	\N	EQMO	\N	\N	1	2020-05-07 12:49:03	2020-05-07 01:00:15	fDTae80rTjuAXawqwI1Scj:APA91bEnegfkrCQf2IAsmy6lDRfprQVHqUmHd3YdxD3L8zt-5LtNc0_MUwBCcfpUGtuKim3oMYUXL2S3mrMOlO68v27Vg2fA9Vzwcv2P2AXU-h8xum9beBJlTn_NGt-FIsLnOG2Hnc82	6	\N	\N	\N	\N
101	2	Test	User	Female	tester60@yopmail.com	$2a$10$Qbw4RmLHESPWu9tfhh2VnOT2mKkJs4m.Mw8PG6g9MNa1IfolsVrwq	\N	\N	\N	\N	OGQI	\N	\N	1	2020-05-07 10:37:17	2020-05-07 10:41:36	ef_3W_0uSp-SgyBseyU7hw:APA91bEU4kjdhMn0ppVBE4ipXBovKzCFpYAKLFsev_uFjta4SxgDGl4c5LU9kbQTbl9yWwAAyLLFws-7GfaNx_1kyuST8yMSqVs0k6D8YGMD7BP11Bx86yByDSrmLVaWmYbDvca_CLfq	6	\N	\N	\N	\N
102	2	Test	User	Female	tester61@yopmail.com	$2a$10$NZafQ2/7yqYpsB0UqQKO0OZIrwC4V6HbQksjzuE5qN4trbLxK/U3e	\N	\N	\N	\N	FZME	\N	\N	1	2020-05-07 10:47:43	2020-05-07 02:13:56	fJdaNn10TJedC7-L3wYBxG:APA91bHZyC-hvENtlYiAfW-Jyk...	6	\N	\N	\N	\N
98	2	Test	User	Female	tester59@yopmail.com	$2a$10$4eAnBHViJmsfYGkfl1DafOEIlBWPuqIguB41JtZlcITxDzDC7rHb.	\N	\N	\N	\N	EQAI	\N	\N	1	2020-05-07 08:52:44	2020-05-14 06:30:01	1234567894dsd	7	\N	\N	\N	\N
104	2	Tester	User	Male	tester63@yopmail.com	$2a$10$f4aMrHj8uYHG8Lw5uAeSTeWd9EpbGtrNpcDVmL6bcK4s1YgsbDzLm	\N	\N	\N	\N	LKMQ	\N	\N	1	2020-05-07 01:00:51	2020-05-07 01:41:42	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
358	2	Female	Test	female	female@yopmail.com	$2a$10$Olfpq03Al535/VvYtUPHauuScYN1IJuEA1yK6FZ6oa66pcytCbB7W	\N	\N	\N	\N	AATQ	\N	\N	1	2020-06-12 10:54:15	2020-06-12 10:56:29	czIDQJQfS02amsfu51wV9I:APA91bEg7ShlMZ3R7kTVlUQ4sqvdMQOUMORtcvzqHHhX9do_lZRL5sA7zKxmKxh5zDrn9OzpcL2e7c0O7gILl1c_D43Kibr6oAEPSM17yrsvwAOeqPCmX6SvMb9oq_EEazh5miKVwz93	1	\N	\N	\N	\N
366	2	Felice	Mcknight	female	felicemcknight@hotmail.com	$2a$10$Lpzf1K9OXVSVsvMTSu9t8.UBl8UUw0c2tdRj.jLXKoqiQb86fu.lG	\N	\N	\N	\N	ANXJ	\N	\N	1	2020-07-14 04:09:12	2020-07-17 03:35:34	c4q-8mzhJ00npVjO21QbvX:APA91bGHIb-Nn_h2EpeEtl77Kfc-qbBUqRFBsJ8K8hhk5Dcfq-pfP3EZT1MbPtiLuRevs_r-AYjnNjZ3dZ-uappdoZWq8Jwu8Y2e73E7P6mKQjdciGgL08wT0LwDAMiEVuJCGnpXASak	6	\N	\N	\N	\N
110	2	tester	useerrM	male	tester65@gmail.com	$2a$10$JTJBy38m8a0I0zcfixKUduiTCvDSsdxlrRTl2BZaZeDaDF3WS7rIu	1588862110832.jpeg	\N	\N	\N	SKOH	\N	\N	1	2020-05-07 02:35:01	2020-05-07 02:35:11	\N	1	\N	\N	\N	\N
111	2	tester	userm	female	tester66@gmail.com	$2a$10$Lvwt4qGzxmFbQztvPQy7UOhbcaIzRZ9EyYXy72j9bMCXd.fTY1JNO	\N	\N	\N	\N	MNJZ	\N	\N	1	2020-05-07 02:37:28	2020-05-07 02:37:28	\N	1	\N	\N	\N	\N
105	2	Testerrr	Userrr	Female	tester64@yopmail.com	$2a$10$ssNLJ7VIJvZiVWfDQVQxR./Yh8XIZwDJVKJfcGqSpHnOZJwisqni2	\N	\N	\N	\N	SBYB	\N	\N	1	2020-05-07 01:01:10	2020-05-07 01:01:52	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
106	2	test	test	female	test70@yopmail.com	$2a$10$/K1ywNb2G2URmzHKn6kZ8uFK6ns8Q4fEVht7m7xCfkk9CIyUtd1Au	\N	\N	\N	\N	MLSN	\N	\N	1	2020-05-07 01:46:13	2020-05-07 01:46:13	\N	1	\N	\N	\N	\N
112	2	test	userm	male	testter65@yopmail.com	$2a$10$ZO3s2OTsFeN4pwwHGZ/2rujvpT.XX1vamveujG.Nl1aZAi20VHVCC	1588862337629.jpeg	\N	\N	\N	KWIO	\N	\N	1	2020-05-07 02:38:45	2020-05-07 02:38:58	\N	1	\N	\N	\N	\N
108	2	at	ta	female	abhinav.t@yopmail.con	$2a$10$6HAhUAB1InT1vTUkhZzeKuKb1Ip6hIbmqBJ.0oMioHPoscPyQ4ihi	\N	\N	\N	\N	KNGA	\N	\N	1	2020-05-07 01:52:33	2020-05-07 01:52:33	\N	1	\N	\N	\N	\N
115	2	Testerrr	Userrr	memale	tester68@yopmail.com	$2a$10$OljuFte5UXu96oH8X3yLL.8M5BS6kWn4diayigmvaRINWR8NdVUbC	\N	\N	\N	\N	JTGT	\N	\N	1	2020-05-07 02:57:38	2020-05-07 02:57:38	\N	1	\N	\N	\N	\N
119	2	Testerrr	Userrr	male	tester72@yopmail.com	$2a$10$2J/Qx5YBH5IczgSJw66s8uA4LM95Z6Pfps5zS665pSxBvq2Jyz4/C	\N	\N	\N	\N	HIWY	\N	\N	1	2020-05-07 03:15:20	2020-05-07 03:19:09	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
113	2	asf	asf	female	tester65@yopmail.com	$2a$10$ax4.In7DEA6eRh9VQkyQpeRpKgmYGU0b6exif9V25qMptxZjM1Bbe	1588862377935.jpeg	\N	\N	\N	TJCE	\N	\N	1	2020-05-07 02:39:32	2020-05-07 03:23:16	fJdaNn10TJedC7-L3wYBxG:APA91bHZyC-hvENtlYiAfW-Jyk...	6	\N	\N	\N	\N
109	2	as	ss	female	aa@yopmail.com	$2a$10$W0lppJ9EhTlUYZ6rCefuPuentnGc3ZvTnXtbMb.lNH2nyq9vkcy0y	\N	\N	\N	\N	LXEM	\N	\N	1	2020-05-07 01:53:43	2020-05-07 01:54:28	fy-PIK2y_Uunk8QEBtTRUn:APA91bFO5xOPVlmuD6t8Yurh5oYZttXGXzOjGAj3If_LViD-piQ3iY4AZzhQGYdI6SBJ3BycTfi76OXQxLHBJQZmSMlGCzvMOUfhSaSNKLu56cN-nOjYBr1y7NsO17ZlJKHl7QRUpcpy	6	\N	\N	\N	\N
117	2	Testerrr	Userrr	female	tester70@yopmail.com	$2a$10$5g3COE334LZi06kouMwQ2.lbbRrndnhtaKXt7/Tt7vmp8FNtkfiwe	\N	\N	\N	\N	QICV	\N	\N	1	2020-05-07 02:57:58	2020-05-07 03:07:38	fDTae80rTjuAXawqwI1Scj:APA91bEnegfkrCQf2IAsmy6lDRfprQVHqUmHd3YdxD3L8zt-5LtNc0_MUwBCcfpUGtuKim3oMYUXL2S3mrMOlO68v27Vg2fA9Vzwcv2P2AXU-h8xum9beBJlTn_NGt-FIsLnOG2Hnc82	6	\N	\N	\N	\N
107	2	test	test	female	test71@yopmail.com	$2a$10$uiDUcZT7ls8iEeOGs.3qYeglt8gvCiyy6iQoal9RrJ8nz62AKznUy	\N	\N	\N	\N	NQBA	\N	\N	1	2020-05-07 01:47:10	2020-05-07 02:26:32	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
118	2	Testerrr	Userrr	female	tester71@yopmail.com	$2a$10$Q2j54Ctk5ZxWqlBwYYKfF.48ahomnXfwEtC4sfQdrmUS4M7zM.IoO	\N	\N	\N	\N	FJCX	\N	\N	1	2020-05-07 03:15:12	2020-05-07 03:15:41	fDTae80rTjuAXawqwI1Scj:APA91bEnegfkrCQf2IAsmy6lDRfprQVHqUmHd3YdxD3L8zt-5LtNc0_MUwBCcfpUGtuKim3oMYUXL2S3mrMOlO68v27Vg2fA9Vzwcv2P2AXU-h8xum9beBJlTn_NGt-FIsLnOG2Hnc82	6	\N	\N	\N	\N
120	2	Testerrr	Userrr	male	tester73@yopmail.com	$2a$10$FFhBcgeiipteIuzP5rL0t.0ChiN9eMu5.pc0TW3xpJyb2pVGJ/yey	\N	\N	\N	\N	QOPQ	\N	\N	1	2020-05-07 03:19:54	2020-05-07 03:26:55	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
114	2	Test	Jdjjd	male	tester66@yopmail.com	$2a$10$/IkF0V7tJ3Q6DcJ7.PrDbOQOWb0qJjqQa8f2MxAjG7LMsVuNvCX8G	\N	\N	\N	\N	MTCH	\N	\N	1	2020-05-07 02:45:19	2020-05-07 02:52:39	fDTae80rTjuAXawqwI1Scj:APA91bEnegfkrCQf2IAsmy6lDRfprQVHqUmHd3YdxD3L8zt-5LtNc0_MUwBCcfpUGtuKim3oMYUXL2S3mrMOlO68v27Vg2fA9Vzwcv2P2AXU-h8xum9beBJlTn_NGt-FIsLnOG2Hnc82	6	\N	\N	\N	\N
116	2	Testerrr	Userrr	male	tester69@yopmail.com	$2a$10$iKwK3x.fY2/KFmQI2KwDae/GYfanCEZlvmoYqw5mKID9ZzXu3WTDu	\N	\N	\N	\N	YPWP	\N	\N	1	2020-05-07 02:57:48	2020-05-07 02:58:21	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
121	2	Testerrr	Userrr	male	tester74@yopmail.com	$2a$10$hfkmyL.iR9RwJ0/hs5orUugF8lXzERX3TqDlUGgGVjjTPfvhC0Ex.	\N	\N	\N	\N	TRRC	\N	\N	1	2020-05-07 03:19:57	2020-05-07 03:28:10	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
122	2	Testerrr	Userrr	male	tester75@yopmail.com	$2a$10$Hvt0/fPYivXt/4zfNCqap.z2nVpy33FtEV5ugto/s4OI/FRo8DPeC	\N	\N	\N	\N	MPAW	\N	\N	1	2020-05-07 03:26:15	2020-05-07 03:32:02	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
123	2	Testerrr	Userrr	female	tester76@yopmail.com	$2a$10$812sXdcrPaldAAWRne7WXuQKobQtm5oB9qPT7/G.4dOs3nE4Xirva	\N	\N	\N	\N	KVEJ	\N	\N	1	2020-05-07 03:26:22	2020-05-07 05:18:46	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
125	2	Blake	Lively	female	blakelively@yopmail.com	$2a$10$gM8RE6Xt3EaAmEqQ2mZm0.Z16q/0sJuKFI.VDdt62WFHkV/9mT2Ha	1588868161908.jpeg	\N	\N	\N	MEXS	\N	\N	1	2020-05-07 04:15:09	2020-05-07 04:17:21	dc1ClKkb1krnk3C6Kq1suR:APA91bGV0KNWtHJCllQxtqv-60DGuaANkzAnUHhvIPQmR_MoSWGoka5h1yA0YghS5f6wNxaM8ZJH-4odTmBEnY8Z9ooLGr5x5fxc9QTaiQdZknmG2Ajn8MpdHUdj3fLzkz78_RrqTBF-	6	\N	\N	\N	\N
124	2	a	d	male	ab@yopmail.com	$2a$10$WBN1OAWdznm8VJuoSIx31OKW6/nZM9fK2kXtkIWB.CeNxezjKuSza	1588868013365.jpeg	\N	\N	\N	IFOM	\N	\N	1	2020-05-07 04:12:47	2020-05-07 04:36:56	dWDag3JrAUcltiwyt4H4XW:APA91bFAyhWYVNEv2uWrYh_ku5TnjcFjVu-t6BEdSK9YTRRjL5wCBTCtClP8hcDxWXWo0RjYsI54maDRxDk4q1e680W65ppXSGYZ_Hn0Tf_OSj7Q_9w2P55W5EQ8k68zgvJJSMQxOX7u	6	\N	\N	\N	\N
127	2	David	Mcknight	female	david@powerofzero.com	$2a$10$S0zvgDCTmdEvnm.43gFrYeFMXVAFdSjb1jR1HcSA2Qgj5wsNd2o0u	\N	\N	\N	\N	XACC	\N	\N	1	2020-05-07 05:21:20	2020-07-14 04:16:29	eiXuvUDiUUmPr1jkonX8ZF:APA91bGVczRus9g4jPgno0Nmxnrvm1_auNKrz4SNHGPzy_dRJb36rhWXKcGk47S1dwjRZCR72i7cRQ4tUc4gT65u9oXrKVxZmkjkLsGJBtQPfD8nbUAURmcXEtY46Gp7Vx-JY_Mvejol	1	\N	\N	\N	\N
129	2	He	Qwerty	male	she@subcodevs.com	$2a$10$5830Axb9bIzvceIVhyr5Ie954EjomckHPrskVgwQZ9e7ZM/2nX.jm	1588874370910.jpeg	\N	\N	\N	JOFX	\N	\N	1	2020-05-07 05:59:13	2020-05-07 05:59:31	\N	1	\N	\N	\N	\N
128	2	she	try	female	gry@yopmail.com	$2a$10$0jDg62Ep..8HJtWO6DbHO.cm7QG8W75ySp1eTTRYHbkRzD5GAmoqO	1588874321120.jpeg	\N	\N	\N	VSCI	\N	\N	1	2020-05-07 05:58:22	2020-05-07 06:00:35	d2-0hMHahUB7gK13pHWB1U:APA91bEdlHHHP5j2e5OssO3G77fLqq3tudNKFI1N5IrsPNFBO-k3bDPBBQ6HFS5Nvs03v2bPTuNsLuk17ANMVVWMwPUKaMGqAIZNJAQH1vlyuDfZXOZjSxa37aq2ER9ZzxYpBW1J1nd9	5	\N	\N	\N	\N
367	2	David	Mcknight	female	david@pozmarketing.com	$2a$10$s/M5AWYvzjAwJrwKECTbs.8Jg7zF2UYwouoMJspCCW/msJO51TcJC	\N	\N	\N	\N	BLFR	\N	\N	1	2020-07-14 04:18:32	2020-07-14 04:19:28	eiXuvUDiUUmPr1jkonX8ZF:APA91bGVczRus9g4jPgno0Nmxnrvm1_auNKrz4SNHGPzy_dRJb36rhWXKcGk47S1dwjRZCR72i7cRQ4tUc4gT65u9oXrKVxZmkjkLsGJBtQPfD8nbUAURmcXEtY46Gp7Vx-JY_Mvejol	1	\N	\N	\N	\N
147	2	secF	Userrr	female	tester91@yopmail.com	$2a$10$o8XoKnUWH2a/2ct2fiEOj.zKTz1tYw.BH3GDSEyKAc9EDUf4wwTlu	\N	\N	\N	\N	LTKX	\N	\N	1	2020-05-08 01:02:15	2020-05-08 01:03:26	ezLQXBscTvePlmZWXetGht:APA91bGVhaeSFmV20jZDyPLESMVgu2c-jH-h4Edozy6bqsyuOB-ImCkQ_925uxWTFH86E_oxkGT-fuz7PvT0dAQoXr-LTS6zSbksZb0J0emZBFIo_LP7r9_I0aJVPjioVR_QgRkFEAdn	6	\N	\N	\N	\N
130	2	Eidi	Diid	male	fun@yopmail.com	$2a$10$RvdOGHkL1vtbwRvmqeqM3uOyf6IXqBWg.pHwVeGDvQ1iLHkzmRkYa	\N	\N	\N	\N	AXHV	\N	\N	1	2020-05-07 06:01:01	2020-05-07 06:07:57	d2-0hMHahUB7gK13pHWB1U:APA91bEdlHHHP5j2e5OssO3G77fLqq3tudNKFI1N5IrsPNFBO-k3bDPBBQ6HFS5Nvs03v2bPTuNsLuk17ANMVVWMwPUKaMGqAIZNJAQH1vlyuDfZXOZjSxa37aq2ER9ZzxYpBW1J1nd9	5	\N	\N	\N	\N
140	2	TestF	Userrr	male	tester84@yopmail.com	$2a$10$HYU5QQblv00lUPPn7ipMKOXGEl1Pt75FoTy.Rf6g9Fb09sGGpnHsW	\N	\N	\N	\N	BEIF	\N	\N	1	2020-05-08 06:54:01	2020-05-08 10:58:37	ezLQXBscTvePlmZWXetGht:APA91bGVhaeSFmV20jZDyPLESMVgu2c-jH-h4Edozy6bqsyuOB-ImCkQ_925uxWTFH86E_oxkGT-fuz7PvT0dAQoXr-LTS6zSbksZb0J0emZBFIo_LP7r9_I0aJVPjioVR_QgRkFEAdn	6	\N	\N	\N	\N
144	2	twoFemale	Userrr	female	tester88@yopmail.com	$2a$10$jpSpaXTY.y04VHq1EJ8heuXfGUIPjQmf0ONf.jlkH8VSl1zFaYZtO	\N	\N	\N	\N	FTJA	\N	\N	1	2020-05-08 11:10:48	2020-05-08 11:12:35	ezLQXBscTvePlmZWXetGht:APA91bGVhaeSFmV20jZDyPLESMVgu2c-jH-h4Edozy6bqsyuOB-ImCkQ_925uxWTFH86E_oxkGT-fuz7PvT0dAQoXr-LTS6zSbksZb0J0emZBFIo_LP7r9_I0aJVPjioVR_QgRkFEAdn	6	\N	\N	\N	\N
139	2	TestM	Userrr	male	tester83@yopmail.com	$2a$10$FEXqeU5dhdz.LhprYjQE9O4w6IpxT3eg4k/NSFbAyAH./aP4Y.12K	\N	\N	\N	\N	INLX	\N	\N	1	2020-05-08 06:53:55	2020-05-08 11:06:52	fJdaNn10TJedC7-L3wYBxG:APA91bHZyC-hvENtlYiAfW-Jyk...	6	\N	\N	\N	\N
136	2	Testerrr	Userrr	female	tester80@yopmail.com	$2a$10$43/2zceNd27gOUYYfYVXx.LF1S0Tgi3HHKUF6Y8QAZsG0M7hx/pM2	\N	\N	\N	\N	IYXW	\N	\N	1	2020-05-08 06:30:14	2020-05-08 06:35:38	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
133	2	Testerrr	Userrr	female	tester77@yopmail.com	$2a$10$OJ3AOEPoYIPyRjAE24k88ex8WhKWMHAW45Wtvy3kb.Sox70O0FCs2	\N	\N	\N	\N	XXCG	\N	\N	1	2020-05-08 05:45:42	2020-05-08 06:27:40	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	5	\N	\N	\N	\N
134	2	Testerrr	Userrr	female	tester78@yopmail.com	$2a$10$fhRLhvX6VlTGY.t8FBfVL.XBaeV/.dkDZuoYEizpFxC1BA.eWBKWy	\N	\N	\N	\N	UHFN	\N	\N	1	2020-05-08 05:45:46	2020-05-08 06:27:56	czEDsJsVRwWC8-jRT4hMzT:APA91bHON2A0A3M2lxhsLmZO0e1rLsKd-7153sbW7_4cwMxnMuH6b2U21hEwwSKRT52ijUd5_gY0bWSgXw0EZzJ0NvwvSAyi9xbyhhmoEJKVKSa1ovduITbrlcvy0qZCO1B7UspzFxm5	5	\N	\N	\N	\N
137	2	Testerrr	Userrr	female	tester81@yopmail.com	$2a$10$DkFEDNwueEeSA4JK4C65PuUVDoJKGFBgEN49CDpMS6WJSPRpHJh9O	\N	\N	\N	\N	NRDV	\N	\N	1	2020-05-08 06:35:56	2020-05-08 06:36:42	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
131	2	adam	eava	female	t@yopmail.com	$2a$10$nqscWlmJFeGdLiBRfiK3uulnwYHLunDW8jhhCy4Dv7Gm2hp65uk/2	\N	\N	\N	\N	RJBQ	\N	\N	1	2020-05-07 06:10:24	2020-05-07 06:11:01	d2-0hMHahUB7gK13pHWB1U:APA91bEdlHHHP5j2e5OssO3G77fLqq3tudNKFI1N5IrsPNFBO-k3bDPBBQ6HFS5Nvs03v2bPTuNsLuk17ANMVVWMwPUKaMGqAIZNJAQH1vlyuDfZXOZjSxa37aq2ER9ZzxYpBW1J1nd9	6	\N	\N	\N	\N
138	2	Testerrr	Userrr	male	tester82@yopmail.com	$2a$10$zzBKHHFLiDFB4Kt6azyCj.sXTRWa7BXOX8Gmfj29HXJ8lJsBZHoyK	\N	\N	\N	\N	ARJJ	\N	\N	1	2020-05-08 06:36:05	2020-05-08 06:37:30	czEDsJsVRwWC8-jRT4hMzT:APA91bHON2A0A3M2lxhsLmZO0e1rLsKd-7153sbW7_4cwMxnMuH6b2U21hEwwSKRT52ijUd5_gY0bWSgXw0EZzJ0NvwvSAyi9xbyhhmoEJKVKSa1ovduITbrlcvy0qZCO1B7UspzFxm5	6	\N	\N	\N	\N
143	2	oneMale	Userrr	male	tester87@yopmail.com	$2a$10$.XLdTwDpDK5UxvmITIHgZuwQ/PPU7YdlSIjEHYkclN902omTW7GM.	\N	\N	\N	\N	VPNI	\N	\N	1	2020-05-08 11:10:34	2020-05-08 11:14:33	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
135	2	Testerrr	Userrr	female	tester79@yopmail.com	$2a$10$1AhZaBVZKCWoP7dOqGg1dee7JPJMfdS7pW1j.1cDtLU/MVUSqhP7W	\N	\N	\N	\N	EETW	\N	\N	1	2020-05-08 06:21:36	2020-05-08 07:05:20	fJdaNn10TJedC7-L3wYBxG:APA91bHZyC-hvENtlYiAfW-Jyk...	5	\N	\N	\N	\N
141	2	TestF	Userrr	female	tester85@yopmail.com	$2a$10$XQWrXVpwETjOtPgOVjmUSOrpRLnkse8qPf6UBsKzufOq6wp9hT.JG	\N	\N	\N	\N	WXNX	\N	\N	1	2020-05-08 07:13:18	2020-05-08 07:23:17	fJdaNn10TJedC7-L3wYBxG:APA91bHZyC-hvENtlYiAfW-Jyk...	5	\N	\N	\N	\N
146	2	secF	Userrr	female	tester90@yopmail.com	$2a$10$y6y5VlN4cYIUNkxVdrJbLeBZtJot9aX67YO3grPsa5zeyE7Eo/ZiC	\N	\N	\N	\N	PDAQ	\N	\N	1	2020-05-08 12:45:22	2020-05-08 12:52:28	foCrzbML90J_vsXwjHYFx7:APA91bFNFUZOwGhHz_6MY9Lks1phck2gCX1GzP6mwUibpAYr59pTHaWFOChDHxGEKuookBqHLu3aBYoPk_Bd7h6N2Ktx34R9GQqOMH9Nqpd4q6PMUAadzbYszZXmPONeC-7F8ux2yKb2	6	\N	\N	\N	\N
148	2	secF	Userrr	female	tester92@yopmail.com	$2a$10$jm9aVaPI03pV/8Iy0DMove1VaRavTuTilIc4e4SLr9fChlxEgh5uC	\N	\N	\N	\N	IPIJ	\N	\N	1	2020-05-08 01:03:04	2020-05-08 01:15:06	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
142	2	TestF	Userrr	female	tester86@yopmail.com	$2a$10$6PEVboC0gzUL1NpMdUOcD.4sBcaOcb3c/DgKZAkHNkSZnyjNNyjAu	\N	\N	\N	\N	ANJO	\N	\N	1	2020-05-08 11:00:31	2020-05-08 11:12:00	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
145	2	firstM	Userrr	male	tester89@yopmail.com	$2a$10$p7l0lKb9ViQojDF.L7HSf.X8rg0.4yfpmKyssc34xHYXw2XzB1IhS	\N	\N	\N	\N	BPHK	\N	\N	1	2020-05-08 12:45:05	2020-05-08 12:59:29	fJdaNn10TJedC7-L3wYBxG:APA91bHZyC-hvENtlYiAfW-Jyk...	5	\N	\N	\N	\N
149	2	secF	Userrr	female	tester93@yopmail.com	$2a$10$Uy/cO2frWWkotNxQbBnEG.qf33IKH33ERHTDoq/xbb4v6XYpLwCOa	\N	\N	\N	\N	ELZC	\N	\N	1	2020-05-08 01:22:40	2020-05-08 01:25:48	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	5	\N	\N	\N	\N
150	2	secF	Userrr	female	tester94@yopmail.com	$2a$10$x3eRXY3dcb.tclmE7loavucOLAZeCpF.3W8Ws9hunJVCS.5wU/Tmu	\N	\N	\N	\N	QIVC	\N	\N	1	2020-05-08 01:22:46	2020-05-08 01:31:07	ezLQXBscTvePlmZWXetGht:APA91bGVhaeSFmV20jZDyPLESMVgu2c-jH-h4Edozy6bqsyuOB-ImCkQ_925uxWTFH86E_oxkGT-fuz7PvT0dAQoXr-LTS6zSbksZb0J0emZBFIo_LP7r9_I0aJVPjioVR_QgRkFEAdn	4	\N	\N	\N	\N
132	2	Qa	Aq	female	a@yopmail.com	$2a$10$3N6y7iIIkGg1KFTbHXU1x.qyKLDE3sVtlKrfeh4yGCz/D8VbNWHuW	\N	\N	\N	\N	IIOQ	\N	\N	1	2020-05-07 06:11:32	2020-05-22 04:12:09	cu8cR8qlSXyRh59Uv8SllX:APA91bH-cTdn4k7EYINFN53SqQVGKDEeblgrKT8Z-l4NOmsGFycleVAlb8iYvFLrBgn3M4HD6CqJMPZqUx0nG-NDp7p0kbxRwjLTmjSqimo0yjYJasc-OyW87WV9dxoT98Do_Kdtxvvp	6	\N	\N	\N	\N
152	2	secF	Userrr	female	tester96@yopmail.com	$2a$10$iwJuxwpi.zX1jPHoiwGHlOWSzpggxg7GcXuF0OYwxl0rR7XYGQ3ne	\N	\N	\N	\N	MOGX	\N	\N	1	2020-05-08 01:31:42	2020-05-08 01:34:44	ezLQXBscTvePlmZWXetGht:APA91bGVhaeSFmV20jZDyPLESMVgu2c-jH-h4Edozy6bqsyuOB-ImCkQ_925uxWTFH86E_oxkGT-fuz7PvT0dAQoXr-LTS6zSbksZb0J0emZBFIo_LP7r9_I0aJVPjioVR_QgRkFEAdn	6	\N	\N	\N	\N
160	2	secFs	Userrr	female	tester104@yopmail.com	$2a$10$CSZb3.XKmpRZClLd4oga4ONWjDGDApdNkFA9EyCb01e7/.bDa.dlm	\N	\N	\N	\N	NTXT	\N	\N	1	2020-05-09 09:02:19	2020-05-09 09:05:55	cr5EzKuTQkKG2jHdzoCyvT:APA91bF3j2f7mZDuyhUnJlX7i4cqBcJEUf_S_ne3494cp8eCBoIxUtUrCYDJSH8lt7K3QKnwjUj-bfsuygL5h1v4gAmANSRGfs1roHrgJvkkWE3ES08mZbb9hLua0SotJ8eHj5UvFhiN	6	\N	\N	\N	\N
159	2	firstM	Userrr	male	tester103@yopmail.com	$2a$10$KNutQQe4X20YLKFjyx9ffOHdXjweijBQmTpvdkZsH43G5B7LX4mYC	\N	\N	\N	\N	EURI	\N	\N	1	2020-05-09 09:02:01	2020-05-09 09:05:27	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
151	2	secF	Userrr	female	tester95@yopmail.com	$2a$10$zMWPPSXGLK8dNWgnwHt1N.e2w7yPXKLmyeAR4WMP1U9OFogFFCfJS	\N	\N	\N	\N	VDGS	\N	\N	1	2020-05-08 01:31:38	2020-05-08 01:35:47	ezLQXBscTvePlmZWXetGht:APA91bGVhaeSFmV20jZDyPLESMVgu2c-jH-h4Edozy6bqsyuOB-ImCkQ_925uxWTFH86E_oxkGT-fuz7PvT0dAQoXr-LTS6zSbksZb0J0emZBFIo_LP7r9_I0aJVPjioVR_QgRkFEAdn	6	\N	\N	\N	\N
172	2	secFs	Userrr	female	tester116@yopmail.com	$2a$10$yrQIHCR0lw8eoPz8nxiV1urdeauvkjollpj/2tblsNT1mLTaqUnm6	\N	\N	\N	\N	SWAH	\N	\N	1	2020-05-13 11:48:34	2020-05-13 11:48:34	\N	1	\N	\N	\N	\N
155	2	secF	Userrr	female	tester99@yopmail.com	$2a$10$WzRlf7Ujp5N.qx2Bg/P60.ViRzM/yoWJCeaBenu4yLVg5afWuPnQK	\N	\N	\N	\N	HQUZ	\N	\N	1	2020-05-08 01:40:07	2020-05-08 01:40:41	ezLQXBscTvePlmZWXetGht:APA91bGVhaeSFmV20jZDyPLESMVgu2c-jH-h4Edozy6bqsyuOB-ImCkQ_925uxWTFH86E_oxkGT-fuz7PvT0dAQoXr-LTS6zSbksZb0J0emZBFIo_LP7r9_I0aJVPjioVR_QgRkFEAdn	6	\N	\N	\N	\N
156	2	secF	Userrr	female	tester100@yopmail.com	$2a$10$xfs/oRba9c2Ww2fX3hAc7O1j5V/8RXRYBASrh08rc64gerkQS.XKm	\N	\N	\N	\N	ICEF	\N	\N	1	2020-05-08 01:40:11	2020-05-08 01:42:41	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
153	2	secF	Userrr	female	tester97@yopmail.com	$2a$10$uwG57Xe7ln7HkVWtqB7ji.PqUuKgqakOaHSo.2eTGVdH0Dvf4bGta	\N	\N	\N	\N	HIAE	\N	\N	1	2020-05-08 01:36:25	2020-05-08 01:37:01	ezLQXBscTvePlmZWXetGht:APA91bGVhaeSFmV20jZDyPLESMVgu2c-jH-h4Edozy6bqsyuOB-ImCkQ_925uxWTFH86E_oxkGT-fuz7PvT0dAQoXr-LTS6zSbksZb0J0emZBFIo_LP7r9_I0aJVPjioVR_QgRkFEAdn	6	\N	\N	\N	\N
154	2	secF	Userrr	female	tester98@yopmail.com	$2a$10$IGUUI2aTye3/X9RK64X2W.sgoLu/KFaKswTZIAxSTKlzM8gc4KeAC	\N	\N	\N	\N	JMZH	\N	\N	1	2020-05-08 01:36:30	2020-05-08 01:37:48	eu5vuZ-kzUDvviEVLeAdqb:APA91bELImVpTplbCsvpKi2mZHEcx1IM6g91aOAvtFfbnhrJJPMjeku5LHNEgl1q2LHXugtZorNByXQxyf9w70t6XUhTjzBsuCuUS8y-p_yqQP1Cs5RQc5TCYrcARnqDoB8yD2dV-Iki	6	\N	\N	\N	\N
161	2	secFs	Userrr	female	tester105@yopmail.com	$2a$10$ShPO3RltevhtYQQJ5kkt2.w8JHJIMfFgOxxYKJtYsWbsW8pAif55W	\N	\N	\N	\N	EIQR	\N	\N	1	2020-05-09 09:07:27	2020-05-09 10:12:03	1234567894dsd	6	\N	\N	\N	\N
166	2	secFs	Userrr	female	tester110@yopmail.com	$2a$10$3GYNv03WYh.MO7eB0y6VleWLn3P8UnnkXF5bDbhYdV7stm8iHSpZ.	\N	\N	\N	\N	XFOH	\N	\N	1	2020-05-09 10:16:21	2020-05-09 10:16:56	cr5EzKuTQkKG2jHdzoCyvT:APA91bF3j2f7mZDuyhUnJlX7i4cqBcJEUf_S_ne3494cp8eCBoIxUtUrCYDJSH8lt7K3QKnwjUj-bfsuygL5h1v4gAmANSRGfs1roHrgJvkkWE3ES08mZbb9hLua0SotJ8eHj5UvFhiN	6	\N	\N	\N	\N
165	2	firstM	Userrr	male	tester109@yopmail.com	$2a$10$QlH4bZWgxYsikcxjmUc0zeYuqJhw1O5/3OtBkcfqw/K/HuRU2o6Qm	\N	\N	\N	\N	AEIJ	\N	\N	1	2020-05-09 10:15:50	2020-05-09 10:16:53	foCrzbML90J_vsXwjHYFx7:APA91bFNFUZOwGhHz_6MY9Lks1phck2gCX1GzP6mwUibpAYr59pTHaWFOChDHxGEKuookBqHLu3aBYoPk_Bd7h6N2Ktx34R9GQqOMH9Nqpd4q6PMUAadzbYszZXmPONeC-7F8ux2yKb2	6	\N	\N	\N	\N
162	2	secFs	Userrr	female	tester106@yopmail.com	$2a$10$AX.FdACy8GTuUQHGKG6vH.Tnv0ga0I1QiFoWgjQRKAOOj.Vop1EKm	\N	\N	\N	\N	PHOW	\N	\N	1	2020-05-09 09:07:38	2020-05-09 09:11:34	1234567894dsd	6	\N	\N	\N	\N
163	2	secFs	Userrr	female	tester107@yopmail.com	$2a$10$A1UzPXAunpRVaVb6ZDVKguz0o3y9SYitjYk0YHvF3C35W2gy5Ii6a	\N	\N	\N	\N	PPJN	\N	\N	1	2020-05-09 09:58:15	2020-05-09 10:06:49	cr5EzKuTQkKG2jHdzoCyvT:APA91bF3j2f7mZDuyhUnJlX7i4cqBcJEUf_S_ne3494cp8eCBoIxUtUrCYDJSH8lt7K3QKnwjUj-bfsuygL5h1v4gAmANSRGfs1roHrgJvkkWE3ES08mZbb9hLua0SotJ8eHj5UvFhiN	6	\N	\N	\N	\N
164	2	firstM	Userrr	male	tester108@yopmail.com	$2a$10$4k0MSEDNw8q/EiUYjNI4ge5iwok/7/zX.haBemPTMlDeKUqkAD.tq	\N	\N	\N	\N	XIZG	\N	\N	1	2020-05-09 09:58:26	2020-05-09 10:13:25	foCrzbML90J_vsXwjHYFx7:APA91bFNFUZOwGhHz_6MY9Lks1phck2gCX1GzP6mwUibpAYr59pTHaWFOChDHxGEKuookBqHLu3aBYoPk_Bd7h6N2Ktx34R9GQqOMH9Nqpd4q6PMUAadzbYszZXmPONeC-7F8ux2yKb2	6	\N	\N	\N	\N
171	2	secFs	Userrr	female	tester115@yopmail.com	$2a$10$XidNauJsc8HK6BM/0ulo3ORqIJMhuHI.6P3nbmfhyoqY.pXcmelZO	\N	\N	\N	\N	PTEI	\N	\N	1	2020-05-13 11:35:26	2020-05-13 11:35:26	\N	1	\N	\N	\N	\N
173	2	secFs	Userrr	female	tester117@yopmail.com	$2a$10$NFopH.Jl/TqQv6oZauzILeqnMbVz7WDLfGC0JwGha/tuerXg7X0sG	\N	\N	\N	\N	TOXK	\N	\N	1	2020-05-13 11:49:10	2020-05-13 11:49:10	\N	1	\N	\N	\N	\N
359	2	John	Doe	male	elgoogclass5@gmail.com	$2a$10$Z3pYfZOa9tMK2pNGG1YZW.rtfLcl2/pEl1kg33rHYCDa1XLPdFrUW	\N	\N	\N	\N	KLBT	\N	\N	1	2020-06-13 02:03:05	2020-06-13 02:07:19	cQ2xgf1gTGWJw4SJOy5G4Y:APA91bEm_FdTntmR1ZWufNIO_b3jAB4Nbq40s7SHuSDsFStr4mU0ZhN2scvkqdP0BGMAULJCx7mCArB8LwlYth2otheJSxYo_B-LiNhYMLhXebwdl7GXnHQC4sE9MgtWP4-jbtgDz0ZS	1	\N	\N	\N	\N
158	2	firstM	Userrr	male	tester102@yopmail.com	$2a$10$lr77tcUrYvIC/l8T8zzbReu2YR83tDMs6dyuusyLGud9JZpVtbbGS	\N	\N	\N	\N	SYUV	\N	\N	1	2020-05-08 01:53:00	2020-05-09 12:04:42	1234567894dsd	7	\N	\N	\N	\N
99	2	Test	User	Female	tester58@yopmail.com	$2a$10$6Rsq1duW59RNaITJHlW2z..Zc/YUq3LcJXhnKArS4J8yuSRKA9EEm	\N	\N	\N	\N	SKZL	\N	\N	1	2020-05-07 09:50:00	2020-05-07 12:46:52	fDTae80rTjuAXawqwI1Scj:APA91bEnegfkrCQf2IAsmy6lDRfprQVHqUmHd3YdxD3L8zt-5LtNc0_MUwBCcfpUGtuKim3oMYUXL2S3mrMOlO68v27Vg2fA9Vzwcv2P2AXU-h8xum9beBJlTn_NGt-FIsLnOG2Hnc82	7	\N	\N	\N	\N
170	2	secFs	Userrr	female	tester114@yopmail.com	$2a$10$1pTLTx/qYT8RJJ2uW9Fk7eCZSROpSmQj4/WC3.N3jzTCEUt0xyeKu	\N	\N	\N	\N	ZAEA	\N	\N	1	2020-05-09 10:32:29	2020-05-13 11:42:02	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	7	\N	\N	\N	\N
174	2	secFs	Userrr	female	testuser1@yopmail.com	$2a$10$zlJwCOP9Qryf2j5KkwwxTeaMfAIIBr99khFDY4UDEHz.FXHhjnw9W	\N	\N	\N	\N	TNLL	\N	\N	1	2020-05-13 11:49:32	2020-05-13 11:49:32	\N	1	\N	\N	\N	\N
169	2	firstM	Userrr	male	tester113@yopmail.com	$2a$10$lVJHfo4IRBC.yjXRcDGRquHNTo8TA76KTS3pjUnUWWinvPg6WtymG	\N	\N	\N	\N	ZIHV	\N	\N	1	2020-05-09 10:32:00	2020-05-13 11:41:46	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	7	\N	\N	\N	\N
175	2	secFs	Userrr	female	testuser101@yopmail.com	$2a$10$xE7BumJ67ZtUlyAe6IgKmOLxEaf90489buI05/MwAbP777bYUnWEm	\N	\N	\N	\N	XGGO	\N	\N	1	2020-05-13 11:49:52	2020-05-13 11:49:52	\N	1	\N	\N	\N	\N
176	2	secFs	Userrr	female	testuser111@yopmail.com	$2a$10$dOFomZ3QvkamgGSvfPJHmOnV5GsuRAKfyZJQFKRkS0.pL163QYqqe	\N	\N	\N	\N	KFGC	\N	\N	1	2020-05-13 11:50:05	2020-05-13 11:50:05	\N	1	\N	\N	\N	\N
196	2	secf	userrt	female	user10@yopmail.com	$2a$10$cWxR9ghWtWzKfGeB4To2BOdFvof8cFxCIqJFS/Rav2pcZ34Eop0la	1589379342577.jpeg	\N	\N	\N	YLHX	\N	\N	1	2020-05-13 02:15:36	2020-05-13 02:16:21	cj2rVhFpQm-FEYuxrQlsjj:APA91bFurpLXORS4AkD-f4PtHfjdh9hFVHIcP8Es9Npb5C8F67ussqAnAzM_SENk9mOUGVbC2dk-9cLXwUKbgCgpiqpsv_beA9iRhL0UjKoeXjhTK4701JxLcpRYBZ-1yRmZUcMpF5iW	4	\N	\N	\N	\N
197	2	firstM	user	male	user11@yopmail.com	$2a$10$GBR.oGG0rtIK.1To7K3PguQ6ljrvdnoW3IkJ.36d7DqVm1hn3/Gq.	1589379527967.jpeg	\N	\N	\N	UUJE	\N	\N	1	2020-05-13 02:18:43	2020-05-13 02:19:28	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	6	\N	\N	\N	\N
167	2	secFs	Userrr	female	tester111@yopmail.com	$2a$10$5JtCc6VmLi9hiilP7q5VMOGaRo/a2mB7PPqepCjJpmw1t1IhII1sG	\N	\N	\N	\N	BVPN	\N	\N	1	2020-05-09 10:22:32	2020-05-13 11:54:08	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	7	\N	\N	\N	\N
168	2	firstM	Userrr	male	tester112@yopmail.com	$2a$10$JzTiDej2LBJ46waQWP4dX.FMBLMY2C/n3bbyfc/BxSx8aT8iYBbTG	\N	\N	\N	\N	NELQ	\N	\N	1	2020-05-09 10:22:40	2020-05-13 11:55:37	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	7	\N	\N	\N	\N
177	2	Test	Yese	female	qwert@gmail.com	$2a$10$rsrCS8yORxovdGa/kiocqe/d5cIAeMDgXmx.1/VaJukI8/882IDpW	\N	\N	\N	\N	DVSS	\N	\N	1	2020-05-13 11:59:05	2020-05-13 11:59:05	\N	1	\N	\N	\N	\N
183	2	firstm	userr	male	user1@yopmail.com	$2y$12$8gHAAkwN.94SSQDIZqociOi8obGlXALDmMpeYJEEMKPt.BtY7QAGO	1589376418114.jpeg	\N	\N	\N	AQSR	\N	\N	1	2020-05-13 01:26:39	2020-05-13 01:38:42	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	6	\N	\N	\N	\N
189	2	secFs	Userrr	female	user2@yopmail.com	$2a$10$LOPf5yOvPOYaj5O/YYhVduPT49EdvfeX9lQfr99kgb.nHz5m5IIjq	\N	\N	\N	\N	WECA	\N	\N	1	2020-05-13 01:38:07	2020-05-13 01:38:52	cj2rVhFpQm-FEYuxrQlsjj:APA91bFurpLXORS4AkD-f4PtHfjdh9hFVHIcP8Es9Npb5C8F67ussqAnAzM_SENk9mOUGVbC2dk-9cLXwUKbgCgpiqpsv_beA9iRhL0UjKoeXjhTK4701JxLcpRYBZ-1yRmZUcMpF5iW	6	\N	\N	\N	\N
157	2	secF	Userrr	female	tester101@yopmail.com	$2a$10$NKAvFXtmBkplDN/yS1EDre4UhvFp2SHmqCis/N7gUU/OqC66cQgcu	\N	\N	\N	\N	NXHN	\N	\N	1	2020-05-08 01:52:49	2020-05-13 01:52:54	1234567894dsd	7	\N	\N	\N	\N
186	2	secf	usert	female	user3@yopmail.com	$2a$10$r84/97eEIV7WHiyO1Gec5uHJXsjwl11eaCrZwcj4kKnvybvh5UlQO	\N	\N	\N	\N	HYTN	\N	\N	1	2020-05-13 01:33:36	2020-05-13 01:33:36	\N	1	\N	\N	\N	\N
187	2	secFs	Userrr	female	testuser112@yopmail.com	$2a$10$drqKGLCGe0g4NSTIThK0wufDSa1ZjuOYpuT2d./U4c7sUshYgg2/a	\N	\N	\N	\N	KIDZ	\N	\N	1	2020-05-13 01:34:34	2020-05-13 01:34:34	\N	1	\N	\N	\N	\N
190	2	firstM	user	male	user4@yopmail.com	$2a$10$cz3fP8dGchkX/mMcGjXNGOlXhgy2zjOlvDS0ebrSr9aAyeiqeYipC	1589377742697.jpeg	\N	\N	\N	PWNE	\N	\N	1	2020-05-13 01:48:57	2020-05-13 01:53:23	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	3	\N	\N	\N	\N
191	2	secf	usert	female	user5@yopmail.com	$2a$10$7zm2M3UoVLTXno1Ps4VyQukXBWPyykUM1.LE3WWiD0KJaGprHV./u	1589377799330.jpeg	\N	\N	\N	CEYD	\N	\N	1	2020-05-13 01:49:44	2020-05-13 02:07:44	cj2rVhFpQm-FEYuxrQlsjj:APA91bFurpLXORS4AkD-f4PtHfjdh9hFVHIcP8Es9Npb5C8F67ussqAnAzM_SENk9mOUGVbC2dk-9cLXwUKbgCgpiqpsv_beA9iRhL0UjKoeXjhTK4701JxLcpRYBZ-1yRmZUcMpF5iW	4	\N	\N	\N	\N
192	2	firstM	user	male	user6@yopmail.com	$2a$10$PVbEFaF2sExCeleNu4GFseAeaZhA.aIXSyHja63cNpSiidrWLiEj6	1589378141150.jpeg	\N	\N	\N	PIZL	\N	\N	1	2020-05-13 01:55:35	2020-05-13 02:07:59	cj2rVhFpQm-FEYuxrQlsjj:APA91bFurpLXORS4AkD-f4PtHfjdh9hFVHIcP8Es9Npb5C8F67ussqAnAzM_SENk9mOUGVbC2dk-9cLXwUKbgCgpiqpsv_beA9iRhL0UjKoeXjhTK4701JxLcpRYBZ-1yRmZUcMpF5iW	6	\N	\N	\N	\N
202	2	secF	user	female	user16@yopmail.com	$2a$10$E6SGelSKiHBhktMHNTeh8eYCbQfM2GBljlRZsLZuGEDgNROcGaK16	1589430237534.jpeg	\N	\N	\N	QEFY	\N	\N	1	2020-05-14 04:23:50	2020-05-14 04:24:47	cj2rVhFpQm-FEYuxrQlsjj:APA91bFurpLXORS4AkD-f4PtHfjdh9hFVHIcP8Es9Npb5C8F67ussqAnAzM_SENk9mOUGVbC2dk-9cLXwUKbgCgpiqpsv_beA9iRhL0UjKoeXjhTK4701JxLcpRYBZ-1yRmZUcMpF5iW	4	\N	\N	\N	\N
193	2	secf	user	female	user7@yopmail.com	$2a$10$0S.MBmjDdQGS81ZKcQxe2ulM2Vpq77zFYwgCITigKdthYmRzXa5AS	1589378167463.jpeg	\N	\N	\N	OPXG	\N	\N	1	2020-05-13 01:55:59	2020-05-13 02:09:14	cj2rVhFpQm-FEYuxrQlsjj:APA91bFurpLXORS4AkD-f4PtHfjdh9hFVHIcP8Es9Npb5C8F67ussqAnAzM_SENk9mOUGVbC2dk-9cLXwUKbgCgpiqpsv_beA9iRhL0UjKoeXjhTK4701JxLcpRYBZ-1yRmZUcMpF5iW	6	\N	\N	\N	\N
199	2	firstM	user	male	user13@yopmail.com	$2a$10$hIIU4IG3SiymsUXg.IEWv.OLLrc.iVLHebQ.6C4jzaCGa94EcyPNO	1589429865637.jpeg	\N	\N	\N	WVXR	\N	\N	1	2020-05-14 04:17:25	2020-05-14 04:19:15	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	3	\N	\N	\N	\N
200	2	secF	user	female	user14@yopmail.com	$2a$10$B7Zx5E5Wtg.by7vFrD3Eq.BMklYlYwy/.jeYKovnhcm4Fyphz8/GS	1589429894244.jpeg	\N	\N	\N	EBUP	\N	\N	1	2020-05-14 04:18:08	2020-05-14 04:22:29	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	4	\N	\N	\N	\N
195	2	firstM	user	male	user9@yopmail.com	$2a$10$Bujca.l1U3jT98YkAWsHse2MeEL5mdGWRMLS8cBndPbCy2QQE0LHK	1589379319981.jpeg	\N	\N	\N	AFEJ	\N	\N	1	2020-05-13 02:15:15	2020-05-13 02:16:02	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	3	\N	\N	\N	\N
194	2	secFs	Userrr	female	user8@yopmail.com	$2a$10$uLcFX1UWpSbpfFynqByjzOyMyZOhv6wpvvn029W0Fio9rpHiF14wS	\N	\N	\N	\N	DFQD	\N	\N	1	2020-05-13 02:01:07	2020-05-13 02:25:21	1234567894dsd	1	\N	\N	\N	\N
198	2	secf	ussert	female	user12@yopmail.com	$2a$10$xEh4w/R6bwj0Yrc8Dew.8eIeWqwKnC0ocNN0EkCP217wJk.h1bQ1C	1589379551500.jpeg	\N	\N	\N	YNCC	\N	\N	1	2020-05-13 02:19:06	2020-05-13 02:25:52	1234567894dsd	6	\N	\N	\N	\N
201	2	firstM	USER	male	user15@yopmail.com	$2a$10$NEdHTtgWSna.eW5o8vhnYOJRUohPQTMnJGul7nFp1Bg5UYg1aPeLi	1589430207841.jpeg	\N	\N	\N	YPJD	\N	\N	1	2020-05-14 04:23:20	2020-05-14 04:24:16	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	3	\N	\N	\N	\N
204	2	secF	user	female	user18@yopmail.com	$2a$10$XtA7OCyFRZJ.Lb.TOi1PuOgX4tcPwdFIoKdC2sE.2LEJDNIPfS3R2	1589430450445.jpeg	\N	\N	\N	DHRX	\N	\N	1	2020-05-14 04:27:24	2020-05-14 04:50:07	1234567894dsd	4	\N	\N	\N	\N
207	2	firstM	user	male	user21@yopmail.com	$2a$10$fWU5RHtnYlLaZ/Lq/2RoAuy8j/yC/9hpWGCJ5JVe2enfrYVyeIcYi	1589432228720.jpeg	\N	\N	\N	JQEN	\N	\N	1	2020-05-14 04:57:03	2020-05-14 04:57:25	1234567894dsd	1	\N	\N	\N	\N
206	2	secF	user	female	user20@yopmail.com	$2a$10$6iK0Y.mgLO8HaMOwzODjVelEnys77RVfRBnZJGby3AnjeuPQr1BSa	1589431895976.jpeg	\N	\N	\N	JTDI	\N	\N	1	2020-05-14 04:51:26	2020-05-14 05:00:03	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	6	\N	\N	\N	\N
216	2	secF	user	female	user27@yopmail.com	$2a$10$2rCjtT64TQxzirynzfFwNuWoIY49e0NaZfzAWx3AQ1o2cH7sOOkaG	1589437873986.jpeg	\N	\N	\N	ODRL	\N	\N	1	2020-05-14 06:31:08	2020-05-14 09:29:56	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	7	\N	\N	\N	\N
211	2	secFs	Userrr	female	use25@yopmail.com	$2a$10$iUjmwhshmmlSP7D7yQ1WYudfND54L7MRkf.op3yGTQ6Fh5ll6NmKC	\N	\N	\N	\N	XGJG	\N	\N	1	2020-05-14 05:17:42	2020-05-14 05:18:25	cj2rVhFpQm-FEYuxrQlsjj:APA91bFurpLXORS4AkD-f4PtHfjdh9hFVHIcP8Es9Npb5C8F67ussqAnAzM_SENk9mOUGVbC2dk-9cLXwUKbgCgpiqpsv_beA9iRhL0UjKoeXjhTK4701JxLcpRYBZ-1yRmZUcMpF5iW	4	\N	\N	\N	\N
210	2	secFs	Userrr	female	use24@yopmail.com	$2a$10$DboSW1/tE1EqNT885FLXIeGB5uxoXT1itCOa81dSUNlXkfAZBfwm2	\N	\N	\N	\N	DXST	\N	\N	1	2020-05-14 05:17:39	2020-05-14 05:18:02	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	5	\N	\N	\N	\N
203	2	firstF	user	male	user17@yopmail.com	$2a$10$f2Twu8BZ.73esVERdpsCdu8fPwruB2pQsIkDZYRvK2cVZglN4WV1m	1589430427886.jpeg	\N	\N	\N	IWNT	\N	\N	1	2020-05-14 04:27:02	2020-05-14 05:48:27	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	3	\N	\N	\N	\N
212	2	fistM	user	male	user22@yopmail.com	$2a$10$KbtZiqeH8DnLlwezi7AfkemJ6gAugUjqR4UFuUV6d9Z4QUGwxj2gy	\N	\N	\N	\N	AHUQ	\N	\N	1	2020-05-14 06:22:25	2020-05-14 06:22:25	\N	1	\N	\N	\N	\N
208	2	secFs	Userrr	female	use22@yopmail.com	$2a$10$WC2PyVAxAhoaig3DLGG1Ru3FSo3uCHQIV83kWJTunKMc.W55ZUrd.	\N	\N	\N	\N	DMNP	\N	\N	1	2020-05-14 05:15:09	2020-05-14 05:15:51	cj2rVhFpQm-FEYuxrQlsjj:APA91bFurpLXORS4AkD-f4PtHfjdh9hFVHIcP8Es9Npb5C8F67ussqAnAzM_SENk9mOUGVbC2dk-9cLXwUKbgCgpiqpsv_beA9iRhL0UjKoeXjhTK4701JxLcpRYBZ-1yRmZUcMpF5iW	4	\N	\N	\N	\N
209	2	secFs	Userrr	female	use23@yopmail.com	$2a$10$QhSKud95cMIKiUxBl2ZcReZr3JMJ8AOKigi352xI4zeRcJI9LwvMO	\N	\N	\N	\N	YZAF	\N	\N	1	2020-05-14 05:15:12	2020-05-14 05:16:19	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	5	\N	\N	\N	\N
205	2	firstM	user	male	user19@yopmail.com	$2a$10$obUFCRXt9NGefb3wBJNIM.8RU8omMdXYnwpFVpz01wZhyH1yP.ekG	1589431867058.jpeg	\N	\N	\N	GKCO	\N	\N	1	2020-05-14 04:51:01	2020-05-14 04:52:02	cj2rVhFpQm-FEYuxrQlsjj:APA91bFurpLXORS4AkD-f4PtHfjdh9hFVHIcP8Es9Npb5C8F67ussqAnAzM_SENk9mOUGVbC2dk-9cLXwUKbgCgpiqpsv_beA9iRhL0UjKoeXjhTK4701JxLcpRYBZ-1yRmZUcMpF5iW	6	\N	\N	\N	\N
215	2	firstM	user	male	user26@yopmail.com	$2a$10$zGrWKwZUKmpbT.CMyMy/deP30iXlhxWXcYgNU/ZFLbC84zW3REDvy	1589437848298.jpeg	\N	\N	\N	ZHQY	\N	\N	1	2020-05-14 06:30:43	2020-05-14 06:31:32	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	6	\N	\N	\N	\N
326	2	Madan	Agrawal	female	madan@yopmail.com	$2a$10$2i9DtG9K9TthrowAkPH3aem6vItYTrHPkiDyzAgVsDXCrCAs1rYJe	1590739732057.jpeg	\N	\N	\N	OMTR	0	2020-06-01 05:15:00	1	2020-05-29 08:08:01	2020-06-04 02:10:43	e0QNplpoSBa5EK0OT6KC1z:APA91bGwvxaCF9PZBPUlyy156CW6m4giu3u1FYn05IgpoNBr6hehqIyjeoxsjZmp8iX0VPd4Nmw9ThtRtGWVmyRrbBeUI24-mMTQv7yw7kyUVavvJB4HtNCU8MjE_hL9kg4rfjP9-Qsz	7	\N	\N	\N	2020-06-01 05:15:00
243	2	new	new	female	ntest1@yopmail.com	$2a$10$JKD6M1rODBvksSWiiHT4vOp.9gymr0xQqydYQfCOCnqHiIb1y1SCi	\N	\N	\N	\N	OVQV	\N	\N	1	2020-05-14 05:48:11	2020-06-05 10:28:58	dZaJSAmH9kUos4Obpy4s6r:APA91bFGDk879XNaOBI3IOewjW_-w9uGIfsrBu6x-plMUkYQSMI06X6MScw7f3eQTpcuX_Bte3aF7a7Lp7fo1Dj2GgGVdUZM0gltbQftFIWqJbVbuWyQWDhsVVAX7wIofbQtzt-W7lFH	1	\N	\N	\N	\N
313	2	Try	Th	female	last@yopmail.com	$2a$10$k9GJWc4bRrr7PkVWjcsG8efwfzPQKsIjlSNWfUvj96F2HUNt52sZ.	1590426491955.jpeg	\N	\N	\N	NOWY	\N	\N	1	2020-05-25 05:07:51	2020-05-26 01:00:38	d3JQJ6KMRsquLVoe5F6f5h:APA91bG5KbEjvEQaRa1RoRQ8h3jBbJjfYu-qZNM491Ka-NgLwt1KyKlWPgqGIa-FlNEuE5yb8qfNI4Y2FrnaAIrWX5Qs2dt0zZA9ml2GqkJf53IR_7Cdo6t9Ppe3s1MjJD1baJBCYtZQ	1	\N	\N	\N	\N
213	2	firstM	user	male	user23@yopmail.com	$2a$10$q5PxnOF3SAd8xgQLdrnOvODBVANmjLPxhVLeygbpEDvN0CaqEorm6	1589437386347.jpeg	\N	\N	\N	BEZD	\N	\N	1	2020-05-14 06:22:47	2020-05-14 06:26:31	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	6	\N	\N	\N	\N
214	2	secF	user	female	user25@yopmail.com	$2a$10$Y6/O1VBaZXELfC0CzF2bMOXyr9e/ikIQeZ/8U1SNuZ1h8rqRQ09K6	1589437438546.jpeg	\N	\N	\N	IDRC	\N	\N	1	2020-05-14 06:23:48	2020-05-14 06:28:06	cj2rVhFpQm-FEYuxrQlsjj:APA91bFurpLXORS4AkD-f4PtHfjdh9hFVHIcP8Es9Npb5C8F67ussqAnAzM_SENk9mOUGVbC2dk-9cLXwUKbgCgpiqpsv_beA9iRhL0UjKoeXjhTK4701JxLcpRYBZ-1yRmZUcMpF5iW	6	\N	\N	\N	\N
217	2	firstM	user	male	user28@yopmail.com	$2a$10$qW54UzMFl/K6R5KKmjO5zu/JW4.nZHm1J/hqCviAn0GX4sufJHfnO	1589445821345.jpeg	\N	\N	\N	ZCJM	\N	\N	1	2020-05-14 08:43:36	2020-05-14 08:44:23	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	6	\N	\N	\N	\N
267	2	secF	Userrr	female	user48@yopmail.com	$2a$10$H8XqRM8TKagUq1YqclruXuqWGByAFqEFP5JA77s5F7zhenBfQ57MG	\N	\N	\N	\N	TYSP	\N	\N	1	2020-05-20 06:39:00	2020-05-25 11:11:08	cxnZV9EzQvClsuB0gV2xcB:APA91bGn6VNpdv65_aiXm1rHMyuuxWJEXMBsKKmqKVZx4iu1SA7hWnSHYRpWWWN7JgQ4RSBQL_ILSx4sAAeS72RRjtUyzNVpw_mEfi70lU3C4JSyuyhFWQ3hpI2yrBnYuvOrbFWMfXGH	6	\N	\N	\N	\N
240	2	qwerr	ssjdj	female	abc@yopmail.com	$2a$10$tGqqncHSqu4R1.v6ZmsFquNbRsUbUFKnmdaCL1USZTBtSUHHI6L2e	\N	\N	\N	\N	YTBE	\N	\N	1	2020-05-14 05:38:02	2020-05-14 05:54:09	eoelKeYjgUiKkrRdxOrJu9:APA91bEjxOzztPJnjSlSzsHzAfYgLhurKJsP6nGDfQN6WboxV6CAom-B590Y2MS-T4pFkRaZmPEgOvEhhFgmQbpuz9nAvOP96HFnmLiNkaEMu6PAH-YwOK-gBcCv6rB9MHPhYrFxDCGT	5	\N	\N	\N	\N
341	2	test	accout	male	test123@yopmail.com	$2a$10$Xx2I.j6Ombctmir2/MQAy.ocFM85Rl0opw3HV2acLJph0dUo8Ethi	1591599715771.jpeg	\N	\N	\N	ZSFU	0	2020-06-19 11:46:41	1	2020-06-08 07:01:41	2020-07-01 12:29:02	c08r1PQX90S9gEGwHYVTor:APA91bGvdAWo2QC6fnTqnPLH1nO4gFHMPv18dlMWC8wZh1p90rjPl77iY-f0hTb3KKOqSp5I2OEEdEkfihBaDlpiwuNyTV1Jb7SOPbZikKmfUB-w1l8oHb6c7NsL4BEhzdQaSdXtPzMn	7	\N	\N	\N	2020-06-19 11:46:41
257	2	Gautam	Marwaha	male	gautammarwaha786@gmail.com	$2a$10$qfL5nGG1cYPcZ0zkAIVb9.TxrBHEYrW8IkJoKFtLnAB10Svk0h23u	1590151745871.jpeg	\N	\N	\N	LDBK	\N	\N	1	2020-05-19 08:38:25	2020-05-23 04:00:39	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1	\N	\N	\N	\N
218	2	secF	user	female	user29@yopmail.com	$2a$10$X7GWSp4ih3p6Zo/ItGcdB.OpRLFJTKEsM98GwWpfygAZPesDEUxpy	1589445845569.jpeg	\N	\N	\N	NRXW	\N	\N	1	2020-05-14 08:43:59	2020-05-14 11:57:20	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	6	\N	\N	\N	\N
219	2	tester	users	male	tester@gmail.com	$2y$12$8gHAAkwN.94SSQDIZqociOi8obGlXALDmMpeYJEEMKPt.BtY7QAGO	\N	\N	\N	\N	NNNN	\N	\N	1	2020-04-16 22:47:49	2020-05-14 09:40:21	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	1	\N	\N	\N	\N
229	2	firstM	Userrr	male	user38@yopmail.com	$2a$10$OPdtqM.AGUpruuLQj.8nge16snvnDvk4QBzDcsSPeDUKsD7VySPGu	\N	\N	\N	\N	SQRR	\N	\N	1	2020-05-14 12:00:52	2020-05-14 12:39:36	cj2rVhFpQm-FEYuxrQlsjj:APA91bFurpLXORS4AkD-f4PtHfjdh9hFVHIcP8Es9Npb5C8F67ussqAnAzM_SENk9mOUGVbC2dk-9cLXwUKbgCgpiqpsv_beA9iRhL0UjKoeXjhTK4701JxLcpRYBZ-1yRmZUcMpF5iW	1	\N	\N	\N	\N
238	2	Dvdv	Fw	female	qc@yopmail.com	$2a$10$fEwVSalrTAILracyJlAREOqjqCsGcR2wD5IK6kaU7tkGFSXe6d1ZS	\N	\N	\N	\N	WWWV	\N	\N	1	2020-05-14 04:47:04	2020-05-14 04:47:04	\N	1	\N	\N	\N	\N
225	2	firstM	Userrr	male	user34@yopmail.com	$2a$10$kd81t5nJGAKftfTx3WQqWe76bmoOH4ewZw4ooXTq5ePN7MrLTMnh.	\N	\N	\N	\N	TEZY	\N	\N	1	2020-05-14 11:12:36	2020-05-14 11:52:14	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	1	\N	\N	\N	\N
239	2	Dhhd	Xbd	female	qz@yopmail.com	$2a$10$6pBYhxiHrDInsbj16V2c0ucdCE8qLuCrHE1idfST.KaSVa.Rxaf4m	\N	\N	\N	\N	THNU	\N	\N	1	2020-05-14 04:47:46	2020-05-14 04:47:46	\N	1	\N	\N	\N	\N
236	2	SecF	user	female	secuser@yopmail.com	$2a$10$/vw/6X80p.VQ/gKas5yLe.bQkGWlJbmIedJSwduZKbin8fzvvGeLq	1589474491906.jpeg	\N	\N	\N	INXF	\N	\N	1	2020-05-14 04:41:26	2020-05-14 04:44:15	c0ecrfQuTBaGRvDl5rmX9k:APA91bEu5YM3CjdiH5ubRY732Jcakz2sw1HcekdxXY1lpWf11wX8ZEuPp4PCvoeMqVRpLzet_jzmINU70R6jgTIeNs_A1rbLiEtNQ3mQcWafWOlFhirh4AEVK3wbSYXkvaXVJYqCb25N	1	\N	\N	\N	\N
314	2	Male	Male	male	gautam.android@mailinator.com	$2a$10$Q/oY12lo7wfUUwHMtGqsp.7kZRWUoVk/JtfLt/VvzJvXaafdLdtxi	1590485182949.jpeg	\N	\N	\N	JWWC	\N	\N	1	2020-05-26 09:23:49	2020-05-26 12:39:12	eZAknozQTRSwdZekkePT-8:APA91bFNxJvWN7p6Xm_xERL3_oVP1NHqKs-eqlQ6qk-xYicLnmSqKYmSAr1RZ9FcByW5vVD4Q03Hbtke4LyGH0Cib7GxLAMAebQy_Q56gqTjZD_LgJOV0-NvrtUAIx7UX6vddJf6zrOz	1	\N	\N	\N	\N
223	2	firstM	Userrr	male	user32@yopmail.com	$2a$10$3S9nL0KuiT2Fz0u2ug5D8eC99GuQJZ8ltXqCgZbckdpanJ.a0cvX.	\N	\N	\N	\N	LTNS	\N	\N	1	2020-05-14 10:28:29	2020-05-14 10:56:23	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	1	\N	\N	\N	\N
224	2	secF	Userrr	female	user33@yopmail.com	$2a$10$vcGEc./MMsFN/DK1XH3yq.GwFfmrglg5gypP2suKrE6msYATYMy/S	\N	\N	\N	\N	XYRY	\N	\N	1	2020-05-14 10:28:37	2020-05-14 11:55:53	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	1	\N	\N	\N	\N
227	2	firstM	Userrr	male	user36@yopmail.com	$2a$10$M39bs7W3lGUPZfZxx0VateT5Vw7zYgQJqIclfPQxfQwirsiBHYWoG	\N	\N	\N	\N	UGJT	\N	\N	1	2020-05-14 11:16:07	2020-05-14 11:33:55	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	1	\N	\N	\N	\N
222	2	secFs	Userrr	female	user31@yopmail.com	$2a$10$alB9xGXF31gOYOVVEMW0Y.UP/qO5CQbpuXg6L1LJlkLJFH0FbXO4S	\N	\N	\N	\N	HYNT	\N	\N	1	2020-05-14 09:42:35	2020-05-14 11:56:12	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	1	\N	\N	\N	\N
221	2	secFs	Userrr	female	user30@yopmail.com	$2a$10$wW1yT4E4w3Q0BnOxNEAcO.kI0xR0Mbsjf9PUZ92dRsH5GsUtKJOpi	\N	\N	\N	\N	CAGI	\N	\N	1	2020-05-14 09:42:31	2020-05-14 10:45:25	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	1	\N	\N	\N	\N
230	2	secF	Userrr	female	user39@yopmail.com	$2a$10$wCdpuGiAwBDmy4V0db8Bmeh0VAKt2oYWrTVPQwDtZCAuNYSbt6B1G	\N	\N	\N	\N	JBWT	\N	\N	1	2020-05-14 12:01:14	2020-05-14 03:13:13	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	1	\N	\N	\N	\N
231	2	secF	Userrr	female	user40@yopmail.com	$2a$10$r2oRTArjmC7st2DGcyilk.IvWty4i6zztjoee6v.OBxpHN9F/BDSC	\N	\N	\N	\N	DRCQ	\N	\N	1	2020-05-14 03:07:27	2020-05-14 03:08:04	ccXqJhiankxGlE1XUj4TGh:APA91bE5pPYr9RtLRs1NloX4ffi_iTqVy80bX3aFIUqt-vaxwZz2FsNlM0ECrM0MJ8DcnJg0U8Lnu8I7Wn5XgqaZ8xXLjkjSuQ-6g6nllbyhphfzRQ52S_PNZ9nhfALEG6FBu3ZkEt6q	1	\N	\N	\N	\N
233	2	subodh	srivastava	male	subodhsri1@subcodevs.com	$2a$10$AQVULt1ky.s1kS9hivq6u..R7FU6TbIjhd/XPFVPLRH2t3JFdjM/a	\N	\N	\N	\N	LBLX	\N	\N	1	2020-05-14 04:39:45	2020-05-14 04:39:45	\N	1	\N	\N	\N	\N
237	2	Abhi	Dff	female	dd@yopmail.com	$2a$10$i/vvqRZIlB93kgawyppuC.8x4fkcaiGdJXLov14hoqPymB77GlXuG	1589474651100.jpeg	\N	\N	\N	WVJR	\N	\N	1	2020-05-14 04:43:46	2020-05-14 04:44:11	\N	1	\N	\N	\N	\N
235	2	abhinav	teotia	male	ta@yopmail.com	$2a$10$14FpHzQxZlFH0IAUpsVtpuiSur8m1O2Gaz7yemHxfa8YTo92g/3Fe	1589474493726.jpeg	\N	\N	\N	MUYO	\N	\N	1	2020-05-14 04:41:20	2020-05-14 04:42:49	eoelKeYjgUiKkrRdxOrJu9:APA91bEjxOzztPJnjSlSzsHzAfYgLhurKJsP6nGDfQN6WboxV6CAom-B590Y2MS-T4pFkRaZmPEgOvEhhFgmQbpuz9nAvOP96HFnmLiNkaEMu6PAH-YwOK-gBcCv6rB9MHPhYrFxDCGT	1	\N	\N	\N	\N
234	2	FirstM	user	male	firstuser@yopmail.com	$2a$10$/ANaXAadmN4YT1gyCpbeteSGPt3yPwywMyvKBa7SrlRK97kHA7eUS	1589474463278.jpeg	\N	\N	\N	KOJG	\N	\N	1	2020-05-14 04:40:49	2020-05-14 04:49:57	dZaJSAmH9kUos4Obpy4s6r:APA91bFGDk879XNaOBI3IOewjW_-w9uGIfsrBu6x-plMUkYQSMI06X6MScw7f3eQTpcuX_Bte3aF7a7Lp7fo1Dj2GgGVdUZM0gltbQftFIWqJbVbuWyQWDhsVVAX7wIofbQtzt-W7lFH	1	\N	\N	\N	\N
244	2	Ellen	Johnson	female	ellen@yopmail.com	$2a$10$z75JSRL.tgrH5IdwojBosuXjV7sz6PalW2zKMiOQ6bXGbdK4cy/te	1589479629753.jpeg	\N	\N	\N	PSGX	\N	\N	1	2020-05-14 06:06:10	2020-05-14 06:07:57	ddNXKEUJwUgxk3DXc-ryb6:APA91bEcbz7WmoxlcffAIcC0yEpD-5e_EPIPabeOyXlFQZW72FCNL9qZ41kPfY59_vWprdyFaBYzO8rRy9gCl1O6OumVqI9WlQ_kM4vdMDBQxFvUlY5rL25sYoMVi2mCwVtAma2-co63	4	\N	\N	\N	\N
241	2	q	a	male	rcc@yopmail.com	$2a$10$PDioL2eP6n5HUrN3NF3IZ.1NXNEfTKOrrRiGgC9g.QA2hGtGY4qNy	\N	\N	\N	\N	OUNI	\N	\N	1	2020-05-14 05:43:55	2020-05-14 05:43:55	\N	1	\N	\N	\N	\N
242	2	aaa	aaaa	female	test1@yopmail.com	$2a$10$hCGFynh23Z57QeQ2PPQZmuDKvNcM5V2ruduztyb/KmqRCpNCH65b.	\N	\N	\N	\N	FHYJ	\N	\N	1	2020-05-14 05:47:24	2020-05-14 05:47:24	\N	1	\N	\N	\N	\N
342	2	test	last	female	test321@yopmail.com	$2a$10$R4AQWFNG2P2O5BgU1rYT5eG6X6s8Pltjr.ixkUl8f4kYubysIuvhe	1591599831273.jpeg	\N	\N	\N	XXRF	0	2020-06-19 11:46:41	1	2020-06-08 07:03:42	2020-07-10 11:12:27	eVBLsmpfh0n0uuS4kab4MH:APA91bH5vCZ820GJwAb_LZwxBgDj2K3oWtEJbP3h4jMXRmlV8gFnQQ0_FoIyZCxfTFK9miyyiNSVgqNnYxQLlxFSjgfnGEi_SIMf8HLe6KfrG3x916tX_pOXPnKK3x3YSEbHBk6Qk60A	7	\N	\N	\N	2020-06-19 11:46:41
245	2	dd	dd	female	fg@yopmail.com	$2a$10$LmAJn2yOXgFXH5RM1N4tQenK46kXfnkJlQrnoqAdNklDYZ6bVL2sa	1589479952507.jpeg	\N	\N	\N	XEPV	\N	\N	1	2020-05-14 06:12:20	2020-05-14 06:12:33	\N	1	\N	\N	\N	\N
263	2	gautam	marwaha	male	g@g.com	$2a$10$UvdTDCknZ4sz5jRYlJfnvuSqni.XNW7kGMK/J46flUDTif3kkt7q6	\N	\N	\N	\N	JCKU	\N	\N	1	2020-05-19 10:07:27	2020-05-26 10:14:42	\N	1	\N	\N	\N	\N
261	2	secF	Userrr	female	user46@yopmail.com	$2a$10$0QoieiSIONw/cQTfMEUlme2V9gwYmK9GexwNJkGfumC29cYKIS5kW	1590158026218.jpeg	\N	\N	\N	QZAE	\N	\N	1	2020-05-19 09:20:05	2020-05-25 10:03:30	cdniu6qW_U4ZgZVcdnnrwj:APA91bG1RM0W0sV9904coiivZXc3hUjndH-uKQ6rXIuvcubu2oS779T_j-NRSdcTdZ7yR7fDW0ACkqzJBicex2lEI7Ma0HwiIRzwT3-FxACGk3VFOUCYDuUWpMZ43VbNonedR7re8Meo	6	\N	\N	\N	\N
273	2	sfdsf	afsfsf	female	aas@gmail.com	$2a$10$4njVGtcRbsLWUzTHLTuSXuAefgAc5ulz7sGptLqDCaIg/JS1My3Mq	\N	\N	\N	\N	APFW	\N	\N	1	2020-05-20 02:31:08	2020-05-20 02:31:08	\N	1	\N	\N	\N	\N
246	2	sks	dkdk	female	qwerty@yopmail.com	$2a$10$BZDV2P71Bq1ufIbnzGJzyu.Vz8pia8wxSGTEFVR1OchI6I6qR2Ygm	1589480005590.jpeg	\N	\N	\N	LLDS	\N	\N	1	2020-05-14 06:13:06	2020-05-15 09:29:25	crvJphAah0janWbwwxad7o:APA91bFB0v3AUhQA_UG60pRxTab_ThZjnJeJRRJ8YoWPmBo2izR8BSp9FmVUH9ZLHragB6AkPiUoBeZEFb10RJV_24LdhKqnKrT5U4lSPJwaSJI319ySfje0luPAi7JJmFdQEuhjk5Rx	7	\N	\N	\N	\N
259	2	Gautam	qa	male	gautammarwaha786+2@gmail.com	$2a$10$XHx7ts3H/3O1VXhJSxrqYuNy2JXQdn32.Ze8l27IWWSrHyMS6QiY.	\N	\N	\N	\N	VGVX	\N	\N	1	2020-05-19 09:07:24	2020-05-19 09:07:24	\N	1	\N	\N	\N	\N
315	2	Rohit	Verma	Female	testuss@subcodevs.com	$2a$10$UVQXgexLqS9F3S5Beuwy7.ajAOcNNIWrXtWDj7JHLMVdWNME/.KVC	\N	\N	\N	\N	ONWK	\N	\N	1	2020-05-26 05:35:30	2020-05-26 05:35:30	\N	1	\N	\N	\N	\N
247	2	Ana	Hathway	female	ana1@yopmail.com	$2a$10$Pahkk55/aoFxE4IiBchLu.5dL10jm6AiK2tp3Mg50H0OVCbpna7Bu	1589480144311.jpeg	\N	\N	\N	ZXCI	\N	\N	1	2020-05-14 06:15:20	2020-05-14 06:28:27	ddNXKEUJwUgxk3DXc-ryb6:APA91bEcbz7WmoxlcffAIcC0yEpD-5e_EPIPabeOyXlFQZW72FCNL9qZ41kPfY59_vWprdyFaBYzO8rRy9gCl1O6OumVqI9WlQ_kM4vdMDBQxFvUlY5rL25sYoMVi2mCwVtAma2-co63	7	\N	\N	\N	\N
268	2	secF	Userrr	female	user49@yopmail.com	$2a$10$2VI3yjW5xJ2OqPF1iyDpT.4oBEBQFPNg9OBdYQt4wVshXvFIq/Vmy	\N	\N	\N	\N	ZLDD	\N	\N	1	2020-05-20 06:39:05	2020-05-25 11:11:49	cxnZV9EzQvClsuB0gV2xcB:APA91bGn6VNpdv65_aiXm1rHMyuuxWJEXMBsKKmqKVZx4iu1SA7hWnSHYRpWWWN7JgQ4RSBQL_ILSx4sAAeS72RRjtUyzNVpw_mEfi70lU3C4JSyuyhFWQ3hpI2yrBnYuvOrbFWMfXGH	6	\N	\N	\N	\N
360	2	Elgog	El	female	elgoogclass3@gmail.com	$2a$10$ujPgRPE22Zd813tK9D2GMecWaJuJYTHT/DNBEHjNE6b2Fxg7RDigO	\N	\N	\N	\N	WBJR	\N	\N	1	2020-06-17 07:46:08	2020-06-17 07:49:30	\N	1	\N	\N	\N	\N
260	2	gautam	qa	female	fgautammarwaha786+3@gmail.com	$2a$10$MItt7cXyMW8JbSrzXeRSouaHmSjquyK4lu9445jMac1D5sx6ToEF6	\N	\N	\N	\N	NDKP	\N	\N	1	2020-05-19 09:08:38	2020-05-19 09:08:38	\N	1	\N	\N	\N	\N
317	2	Q	L	male	email@yopmail.com	$2a$10$97W6MgIc0eoe5cjYAd.jQOp4scl/76sT2h9VnhCDv5tIDimdRg5ZO	1590598911026.jpeg	\N	\N	\N	UUKA	0	2020-05-27 17:19:16	1	2020-05-26 05:42:33	2020-06-11 05:17:32	fbEeuXuQRtilV3uIsGMtrm:APA91bHOMs8UHHUpyC6LuA-C7vDnryTb9g76rSLnhvl3pYDE6vcUxJadUId70ueXiXk6sKbTPcG197ax9Dav7PZ_5socb-BWmeCfwblXS8E891WXdQbQKNidERt2x80WOnwL8pbttw3V	1	\N	\N	\N	2020-05-27 17:19:16
262	2	gautam	qa	female	gautam@gmail.com	$2a$10$9EIVB4afUQaX.Azl4JUd1.XSkRzFJOlP.ATeQArC8RT30jlibkoRK	1589882759505.jpeg	\N	\N	\N	QAFS	\N	\N	1	2020-05-19 10:00:30	2020-05-19 10:06:00	\N	1	\N	\N	\N	\N
275	2	Divya	S	female	subodh.s@subcodevs.com	$2a$10$dG9LvPFwgaEMH7ZuTvee4e98RUuS94OIyLb3a8pMYmZc9e6..6qAu	\N	\N	\N	\N	PAWO	\N	\N	1	2020-05-21 03:05:55	2020-07-20 10:01:46	cEt9nI1WukDIpzxV0HGzgT:APA91bE1Kp6wZKSwXqBJ58uc0bTzZmBbQ0CoUnsSM6t42kk1RhTgsY089e45HP-xAKxOGLp93SrxUxgzmyhy73aqQ69LI4hfPvsVqGSMHj-tXcJJ0UhPPreS0EzMutQbXRjrnUhlRYLc	5	\N	\N	\N	\N
255	2	secF	Userrr	female	user44@yopmail.com	$2a$10$qhiZxDmnVFQjADtDR27Vd.oalnMlPBeFYjAC7LdcV/5upN8bRGXba	\N	\N	\N	\N	BYHY	\N	\N	1	2020-05-18 09:56:45	2020-05-18 01:19:32	cvTEtFXUTZek_GYwOnxHLt:APA91bE1aIwv-WJUyzAb9LIOdkpEQZkFZ_CxYbIs9g_RzSt2klkOhXS6Tmd2rbTmRfOOXtM8Sia1O0zmC91DxntA7Si1Tn1a9MUsIXsGx8GbBTfRG5aY9OuhCBbs1YEAByjZ_ZMpOFq-	7	\N	\N	\N	\N
249	2	secF	user	female	user43@yopmail.com	$2a$10$prLDP6PaEK8UJN/F/rKoNuJLPLsSn02eKusUYVFTZgzLgHFXAkwS2	1589880923011.jpeg	\N	\N	\N	UNWG	\N	\N	1	2020-05-15 09:03:41	2020-05-19 12:52:20	dD4NeqvoQEOiuge1wkTj5v:APA91bFEGUhEoWidTlD4Zo2aQPbQtAL-gpJP_beak4jOxNPX153941SUAlTEXgS7q6H8rdv_AmGf-Zx7sfEb1XFzHyEl9kMWenXyE7DkCQUYlfK9aECZLt-LxiMSptnoCc05MZlMRYE7	4	\N	\N	\N	\N
258	2	Gautam	Marwaha	male	$gautam$marwaha786$@gmail.com	$2a$10$1MpyMmF8QVtRBL8IdcAxgemkFdQDsXrgIp0yNfKIoh2ctz9HROnO2	\N	\N	\N	\N	AUGT	\N	\N	1	2020-05-19 08:50:55	2020-05-19 08:50:55	\N	1	\N	\N	\N	\N
269	2	sdgvsfg	dfdsf	female	$afdsf@dfvdsf.aefaf	$2a$10$HBrYB0.xC.e8xmn5GTFpjeIoBBtlsXPJKLF/ZCbYwoJ7Pskc0afiO	\N	\N	\N	\N	OMSM	\N	\N	1	2020-05-20 07:14:05	2020-05-20 07:14:05	\N	1	\N	\N	\N	\N
256	2	usersr	testerr	female	user45@yopmail.com	$2a$10$5CvS8e2FOlvoKo45f43xYOqyXEzZQzmAkKZdv7v/a3CPPhVvussVa	1589882618791.jpeg	\N	\N	\N	IPHT	\N	\N	1	2020-05-18 09:56:48	2020-05-19 10:03:39	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	7	\N	\N	\N	\N
254	2	secF	Userrr	female	user42@yopmail.com	$2a$10$fMIc5lAyKgxU9iNO6p/GgezgnmIQ2GE4F4O2GivKfYJoqm89avy6a	\N	\N	\N	\N	URRJ	\N	\N	1	2020-05-15 11:14:31	2020-05-19 12:52:43	cvTEtFXUTZek_GYwOnxHLt:APA91bE1aIwv-WJUyzAb9LIOdkpEQZkFZ_CxYbIs9g_RzSt2klkOhXS6Tmd2rbTmRfOOXtM8Sia1O0zmC91DxntA7Si1Tn1a9MUsIXsGx8GbBTfRG5aY9OuhCBbs1YEAByjZ_ZMpOFq-	5	\N	\N	\N	\N
270	2	sgsg	sgsdg	female	sdgdsg@sdef.sdfg	$2a$10$wwt22b8Cs2r2s9m5EEgU3.YC.uYq4jrGNq3..Mt/dJ6HWrTGp3gVa	\N	\N	\N	\N	XATT	\N	\N	1	2020-05-20 07:15:17	2020-05-20 07:15:17	\N	1	\N	\N	\N	\N
265	2	Subodh	testF	female	subodh@subcodevs.com	$2a$10$Npc22ET4MarrmVDXEOltOuqRnpoAN0ELCNxg5Z.Y/tSOvsyMPOdSO	\N	\N	\N	\N	REGD	\N	\N	1	2020-05-20 12:42:51	2020-05-20 12:42:51	\N	1	\N	\N	\N	\N
274	2	Hzjjs	Hsjjs	female	hsjja@hsj.jzk	$2a$10$56IrmgcBYZhh.zx7eWS23eW0rw0ua1ehCvetLCmk1OWK//D87Zo1.	\N	\N	\N	\N	CRGL	\N	\N	1	2020-05-21 11:34:32	2020-05-21 11:34:32	\N	1	\N	\N	\N	\N
271	2	sgsg	dgdsg	female	dsgsg@afs.sgesdg	$2a$10$tU1mTtOASTD5aHI.rQImteJDHwRivv1QxCimtihpfkan7BWhTHJR6	\N	\N	\N	\N	RICA	\N	\N	1	2020-05-20 07:15:33	2020-05-20 07:15:33	\N	1	\N	\N	\N	\N
272	2	asdfsd	asfasf	female	afaf@asfasf.asfasf	$2a$10$tMU25BhnkCVgwycTYsJhC.K1omG8PB/WNRnjutssLviTDI1L/3LFO	\N	\N	\N	\N	QVUX	\N	\N	1	2020-05-20 07:15:47	2020-05-20 07:15:47	\N	1	\N	\N	\N	\N
295	2	abhi	teoti	male	teotia@yopmail.com	$2a$10$/ZAzE8YM4N2EdZVH15.OBO/quq8QkqkPjb9asYnwOrJbKLPTrTD.6	\N	\N	\N	\N	XJCD	\N	\N	1	2020-05-22 10:18:21	2020-05-22 10:18:21	\N	1	\N	\N	\N	\N
283	2	Hhdh	Ehhehe	female	hehyryrueu@gmail.com	$2a$10$8kjEbE3U6vjtDZg70NUQWOGIy2LbQKZWPuWfBBfhg/0QMaeosle1C	\N	\N	\N	\N	POQZ	\N	\N	1	2020-05-22 07:13:54	2020-05-22 07:13:54	\N	1	\N	\N	\N	\N
284	2	Gautam	M	male	gomsymarwaha@yahoo.com	$2a$10$qKB1ORPsJvcN178L2kBmuean3wdw.lafguBH8FiXSEZN.b4ixNjku	\N	\N	\N	\N	UDYR	\N	\N	1	2020-05-22 07:21:58	2020-05-22 07:21:58	\N	1	\N	\N	\N	\N
278	2	arskd	ekd	female	qw@yopmail.com	$2a$10$I8JIs8Xgdz0a7IqY2G/hk.5g6KKWfPo8VmF9wyshaRGSnmFjS1x0S	\N	\N	\N	\N	NHLL	\N	\N	1	2020-05-22 03:45:37	2020-05-22 04:05:40	cCN1rOIJM07fpqoD8203M2:APA91bE18gFlQo0x8XpUgAce8Z7dnObksJDI6F5V20lNutwct395RZVPI9ycny4XcLmTpmyNECeK26zIZo_DOXulX52sMSdRm0rzVfbGUAfQcJmIZN1Ctq1raTBUtzPBey_NNgVL25Hu	7	\N	\N	\N	\N
264	2	secF	Userrr	female	user47@yopmail.com	$2a$10$n4OetG6Xt0ggul25NTdf.u5iVMJSM4ZgHW85G95QLer2GjhCTwTVa	1589950674635.jpeg	\N	\N	\N	IVFD	\N	\N	1	2020-05-19 12:53:42	2020-05-25 10:58:57	cxnZV9EzQvClsuB0gV2xcB:APA91bGn6VNpdv65_aiXm1rHMyuuxWJEXMBsKKmqKVZx4iu1SA7hWnSHYRpWWWN7JgQ4RSBQL_ILSx4sAAeS72RRjtUyzNVpw_mEfi70lU3C4JSyuyhFWQ3hpI2yrBnYuvOrbFWMfXGH	6	\N	\N	\N	\N
297	2	awdrwa	af	female	afs@afr.aer	$2a$10$bmwAZuS5X92Y1w.gh5U9rOyxMZSB/Y0xolLPjK1YcIyfS7gll8JJ.	\N	\N	\N	\N	NNCB	\N	\N	1	2020-05-22 12:19:58	2020-05-22 12:19:58	\N	1	\N	\N	\N	\N
276	2	ansn	skdj	female	at@gmail.com	$2a$10$t11FsejPvwGlPhgmjHF2T.J1hTednaYaqhgbid.hSXXrmXSkXcl5K	\N	\N	\N	\N	ZRCH	\N	\N	1	2020-05-22 03:44:21	2020-05-22 03:44:21	\N	1	\N	\N	\N	\N
277	2	jsis	skdk	female	try@gmail.com	$2a$10$qzqYl/A4Tl6cNwpjmLXkyOKGd4x4RoHIyNcrb.qdP8WFtCCjeF9Fi	\N	\N	\N	\N	BZOU	\N	\N	1	2020-05-22 03:45:05	2020-05-22 03:45:05	\N	1	\N	\N	\N	\N
282	2	Fry	Ff	female	try@yopmail.com	$2a$10$jaaW/J108xFG.h5WmPFdbOpnGVYbXiioERn0HFZdxSkaaU1RrxcwW	\N	\N	\N	\N	HVHI	\N	\N	1	2020-05-22 04:32:21	2020-05-22 04:32:21	\N	1	\N	\N	\N	\N
279	2	bhavna	qaf	female	gomjita@gmail.con	$2a$10$LluuISzNI58KG1Y7BJ3wauKdbW6Pu2gwoo01Xrj79FWVZANQe3NwC	\N	\N	\N	\N	ULTZ	\N	\N	1	2020-05-22 03:46:37	2020-05-22 03:46:37	\N	1	\N	\N	\N	\N
286	2	Gg	Ggt	female	gghgf@gmail.com	$2a$10$fm3KENlVyuTK1pLCNX9zx.r8LTYIK11QRBslixQfk3rwnDltmIHui	\N	\N	\N	\N	TANL	\N	\N	1	2020-05-22 07:53:23	2020-05-22 07:53:23	\N	1	\N	\N	\N	\N
287	2	Ghhh	Gggg	female	fuchfugj@gmail.com	$2a$10$omLlTALXsyi4RKesB7brVOzuuaEIaR01z/Bs2/7y83soo4FrSMpv2	\N	\N	\N	\N	QCHY	\N	\N	1	2020-05-22 07:54:23	2020-05-22 07:54:23	\N	1	\N	\N	\N	\N
293	2	Gg	Ghh	female	onspotyogi@gmail.com	$2a$10$e.1nbzouL1rL65ObaKRO1.u6WnHZYb3ePfytrIq1CDdlCNcZkOS1u	\N	\N	\N	\N	VPOJ	\N	\N	1	2020-05-22 08:50:23	2020-05-22 08:53:20	e2NFREC9RuStyQOyxOX5Jr:APA91bExtpLthKAUONFMmk6-85ZMa6foP4oNmR9nlE8h9slDuJTnSxddvZeJJe1s8q5q0mGi4iH635Gj_NfjBYZmciBas52haC6b2JREUkDyQYQ2IGfTtCZYvcXldZzPs_qsvZPS4GAS	1	\N	\N	\N	\N
126	2	Subodh	Srivastava	male	subodhsri1@gmail.com	$2a$10$BxKT7Md41PfvEuHuI.NoweqcdANlWmEGF6ffnZgjSEway5tWHE1.G	\N	\N	\N	\N	SQDT	\N	\N	1	2020-05-07 04:20:37	2020-06-23 03:35:39	cjbUl3ws50qivDvjEBc6Jf:APA91bHmC30c-TV7QVTEPpkqLfYr-SgeEyLPxCC2tNT4HVz_UQ5_RIFfQfyKIgjL60aThvMMIqJtgqVL685mDOGBHJS1KTW56K4wFclr46NW7JMjz6Kn-7KVhVwzwUK9Mub1Uu_MNq7N	4	\N	\N	\N	\N
288	2	afa	asfa	female	asf@awf.af	$2a$10$dIEE9xZv.OQdGJLXzX4Jxu62sIw9RoioKLeDByjRz46B7GUxapS8u	\N	\N	\N	\N	HJBN	\N	\N	1	2020-05-22 08:17:04	2020-05-22 08:17:04	\N	1	\N	\N	\N	\N
292	2	hhshs	hshs	female	jsj@hsj.com	$2a$10$XRs3ucF9INKG09B1orylJ.1Z7hQcqEPXY59CmbONC1dYHpZkDg.6u	\N	\N	\N	\N	LNXO	\N	\N	1	2020-05-22 08:44:40	2020-05-22 08:44:40	\N	1	\N	\N	\N	\N
280	2	Fhd	Eheh	female	raq@yopmail.com	$2a$10$MuakAfS9/rV5qwzOMInCQ.pPCznnMKWIoSg7CDUpEG3j3ZNb91/9G	\N	\N	\N	\N	VYNA	\N	\N	1	2020-05-22 04:08:54	2020-05-22 04:15:32	dCRQRPmQQxC7ZsEabqdisS:APA91bHd9wD1Q986hAv7hPS9da7A_O2P_jxk_prefmj7-jvveZICvp06inzfiGCzRt9ILlUA-Hk3z-YrQs_bxMJG0GI6TkFrM0jv81Vm2MhG2sm4rCskNncWvcwtbAPRAv1Tp--el8Xh	7	\N	\N	\N	\N
290	2	Trump	Us	male	trump@yopmail.com	$2a$10$i0m73FMlU2bqBgl6JfsJuOd3ezgw/lHg/CttP2uDRzVILfnFV4l12	\N	\N	\N	\N	BXBZ	\N	\N	1	2020-05-22 08:34:59	2020-05-22 08:34:59	\N	1	\N	\N	\N	\N
343	2	firstM	Userrr	male	user58@yopmail.com	$2a$10$biu7ahLh1MG6th/ORY9Wnei7pFEldXW6YZ/QspUfQWY7lrRh6Gl9.	\N	\N	\N	\N	FWXL	0	2020-06-11 09:52:06	1	2020-06-09 11:46:57	2020-06-17 08:37:02	cFw4ceeKSeWNhOlRfDP5Xg:APA91bHQRv763w4MGkHQ_sNdDvwERIRUVmhqsvYJmMUBZbUqIHfgOP4RJkKZC6KpRYqxz-YrxwxJo17RuL6DivJfsdc-qM6MVzINUEZjY257kR-uKelZ6A6iCyc6oC4CO5D5q4LMgoAV	7	\N	\N	\N	2020-06-10 09:52:06
316	2	Try	Angle	female	web@yopmail.com	$2a$10$iAwgrhgQHqYAuCiCPKO91eQCj1mZO7TdZsfzC3bDiBLEg5Qs5iJNe	1590514923147.jpeg	\N	\N	\N	LZAA	\N	\N	1	2020-05-26 05:41:48	2020-05-26 05:42:03	\N	1	\N	\N	\N	\N
285	2	female	female	female	gomsymarwaha@yahoo.in	$2a$10$FoRKA9w1.w7e9a.fIKHtiOdfaU2WQtDP.GDIZb83fnvlmfw.wI6P2	1590496789551.jpeg	\N	\N	\N	HGZW	\N	\N	1	2020-05-22 07:23:23	2020-05-27 06:52:34	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1	\N	\N	\N	\N
361	2	Elgoog	Play	female	elgoogclass2@gmail.com	$2a$10$9yNtzO9The5ZtCQRMEZ.kOS7W9IFVAEsxUeBGsvmRbPbZRLtSZgay	\N	\N	\N	\N	YVAE	\N	\N	1	2020-06-17 07:48:59	2020-06-17 07:48:59	\N	1	\N	\N	\N	\N
298	2	f	dk	female	dk@yopmail.com	$2a$10$EdPb4SE0YOC7wBe4MxF3AuHz0.2Jf9eBjvrupBUzbN.YOswhmHNbC	1590152875878.jpeg	\N	\N	\N	INJG	\N	\N	1	2020-05-22 12:42:08	2020-05-22 01:22:15	cCN1rOIJM07fpqoD8203M2:APA91bE18gFlQo0x8XpUgAce8Z7dnObksJDI6F5V20lNutwct395RZVPI9ycny4XcLmTpmyNECeK26zIZo_DOXulX52sMSdRm0rzVfbGUAfQcJmIZN1Ctq1raTBUtzPBey_NNgVL25Hu	1	\N	\N	\N	\N
348	2	Abhi	Teo	male	abcd@yopmail.com	$2a$10$9OQmOqXodC.nglnUkPMm3eH9nTYbOCOEpTaVHH0dm21o6YEqCBTv2	\N	\N	\N	\N	SAKT	\N	\N	1	2020-06-11 08:34:54	2020-06-11 09:59:24	czIDQJQfS02amsfu51wV9I:APA91bEg7ShlMZ3R7kTVlUQ4sqvdMQOUMORtcvzqHHhX9do_lZRL5sA7zKxmKxh5zDrn9OzpcL2e7c0O7gILl1c_D43Kibr6oAEPSM17yrsvwAOeqPCmX6SvMb9oq_EEazh5miKVwz93	7	\N	\N	\N	\N
294	2	qwer	qwert	female	car@yopmail.com	$2a$10$0n/vCJfggHqKo0DZnhDWQONHHFLcyAC69juaotYKjJTxI.9c6Yh1u	\N	\N	\N	\N	YNYN	\N	\N	1	2020-05-22 10:15:06	2020-05-22 10:15:06	\N	1	\N	\N	\N	\N
296	2	abhi	teotia	female	abhi@yopmail.com	$2a$10$GcsvgcyPj/SKZ5cYy.fu0.vrQOvDrhgYjcANM6J1v6F1hYV.wEANG	1590142752048.jpeg	\N	\N	\N	YPRG	\N	\N	1	2020-05-22 10:19:02	2020-05-22 10:23:55	cCN1rOIJM07fpqoD8203M2:APA91bE18gFlQo0x8XpUgAce8Z7dnObksJDI6F5V20lNutwct395RZVPI9ycny4XcLmTpmyNECeK26zIZo_DOXulX52sMSdRm0rzVfbGUAfQcJmIZN1Ctq1raTBUtzPBey_NNgVL25Hu	1	\N	\N	\N	\N
323	2	Tester	Users	Female	testers1@gmail.com	$2y$12$8gHAAkwN.94SSQDIZqociOi8obGlXALDmMpeYJEEMKPt.BtY7QAGO	\N	\N	\N	\N	WYBL	\N	\N	1	2020-05-28 03:53:55	2020-05-28 04:49:57	ft2VCHufQOiu1MprOTEPW4:APA91bHBObRr3Tpp8xn2UW2MuKUl4VDQiDbB9R61gXvxDQV0VbFZgeS8gGuqnwIjB0kBh3pOxK_sUf7uPWqQONxU07xxpR-8eWg3_mMLsWZaOxIUQuCDRAXDSgl7wFyK9tOGioH4hG7n	6	\N	\N	\N	\N
329	2	abhinav	teotia	male	teotia12@yopmail.com	$2a$10$8PTByRwzU55CbMqk/OvFOO7PotN2hAYnYfzZvgis6ex0X6tXOeWzK	1590988880684.jpeg	\N	\N	\N	XDBU	\N	\N	1	2020-06-01 05:21:09	2020-06-01 05:23:00	cpp9j3VaIUIFsCH2gXQmtj:APA91bE60XmothOYDJzjWbf712eWHEm26kc6a-KOqBnrDNuDNat2_vvFSlWSapU4v5WRBwfZJdRGuh3Lvge_wv8aNJtXKtPSyFSypG5Wlv5YtRnJBHH_Z-uzwXOwF-4r6Sb1WE_RIiuH	1	\N	\N	\N	\N
333	2	Demo	Te	female	demo@gms.com	$2a$10$7Te3U2uWCy.ho69Qi8ruweVimFQmVSjHptb/ZYssK1uRSBcOTuuZm	\N	\N	\N	\N	ZLOZ	\N	\N	1	2020-06-02 06:50:40	2020-06-02 06:50:40	\N	1	\N	\N	\N	\N
324	1	Tester	Users	Male	testers2@gmail.com	$2y$12$8gHAAkwN.94SSQDIZqociOi8obGlXALDmMpeYJEEMKPt.BtY7QAGO	\N	\N	\N	\N	YOXA	\N	\N	1	2020-05-28 03:56:00	2020-05-28 03:58:48	chJTK7FmSJqtjkScBd0Gba:APA91bHMyMzTcL6PCJCnJmlK0MgnYDqjZtGnT9_g-vV-lWB-mANhGDfM1n_bhkeYO64ntM4CYzeo4JfxPmdEVA0foUoS7JwKHJxSXSve-6kWCTBu2t2CV5L-krnTYdsYMpCI7ddoPNpv	6	\N	\N	\N	\N
299	2	test	test	female	test@test.com	$2a$10$hbI56SG2OIL5S67YQby/rer2e4Bxxy6uw8UdaHFodWeoP3YPQCf4a	\N	\N	\N	\N	UOCA	\N	\N	1	2020-05-22 02:55:38	2020-05-22 02:55:38	\N	1	\N	\N	\N	\N
368	2	David	Mcknight	female	davidcmcknight@gmail.com	$2a$10$/9ZRUwV9noYT8Q62.YV6e.b.eXWEo9iyfqHjI2xF56EZzPjqlB9fu	\N	\N	\N	\N	TYEF	\N	\N	1	2020-07-17 03:26:02	2020-07-17 03:27:00	cUE-KgjcoUsNlt2fJRwSu0:APA91bGSdysYVm8yjOCTzk5ItyueQpFhimAsVXG8P2zCoAnzNCZqP4aSzA_c_5-AAJ6qN7NIsEmIDWV8WJbsTVc1-8HMoXdIEeeH1qcCpwyVmjm2jVg5M-rD3KJNE0VOPjDgDyGC5QmO	7	\N	\N	\N	\N
344	2	secFjcjvvjjgjjgjgjgjgfhjf	Userrr	female	user59@yopmail.com	$2a$10$SsBrh7duTU.9rewkPucukuiI6J0eNZaPiRS4lWJwj.1a.zVZZWTDm	\N	\N	\N	\N	JWPY	0	2020-06-11 09:52:06	1	2020-06-09 11:47:11	2020-06-10 09:48:30	epWYhvmITLuxxv5A8RIqYg:APA91bFWISeTGwCIgmytcrvDRlktPK0tRa3k9ucb-VQAgJoM8-3CzPVb07VibnVAx5O5dmP-56zn8ac6abdCLyRNBppItbyTWiz1VivU5PdVEH1sEg-3rnU2rs_rf4ionhmQNTWMD2Xi	7	\N	\N	\N	2020-06-10 09:52:06
349	2	nav	tia	female	efgh@yopmail.com	$2a$10$rWHXT1PUNXmRUkDVVL7S/eHOkxxHm35ki8V67eyNB7jFnWGzy6EbS	\N	\N	\N	\N	TXSR	\N	\N	1	2020-06-11 08:35:14	2020-06-12 10:49:37	fpSEAjWv_UPIvorM68LiIk:APA91bHd2bHbqDzVAJVVdA67FX691drzvMLALOVWk1A3kgolanTYNfntzGPPGXHwUqqQ2PGqcnybp-J8mjBVTri4ICPfEya3P1S6N5ETUJn3aEtC8GOQ7uDLEri2gyr5of0mbiVO3QB6	7	\N	\N	\N	\N
289	2	face	tde	female	try1@yopmail.com	$2a$10$HwE87CZXdtCPE.ejUSdl1uhOb5LR8jVACnGQrWRkxh2LaGvG8kXuq	1590136331659.jpeg	\N	\N	\N	KLWZ	\N	\N	1	2020-05-22 08:32:04	2020-05-25 01:05:57	dCRQRPmQQxC7ZsEabqdisS:APA91bHd9wD1Q986hAv7hPS9da7A_O2P_jxk_prefmj7-jvveZICvp06inzfiGCzRt9ILlUA-Hk3z-YrQs_bxMJG0GI6TkFrM0jv81Vm2MhG2sm4rCskNncWvcwtbAPRAv1Tp--el8Xh	6	\N	\N	\N	\N
325	2	notification	test	male	test@yopmail.com	$2a$10$zKsv6lVno7RTMeI.fSVBz.2mHFDsycaK5Goh5F4xW91KZSg4k9xOW	1590739562148.jpeg	\N	\N	\N	TZXH	0	2020-06-01 05:15:00	1	2020-05-29 08:05:46	2020-06-01 05:12:57	cpp9j3VaIUIFsCH2gXQmtj:APA91bE60XmothOYDJzjWbf712eWHEm26kc6a-KOqBnrDNuDNat2_vvFSlWSapU4v5WRBwfZJdRGuh3Lvge_wv8aNJtXKtPSyFSypG5Wlv5YtRnJBHH_Z-uzwXOwF-4r6Sb1WE_RIiuH	7	\N	\N	\N	2020-06-01 05:15:00
336	2	Gautam	Male	male	gautam.male@mailinator.com	$2a$10$a4tX/WEHTKaqfzqsB/0id.qdZZNPKiMkfLhZDRrDx606yKTpymWm2	\N	\N	\N	\N	VLRF	0	2020-06-10 07:39:28	1	2020-06-04 08:52:55	2020-06-10 10:22:29	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	7	\N	\N	\N	2020-06-10 07:39:28
321	2	Rohit	Verma	Female	testussfdfd@subcodevs.com	$2a$10$412GuNP3rSQA12CX5K/DNelbzsrBMK8MYxcdbX.2RfZzhzD0Ftygq	\N	\N	\N	\N	BOLL	\N	\N	1	2020-05-27 02:48:43	2020-05-27 02:48:43	\N	1	\N	\N	\N	\N
307	2	abhinav	teotia	female	teotia1@yopmail.com	$2a$10$GSiMxOX1xxAady0EfqgtJOjxD6/t6OQOsZDVQuFn2ozRHskWDg2Ja	1590368564142.jpeg	\N	\N	\N	TUOX	\N	\N	1	2020-05-25 01:02:21	2020-05-25 01:03:30	cr3zxBF_WEtBvsxd67j4ow:APA91bG_6OID-Zx4_j1SaCEq97u9qQZOlcM98cllqF6JSbaODWzi-7THYEOjJdWzUQKXRzIy5Ie2ze7w-kJQKyYx93CHppkrsv3qCt_l4oGU0965QNOeBveS-PVXTxYbmVDja-shIOVE	6	\N	\N	\N	\N
302	2	firstM	Userrr	male	user51@yopmail.com	$2a$10$nqOQOleXML3lNP0heIA8LOlDldWs3F6aC9HKdMiPnS9pCNaphGyH.	1590406124836.jpeg	\N	\N	\N	MAQP	\N	\N	1	2020-05-23 08:31:53	2020-05-25 01:20:50	cdniu6qW_U4ZgZVcdnnrwj:APA91bG1RM0W0sV9904coiivZXc3hUjndH-uKQ6rXIuvcubu2oS779T_j-NRSdcTdZ7yR7fDW0ACkqzJBicex2lEI7Ma0HwiIRzwT3-FxACGk3VFOUCYDuUWpMZ43VbNonedR7re8Meo	6	\N	\N	\N	\N
305	2	gautam	marwaha	female	gautam.test@mailinator.com	$2a$10$Fja8WJSth9mTRbfgczJnSO9OqnfLY6CvirHlHuXyNzrTXKBuQSh02	\N	\N	\N	\N	WOIH	\N	\N	1	2020-05-24 05:29:21	2020-05-24 05:36:31	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1	\N	\N	\N	\N
306	2	test	name	female	testthemailabhinav@yopmail.com	$2a$10$v0zGHPqkRdpku.Aw3f4PkeMVjrJRBHK.fl6dmxWAvETe4zd3tgXvW	1590368423174.jpeg	\N	\N	\N	ELEJ	\N	\N	1	2020-05-25 01:00:02	2020-05-25 01:00:24	\N	1	\N	\N	\N	\N
301	2	secF	Userrr	female	user50@yopmail.com	$2a$10$GiMuiBilQMjebn5JOhnELeR1XPyQ9/6one3x5RUfciyqwVbx8jJ/y	1590406078376.jpeg	\N	\N	\N	ZNTM	\N	\N	1	2020-05-23 08:31:39	2020-05-25 12:58:28	cdniu6qW_U4ZgZVcdnnrwj:APA91bG1RM0W0sV9904coiivZXc3hUjndH-uKQ6rXIuvcubu2oS779T_j-NRSdcTdZ7yR7fDW0ACkqzJBicex2lEI7Ma0HwiIRzwT3-FxACGk3VFOUCYDuUWpMZ43VbNonedR7re8Meo	6	\N	\N	\N	\N
327	2	firstM	Userrr	male	user54@yopmail.com	$2a$10$ctq0nk0gFnoPv2DZmWkFu.A3ds97k1.ZWlRsrsmKBPub7rubAmqle	\N	\N	\N	\N	BGUA	\N	\N	1	2020-05-29 10:14:58	2020-06-03 01:46:40	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	7	\N	\N	\N	\N
303	2	gautam	test	male	gautam_marwaha@yahoo.in	$2a$10$7.hR/QyHJysfJi9upzk9kewIYtaF9XP.OMaAJbXaJ435JIpXaSGiK	\N	\N	\N	\N	EKYN	\N	\N	1	2020-05-24 05:22:10	2020-05-24 05:22:10	\N	1	\N	\N	\N	\N
300	2	a	f	female	asf@yopmail.com	$2a$10$93IkN2ty8VTsE6G3HDSjS.DI3txIsh9pvHI7kjkLAZFG/4zEUBhQm	1590168674246.jpeg	\N	\N	\N	QZNY	\N	\N	1	2020-05-22 04:35:13	2020-05-22 05:31:14	fciXgSmjI05lg8BWe_UCNC:APA91bFQAhL_fik98j33TaxLrsmQwOCHdcZTXNs-DO96NSWz48mCry8LiZkjOuH4tMVC3BU-Zv2Kxpf02ovuP_kxTZGe1s8jBi07VC5OsOsDqup9daJliV7AOhudVxzInLfeAH4MZH5l	1	\N	\N	\N	\N
304	2	gautam	marwaha	female	test-q@gmail.com	$2a$10$fvzJWAeffZf0qs7pXiY1jut9YFqs6nra711vj8ZBUcLgohi2KbaIi	\N	\N	\N	\N	GGQX	\N	\N	1	2020-05-24 05:26:40	2020-05-24 05:26:40	\N	1	\N	\N	\N	\N
369	2	Kristine	Cooj	female	ahart3188@gmail.com	$2a$10$TRErp5zUvm12JpR/Yz/HsejqdiO5PZEdZr7aTTRG.0ICzytJiMO.W	1595035377248.jpeg	\N	\N	\N	LLMI	\N	\N	1	2020-07-18 01:22:18	2020-07-18 05:24:09	dJ8mCy57QIiyVCcan4WmKd:APA91bF-wONl3sa2nogd9tNvKDX5jkYlfIqCwMNgRAAbami-TOLE9k05RgmB3oCZ7U02PVMAUBrazo2rMfgdVwN9HBPQIuCwUPfTYwiUNTfrK_EQQUpPaf_RgIXuosoXKGDK6SaHMdhP	1	\N	\N	\N	\N
312	2	secMas	userasfafasfasfsafafsasfa	male	user53@yopmail.com	$2a$10$UyX9IbcHqPWxr/amH3jFbuCzxUFPuJmxVQz5DcRiqiBo5lF62IxYe	1590414391861.jpeg	\N	\N	\N	MWLY	0	2020-05-28 05:44:28	1	2020-05-25 01:46:22	2020-06-03 01:45:37	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	7	\N	\N	\N	2020-05-28 05:44:28
308	2	gautam	marwaha	male	gautam.oh@mailinator.com	$2a$10$vmpveq5OgXLN295d/8hrHuq5oxfG97Q54mL7PV61veupZuCHZeCKG	\N	\N	\N	\N	SUKX	\N	\N	1	2020-05-25 04:38:02	2020-05-25 01:02:53	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	7	\N	\N	\N	\N
363	2	Release	Test	male	release1@yopmail.com	$2a$10$mVxQjVZaW1aZHmEDunQ54..CkYZYpnWwrWMUFhBHaSMavi4Fxc2ky	\N	\N	\N	\N	WMFB	0	2020-06-19 12:07:45	1	2020-06-19 11:53:03	2020-06-19 01:11:49	dXM2S0w-Q3e4gMQVnONWo8:APA91bHfWF9u4ip_oUzOjezHSftB62CDrmfmGlS5PG4OQZUjs_PcbExYpkZohC8moei5YlLatoKQum_ZqHmaVCAwvylt1hL5gjkxRSwJhgvH8n7OZrwiSFz9rPyf8hxmTiIVqn5UtFSU	7	\N	\N	\N	2020-06-19 12:07:45
337	2	Bhavna	Female	female	bhavna.female@mailinator.com	$2a$10$/NZ0mJHdEdHqVrwjOb2kJOxUcVdwZRl5UhBxWdvZw8WAWbqwPeeDO	\N	\N	\N	\N	DMOP	0	2020-06-10 07:39:28	1	2020-06-04 08:55:45	2020-06-27 07:07:58	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	7	\N	\N	\N	2020-06-10 07:39:28
331	2	Gautam	Android	male	male.android@mailinator.com	$2a$10$cDFZRKQ7ZXCBvgCM0rRnnOK79laGqFEqiylXTSs2.jAnwlZ5oKTDe	\N	\N	\N	\N	UQAQ	\N	\N	1	2020-06-01 09:28:28	2020-06-01 09:30:23	\N	1	\N	\N	\N	\N
328	2	secF	Userrr	female	user55@yopmail.com	$2a$10$rgSW7kE6MvU41vGwL9sLrOSjaRTU7QAd70UbmSbA1zP1cNL.VLBJC	\N	\N	\N	\N	MEOP	\N	\N	1	2020-05-29 10:15:11	2020-06-03 01:46:27	e7Ufb4lLQYWy1MupwYXU3e:APA91bEPkV_yX_82OTYb-D_YTFzJ7cjaUt1-IudepvJXkNbGNkCL-1yUFHywZxNa68_lYuuJiQALw4q5ApyQoKpIo6jj9TrLGPiuRjPniZIYmuwjpMxqF7glv3Wi3E82mcP81q0wSP-9	7	\N	\N	\N	\N
311	2	firstM	Userrr	male	user52@yopmail.com	$2a$10$gUrEpJbwtilpEzFogDbq8OgKMSHHy5gW9w0SxYqH9SzFTjwq8.0qy	1590414827812.jpeg	\N	\N	\N	WGAE	0	2020-05-28 05:44:28	1	2020-05-25 01:45:46	2020-06-03 01:19:26	dPhStgg7QbiiY4gFMo_S3Y:APA91bHRNQZJulY_Uy8ot-mxOXhtqO6o8oxiJjzNEKK4yWqnwB_lUcsEWmF9o9opgXL1oWyrOpufQaFmonS0Q8aHbWa3tmzUSvPgm83SQLwBXdjF7rqZM78H9CcodIiLHlCkNJkfCsdu	7	\N	\N	\N	2020-05-28 05:44:28
350	2	Tedt	Tedt	female	demo.globalia2@gmail.com	$2a$10$lpRZ21gmZPTd8r9l/XflqOqEcd8OADgFtzdpWicxPx8.DnF81aRa.	\N	\N	\N	\N	MHXD	\N	\N	1	2020-06-11 09:54:17	2020-06-11 09:54:17	\N	1	\N	\N	\N	\N
322	2	test	rest	male	on1@yopmail.com	$2a$10$wMCpUHW0y7mLuDk0fhas6OXEz4hL0cylQaBGV9DY..Ibj9WO3aCgi	1590599515298.jpeg	\N	\N	\N	KYAA	0	2020-05-27 17:19:16	1	2020-05-27 05:11:44	2020-05-29 07:41:24	c-v8W5JS2kuwtElzIm240t:APA91bGIoshnH5G4LicHKjKUnASajeu_EYW9wvM58n6WGQJ5y3kbhaM0lR2XfnBn6FOypS9_N6Hmvo9v5UyshwqiIy00dPi9wcf8g-_IT4jad8YwdOilIul-qPrIlO97y2rDkY5yIFUM	1	\N	\N	\N	2020-05-27 17:19:16
362	2	latest	test	female	release@yopmail.com	$2a$10$.9JJpx716itDLuzcyjvY7eXaaaDJkCnp2EsjkkyEMrzvAQEWkjEOW	1592566485325.jpeg	\N	\N	\N	IBDO	0	2020-06-19 12:07:45	1	2020-06-19 11:34:16	2020-06-19 11:54:29	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	7	\N	\N	\N	2020-06-19 12:07:45
340	2	mkb	Mkb	male	mk2@yopmail.com	$2a$10$y1OI9/lgSif5i/ATwBBCeeMOLo6YBtppChhh5qVVcyeYTdFKRlNAG	\N	\N	\N	\N	DHDD	0	2020-06-11 07:50:14	1	2020-06-08 05:49:08	2020-06-20 02:30:01	e0QNplpoSBa5EK0OT6KC1z:APA91bGwvxaCF9PZBPUlyy156CW6m4giu3u1FYn05IgpoNBr6hehqIyjeoxsjZmp8iX0VPd4Nmw9ThtRtGWVmyRrbBeUI24-mMTQv7yw7kyUVavvJB4HtNCU8MjE_hL9kg4rfjP9-Qsz	7	\N	\N	\N	2020-06-10 07:50:14
352	2	Tedtb	Ggghh	female	demos@yopmail.com	$2a$10$OCfDfraOE5Q/y/r6pxL/ruuaCql4u2n70Qup8/0t978ypq9uoAk6W	\N	\N	\N	\N	ADWN	\N	\N	1	2020-06-11 12:01:25	2020-06-11 12:01:25	\N	1	\N	\N	\N	\N
334	2	secF	Userrr	female	user56@yopmail.com	$2a$10$SKp6GEeLpgfua6fktHvFguVAy/AIYIRzRl4sWAqvFCqnnv/AwQGpy	\N	\N	\N	\N	EROF	\N	\N	1	2020-06-03 01:47:53	2020-06-09 11:12:42	eK_CqKB0RNeS9Toz5d6hE3:APA91bG3UC3oNH4v7BDElUB4sYsY9KnMZH9sc1ARWMNcDKGSP4pOoGRv3Dk3ESZyvlIOFeK0UUi0Ld7XlC_RNEQzxJZbyiQAbWcV52SDPKOiusP4yoEoyqv2XO3cpat-m-oEiVMbTLe3	7	\N	\N	\N	\N
330	2	sheetal	iPhone	female	female.iphone@mailinator.com	$2a$10$8rH8Kv.MUzQ9U0L.ToWum.fChdKjnjIWqBpG6oqMmdq/Rtq7K3YpW	\N	\N	\N	\N	BSQF	\N	\N	1	2020-06-01 09:25:36	2020-06-04 04:32:09	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	1	\N	\N	\N	\N
332	2	Gomsy	Android	male	gomsy.android@mailinator.com	$2a$10$WwtQU4UIjeZQIRlk5hy35eFHoV1pGzkUDjDEF6/VMnnkgtvLXb6Ta	\N	\N	\N	\N	FPVE	\N	\N	1	2020-06-01 09:48:18	2020-06-04 08:22:04	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	1	\N	\N	\N	\N
345	2	TesterQ	Testerw	female	testusers1@gmail.com	$2y$12$8gHAAkwN.94SSQDIZqociOi8obGlXALDmMpeYJEEMKPt.BtY7QAGO	\N	\N	\N	\N	IQOU	\N	\N	1	2020-06-10 10:02:34	2020-06-17 04:09:37	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	7	\N	\N	\N	\N
319	2	Male	Kumar	male	male.oh@mailinator.com	$2a$10$HvWDMRXTGHRGb/v3cSgCGev.osyQH1WBCO3CNPmEWSY7.WghNjsFm	1590567316755.jpeg	\N	\N	\N	IDYA	\N	\N	1	2020-05-27 08:13:39	2020-06-01 09:14:46	cUTb6yUoRcinLCq3pSvqJo:APA91bHFx_RpN9P50PC8adAOon0rcEM4H-H_M0ff93mhUiAhL_OgC7MRj7ZcLYK0AOoN_dALKKV4OGbd26pVDsE4VlB7Hvg2WAp492Iq8CrFVa_xMjzNVBOY9744H5FJOKaLGetOmOzM	7	\N	\N	\N	\N
364	2	Subodh	Srivastava	female	subodh@yopmail.com	$2a$10$EcytYriMCBqVpL24udfP8eA3hqDvKUCaN.iJzKhheoWhTR1cAFGNC	1592927043420.jpeg	\N	\N	\N	XPOE	0	2020-07-18 03:49:51	1	2020-06-23 03:43:16	2020-07-18 03:56:52	cjbUl3ws50qivDvjEBc6Jf:APA91bHmC30c-TV7QVTEPpkqLfYr-SgeEyLPxCC2tNT4HVz_UQ5_RIFfQfyKIgjL60aThvMMIqJtgqVL685mDOGBHJS1KTW56K4wFclr46NW7JMjz6Kn-7KVhVwzwUK9Mub1Uu_MNq7N	1	\N	\N	\N	2020-07-18 03:49:51
320	2	female	kumari	female	female.oh@mailinator.com	$2a$10$u/HAC4Ym3UmiBwfnQCD2d.d5XWs9fkCHukth6ES2YKOpfe36JlK6G	1590568680147.jpeg	\N	\N	\N	ESIM	\N	\N	1	2020-05-27 08:37:38	2020-06-01 09:17:20	e6tvONUQwElnpNzWw1HpG6:APA91bHvowm_j_pC0soTlyCgWN0g4uMvRf7NH1KUIK4PkytvvNwj_upjMQuUR6RN1bMS620bFgEeX91tH18fjIPm7Y7R2hU4w8k61pAQPSBw5qHurUaj1ANqJbzIWyHFzE4mYpdC4jI1	7	\N	\N	\N	\N
346	2	Testuser	Test	female	testuser2@gmail.com	$2y$12$8gHAAkwN.94SSQDIZqociOi8obGlXALDmMpeYJEEMKPt.BtY7QAGO	\N	\N	\N	\N	BKRE	\N	\N	1	2020-06-10 10:05:12	2020-06-10 11:13:54	cGdG8VmBSMuL83NJXhjCjs:APA91bE_fx3JXk3pw9uXjdNKQd2Dq3qKpVzNSk6b9D0inqWJIiXMvjoICTUONnbZNcgGS4ZlnSdHaeEhAonGRv4EOsT4fX7tYyGjtSyYMOtEbmFB3OWKGCwCOOg0I0nod16sj5IkP3Gy	6	\N	\N	\N	\N
357	2	male	id	male	male@yopmail.com	$2a$10$NdIyU3JwBtTrm64nyRWIL.XNgLMtZkoxlYHbYM0nZQFi8pTo9bcHi	\N	\N	\N	\N	STVY	0	2020-07-18 03:49:51	1	2020-06-12 10:50:36	2020-06-26 06:26:54	cm0zU4n030Bap7ZrOuWzlZ:APA91bEZfHPON2x1rmvE7qLmXp449qt2GGqJpwQtrjMGFXbjD3dzzfc9B88FmjV-wKXQc-7NTNehoxMCl_RX3AZp01ZcPIL68mMqBESFhd8D-TTfMve3T9IyhL3ma9Lvqmt8ctFF6N3Y	1	\N	\N	\N	2020-07-18 03:49:51
335	2	firstM	Userrr	male	user57@yopmail.com	$2a$10$60C./2wVuTdS5n56ZnjJJO3bDBEqOMohBQh54u3fBPeQzCsgEVFwm	\N	\N	\N	\N	WZRQ	\N	\N	1	2020-06-03 01:48:06	2020-06-09 11:15:45	ebPye87hVEBduXyOplHCSo:APA91bFNburv6c4ZM7t_6aMOD6EkjqzOuEY97FlAMTs2oFbOJvzy0EmAGQW_j129qtynYdSJCVdcVpYp_TBa0P-QrE4YyOgLouMYrZNz86VoW2ALLxzUQG2oSyK_WqG5LgMBPOPB-eqy	7	\N	\N	\N	\N
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 369, true);


--
-- Name: Options_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Options"
    ADD CONSTRAINT "Options_pkey" PRIMARY KEY (id);


--
-- Name: chat_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_attachments
    ADD CONSTRAINT chat_attachments_pkey PRIMARY KEY (id);


--
-- Name: chat_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_messages
    ADD CONSTRAINT chat_messages_pkey PRIMARY KEY (id);


--
-- Name: chat_status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_status
    ADD CONSTRAINT chat_status_pkey PRIMARY KEY (id);


--
-- Name: completion_goals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.completion_goals
    ADD CONSTRAINT completion_goals_pkey PRIMARY KEY (id);


--
-- Name: goal_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goal_notifications
    ADD CONSTRAINT goal_notifications_pkey PRIMARY KEY (id);


--
-- Name: goal_setting_answers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goal_setting_answers
    ADD CONSTRAINT goal_setting_answers_pkey PRIMARY KEY (id);


--
-- Name: goal_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goal_settings
    ADD CONSTRAINT goal_settings_pkey PRIMARY KEY (id);


--
-- Name: info_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.info_messages
    ADD CONSTRAINT info_messages_pkey PRIMARY KEY (id);


--
-- Name: monthly_goals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.monthly_goals
    ADD CONSTRAINT monthly_goals_pkey PRIMARY KEY (id);


--
-- Name: notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: pages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);


--
-- Name: quickies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quickies
    ADD CONSTRAINT quickies_pkey PRIMARY KEY (id);


--
-- Name: roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: subscripations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscripations
    ADD CONSTRAINT subscripations_pkey PRIMARY KEY (id);


--
-- Name: unavailabilities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unavailabilities
    ADD CONSTRAINT unavailabilities_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

