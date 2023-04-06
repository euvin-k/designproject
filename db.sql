PGDMP         %                {           unadoctrina    15.2    15.2 ?    U           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            V           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            W           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            X           1262    16398    unadoctrina    DATABASE     �   CREATE DATABASE unadoctrina WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE unadoctrina;
                postgres    false            �            1259    16424    file    TABLE     N   CREATE TABLE public.file (
    file_id integer NOT NULL,
    filename text
);
    DROP TABLE public.file;
       public         heap    postgres    false            �            1259    16469    File_file_id_seq    SEQUENCE     �   ALTER TABLE public.file ALTER COLUMN file_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."File_file_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    217            �            1259    16414    group    TABLE     �   CREATE TABLE public."group" (
    group_id integer NOT NULL,
    group_name text,
    learning_topic text,
    member_count integer
);
    DROP TABLE public."group";
       public         heap    postgres    false            �            1259    16468    Group_group_id_seq    SEQUENCE     �   ALTER TABLE public."group" ALTER COLUMN group_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Group_group_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    215            �            1259    16404    library    TABLE     Z   CREATE TABLE public.library (
    library_id integer NOT NULL,
    chat_box_id integer
);
    DROP TABLE public.library;
       public         heap    postgres    false            �            1259    16467    Library_library_id_seq    SEQUENCE     �   ALTER TABLE public.library ALTER COLUMN library_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Library_library_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    214            �            1259    16459    chatbox    TABLE     [   CREATE TABLE public.chatbox (
    id integer NOT NULL,
    mid integer,
    lid integer
);
    DROP TABLE public.chatbox;
       public         heap    postgres    false            �            1259    16464    chatbox_chat_box_id_seq    SEQUENCE     �   ALTER TABLE public.chatbox ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.chatbox_chat_box_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    218            �            1259    16617    enlist    TABLE     S   CREATE TABLE public.enlist (
    uid integer NOT NULL,
    iid integer NOT NULL
);
    DROP TABLE public.enlist;
       public         heap    postgres    false            �            1259    16534    interest    TABLE     V   CREATE TABLE public.interest (
    id integer NOT NULL,
    name character varying
);
    DROP TABLE public.interest;
       public         heap    postgres    false            �            1259    16537    interest_id_seq    SEQUENCE     �   ALTER TABLE public.interest ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.interest_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
    CYCLE
);
            public          postgres    false    224            �            1259    16551    match    TABLE     f   CREATE TABLE public.match (
    uid1 integer NOT NULL,
    uid2 integer NOT NULL,
    cbid integer
);
    DROP TABLE public.match;
       public         heap    postgres    false            �            1259    16598    no_match    TABLE     W   CREATE TABLE public.no_match (
    uid1 integer NOT NULL,
    uid2 integer NOT NULL
);
    DROP TABLE public.no_match;
       public         heap    postgres    false            �            1259    16583    nomatch    TABLE     V   CREATE TABLE public.nomatch (
    uid1 integer NOT NULL,
    uid2 integer NOT NULL
);
    DROP TABLE public.nomatch;
       public         heap    postgres    false            �            1259    16419    user    TABLE     �   CREATE TABLE public."user" (
    email character varying,
    password character varying,
    id integer NOT NULL,
    phone_number character varying,
    first_name character varying,
    last_name character varying
);
    DROP TABLE public."user";
       public         heap    postgres    false            �            1259    16484    user_user_id_seq    SEQUENCE     �   ALTER TABLE public."user" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.user_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
    CYCLE
);
            public          postgres    false    216            G          0    16459    chatbox 
   TABLE DATA           /   COPY public.chatbox (id, mid, lid) FROM stdin;
    public          postgres    false    218   �A       R          0    16617    enlist 
   TABLE DATA           *   COPY public.enlist (uid, iid) FROM stdin;
    public          postgres    false    229   �A       F          0    16424    file 
   TABLE DATA           1   COPY public.file (file_id, filename) FROM stdin;
    public          postgres    false    217    B       D          0    16414    group 
   TABLE DATA           U   COPY public."group" (group_id, group_name, learning_topic, member_count) FROM stdin;
    public          postgres    false    215   =B       M          0    16534    interest 
   TABLE DATA           ,   COPY public.interest (id, name) FROM stdin;
    public          postgres    false    224   ZB       C          0    16404    library 
   TABLE DATA           :   COPY public.library (library_id, chat_box_id) FROM stdin;
    public          postgres    false    214   �B       O          0    16551    match 
   TABLE DATA           1   COPY public.match (uid1, uid2, cbid) FROM stdin;
    public          postgres    false    226   �B       Q          0    16598    no_match 
   TABLE DATA           .   COPY public.no_match (uid1, uid2) FROM stdin;
    public          postgres    false    228   �B       P          0    16583    nomatch 
   TABLE DATA           -   COPY public.nomatch (uid1, uid2) FROM stdin;
    public          postgres    false    227   �B       E          0    16419    user 
   TABLE DATA           Z   COPY public."user" (email, password, id, phone_number, first_name, last_name) FROM stdin;
    public          postgres    false    216   C       Y           0    0    File_file_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public."File_file_id_seq"', 1, false);
          public          postgres    false    222            Z           0    0    Group_group_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public."Group_group_id_seq"', 1, false);
          public          postgres    false    221            [           0    0    Library_library_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public."Library_library_id_seq"', 1, false);
          public          postgres    false    220            \           0    0    chatbox_chat_box_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.chatbox_chat_box_id_seq', 1, false);
          public          postgres    false    219            ]           0    0    interest_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.interest_id_seq', 4, true);
          public          postgres    false    225            ^           0    0    user_user_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.user_user_id_seq', 9, true);
          public          postgres    false    223            �           2606    16463    chatbox Chatbox_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.chatbox
    ADD CONSTRAINT "Chatbox_pkey" PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.chatbox DROP CONSTRAINT "Chatbox_pkey";
       public            postgres    false    218            �           2606    16430    file File_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.file
    ADD CONSTRAINT "File_pkey" PRIMARY KEY (file_id);
 :   ALTER TABLE ONLY public.file DROP CONSTRAINT "File_pkey";
       public            postgres    false    217            �           2606    16418    group Group_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public."group"
    ADD CONSTRAINT "Group_pkey" PRIMARY KEY (group_id);
 >   ALTER TABLE ONLY public."group" DROP CONSTRAINT "Group_pkey";
       public            postgres    false    215            �           2606    16408    library Library_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.library
    ADD CONSTRAINT "Library_pkey" PRIMARY KEY (library_id);
 @   ALTER TABLE ONLY public.library DROP CONSTRAINT "Library_pkey";
       public            postgres    false    214            �           2606    16621    enlist enlist_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.enlist
    ADD CONSTRAINT enlist_pkey PRIMARY KEY (uid, iid);
 <   ALTER TABLE ONLY public.enlist DROP CONSTRAINT enlist_pkey;
       public            postgres    false    229    229            �           2606    16629    interest id 
   CONSTRAINT     D   ALTER TABLE ONLY public.interest
    ADD CONSTRAINT id UNIQUE (id);
 5   ALTER TABLE ONLY public.interest DROP CONSTRAINT id;
       public            postgres    false    224            �           2606    16639    interest interest_name_key 
   CONSTRAINT     U   ALTER TABLE ONLY public.interest
    ADD CONSTRAINT interest_name_key UNIQUE (name);
 D   ALTER TABLE ONLY public.interest DROP CONSTRAINT interest_name_key;
       public            postgres    false    224            �           2606    16555    match match_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.match
    ADD CONSTRAINT match_pkey PRIMARY KEY (uid1, uid2);
 :   ALTER TABLE ONLY public.match DROP CONSTRAINT match_pkey;
       public            postgres    false    226    226            �           2606    16602    no_match no_match_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.no_match
    ADD CONSTRAINT no_match_pkey PRIMARY KEY (uid1, uid2);
 @   ALTER TABLE ONLY public.no_match DROP CONSTRAINT no_match_pkey;
       public            postgres    false    228    228            �           2606    16587    nomatch nomatch_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.nomatch
    ADD CONSTRAINT nomatch_pkey PRIMARY KEY (uid1, uid2);
 >   ALTER TABLE ONLY public.nomatch DROP CONSTRAINT nomatch_pkey;
       public            postgres    false    227    227            �           2606    16637    user user_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public."user" DROP CONSTRAINT user_email_key;
       public            postgres    false    216            �           2606    16544    user user_id_key 
   CONSTRAINT     K   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_id_key UNIQUE (id);
 <   ALTER TABLE ONLY public."user" DROP CONSTRAINT user_id_key;
       public            postgres    false    216            �           1259    16579    fki_cbid    INDEX     :   CREATE INDEX fki_cbid ON public.match USING btree (cbid);
    DROP INDEX public.fki_cbid;
       public            postgres    false    226            �           1259    16635    fki_iid    INDEX     9   CREATE INDEX fki_iid ON public.enlist USING btree (iid);
    DROP INDEX public.fki_iid;
       public            postgres    false    229            �           1259    16627    fki_uid    INDEX     9   CREATE INDEX fki_uid ON public.enlist USING btree (uid);
    DROP INDEX public.fki_uid;
       public            postgres    false    229            �           1259    16567    fki_uid1    INDEX     :   CREATE INDEX fki_uid1 ON public.match USING btree (uid1);
    DROP INDEX public.fki_uid1;
       public            postgres    false    226            �           1259    16573    fki_uid2    INDEX     :   CREATE INDEX fki_uid2 ON public.match USING btree (uid2);
    DROP INDEX public.fki_uid2;
       public            postgres    false    226            �           1259    16561    fki_uids    INDEX     :   CREATE INDEX fki_uids ON public.match USING btree (uid1);
    DROP INDEX public.fki_uids;
       public            postgres    false    226            �           2606    16574 
   match cbid    FK CONSTRAINT     h   ALTER TABLE ONLY public.match
    ADD CONSTRAINT cbid FOREIGN KEY (cbid) REFERENCES public.chatbox(id);
 4   ALTER TABLE ONLY public.match DROP CONSTRAINT cbid;
       public          postgres    false    218    226    3225            �           2606    16630 
   enlist iid    FK CONSTRAINT     h   ALTER TABLE ONLY public.enlist
    ADD CONSTRAINT iid FOREIGN KEY (iid) REFERENCES public.interest(id);
 4   ALTER TABLE ONLY public.enlist DROP CONSTRAINT iid;
       public          postgres    false    229    3227    224            �           2606    16603    no_match no_match_uid1_fkey    FK CONSTRAINT     x   ALTER TABLE ONLY public.no_match
    ADD CONSTRAINT no_match_uid1_fkey FOREIGN KEY (uid1) REFERENCES public."user"(id);
 E   ALTER TABLE ONLY public.no_match DROP CONSTRAINT no_match_uid1_fkey;
       public          postgres    false    228    3221    216            �           2606    16608    no_match no_match_uid2_fkey    FK CONSTRAINT     x   ALTER TABLE ONLY public.no_match
    ADD CONSTRAINT no_match_uid2_fkey FOREIGN KEY (uid2) REFERENCES public."user"(id);
 E   ALTER TABLE ONLY public.no_match DROP CONSTRAINT no_match_uid2_fkey;
       public          postgres    false    216    3221    228            �           2606    16622 
   enlist uid    FK CONSTRAINT     f   ALTER TABLE ONLY public.enlist
    ADD CONSTRAINT uid FOREIGN KEY (uid) REFERENCES public."user"(id);
 4   ALTER TABLE ONLY public.enlist DROP CONSTRAINT uid;
       public          postgres    false    229    216    3221            �           2606    16562 
   match uid1    FK CONSTRAINT     g   ALTER TABLE ONLY public.match
    ADD CONSTRAINT uid1 FOREIGN KEY (uid1) REFERENCES public."user"(id);
 4   ALTER TABLE ONLY public.match DROP CONSTRAINT uid1;
       public          postgres    false    3221    216    226            �           2606    16588    nomatch uid1    FK CONSTRAINT     i   ALTER TABLE ONLY public.nomatch
    ADD CONSTRAINT uid1 FOREIGN KEY (uid1) REFERENCES public."user"(id);
 6   ALTER TABLE ONLY public.nomatch DROP CONSTRAINT uid1;
       public          postgres    false    216    227    3221            �           2606    16568 
   match uid2    FK CONSTRAINT     g   ALTER TABLE ONLY public.match
    ADD CONSTRAINT uid2 FOREIGN KEY (uid2) REFERENCES public."user"(id);
 4   ALTER TABLE ONLY public.match DROP CONSTRAINT uid2;
       public          postgres    false    3221    226    216            �           2606    16593    nomatch uid2    FK CONSTRAINT     i   ALTER TABLE ONLY public.nomatch
    ADD CONSTRAINT uid2 FOREIGN KEY (uid2) REFERENCES public."user"(id);
 6   ALTER TABLE ONLY public.nomatch DROP CONSTRAINT uid2;
       public          postgres    false    227    3221    216            G      x������ � �      R   #   x�3�4�2�4� ��&@l�e	�[�=... F�      F      x������ � �      D      x������ � �      M   2   x�3��M,��2�N�L�KN�2�t�K��,��2���,.�/������ ��      C      x������ � �      O      x������ � �      Q      x������ � �      P      x������ � �      E     x�e�=k1���;n��!{��B�tH��.�m�B�Hr-����^4�}���g|�.���U���}bq�~����~m>�\SM����ʥ�j��fc((���F�jt�A*� Fbu��$��/	F��^l���0w�{��%l�o�]�/k_GjѦ&��&q�mϬ�,�2L]Ԫx�`�sNU4�hKl���K�Bp�{�?A���	����݇��,���(�55�D6�hD����s��	5g�Y���!�xS&>�ڃ0|��a���r�     