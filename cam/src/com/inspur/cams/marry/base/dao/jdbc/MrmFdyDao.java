package com.inspur.cams.marry.base.dao.jdbc;

import java.math.BigDecimal;
import java.sql.Types;
import java.util.List;
import java.util.Map;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.marry.base.dao.IMrmFdyDao;
import com.inspur.cams.marry.base.data.MrmFdy;

/**
 * @title:MrmFdyDao
 * @description:
 * @author:
 * @since:2012-02-02
 * @version:1.0
*/
 public class MrmFdyDao extends EntityDao<MrmFdy> implements IMrmFdyDao{

 	public MrmFdyDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return MrmFdy.class;
	}
 
   
	// 获得辅导员
		public BigDecimal getFdyNum(String deptId) {
			String sql = "select count(*) AS FDY_NUM from mrm_fdy  f where f.organ_id= ? ";
			List list = this.executeQuery(sql, new int[] { Types.VARCHAR },
					new Object[] { deptId });
			BigDecimal fdyNum =new BigDecimal(0);
			if (list.size() > 0) {
				fdyNum = (BigDecimal)((Map) list.get(0)).get("FDY_NUM");
			}
			return fdyNum;
		}
		// 获得政府购买服务、公开招募人数包括其他情况
		public List getFdyRyly (String deptId) { 
			String sql = "select f.ryly,f.qtqk from mrm_fdy f where f.organ_id= ? ";
			List list = this.executeQuery(sql, new int[] {Types.VARCHAR},
					new Object[] {deptId});
			return list;
		}
   
   
}
