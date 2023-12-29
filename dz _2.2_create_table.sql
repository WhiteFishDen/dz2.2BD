create table if not exists Music_Collection
(
	id int generated always as identity primary key,
	performer varchar not null,
	album varchar not null,
	music_style varchar not null
);

create table if not exists Music_Collection_Archive
(
	id int generated always as identity primary key,
	performer varchar not null,
	album varchar not null,
	music_style varchar not null
);

insert into music_collection (performer, album, music_style)
values	('The Beatles', 'Let It Be', 'rock'),
		('The Beatles', 'Yellow Submarine', 'rock'),
		('Linkin Park', 'Hibryd Theory', 'new-metall'),
		('Linkin Park', 'Meteora', 'new-metall'),
		('Muse', 'Drones', 'progress-rock'),
		('Muse', 'Absolution', 'progress-rock'),
		('Metallica', 'Master of Puppets', 'hard-rock');