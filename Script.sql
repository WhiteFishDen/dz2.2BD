create or replace function check_exist_product() returns trigger as
$$
begin
	if empty_(new._name) 
	then old.amount := old.amount + new.amount;
	else 
	insert into product (price, amount, _name)
	values (new.price, new.amount, new._name);
	end if;
	return new;
end;
$$ language plpgsql;

 create or replace function empty_(prod varchar) returns bool as $$
 declare result bool;
begin
	if (select _name from product 
	where _name = prod) is null
	then result = false;
	else result = true;
	end if;
	return result;
end;
$$ language plpgsql;



create or replace trigger product_insert_trigger
	after insert 
	on product
	for each row 
	execute procedure check_exist_product();
	
insert into product (price, amount, _name)
values (121, 2, 'milk');

select empty_('milk');