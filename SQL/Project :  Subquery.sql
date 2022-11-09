-- count * genres.name jazz
with song as
(SELECT * 
from genres
join tracks on genres.genreid = tracks.genreid
WHERE genres.name = 'Jazz')

SELECT 
name, COUNT(*) from song
GROUP by name;

--filter playlist.name Grunge, TV Shows
with nam as
(SELECT 
			playlists.name,
			sum(unitprice) as total_uniprice
from tracks
join playlist_track on tracks.trackid = playlist_track.trackid
join playlists on playlists.PlaylistId= playlist_track.playlistid
GROUP by playlists.name)

SELECT * from nam 
where name in ('Grunge', 'TV Shows');

## main.sql
.open HW_subquery/chinook.db
.mode table
.read HW_subquery/script.sql
