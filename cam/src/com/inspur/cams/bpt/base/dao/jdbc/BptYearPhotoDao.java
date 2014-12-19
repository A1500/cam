package com.inspur.cams.bpt.base.dao.jdbc;


import java.sql.Types;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.base.dao.IBptYearPhotoDao;
import com.inspur.cams.bpt.base.data.BptYearPhoto;
import com.inspur.cams.bpt.util.FilterLimit;



/**
 * BptYearPhotoDao
 * @description:
 * @author:
 * @since:2011-05-21
 * @version:1.0
*/
 public class BptYearPhotoDao extends EntityDao<BptYearPhoto> implements IBptYearPhotoDao{

	@Override
	protected Class<BptYearPhoto> getEntityClass() {
		return BptYearPhoto.class;
	}
	@Trans
	public void deleteYearPhoto(String photoId){
    	 String photoTable = "COM_PHOTO";
    	 if(photoId!=null && photoId.length()>0){
    	 	photoTable = photoTable+"_"+photoId.substring(0,6);
    	 } 
		String yearsql=" delete from bpt_year_photo t where t.photo_Id='"+photoId+"'";
		String photosql=" delete from "+photoTable+" t where t.photo_Id='"+photoId+"'";
		this.executeUpdate(yearsql);
		this.executeUpdate(photosql);
	}
}
