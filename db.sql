PGDMP                         {           unadoctrina    15.2    15.2 #    )           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            *           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            +           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            ,           1262    16398    unadoctrina    DATABASE     �   CREATE DATABASE unadoctrina WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
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
            public          postgres    false    218            �            1259    16414    group    TABLE     �   CREATE TABLE public."group" (
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
            public          postgres    false    216            �            1259    16404    library    TABLE     Z   CREATE TABLE public.library (
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
            public          postgres    false    214            �            1259    16409    match    TABLE     �   CREATE TABLE public.match (
    match_id integer NOT NULL,
    username_1 text,
    username_2 text,
    match_type "char",
    chat_box_id "char"
);
    DROP TABLE public.match;
       public         heap    postgres    false            �            1259    16466    Match_match_id_seq    SEQUENCE     �   ALTER TABLE public.match ALTER COLUMN match_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Match_match_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    215            �            1259    16459    chatbox    TABLE     p   CREATE TABLE public.chatbox (
    chat_box_id integer NOT NULL,
    match_id integer,
    library_id integer
);
    DROP TABLE public.chatbox;
       public         heap    postgres    false            �            1259    16464    chatbox_chat_box_id_seq    SEQUENCE     �   ALTER TABLE public.chatbox ALTER COLUMN chat_box_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.chatbox_chat_box_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    219            �            1259    16534    interest    TABLE     "   CREATE TABLE public.interest (
);
    DROP TABLE public.interest;
       public         heap    postgres    false            �            1259    16419    user    TABLE     �   CREATE TABLE public."user" (
    interest character varying,
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
            public          postgres    false    217                      0    16459    chatbox 
   TABLE DATA           D   COPY public.chatbox (chat_box_id, match_id, library_id) FROM stdin;
    public          postgres    false    219   &$                 0    16424    file 
   TABLE DATA           1   COPY public.file (file_id, filename) FROM stdin;
    public          postgres    false    218   C$                 0    16414    group 
   TABLE DATA           U   COPY public."group" (group_id, group_name, learning_topic, member_count) FROM stdin;
    public          postgres    false    216   `$       &          0    16534    interest 
   TABLE DATA           "   COPY public.interest  FROM stdin;
    public          postgres    false    226   }$                 0    16404    library 
   TABLE DATA           :   COPY public.library (library_id, chat_box_id) FROM stdin;
    public          postgres    false    214   �$                 0    16409    match 
   TABLE DATA           Z   COPY public.match (match_id, username_1, username_2, match_type, chat_box_id) FROM stdin;
    public          postgres    false    215   �$                 0    16419    user 
   TABLE DATA           d   COPY public."user" (interest, email, password, id, phone_number, first_name, last_name) FROM stdin;
    public          postgres    false    217   �$       -           0    0    File_file_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public."File_file_id_seq"', 1, false);
          public          postgres    false    224            .           0    0    Group_group_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public."Group_group_id_seq"', 1, false);
          public          postgres    false    223            /           0    0    Library_library_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public."Library_library_id_seq"', 1, false);
          public          postgres    false    222            0           0    0    Match_match_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public."Match_match_id_seq"', 1, false);
          public          postgres    false    221            1           0    0    chatbox_chat_box_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.chatbox_chat_box_id_seq', 1, false);
          public          postgres    false    220            2           0    0    user_user_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.user_user_id_seq', 9, true);
          public          postgres    false    225            �           2606    16463    chatbox Chatbox_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.chatbox
    ADD CONSTRAINT "Chatbox_pkey" PRIMARY KEY (chat_box_id);
 @   ALTER TABLE ONLY public.chatbox DROP CONSTRAINT "Chatbox_pkey";
       public            postgres    false    219            �           2606    16430    file File_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.file
    ADD CONSTRAINT "File_pkey" PRIMARY KEY (file_id);
 :   ALTER TABLE ONLY public.file DROP CONSTRAINT "File_pkey";
       public            postgres    false    218            �           2606    16418    group Group_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public."group"
    ADD CONSTRAINT "Group_pkey" PRIMARY KEY (group_id);
 >   ALTER TABLE ONLY public."group" DROP CONSTRAINT "Group_pkey";
       public            postgres    false    216            �           2606    16408    library Library_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.library
    ADD CONSTRAINT "Library_pkey" PRIMARY KEY (library_id);
 @   ALTER TABLE ONLY public.library DROP CONSTRAINT "Library_pkey";
       public            postgres    false    214            �           2606    16413    match Match_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.match
    ADD CONSTRAINT "Match_pkey" PRIMARY KEY (match_id);
 <   ALTER TABLE ONLY public.match DROP CONSTRAINT "Match_pkey";
       public            postgres    false    215                  x������ � �            x������ � �            x������ � �      &      x������ � �            x������ � �            x������ � �           x�eлNA�z�;��ƞ�g:*�"EB���3c6�K�.H�=��h@���޽���<|�x\��Ɍc��!?�9����ji�|b.E�����m�(U�yn�0��1��ՐtK���m�̑ǩ�-|.�_E���������y�sM5�J^�쀙%C�>�PP<9O�Z�肃T<A��ꈋIf�_���p��=�_��vqx�>�}��E���|9�� �&��
�b-C��4�Z�lsΩ�Fm�M6s���(�]�ݪ��tj     