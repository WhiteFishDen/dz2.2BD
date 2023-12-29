
--TASK 2.1
create or replace function check_exists_album() returns trigger as 
$$
begin 
	if empty_(new.album)
   then  return null;
	elsif(TG_OP = 'INSERT' AND NOT EXISTS(SELECT 1 FROM pg_trigger WHERE tgrelid = TG_RELID AND tgname = TG_NAME))
	then 
	insert into music_collection (performer, album, music_style)
	values	(new.performer, new.album, new.music_style);
    end if;
	return new;
end;
$$ language plpgsql;

create or replace function empty_(item varchar) returns bool as
 $$
 declare result bool;
begin
	if (select album from music_collection 
	where album = item
	limit 1) is null
	then result = false;
	else result = true;
	end if;
	return result;
end;
$$ language plpgsql;

create or replace trigger insert_item_collection_album_check
	before insert 
	on music_collection
	for each row 
	execute procedure check_exists_album();

insert into music_collection (performer, album, music_style)
values	('The Beatles', 'Revolver', 'rock');
--TASK 2.2

create or replace function dont_delete_beatles() return trigger as 
$$
begin
	if old.performer = 'The Beatles'
	then return null;
	elseif (TG_OP = 'DELETE' AND NOT EXISTS(SELECT 1 FROM pg_trigger WHERE tgrelid = TG_RELID AND tgname = TG_NAME))
	then
	delete from music_collection
	where 
end
$$ language plpgsql;









