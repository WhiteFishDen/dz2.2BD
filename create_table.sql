create table if not exists employees
(
	employe_id int generated always as identity primary key,
	firstname varchar,
	secondname varchar,
	_age int
);

create table if not exists archive
(
	archive_id int generated always as identity primary key,
	firstname varchar,
	secondname varchar,
	_age int
);

create table if not exists product
(
    product_id int generated always as identity primary key,
	price int not null,
	amount int not null,
	_name varchar(20) not null
);
drop table product;