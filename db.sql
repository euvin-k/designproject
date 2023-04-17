PGDMP         3                {           unadoctrina    15.2    15.2 D    W           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            X           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            Y           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            Z           1262    16398    unadoctrina    DATABASE     �   CREATE DATABASE unadoctrina WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE unadoctrina;
                postgres    false                        2615    16817    pgagent    SCHEMA        CREATE SCHEMA pgagent;
    DROP SCHEMA pgagent;
                postgres    false            [           0    0    SCHEMA pgagent    COMMENT     6   COMMENT ON SCHEMA pgagent IS 'pgAgent system tables';
                   postgres    false    7                        3079    16818 	   adminpack 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;
    DROP EXTENSION adminpack;
                   false            \           0    0    EXTENSION adminpack    COMMENT     M   COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';
                        false    2            �            1259    16617    enlist    TABLE     S   CREATE TABLE public.enlist (
    uid integer NOT NULL,
    iid integer NOT NULL
);
    DROP TABLE public.enlist;
       public         heap    postgres    false            �            1259    16964    group    TABLE     Z   CREATE TABLE public."group" (
    id integer NOT NULL,
    name character varying(150)
);
    DROP TABLE public."group";
       public         heap    postgres    false            �            1259    16970    group_admin    TABLE     X   CREATE TABLE public.group_admin (
    gid integer NOT NULL,
    uid integer NOT NULL
);
    DROP TABLE public.group_admin;
       public         heap    postgres    false            �            1259    16828    group_id_seq    SEQUENCE     �   CREATE SEQUENCE public.group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.group_id_seq;
       public          postgres    false            �            1259    16963    group_id_seq1    SEQUENCE     �   CREATE SEQUENCE public.group_id_seq1
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.group_id_seq1;
       public          postgres    false    226            ]           0    0    group_id_seq1    SEQUENCE OWNED BY     @   ALTER SEQUENCE public.group_id_seq1 OWNED BY public."group".id;
          public          postgres    false    225            �            1259    16829    in_group    TABLE     U   CREATE TABLE public.in_group (
    gid integer NOT NULL,
    uid integer NOT NULL
);
    DROP TABLE public.in_group;
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
            public          postgres    false    218            �            1259    16985    join_request    TABLE     Y   CREATE TABLE public.join_request (
    gid integer NOT NULL,
    uid integer NOT NULL
);
     DROP TABLE public.join_request;
       public         heap    postgres    false            �            1259    16551    match    TABLE     T   CREATE TABLE public.match (
    uid1 integer NOT NULL,
    uid2 integer NOT NULL
);
    DROP TABLE public.match;
       public         heap    postgres    false            �            1259    16707    reject    TABLE     U   CREATE TABLE public.reject (
    uid1 integer NOT NULL,
    uid2 integer NOT NULL
);
    DROP TABLE public.reject;
       public         heap    postgres    false            �            1259    17000    reject_group    TABLE     Y   CREATE TABLE public.reject_group (
    gid integer NOT NULL,
    uid integer NOT NULL
);
     DROP TABLE public.reject_group;
       public         heap    postgres    false            �            1259    16419    user    TABLE     �   CREATE TABLE public."user" (
    email character varying,
    password character varying,
    id integer NOT NULL,
    phone_number character varying,
    first_name character varying,
    last_name character varying,
    "desc" character varying
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
            public          postgres    false    216            �           2604    16967    group id    DEFAULT     g   ALTER TABLE ONLY public."group" ALTER COLUMN id SET DEFAULT nextval('public.group_id_seq1'::regclass);
 9   ALTER TABLE public."group" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    226    225    226            L          0    16617    enlist 
   TABLE DATA           *   COPY public.enlist (uid, iid) FROM stdin;
    public          postgres    false    221   �G       Q          0    16964    group 
   TABLE DATA           +   COPY public."group" (id, name) FROM stdin;
    public          postgres    false    226   �G       R          0    16970    group_admin 
   TABLE DATA           /   COPY public.group_admin (gid, uid) FROM stdin;
    public          postgres    false    227   �G       O          0    16829    in_group 
   TABLE DATA           ,   COPY public.in_group (gid, uid) FROM stdin;
    public          postgres    false    224   �G       I          0    16534    interest 
   TABLE DATA           ,   COPY public.interest (id, name) FROM stdin;
    public          postgres    false    218   	H       S          0    16985    join_request 
   TABLE DATA           0   COPY public.join_request (gid, uid) FROM stdin;
    public          postgres    false    228   jH       K          0    16551    match 
   TABLE DATA           +   COPY public.match (uid1, uid2) FROM stdin;
    public          postgres    false    220   �H       M          0    16707    reject 
   TABLE DATA           ,   COPY public.reject (uid1, uid2) FROM stdin;
    public          postgres    false    222   �H       T          0    17000    reject_group 
   TABLE DATA           0   COPY public.reject_group (gid, uid) FROM stdin;
    public          postgres    false    229   �H       G          0    16419    user 
   TABLE DATA           b   COPY public."user" (email, password, id, phone_number, first_name, last_name, "desc") FROM stdin;
    public          postgres    false    216   �H       ^           0    0    group_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.group_id_seq', 1, false);
          public          postgres    false    223            _           0    0    group_id_seq1    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.group_id_seq1', 2, true);
          public          postgres    false    225            `           0    0    interest_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.interest_id_seq', 11, true);
          public          postgres    false    219            a           0    0    user_user_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.user_user_id_seq', 14, true);
          public          postgres    false    217            �           2606    16621    enlist enlist_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.enlist
    ADD CONSTRAINT enlist_pkey PRIMARY KEY (uid, iid);
 <   ALTER TABLE ONLY public.enlist DROP CONSTRAINT enlist_pkey;
       public            postgres    false    221    221            �           2606    16974    group_admin group_admin_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.group_admin
    ADD CONSTRAINT group_admin_pkey PRIMARY KEY (gid, uid);
 F   ALTER TABLE ONLY public.group_admin DROP CONSTRAINT group_admin_pkey;
       public            postgres    false    227    227            �           2606    16969    group group_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public."group"
    ADD CONSTRAINT group_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public."group" DROP CONSTRAINT group_pkey;
       public            postgres    false    226            �           2606    16629    interest id 
   CONSTRAINT     D   ALTER TABLE ONLY public.interest
    ADD CONSTRAINT id UNIQUE (id);
 5   ALTER TABLE ONLY public.interest DROP CONSTRAINT id;
       public            postgres    false    218            �           2606    16833    in_group in_group_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.in_group
    ADD CONSTRAINT in_group_pkey PRIMARY KEY (gid, uid);
 @   ALTER TABLE ONLY public.in_group DROP CONSTRAINT in_group_pkey;
       public            postgres    false    224    224            �           2606    16639    interest interest_name_key 
   CONSTRAINT     U   ALTER TABLE ONLY public.interest
    ADD CONSTRAINT interest_name_key UNIQUE (name);
 D   ALTER TABLE ONLY public.interest DROP CONSTRAINT interest_name_key;
       public            postgres    false    218            �           2606    16989    join_request join_request_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.join_request
    ADD CONSTRAINT join_request_pkey PRIMARY KEY (gid, uid);
 H   ALTER TABLE ONLY public.join_request DROP CONSTRAINT join_request_pkey;
       public            postgres    false    228    228            �           2606    16555    match match_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.match
    ADD CONSTRAINT match_pkey PRIMARY KEY (uid1, uid2);
 :   ALTER TABLE ONLY public.match DROP CONSTRAINT match_pkey;
       public            postgres    false    220    220            �           2606    17004    reject_group reject_group_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.reject_group
    ADD CONSTRAINT reject_group_pkey PRIMARY KEY (gid, uid);
 H   ALTER TABLE ONLY public.reject_group DROP CONSTRAINT reject_group_pkey;
       public            postgres    false    229    229            �           2606    16711    reject reject_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.reject
    ADD CONSTRAINT reject_pkey PRIMARY KEY (uid1, uid2);
 <   ALTER TABLE ONLY public.reject DROP CONSTRAINT reject_pkey;
       public            postgres    false    222    222            �           2606    16637    user user_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public."user" DROP CONSTRAINT user_email_key;
       public            postgres    false    216            �           2606    16544    user user_id_key 
   CONSTRAINT     K   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_id_key UNIQUE (id);
 <   ALTER TABLE ONLY public."user" DROP CONSTRAINT user_id_key;
       public            postgres    false    216            �           1259    16635    fki_iid    INDEX     9   CREATE INDEX fki_iid ON public.enlist USING btree (iid);
    DROP INDEX public.fki_iid;
       public            postgres    false    221            �           1259    16627    fki_uid    INDEX     9   CREATE INDEX fki_uid ON public.enlist USING btree (uid);
    DROP INDEX public.fki_uid;
       public            postgres    false    221            �           1259    16567    fki_uid1    INDEX     :   CREATE INDEX fki_uid1 ON public.match USING btree (uid1);
    DROP INDEX public.fki_uid1;
       public            postgres    false    220            �           1259    16573    fki_uid2    INDEX     :   CREATE INDEX fki_uid2 ON public.match USING btree (uid2);
    DROP INDEX public.fki_uid2;
       public            postgres    false    220            �           1259    16561    fki_uids    INDEX     :   CREATE INDEX fki_uids ON public.match USING btree (uid1);
    DROP INDEX public.fki_uids;
       public            postgres    false    220            �           2606    16975     group_admin group_admin_gid_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.group_admin
    ADD CONSTRAINT group_admin_gid_fkey FOREIGN KEY (gid) REFERENCES public."group"(id);
 J   ALTER TABLE ONLY public.group_admin DROP CONSTRAINT group_admin_gid_fkey;
       public          postgres    false    226    3237    227            �           2606    16980     group_admin group_admin_uid_fkey    FK CONSTRAINT     |   ALTER TABLE ONLY public.group_admin
    ADD CONSTRAINT group_admin_uid_fkey FOREIGN KEY (uid) REFERENCES public."user"(id);
 J   ALTER TABLE ONLY public.group_admin DROP CONSTRAINT group_admin_uid_fkey;
       public          postgres    false    216    227    3218            �           2606    16630 
   enlist iid    FK CONSTRAINT     h   ALTER TABLE ONLY public.enlist
    ADD CONSTRAINT iid FOREIGN KEY (iid) REFERENCES public.interest(id);
 4   ALTER TABLE ONLY public.enlist DROP CONSTRAINT iid;
       public          postgres    false    218    3220    221            �           2606    16834    in_group in_group_uid_fkey    FK CONSTRAINT     v   ALTER TABLE ONLY public.in_group
    ADD CONSTRAINT in_group_uid_fkey FOREIGN KEY (uid) REFERENCES public."user"(id);
 D   ALTER TABLE ONLY public.in_group DROP CONSTRAINT in_group_uid_fkey;
       public          postgres    false    3218    224    216            �           2606    16990 "   join_request join_request_gid_fkey    FK CONSTRAINT        ALTER TABLE ONLY public.join_request
    ADD CONSTRAINT join_request_gid_fkey FOREIGN KEY (gid) REFERENCES public."group"(id);
 L   ALTER TABLE ONLY public.join_request DROP CONSTRAINT join_request_gid_fkey;
       public          postgres    false    228    3237    226            �           2606    16995 "   join_request join_request_uid_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY public.join_request
    ADD CONSTRAINT join_request_uid_fkey FOREIGN KEY (uid) REFERENCES public."user"(id);
 L   ALTER TABLE ONLY public.join_request DROP CONSTRAINT join_request_uid_fkey;
       public          postgres    false    216    228    3218            �           2606    17005 "   reject_group reject_group_gid_fkey    FK CONSTRAINT        ALTER TABLE ONLY public.reject_group
    ADD CONSTRAINT reject_group_gid_fkey FOREIGN KEY (gid) REFERENCES public."group"(id);
 L   ALTER TABLE ONLY public.reject_group DROP CONSTRAINT reject_group_gid_fkey;
       public          postgres    false    229    226    3237            �           2606    17010 "   reject_group reject_group_uid_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY public.reject_group
    ADD CONSTRAINT reject_group_uid_fkey FOREIGN KEY (uid) REFERENCES public."user"(id);
 L   ALTER TABLE ONLY public.reject_group DROP CONSTRAINT reject_group_uid_fkey;
       public          postgres    false    216    229    3218            �           2606    16622 
   enlist uid    FK CONSTRAINT     f   ALTER TABLE ONLY public.enlist
    ADD CONSTRAINT uid FOREIGN KEY (uid) REFERENCES public."user"(id);
 4   ALTER TABLE ONLY public.enlist DROP CONSTRAINT uid;
       public          postgres    false    221    3218    216            �           2606    16562 
   match uid1    FK CONSTRAINT     g   ALTER TABLE ONLY public.match
    ADD CONSTRAINT uid1 FOREIGN KEY (uid1) REFERENCES public."user"(id);
 4   ALTER TABLE ONLY public.match DROP CONSTRAINT uid1;
       public          postgres    false    216    3218    220            �           2606    16712    reject uid1    FK CONSTRAINT     h   ALTER TABLE ONLY public.reject
    ADD CONSTRAINT uid1 FOREIGN KEY (uid1) REFERENCES public."user"(id);
 5   ALTER TABLE ONLY public.reject DROP CONSTRAINT uid1;
       public          postgres    false    216    3218    222            �           2606    16568 
   match uid2    FK CONSTRAINT     g   ALTER TABLE ONLY public.match
    ADD CONSTRAINT uid2 FOREIGN KEY (uid2) REFERENCES public."user"(id);
 4   ALTER TABLE ONLY public.match DROP CONSTRAINT uid2;
       public          postgres    false    216    220    3218            �           2606    16717    reject uid2    FK CONSTRAINT     h   ALTER TABLE ONLY public.reject
    ADD CONSTRAINT uid2 FOREIGN KEY (uid2) REFERENCES public."user"(id);
 5   ALTER TABLE ONLY public.reject DROP CONSTRAINT uid2;
       public          postgres    false    216    3218    222            L      x�34�4�24��\1z\\\  \�      Q      x������ � �      R      x������ � �      O      x������ � �      I   Q   x�3��M,��2�N�L�KN�2�t�K��,��2���,.�/��2�tM�����L.�����,19�K�@2�\1z\\\ �2}      S      x������ � �      K      x������ � �      M      x������ � �      T      x������ � �      G   �  x�e��k�0 �g�P ��b,�%[ol��h���ұ}�bm��l����wv6h	c�$�~wN8%�jߙ��n販1B��{���O;��4��6��`wE��6j�
Q�UaDUZ������"t]ai�Ba�q�q�Uf!��ݬ5��&^�w�t�eK���S�����&N�k�e~��=��v8&v�����xHq�C���M�@�=K�׫DVqi�;|���Q꟧�~���X�RyR��UPj��T����p ZY缫��$�PH�+Q+��V�XE�P����Q���L�.����D��1�!�l�ճ��m���n���H�Sc�>Po�>�y�����������on�|{�\�>T�*�"�v������� ʉ�(G�P� ��-E(���7,nȾ�u�HC��g:���u߽4��"a�p�,�:D�ϙi�t�f��=α5��i;��[�Տ|�Z����     