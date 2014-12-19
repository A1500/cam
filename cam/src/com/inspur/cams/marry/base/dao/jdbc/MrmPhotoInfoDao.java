package com.inspur.cams.marry.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.marry.base.dao.IMrmPhotoInfoDao;
import com.inspur.cams.marry.base.data.MrmPhotoInfo;

/**
 * @title:MrmPhotoInfoDao
 * @description:
 * @author:
 * @since:2012-03-14
 * @version:1.0
*/
 public class MrmPhotoInfoDao extends EntityDao<MrmPhotoInfo> implements IMrmPhotoInfoDao{

 	public MrmPhotoInfoDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return MrmPhotoInfo.class;
	}
  
   public DataSet queryPhotoInfo(ParameterSet pset){
		String organCode = (String) pset.getParameter("organCode");
		String createTime = (String) pset.getParameter("createTime");
		StringBuffer sqlPic = new StringBuffer(
				"select t.id,t.content,t.note,t.organ_code,t.organ_name,t.create_time " +
				"from MRM_PHOTO_INFO t where 1 = 1 "
		);
		List typeList = new ArrayList();
		List<Object> argsList = new ArrayList();
		if (organCode != null && !organCode.equals("")) {
			sqlPic.append(" AND t.organ_code = ?");// 社区
			typeList.add(Types.VARCHAR);
			argsList.add(organCode);
		}
		
		if (createTime != null && !"".equals(createTime)) {
			sqlPic.append(" and t.create_time >= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(createTime);
		}
		
		sqlPic.append(" order by t.create_time desc");
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sqlPic.toString(), types, args, pset
						.getPageStart(), pset.getPageLimit(), true);
		}else {
			ds = this.executeDataset(sqlPic.toString(), pset.getPageStart(), pset.getPageLimit(), true);
		}
		return ds;
	   
   }
}
