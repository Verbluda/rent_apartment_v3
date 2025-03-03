PGDMP                      |            apartment_db    16.4 (Debian 16.4-1.pgdg120+1)    16.6 4    e           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            f           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            g           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            h           1262    16384    apartment_db    DATABASE     w   CREATE DATABASE apartment_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';
    DROP DATABASE apartment_db;
                lucy    false            �            1255    16425 $   log_apartment_registration_process()    FUNCTION     i  CREATE FUNCTION public.log_apartment_registration_process() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
    INSERT INTO logs_apartment_registration_info (operation_type, logs_message)
    VALUES ('INSERT', 'зарегистрированы новые апартаменты по адресу: ' || NEW.city);
    RETURN NEW;
    END;
    $$;
 ;   DROP FUNCTION public.log_apartment_registration_process();
       public          lucy    false            �            1259    16412    address    TABLE     �   CREATE TABLE public.address (
    id bigint NOT NULL,
    city character varying,
    street character varying,
    number_of_house character varying,
    number_of_apartment character varying,
    apartment_id bigint
);
    DROP TABLE public.address;
       public         heap    lucy    false            �            1259    16424    address_sequence    SEQUENCE     y   CREATE SEQUENCE public.address_sequence
    START WITH 2
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.address_sequence;
       public          lucy    false            �            1259    16406 	   apartment    TABLE     �   CREATE TABLE public.apartment (
    id bigint NOT NULL,
    is_available boolean,
    number_of_room integer,
    price_per_day double precision,
    photo_id bigint
);
    DROP TABLE public.apartment;
       public         heap    lucy    false            �            1259    16411    apartment_sequence    SEQUENCE     {   CREATE SEQUENCE public.apartment_sequence
    START WITH 3
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.apartment_sequence;
       public          lucy    false            �            1259    16454    booking_info    TABLE     �   CREATE TABLE public.booking_info (
    id bigint NOT NULL,
    start_date timestamp without time zone,
    end_date timestamp without time zone,
    amount character varying,
    discount character varying,
    apartment_id bigint,
    user_id bigint
);
     DROP TABLE public.booking_info;
       public         heap    lucy    false            �            1259    16471    booking_info_sequence    SEQUENCE     ~   CREATE SEQUENCE public.booking_info_sequence
    START WITH 3
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.booking_info_sequence;
       public          lucy    false            �            1259    16389    flyway_schema_history    TABLE     �  CREATE TABLE public.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);
 )   DROP TABLE public.flyway_schema_history;
       public         heap    lucy    false            �            1259    16440    integration_info    TABLE     �   CREATE TABLE public.integration_info (
    service_name_id character varying NOT NULL,
    path_value character varying,
    token_value character varying
);
 $   DROP TABLE public.integration_info;
       public         heap    lucy    false            �            1259    16473     logs_apartment_registration_info    TABLE     �   CREATE TABLE public.logs_apartment_registration_info (
    id bigint NOT NULL,
    operation_type character varying,
    date_operation timestamp without time zone DEFAULT now(),
    logs_message character varying
);
 4   DROP TABLE public.logs_apartment_registration_info;
       public         heap    lucy    false            �            1259    16472 '   logs_apartment_registration_info_id_seq    SEQUENCE     �   ALTER TABLE public.logs_apartment_registration_info ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.logs_apartment_registration_info_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          lucy    false    229            �            1259    16481 )   logs_apartment_registration_info_sequence    SEQUENCE     �   CREATE SEQUENCE public.logs_apartment_registration_info_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 @   DROP SEQUENCE public.logs_apartment_registration_info_sequence;
       public          lucy    false            �            1259    16427    photo    TABLE     T   CREATE TABLE public.photo (
    id bigint NOT NULL,
    photo_of_apartment bytea
);
    DROP TABLE public.photo;
       public         heap    lucy    false            �            1259    16434    photo_sequence    SEQUENCE     w   CREATE SEQUENCE public.photo_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.photo_sequence;
       public          lucy    false            �            1259    16447    product_info    TABLE     �   CREATE TABLE public.product_info (
    id character varying NOT NULL,
    description character varying,
    amount_of_discount integer
);
     DROP TABLE public.product_info;
       public         heap    lucy    false            �            1259    16398 	   user_info    TABLE     �   CREATE TABLE public.user_info (
    id bigint NOT NULL,
    user_name character varying,
    email character varying,
    password character varying,
    token character varying,
    date_registration timestamp without time zone
);
    DROP TABLE public.user_info;
       public         heap    lucy    false            �            1259    16405    user_info_sequence    SEQUENCE     {   CREATE SEQUENCE public.user_info_sequence
    START WITH 4
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.user_info_sequence;
       public          lucy    false            X          0    16412    address 
   TABLE DATA           g   COPY public.address (id, city, street, number_of_house, number_of_apartment, apartment_id) FROM stdin;
    public          lucy    false    220   C?       V          0    16406 	   apartment 
   TABLE DATA           ^   COPY public.apartment (id, is_available, number_of_room, price_per_day, photo_id) FROM stdin;
    public          lucy    false    218   �?       ^          0    16454    booking_info 
   TABLE DATA           i   COPY public.booking_info (id, start_date, end_date, amount, discount, apartment_id, user_id) FROM stdin;
    public          lucy    false    226   �?       S          0    16389    flyway_schema_history 
   TABLE DATA           �   COPY public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
    public          lucy    false    215   @       \          0    16440    integration_info 
   TABLE DATA           T   COPY public.integration_info (service_name_id, path_value, token_value) FROM stdin;
    public          lucy    false    224   �A       a          0    16473     logs_apartment_registration_info 
   TABLE DATA           l   COPY public.logs_apartment_registration_info (id, operation_type, date_operation, logs_message) FROM stdin;
    public          lucy    false    229   �B       Z          0    16427    photo 
   TABLE DATA           7   COPY public.photo (id, photo_of_apartment) FROM stdin;
    public          lucy    false    222   �B       ]          0    16447    product_info 
   TABLE DATA           K   COPY public.product_info (id, description, amount_of_discount) FROM stdin;
    public          lucy    false    225   �B       T          0    16398 	   user_info 
   TABLE DATA           ]   COPY public.user_info (id, user_name, email, password, token, date_registration) FROM stdin;
    public          lucy    false    216   G       i           0    0    address_sequence    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.address_sequence', 2, false);
          public          lucy    false    221            j           0    0    apartment_sequence    SEQUENCE SET     A   SELECT pg_catalog.setval('public.apartment_sequence', 3, false);
          public          lucy    false    219            k           0    0    booking_info_sequence    SEQUENCE SET     D   SELECT pg_catalog.setval('public.booking_info_sequence', 3, false);
          public          lucy    false    227            l           0    0 '   logs_apartment_registration_info_id_seq    SEQUENCE SET     V   SELECT pg_catalog.setval('public.logs_apartment_registration_info_id_seq', 1, false);
          public          lucy    false    228            m           0    0 )   logs_apartment_registration_info_sequence    SEQUENCE SET     X   SELECT pg_catalog.setval('public.logs_apartment_registration_info_sequence', 1, false);
          public          lucy    false    230            n           0    0    photo_sequence    SEQUENCE SET     =   SELECT pg_catalog.setval('public.photo_sequence', 1, false);
          public          lucy    false    223            o           0    0    user_info_sequence    SEQUENCE SET     A   SELECT pg_catalog.setval('public.user_info_sequence', 4, false);
          public          lucy    false    217            �           2606    16418    address address_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.address DROP CONSTRAINT address_pkey;
       public            lucy    false    220            �           2606    16410    apartment apartment_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.apartment
    ADD CONSTRAINT apartment_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.apartment DROP CONSTRAINT apartment_pkey;
       public            lucy    false    218            �           2606    16460    booking_info booking_info_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.booking_info
    ADD CONSTRAINT booking_info_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.booking_info DROP CONSTRAINT booking_info_pkey;
       public            lucy    false    226            �           2606    16396 .   flyway_schema_history flyway_schema_history_pk 
   CONSTRAINT     x   ALTER TABLE ONLY public.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);
 X   ALTER TABLE ONLY public.flyway_schema_history DROP CONSTRAINT flyway_schema_history_pk;
       public            lucy    false    215            �           2606    16446 &   integration_info integration_info_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY public.integration_info
    ADD CONSTRAINT integration_info_pkey PRIMARY KEY (service_name_id);
 P   ALTER TABLE ONLY public.integration_info DROP CONSTRAINT integration_info_pkey;
       public            lucy    false    224            �           2606    16480 F   logs_apartment_registration_info logs_apartment_registration_info_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.logs_apartment_registration_info
    ADD CONSTRAINT logs_apartment_registration_info_pkey PRIMARY KEY (id);
 p   ALTER TABLE ONLY public.logs_apartment_registration_info DROP CONSTRAINT logs_apartment_registration_info_pkey;
       public            lucy    false    229            �           2606    16433    photo photo_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.photo
    ADD CONSTRAINT photo_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.photo DROP CONSTRAINT photo_pkey;
       public            lucy    false    222            �           2606    16453    product_info product_info_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.product_info
    ADD CONSTRAINT product_info_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.product_info DROP CONSTRAINT product_info_pkey;
       public            lucy    false    225            �           2606    16404    user_info user_info_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.user_info
    ADD CONSTRAINT user_info_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.user_info DROP CONSTRAINT user_info_pkey;
       public            lucy    false    216            �           1259    16397    flyway_schema_history_s_idx    INDEX     `   CREATE INDEX flyway_schema_history_s_idx ON public.flyway_schema_history USING btree (success);
 /   DROP INDEX public.flyway_schema_history_s_idx;
       public            lucy    false    215            �           2620    16426    address log_address_trigger    TRIGGER     �   CREATE TRIGGER log_address_trigger AFTER INSERT ON public.address FOR EACH ROW EXECUTE FUNCTION public.log_apartment_registration_process();
 4   DROP TRIGGER log_address_trigger ON public.address;
       public          lucy    false    231    220            �           2606    16419 !   address address_apartment_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_apartment_id_fkey FOREIGN KEY (apartment_id) REFERENCES public.apartment(id);
 K   ALTER TABLE ONLY public.address DROP CONSTRAINT address_apartment_id_fkey;
       public          lucy    false    218    220    3250            �           2606    16435 !   apartment apartment_photo_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.apartment
    ADD CONSTRAINT apartment_photo_id_fkey FOREIGN KEY (photo_id) REFERENCES public.photo(id);
 K   ALTER TABLE ONLY public.apartment DROP CONSTRAINT apartment_photo_id_fkey;
       public          lucy    false    218    222    3254            �           2606    16461 +   booking_info booking_info_apartment_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.booking_info
    ADD CONSTRAINT booking_info_apartment_id_fkey FOREIGN KEY (apartment_id) REFERENCES public.apartment(id);
 U   ALTER TABLE ONLY public.booking_info DROP CONSTRAINT booking_info_apartment_id_fkey;
       public          lucy    false    226    218    3250            �           2606    16466 &   booking_info booking_info_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.booking_info
    ADD CONSTRAINT booking_info_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.user_info(id);
 P   ALTER TABLE ONLY public.booking_info DROP CONSTRAINT booking_info_user_id_fkey;
       public          lucy    false    216    226    3248            X   2   x�3�0�¾��v]�ta煅6\�ra�s��ӌ�Ԍӈ+F��� �!      V   #   x�3�,�4�4700����2��8M��=... h��      ^   R   x�m��� ��,��6��Y���
���"?ξ�� LDǼ͈D-F�a4��B��X�Jgތ��:����W�:j�}��B�      S   o  x�}�K��0D��S�6�?�9g�f � �c+�0���EnjhK���p�j�#�H�c_R��u�m��|~�_���P�B5
���;��GBA�܎���i��E~Q}q�'��D!m�A8\}�Y��h"L����c����1�L`��p:��0���v9?
+����kPo@����~�ѥ{:2ylg�ࢢ؊s�H�����z�O2ZUE�+���s�H0�0���z?yӦ��Rӵ���t���h��F	�V��f^�0%�w��1-Xa�h3��,D2z�Q��0f��=0ߺ�i��M���|���#�=+��V0�s���\Ѷ��͐�I3N�q~n�Z����Ƶt5Ɛˤ�ͯ��f�<��      \   �   x�U�]O�0�k�?����,!f�gl���t1Y�� �Q��9~�eٍ��'�yS��*k{������{�	^ʂ[�}���B��P�=~'s�0�F^\Z��+Gw��G#ҏ�MML)�$�1Q���ۀL8 詡j��O��_p�?Kn+9�q�)�a��������= v!�ƽmbvz�)�j�7g���D'G�򗬓�g;�Ώĭ7|��j��J�zp3w����QX(*��<�z��| ���f�      a      x������ � �      Z      x������ � �      ]   &  x��V[n�F��N1��*�w�_.b��چ� 9M����
37JU�P�R����<�����'�a�.�Cgq����Y��m�C���v�U��������6�Є:��;l�](.X��<�������UX�,oU�d<���+��:V���>4�7r����C]�VC��6q�q�p�t���������x���aj��sX�U��wb�B��p&�1:�����O��̟�0;�|�e���N�(|��'�ߜ��#��q��"O����D����r�R�s��qj
��y
~:�5�����ߍ`�e���9�z��Za��Љ�K��]�:���A$��,�hjF���>ă"M�s�Gj��l��H23lu�IT��e�g�"������(�%�Q�1ߣa|
o��`�vsE
�h�l;��|z���Y�%�获㽶넷۶j�鶭��6�\mp�\�%�P�5@-���&�����%J�`��S]���$�Ҳawج��m�wR�N��Ir��A�C�jg��̝�:ޟ'����~IG�o���q
[|�V��U�~H��	������0aK�3��YнnD,̃�H��I%����VqU�`�o��mV�F��x�����}�H̿�`��Oj����8˥�tV2��^p�Kv�R���U���k��B�1���w�����T<��G����8l۱1�yU���j�ӱK�<��6tB�X�4GJγЫ~�o��-��|)�V�ݡ
�h���I!&Ex�zjJ�"��Z��3�N��8������5��Y­�H��g�G�ֹ���������l)��~�׍L�Sl�&���"���g��� �@��	���d��Ӝ�N=`:�Hs�UW[�[�����/�n���bk�FxS��}u:�Qk;^h'~7k�)!���W��k���n�Y>�1o���H�ܬ%X�p~|��'��U��VÛ|���8��Pq')�|��k�w��-4 ��g�PѲX�H#��,4��0��Oؾ J��Ǧ��ǯ���?�:_�      T   �   x���M�0����]6�{s� إn�"*�P7A�tVJ>�B]���c(�)<�������ö��Ւ.E����3r����u�f��v���UFMJ'��E����v4�5�p��%��,�9��P��� (�0G��ǽiW4-��ج�s�1���c�     