package com.inspur.cams.dis.base.dao.support;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.dis.base.dao.IDisPhotoDao;
import com.inspur.cams.dis.base.data.DisPhoto;

/**
 * @title:DisPhotoDao
 * @description:
 * @author:
 * @since:2012-11-09
 * @version:1.0
*/
 public class DisPhotoDao extends EntityDao<DisPhoto> implements IDisPhotoDao{

 	public DisPhotoDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return DisPhoto.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from DisPhoto");
	}
   
   /**
	 * 根据外键infoId删除所有与之相关的图片记录
	 * @param infoId
	 */
	public void deleteInInfoId(String infoId){
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from dis_photo where INFO_ID = '").append(infoId).append("' ");
		executeUpdate(sql.toString());
	}
   
}
