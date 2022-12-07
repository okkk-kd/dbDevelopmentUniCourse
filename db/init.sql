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


-- insert into users.user
insert into users.user(username, password, name, second_name, email, phone, address)
values ('1admin', 'admin1', 'daniil', 'kritsin', 'daniil1@kritinidzin.ru', '1+79643580711', 'г.Москва');
insert into users.user(username, password, name, second_name, email, phone, address)
values ('2admin', 'admin2', 'daniil', 'kritsin', 'daniil2@kritinidzin.ru', '2+79643580711', 'г.Москва');
insert into users.user(username, password, name, second_name, email, phone, address)
values ('3admin', 'admin3', 'daniil', 'kritsin', 'daniil3@kritinidzin.ru', '3+79643580711', 'г.Москва');
insert into users.user(username, password, name, second_name, email, phone, address)
values ('4admin', 'admin4', 'daniil', 'kritsin', 'daniil4@kritinidzin.ru', '4+79643580711', 'г.Москва');
insert into users.user(username, password, name, second_name, email, phone, address)
values ('5admin', 'admin5', 'daniil', 'kritsin', 'daniil5@kritinidzin.ru', '5+79643580711', 'г.Москва');

-- insert into users.session
insert into users.sessions(user_id, session_key, is_active, expired_at)
values (1,'session_key',true, now());
insert into users.sessions(user_id, session_key, is_active, expired_at)
values (2,'session_key',true, now());
insert into users.sessions(user_id, session_key, is_active, expired_at)
values (3,'session_key',true, now());
insert into users.sessions(user_id, session_key, is_active, expired_at)
values (4,'session_key',true, now());
insert into users.sessions(user_id, session_key, is_active, expired_at)
values (5,'session_key',true, now());

-- insert into users.role_list
insert into users.role_list(name, display_name, is_active) values('1admin', '1admin', true);
insert into users.role_list(name, display_name, is_active) values('2admin', '2admin', true);
insert into users.role_list(name, display_name, is_active) values('3admin', '3admin', true);
insert into users.role_list(name, display_name, is_active) values('4admin', '4admin', true);
insert into users.role_list(name, display_name, is_active) values('5admin', '5admin', true);

-- insert into users.role
insert into users.role(user_id, role_id) values(1, 1);
insert into users.role(user_id, role_id) values(2, 2);
insert into users.role(user_id, role_id) values(3, 3);
insert into users.role(user_id, role_id) values(4, 4);
insert into users.role(user_id, role_id) values(5, 5);

-- insert into products.product_list
insert into products.product_list(name, display_name, is_active) values('1orange', '1orange', true);
insert into products.product_list(name, display_name, is_active) values('2orange', '2orange', true);
insert into products.product_list(name, display_name, is_active) values('3orange', '3orange', true);
insert into products.product_list(name, display_name, is_active) values('4orange', '4orange', true);
insert into products.product_list(name, display_name, is_active) values('5orange', '5orange', true);

-- insert into products.category
insert into products.category(name, display_name) values('1category', '1category');
insert into products.category(name, display_name) values('2category', '2category');
insert into products.category(name, display_name) values('3category', '3category');
insert into products.category(name, display_name) values('4category', '4category');
insert into products.category(name, display_name) values('5category', '5category');

-- insert into products.product
insert into products.product(product_id, category_id, price, amount) values(1,1,1,10);
insert into products.product(product_id, category_id, price, amount) values(2,2,2,10);
insert into products.product(product_id, category_id, price, amount) values(3,3,3,10);
insert into products.product(product_id, category_id, price, amount) values(4,4,4,10);
insert into products.product(product_id, category_id, price, amount) values(5,5,5,10);

--insert into users.favourites
insert into users.favourites(user_id, product_id) values(1, 1);
insert into users.favourites(user_id, product_id) values(2, 2);
insert into users.favourites(user_id, product_id) values(3, 3);
insert into users.favourites(user_id, product_id) values(4, 4);
insert into users.favourites(user_id, product_id) values(5, 5);

--insert into users.cart
insert into users.cart(user_id, product_id, amount) values(1,1,1);
insert into users.cart(user_id, product_id, amount) values(2,2,2);
insert into users.cart(user_id, product_id, amount) values(3,3,3);
insert into users.cart(user_id, product_id, amount) values(4,4,4);
insert into users.cart(user_id, product_id, amount) values(5,5,5);

-- insert into storages.storage_list
insert into storages.storage_list(name, display_name, address) values('1storage', '1storage', '1address');
insert into storages.storage_list(name, display_name, address) values('2storage', '2storage', '2address');
insert into storages.storage_list(name, display_name, address) values('3storage', '3storage', '3address');
insert into storages.storage_list(name, display_name, address) values('4storage', '4storage', '4address');
insert into storages.storage_list(name, display_name, address) values('5storage', '5storage', '5address');

-- insert into storages.store
insert into storages.storage(storage_id, product_id, amount, is_active) values(1,1,1,true);
insert into storages.storage(storage_id, product_id, amount, is_active) values(2,2,2,true);
insert into storages.storage(storage_id, product_id, amount, is_active) values(3,3,3,true);
insert into storages.storage(storage_id, product_id, amount, is_active) values(4,4,4,true);
insert into storages.storage(storage_id, product_id, amount, is_active) values(5,5,5,true);

-- insert into shops.shop_list
insert into shops.shop_list(name, display_name, address) values('1storage', '1storage', '1address');
insert into shops.shop_list(name, display_name, address) values('2storage', '2storage', '2address');
insert into shops.shop_list(name, display_name, address) values('3storage', '3storage', '3address');
insert into shops.shop_list(name, display_name, address) values('4storage', '4storage', '4address');
insert into shops.shop_list(name, display_name, address) values('5storage', '5storage', '5address');

-- insert into shops.shop
insert into shops.shop(shop_id, product_id, amount, is_active) values(1,1,1,true);
insert into shops.shop(shop_id, product_id, amount, is_active) values(2,2,2,true);
insert into shops.shop(shop_id, product_id, amount, is_active) values(3,3,3,true);
insert into shops.shop(shop_id, product_id, amount, is_active) values(4,4,4,true);
insert into shops.shop(shop_id, product_id, amount, is_active) values(5,5,5,true);

-- insert into orders.order
insert into orders.order(user_id, product_id, amount, created_at, updated_at, price) values(1,1,1,now(),now(),10);
insert into orders.order(user_id, product_id, amount, created_at, updated_at, price) values(2,2,2,now(),now(),10);
insert into orders.order(user_id, product_id, amount, created_at, updated_at, price) values(3,3,3,now(),now(),10);
insert into orders.order(user_id, product_id, amount, created_at, updated_at, price) values(4,4,4,now(),now(),10);
insert into orders.order(user_id, product_id, amount, created_at, updated_at, price) values(5,5,5,now(),now(),10);

-- select orders
select 'orders';
select 'select * from orders.order;';
select * from orders.order;
select 'select * from orders.order where id > 2;';
select * from orders.order where id > 2;
select 'select * from orders.order where id = 2;';
select * from orders.order where id = 2;
select 'select * from orders.order where id < 2;';
select * from orders.order where id < 2;
select 'select * from orders.order where id != 2;';
select * from orders.order where id != 2;
select 'select * from orders.order where id between 2 and 10;';
select * from orders.order where id between 2 and 10;


-- select products
select 'products';
select 'select * from products.category;';
select * from products.category;
select 'select * from products.product;';
select * from products.product;
select 'select * from products.product_list;';
select * from products.product_list;
select 'inner join';
select c.display_name as "category_name",
       l.display_name as "product name",
       l.is_active    as "status",
       p.amount,
       p.price
from products.product p
         inner join products.category c on c.id = p.category_id
         inner join products.product_list l on l.id = p.product_id
where p.id between 2 and 6;



-- select shops
select 'shops';
select 'select * from shops.shop;';
select * from shops.shop;
select 'select * from shops.shop_list;';
select * from shops.shop_list;

select 'with included condition';
select *
from shops.shop s
where s.product_id = (select id from shops.shop_list sl where sl.name = '1storage');

select 'update with included condition';
update shops.shop
set amount = 99
where product_id = (select id from shops.shop_list sl where sl.name = '1storage');

select 'with included condition';
select *
from shops.shop s
where s.product_id = (select id from shops.shop_list sl where sl.name = '1storage');



-- select storages
select 'storage';
select 'select * from storages.storage;';
select * from storages.storage;
select 'select * from storages.storage_list;';
select * from storages.storage_list;
insert into storages.storage(storage_id, product_id, amount, is_active) values(4,1,11,true);
insert into storages.storage(storage_id, product_id, amount, is_active) values(4,2,12,true);
insert into storages.storage(storage_id, product_id, amount, is_active) values(4,3,13,true);
insert into storages.storage(storage_id, product_id, amount, is_active) values(4,4,14,true);
insert into storages.storage(storage_id, product_id, amount, is_active) values(4,5,15,true);
select 'right join';
select
    sl.display_name
from storages.storage s
         right join storages.storage_list sl on sl.id = s.storage_id
where s.id > 2;

-- select users
select 'users';
select * from users.favourites;
select * from users.role;
select * from users.role_list;
select * from users.sessions;
select * from users.cart;
select * from users.user;
