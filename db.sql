PGDMP     *            
        {           postgres    15.2    15.2 N    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    5    postgres    DATABASE     �   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE postgres;
                postgres    false            �           0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                   postgres    false    3537                        2615    16398    pgagent    SCHEMA        CREATE SCHEMA pgagent;
    DROP SCHEMA pgagent;
                postgres    false            �           0    0    SCHEMA pgagent    COMMENT     6   COMMENT ON SCHEMA pgagent IS 'pgAgent system tables';
                   postgres    false    8                        3079    16384 	   adminpack 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;
    DROP EXTENSION adminpack;
                   false            �           0    0    EXTENSION adminpack    COMMENT     M   COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';
                        false    2                        3079    16399    pgagent 	   EXTENSION     <   CREATE EXTENSION IF NOT EXISTS pgagent WITH SCHEMA pgagent;
    DROP EXTENSION pgagent;
                   false    8            �           0    0    EXTENSION pgagent    COMMENT     >   COMMENT ON EXTENSION pgagent IS 'A PostgreSQL job scheduler';
                        false    3            �            1259    16563    file    TABLE     N   CREATE TABLE public.file (
    file_id integer NOT NULL,
    filename text
);
    DROP TABLE public.file;
       public         heap    postgres    false            �            1259    16568    File_file_id_seq    SEQUENCE     �   ALTER TABLE public.file ALTER COLUMN file_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."File_file_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    234            �            1259    16575    library    TABLE     Z   CREATE TABLE public.library (
    library_id integer NOT NULL,
    chat_box_id integer
);
    DROP TABLE public.library;
       public         heap    postgres    false            �            1259    16578    Library_library_id_seq    SEQUENCE     �   ALTER TABLE public.library ALTER COLUMN library_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Library_library_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    236            �            1259    16579    chatbox    TABLE     [   CREATE TABLE public.chatbox (
    id integer NOT NULL,
    mid integer,
    lid integer
);
    DROP TABLE public.chatbox;
       public         heap    postgres    false            �            1259    16582    chatbox_chat_box_id_seq    SEQUENCE     �   ALTER TABLE public.chatbox ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.chatbox_chat_box_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    238            �            1259    16583    enlist    TABLE     S   CREATE TABLE public.enlist (
    uid integer NOT NULL,
    iid integer NOT NULL
);
    DROP TABLE public.enlist;
       public         heap    postgres    false            �            1259    16678    group    TABLE     Z   CREATE TABLE public."group" (
    id integer NOT NULL,
    name character varying(150)
);
    DROP TABLE public."group";
       public         heap    postgres    false            �            1259    16677    group_id_seq    SEQUENCE     �   CREATE SEQUENCE public.group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.group_id_seq;
       public          postgres    false    248            �           0    0    group_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.group_id_seq OWNED BY public."group".id;
          public          postgres    false    247            �            1259    16684    in_group    TABLE     U   CREATE TABLE public.in_group (
    gid integer NOT NULL,
    uid integer NOT NULL
);
    DROP TABLE public.in_group;
       public         heap    postgres    false            �            1259    16586    interest    TABLE     V   CREATE TABLE public.interest (
    id integer NOT NULL,
    name character varying
);
    DROP TABLE public.interest;
       public         heap    postgres    false            �            1259    16591    interest_id_seq    SEQUENCE     �   ALTER TABLE public.interest ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.interest_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
    CYCLE
);
            public          postgres    false    241            �            1259    16592    match    TABLE     T   CREATE TABLE public.match (
    uid1 integer NOT NULL,
    uid2 integer NOT NULL
);
    DROP TABLE public.match;
       public         heap    postgres    false            �            1259    16595    reject    TABLE     U   CREATE TABLE public.reject (
    uid1 integer NOT NULL,
    uid2 integer NOT NULL
);
    DROP TABLE public.reject;
       public         heap    postgres    false            �            1259    16598    user    TABLE     �   CREATE TABLE public."user" (
    email character varying,
    password character varying,
    id integer NOT NULL,
    phone_number character varying,
    first_name character varying,
    last_name character varying,
    "desc" character varying
);
    DROP TABLE public."user";
       public         heap    postgres    false            �            1259    16603    user_user_id_seq    SEQUENCE     �   ALTER TABLE public."user" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.user_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
    CYCLE
);
            public          postgres    false    245            �           2604    16681    group id    DEFAULT     f   ALTER TABLE ONLY public."group" ALTER COLUMN id SET DEFAULT nextval('public.group_id_seq'::regclass);
 9   ALTER TABLE public."group" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    247    248    248            �          0    16400    pga_jobagent 
   TABLE DATA           I   COPY pgagent.pga_jobagent (jagpid, jaglogintime, jagstation) FROM stdin;
    pgagent          postgres    false    219   WN       �          0    16409    pga_jobclass 
   TABLE DATA           7   COPY pgagent.pga_jobclass (jclid, jclname) FROM stdin;
    pgagent          postgres    false    221   �N       �          0    16419    pga_job 
   TABLE DATA           �   COPY pgagent.pga_job (jobid, jobjclid, jobname, jobdesc, jobhostagent, jobenabled, jobcreated, jobchanged, jobagentid, jobnextrun, joblastrun) FROM stdin;
    pgagent          postgres    false    223   �N       �          0    16467    pga_schedule 
   TABLE DATA           �   COPY pgagent.pga_schedule (jscid, jscjobid, jscname, jscdesc, jscenabled, jscstart, jscend, jscminutes, jschours, jscweekdays, jscmonthdays, jscmonths) FROM stdin;
    pgagent          postgres    false    227   �N       �          0    16495    pga_exception 
   TABLE DATA           J   COPY pgagent.pga_exception (jexid, jexscid, jexdate, jextime) FROM stdin;
    pgagent          postgres    false    229   �N       �          0    16509 
   pga_joblog 
   TABLE DATA           X   COPY pgagent.pga_joblog (jlgid, jlgjobid, jlgstatus, jlgstart, jlgduration) FROM stdin;
    pgagent          postgres    false    231   O       �          0    16443    pga_jobstep 
   TABLE DATA           �   COPY pgagent.pga_jobstep (jstid, jstjobid, jstname, jstdesc, jstenabled, jstkind, jstcode, jstconnstr, jstdbname, jstonerror, jscnextrun) FROM stdin;
    pgagent          postgres    false    225   8O       �          0    16525    pga_jobsteplog 
   TABLE DATA           |   COPY pgagent.pga_jobsteplog (jslid, jsljlgid, jsljstid, jslstatus, jslresult, jslstart, jslduration, jsloutput) FROM stdin;
    pgagent          postgres    false    233   UO       �          0    16579    chatbox 
   TABLE DATA           /   COPY public.chatbox (id, mid, lid) FROM stdin;
    public          postgres    false    238   rO       �          0    16583    enlist 
   TABLE DATA           *   COPY public.enlist (uid, iid) FROM stdin;
    public          postgres    false    240   �O       �          0    16563    file 
   TABLE DATA           1   COPY public.file (file_id, filename) FROM stdin;
    public          postgres    false    234   �O       �          0    16678    group 
   TABLE DATA           +   COPY public."group" (id, name) FROM stdin;
    public          postgres    false    248   �O       �          0    16684    in_group 
   TABLE DATA           ,   COPY public.in_group (gid, uid) FROM stdin;
    public          postgres    false    249   �O       �          0    16586    interest 
   TABLE DATA           ,   COPY public.interest (id, name) FROM stdin;
    public          postgres    false    241   P       �          0    16575    library 
   TABLE DATA           :   COPY public.library (library_id, chat_box_id) FROM stdin;
    public          postgres    false    236   mP       �          0    16592    match 
   TABLE DATA           +   COPY public.match (uid1, uid2) FROM stdin;
    public          postgres    false    243   �P       �          0    16595    reject 
   TABLE DATA           ,   COPY public.reject (uid1, uid2) FROM stdin;
    public          postgres    false    244   �P       �          0    16598    user 
   TABLE DATA           b   COPY public."user" (email, password, id, phone_number, first_name, last_name, "desc") FROM stdin;
    public          postgres    false    245   �P       �           0    0    File_file_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public."File_file_id_seq"', 1, false);
          public          postgres    false    235            �           0    0    Library_library_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public."Library_library_id_seq"', 1, false);
          public          postgres    false    237            �           0    0    chatbox_chat_box_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.chatbox_chat_box_id_seq', 1, false);
          public          postgres    false    239            �           0    0    group_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.group_id_seq', 1, false);
          public          postgres    false    247            �           0    0    interest_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.interest_id_seq', 10, true);
          public          postgres    false    242            �           0    0    user_user_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.user_user_id_seq', 14, true);
          public          postgres    false    246                       2606    16605    chatbox Chatbox_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.chatbox
    ADD CONSTRAINT "Chatbox_pkey" PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.chatbox DROP CONSTRAINT "Chatbox_pkey";
       public            postgres    false    238            
           2606    16607    file File_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.file
    ADD CONSTRAINT "File_pkey" PRIMARY KEY (file_id);
 :   ALTER TABLE ONLY public.file DROP CONSTRAINT "File_pkey";
       public            postgres    false    234                       2606    16611    library Library_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.library
    ADD CONSTRAINT "Library_pkey" PRIMARY KEY (library_id);
 @   ALTER TABLE ONLY public.library DROP CONSTRAINT "Library_pkey";
       public            postgres    false    236                       2606    16613    enlist enlist_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.enlist
    ADD CONSTRAINT enlist_pkey PRIMARY KEY (uid, iid);
 <   ALTER TABLE ONLY public.enlist DROP CONSTRAINT enlist_pkey;
       public            postgres    false    240    240            #           2606    16683    group group_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public."group"
    ADD CONSTRAINT group_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public."group" DROP CONSTRAINT group_pkey;
       public            postgres    false    248                       2606    16615    interest id 
   CONSTRAINT     D   ALTER TABLE ONLY public.interest
    ADD CONSTRAINT id UNIQUE (id);
 5   ALTER TABLE ONLY public.interest DROP CONSTRAINT id;
       public            postgres    false    241            %           2606    16688    in_group in_group_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.in_group
    ADD CONSTRAINT in_group_pkey PRIMARY KEY (gid, uid);
 @   ALTER TABLE ONLY public.in_group DROP CONSTRAINT in_group_pkey;
       public            postgres    false    249    249                       2606    16617    interest interest_name_key 
   CONSTRAINT     U   ALTER TABLE ONLY public.interest
    ADD CONSTRAINT interest_name_key UNIQUE (name);
 D   ALTER TABLE ONLY public.interest DROP CONSTRAINT interest_name_key;
       public            postgres    false    241                       2606    16619    match match_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.match
    ADD CONSTRAINT match_pkey PRIMARY KEY (uid1, uid2);
 :   ALTER TABLE ONLY public.match DROP CONSTRAINT match_pkey;
       public            postgres    false    243    243                       2606    16621    reject reject_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.reject
    ADD CONSTRAINT reject_pkey PRIMARY KEY (uid1, uid2);
 <   ALTER TABLE ONLY public.reject DROP CONSTRAINT reject_pkey;
       public            postgres    false    244    244                       2606    16623    user user_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public."user" DROP CONSTRAINT user_email_key;
       public            postgres    false    245            !           2606    16625    user user_id_key 
   CONSTRAINT     K   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_id_key UNIQUE (id);
 <   ALTER TABLE ONLY public."user" DROP CONSTRAINT user_id_key;
       public            postgres    false    245                       1259    16626    fki_iid    INDEX     9   CREATE INDEX fki_iid ON public.enlist USING btree (iid);
    DROP INDEX public.fki_iid;
       public            postgres    false    240                       1259    16627    fki_uid    INDEX     9   CREATE INDEX fki_uid ON public.enlist USING btree (uid);
    DROP INDEX public.fki_uid;
       public            postgres    false    240                       1259    16628    fki_uid1    INDEX     :   CREATE INDEX fki_uid1 ON public.match USING btree (uid1);
    DROP INDEX public.fki_uid1;
       public            postgres    false    243                       1259    16629    fki_uid2    INDEX     :   CREATE INDEX fki_uid2 ON public.match USING btree (uid2);
    DROP INDEX public.fki_uid2;
       public            postgres    false    243                       1259    16630    fki_uids    INDEX     :   CREATE INDEX fki_uids ON public.match USING btree (uid1);
    DROP INDEX public.fki_uids;
       public            postgres    false    243            &           2606    16631 
   enlist iid    FK CONSTRAINT     h   ALTER TABLE ONLY public.enlist
    ADD CONSTRAINT iid FOREIGN KEY (iid) REFERENCES public.interest(id);
 4   ALTER TABLE ONLY public.enlist DROP CONSTRAINT iid;
       public          postgres    false    3348    240    241            ,           2606    16689    in_group in_group_gid_fkey    FK CONSTRAINT     w   ALTER TABLE ONLY public.in_group
    ADD CONSTRAINT in_group_gid_fkey FOREIGN KEY (gid) REFERENCES public."group"(id);
 D   ALTER TABLE ONLY public.in_group DROP CONSTRAINT in_group_gid_fkey;
       public          postgres    false    248    249    3363            -           2606    16694    in_group in_group_uid_fkey    FK CONSTRAINT     v   ALTER TABLE ONLY public.in_group
    ADD CONSTRAINT in_group_uid_fkey FOREIGN KEY (uid) REFERENCES public."user"(id);
 D   ALTER TABLE ONLY public.in_group DROP CONSTRAINT in_group_uid_fkey;
       public          postgres    false    249    3361    245            '           2606    16636 
   enlist uid    FK CONSTRAINT     f   ALTER TABLE ONLY public.enlist
    ADD CONSTRAINT uid FOREIGN KEY (uid) REFERENCES public."user"(id);
 4   ALTER TABLE ONLY public.enlist DROP CONSTRAINT uid;
       public          postgres    false    3361    240    245            (           2606    16641 
   match uid1    FK CONSTRAINT     g   ALTER TABLE ONLY public.match
    ADD CONSTRAINT uid1 FOREIGN KEY (uid1) REFERENCES public."user"(id);
 4   ALTER TABLE ONLY public.match DROP CONSTRAINT uid1;
       public          postgres    false    3361    243    245            *           2606    16646    reject uid1    FK CONSTRAINT     h   ALTER TABLE ONLY public.reject
    ADD CONSTRAINT uid1 FOREIGN KEY (uid1) REFERENCES public."user"(id);
 5   ALTER TABLE ONLY public.reject DROP CONSTRAINT uid1;
       public          postgres    false    244    3361    245            )           2606    16651 
   match uid2    FK CONSTRAINT     g   ALTER TABLE ONLY public.match
    ADD CONSTRAINT uid2 FOREIGN KEY (uid2) REFERENCES public."user"(id);
 4   ALTER TABLE ONLY public.match DROP CONSTRAINT uid2;
       public          postgres    false    243    245    3361            +           2606    16656    reject uid2    FK CONSTRAINT     h   ALTER TABLE ONLY public.reject
    ADD CONSTRAINT uid2 FOREIGN KEY (uid2) REFERENCES public."user"(id);
 5   ALTER TABLE ONLY public.reject DROP CONSTRAINT uid2;
       public          postgres    false    245    244    3361            �   @   x�34�02�4202�50�5�P04�2��25�366105�r��{�����:��q��qqq E�S      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x�34�4�2\1z\\\ �+      �      x������ � �      �      x������ � �      �      x������ � �      �   Q   x�3��M,��2�N�L�KN�2�t�K��,��2���,.�/��2�tM�����L.�����,18}2�J2�ҹb���� l�}      �      x������ � �      �      x������ � �      �      x������ � �      �   0  x�e�[o�0 ���W�R��4"�c�4��&�n�ŗ�&����tݯ�Im�dE�9vr�sa��l]�j���Ά�P!�|}�7+}������)3�8�4(�bB�Cq�ZbCnA�@��6hU ��	,Ae�d����Y����lc��Eu�.���!��(2�O�M�P,�������[Z����6�+@�W]��f:K�a�Դ�`�F�E�|��[{VwߪϷe/���YHVX��KO��ܺ�qM�R����1-�s�)KA���*	�&葕NV�=�X�Xթ�f�f��J�+�}h�������mNb�yR�T4l{W�8��ԛ�y�Onv���ò_=鋻�J��^P��E!q�P��+��>5�p4ȔK��J��Ǚ4`�mFؑ�Mn�}�J�m�rL�idi\��Kÿ)&�oO�M� ���0Mz�Oh�0���ē!ힺ5�=��Pg�~������rU��̓��ݻ�ߋ4b�
K��� a����@4^�nP%���R/vVc�9�)W$���앦�5��!���m�|�Ŕ�i��F�5����l6��c�     