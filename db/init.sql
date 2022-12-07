CREATE SCHEMA orders;
CREATE SCHEMA products;
CREATE SCHEMA shops;
CREATE SCHEMA storages;
CREATE SCHEMA users;



create table products.product_list
(
    id           serial
        constraint product_list_pk
            primary key,
    name         varchar(50),
    display_name varchar(50),
    is_active    boolean
);

alter table products.product_list
    owner to postgres;

create unique index product_list_id_uindex
    on products.product_list (id);

create unique index product_list_display_name_uindex
    on products.product_list (display_name);

create unique index product_list_name_uindex
    on products.product_list (name);



create table products.category
(
    id           serial
        constraint category_pk
            primary key,
    name         varchar(50),
    display_name varchar(50)
);

alter table products.category
    owner to postgres;

create unique index category_display_name_uindex
    on products.category (display_name);

create unique index category_id_uindex
    on products.category (id);

create unique index category_name_uindex
    on products.category (name);



create table products.product
(
    id          serial
        constraint product_pk
            primary key,
    product_id  integer
        constraint product_product_list_id_fk
            references products.product_list,
    category_id integer
        constraint product_category_id_fk
            references products.category,
    price       double precision,
    amount      integer
);

alter table products.product
    owner to postgres;

create unique index product_id_uindex
    on products.product (id);

create table users.user
(
    id          serial
        constraint user_pk
            primary key,
    username    varchar(30),
    password    varchar(100),
    name        varchar(30),
    second_name varchar(30),
    email       varchar(50),
    phone       varchar(15),
    address     text
);

alter table users.user
    owner to postgres;

create unique index user_id_uindex
    on users.user (id);

create unique index user_username_uindex
    on users.user (username);

create unique index user_email_uindex
    on users.user (email);

create unique index user_phone_uindex
    on users.user (phone);


create table users.sessions
(
    id          serial
        constraint sessions_pk
            primary key,
    user_id     integer
        constraint sessions_user_id_fk
            references users.user,
    session_key varchar(30),
    is_active   boolean,
    expired_at  timestamp
);

alter table users.sessions
    owner to postgres;

create unique index sessions_id_uindex
    on users.sessions (id);

create table users.role_list
(
    id           serial
        constraint role_list_pk
            primary key,
    name         varchar(50),
    display_name varchar(50),
    is_active    boolean
);

alter table users.role_list
    owner to postgres;

create unique index role_list_display_name_uindex
    on users.role_list (display_name);

create unique index role_list_id_uindex
    on users.role_list (id);

create unique index role_list_name_uindex
    on users.role_list (name);


create table users.role
(
    id      serial
        constraint role_pk
            primary key,
    user_id integer
        constraint role_user_id_fk
            references users.user,
    role_id integer
        constraint role_role_list_id_fk
            references users.role_list
);

alter table users.role
    owner to postgres;

create unique index role_id_uindex
    on users.role (id);


create table users.favourites
(
    id         serial
        constraint favourites_pk
            primary key,
    user_id    integer
        constraint favourites_user_id_fk
            references users.user,
    product_id integer
        constraint favourites_product_id_fk
            references products.product
);

alter table users.favourites
    owner to postgres;

create unique index favourites_id_uindex
    on users.favourites (id);


create table users.cart
(
    id         serial
        constraint cart_pk
            primary key,
    user_id    integer
        constraint cart_user_id_fk
            references users.user,
    product_id integer
        constraint cart_product_id_fk
            references products.product,
    amount     integer
);

alter table users.cart
    owner to postgres;

create unique index cart_id_uindex
    on users.cart (id);


create table storages.storage_list
(
    id           serial
        constraint storage_list_pk
            primary key,
    name         varchar(50),
    display_name varchar(50),
    address      varchar(50)
);

alter table storages.storage_list
    owner to postgres;

create unique index storage_list_display_name_uindex
    on storages.storage_list (display_name);

create unique index storage_list_id_uindex
    on storages.storage_list (id);

create unique index storage_list_name_uindex
    on storages.storage_list (name);


create table storages.storage
(
    id         serial
        constraint storage_pk
            primary key,
    storage_id integer
        constraint storage_storage_list_id_fk
            references storages.storage_list,
    product_id integer
        constraint storage_product_id_fk
            references products.product,
    amount     integer,
    is_active  boolean
);

alter table storages.storage
    owner to postgres;

create unique index storage_id_uindex
    on storages.storage (id);

create table shops.shop_list
(
    id           serial
        constraint shop_list_pk
            primary key,
    name         varchar(50),
    display_name varchar(50),
    address      varchar(50)
);

alter table shops.shop_list
    owner to postgres;

create unique index shop_list_display_name_uindex
    on shops.shop_list (display_name);

create unique index shop_list_id_uindex
    on shops.shop_list (id);

create unique index shop_list_name_uindex
    on shops.shop_list (name);


create table shops.shop
(
    id         serial
        constraint shop_pk
            primary key,
    shop_id    integer
        constraint shop_shop_list_id_fk
            references shops.shop_list,
    product_id integer
        constraint shop_product_id_fk
            references products.product,
    amount     integer,
    is_active  boolean
);

alter table shops.shop
    owner to postgres;

create unique index shop_id_uindex
    on shops.shop (id);


create table orders.order
(
    id         serial
        constraint order_pk
            primary key,
    user_id    integer
        constraint order_user_id_fk
            references users.user,
    product_id integer
        constraint order_product_id_fk
            references products.product,
    amount     integer,
    created_at timestamp,
    updated_at timestamp,
    price      integer
);

alter table orders.order
    owner to postgres;

create unique index order_id_uindex
    on orders.order (id);

