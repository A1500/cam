package com.inspur.cams.jcm.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.jcm.dao.IComPhotoDao;
import com.inspur.cams.jcm.data.ComPhoto;

/**
 * 人员照片表dao
 * @author 
 * @date 2014-05-16
 */
public class ComPhotoDao extends EntityDao<ComPhoto> implements IComPhotoDao {
	
	@Override
	public Class<ComPhoto> getEntityClass() {
		return ComPhoto.class;
	}

}