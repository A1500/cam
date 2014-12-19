package com.inspur.cams.marry.base.dao.jdbc;

import java.sql.Types;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.marry.base.dao.IMrmBuluDao;
import com.inspur.cams.marry.base.data.MrmBulu;

/**
 * @title:MrmBuluDao
 * @description:
 * @author:
 * @since:2012-02-23
 * @version:1.0
*/
 public class MrmBuluDao extends EntityDao<MrmBulu> implements IMrmBuluDao{

 	public MrmBuluDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return MrmBulu.class;
	}
  
   
   public List getBuluInfo(String deptId) {// 婚姻家庭辅导室、间数
		String sql = "select * from mrm_bulu b where b.dept_code= ? ";
		List list = this.executeQuery(sql, new int[] { Types.VARCHAR },
				new Object[] { deptId });
		return list;
	}
   
}
