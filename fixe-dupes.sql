create temp table dups1 as
select i.path_wide_ch pwc,
			i.import_index ii,
            count(i.path_wide_ch) c
from images as i, paths_images as pi
where  i._id_int_64=pi._val_id_int_64
group by i.path_wide_ch,i.import_index
having c>1


create temp table dups2 as
select ROW_NUMBER() over (PARTITION BY  pwc,ii ORDER BY  pwc,ii) AS rn,
i._id_int_64,
pi._key_id_int_64,
pi._val_id_int_64
from images as i, paths_images as pi ,dups1 d  
where
i._id_int_64=pi._val_id_int_64
and i.path_wide_ch=d.pwc and i.import_index=d.ii


create temp table dups3 as
select * from dups2 where rn>1

select * from paths_images as pi ,dups3 d
where  pi._key_id_int_64=d._key_id_int_64 and pi._val_id_int_64=d._val_id_int_64

select * from images as i ,dups3 d
where i._id_int_64=d._id_int_64


delete from paths_images where ROWID in
(select pi.ROWID from paths_images as pi ,dups3 d where  pi._key_id_int_64=d._key_id_int_64 and pi._val_id_int_64=d._val_id_int_64)

delete from image_user_attributes where ROWID in
(select i.ROWID from image_user_attributes as i ,dups3 d where  i._out_id_int_64=d._id_int_64)

delete from image_exiv_attributes where ROWID in
(select i.ROWID from image_exiv_attributes as i ,dups3 d where  i._out_id_int_64=d._id_int_64)

delete from image_history_state_proxy where ROWID in
(select i.ROWID from image_history_state_proxy as i ,dups3 d where  i._image_id_int_64=d._id_int_64)


delete from images where ROWID in
(select i.ROWID from images as i ,dups3 d where  i._id_int_64=d._id_int_64)
