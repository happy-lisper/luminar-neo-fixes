# integrity tests

## 1
select
			ihs._id_int_64,
			ihsp._state_id_int_64
from image_history_state_proxy as ihsp
full outer  join img_history_states as ihs on ihsp._state_id_int_64=ihs._id_int_64
where ihs._id_int_64 is null or ihsp._state_id_int_64 is null


##2
select
			ihs._id_int_64 ihs_i,
			ihsp._image_id_int_64 ihsp_i,
			count(ihs._id_int_64) c,
			ihs.*
from image_history_state_proxy as ihsp,images as i
left   join img_history_states as ihs on ihsp._state_id_int_64=ihs._id_int_64
where i._id_int_64=ihsp._image_id_int_64
group by ihs_i
having c>1


select
			ihs._id_int_64,
			ihsp._id_int_64,
			ihsp._image_id_int_64,
			"images",
			i.*,
			"image_history_state_proxy",
			ihsp.*,
			"img_history_states",
			ihs.*
from image_history_state_proxy as ihsp,images as i, paths_images as pi
left   join img_history_states as ihs on ihsp._state_id_int_64=ihs._id_int_64
where  i._id_int_64=pi._val_id_int_64 and i._id_int_64=ihsp._image_id_int_64 and  ihs._id_int_64=545

##3
select *
from images as i
left  join image_history_state_proxy as ihsp on i._id_int_64=ihsp._image_id_int_64
left  join img_history_states as ihs on ihsp._state_id_int_64=ihs._id_int_64

 ##4
select i.path_wide_ch pwc,
			i.import_index ii,
            count(i.path_wide_ch) c
 from images as i, paths_images as pi
where  i._id_int_64=pi._val_id_int_64
group by i.path_wide_ch,i.import_index
having c>1


select i.path_wide_ch pwc,
			i.import_index ii,
            count(i.path_wide_ch) c,
			ihsp._image_id_int_64,
			ihs._id_int_64,
			ihs.crop_info_wide_ch
 from images as i, paths_images as pi
left join image_history_state_proxy as ihsp on i._id_int_64=ihsp._image_id_int_64
left  join img_history_states as ihs on ihsp._state_id_int_64=ihs._id_int_64
where  i._id_int_64=pi._val_id_int_64
group by i.path_wide_ch,i.import_index
having c>1

##5
select i.path_wide_ch pwc,
			i.import_index ii,
            count(i.path_wide_ch) c,
			iua._out_id_int_64,
			iea._out_id_int_64,
			ihsp._image_id_int_64,
			ihs._id_int_64,
			*
 from images as i, paths_images as pi
 left join image_user_attributes as iua on i._id_int_64=iua._out_id_int_64
 left join image_exiv_attributes as iea on i._id_int_64=iea._out_id_int_64
 left join image_history_state_proxy as ihsp on i._id_int_64=ihsp._image_id_int_64
 left  join img_history_states as ihs on ihsp._state_id_int_64=ihs._id_int_64
where  i._id_int_64=pi._val_id_int_64
group by pwc,ii
having c>1
order by pwc,ii
