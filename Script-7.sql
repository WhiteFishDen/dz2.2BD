

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
	price int,
	amount int,
	_name varchar(20)
);
insert into product (price, amount, _name)
values (121, 2, 'milk'), (59, 15,'tomato');

insert into employees (firstname, secondname, _age)
values ('Mark', 'Hemill', 57), ('Ron', 'Uizli', 25), ('Ron', 'Srtark', 35);

insert into archive (firstname, secondname, _age)
values ('Lui', 'Armstrong', 47);




create or replace function check_exist_product() returns trigger as
$$
begin
	if empty_(new._name)
	then
		update product set amount = amount + new.amount
	 	where _name = new._name;
	 	--return null;
	else 
	if(TG_OP = 'INSERT' AND NOT EXISTS(SELECT 1 FROM pg_trigger WHERE tgrelid = TG_RELID AND tgname = TG_NAME))
	then 
	insert into product (price, amount, _name)
	values (new.price, new.amount, new._name);
	end if;
end if;
	call _info();
	return new;
end;
$$ language plpgsql;

 create or replace function empty_(prod varchar) returns bool as
 $$
 declare result bool;
begin
	if (select _name from product 
	where _name = prod
	limit 1) is null
	then result = false;
	else result = true;
	end if;
	return result;
end;
$$ language plpgsql;



create or replace trigger product_insert_trigger
	before insert 
	on product 	
	for each row 
	execute procedure check_exist_product();

create or replace procedure _info() language plpgsql as 
$$
begin 
	set client_min_messages = 'log';
	raise log 'сообщение';
end;
$$;

insert into product (price, amount, _name)
values (121, 2, 'war');

select empty_('k');

truncate product;









