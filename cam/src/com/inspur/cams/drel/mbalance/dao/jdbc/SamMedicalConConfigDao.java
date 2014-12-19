package com.inspur.cams.drel.mbalance.dao.jdbc;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.mbalance.dao.ISamMedicalConConfigDao;
import com.inspur.cams.drel.mbalance.data.SamMedicalConConfig;

/**
 * @title:SamMedicalConConfigDao
 * @description:一站结算_医保系统连接配置dao
 * @author:路国隋
 * @since:2011-09-27
 * @version:1.0
*/
 public class SamMedicalConConfigDao extends EntityDao<SamMedicalConConfig> implements ISamMedicalConConfigDao{

 	public SamMedicalConConfigDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamMedicalConConfig.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SamMedicalConConfig");
	}

	/**
	 * 查询接口URL
	 * 
	 * @param organId
	 */
	public Map queryConConfig(String organArea,String insuranceType){
		StringBuffer sql=new StringBuffer();
		sql.append("select * from SAM_MEDICAL_CON_CONFIG \n");
		sql.append(" where CON_AREA='"+organArea+"' \n");
		if(StringUtils.isNotEmpty(insuranceType)){
			if("4".equals(insuranceType)){
				sql.append(" and CON_TYPE ='1' ");
			}else{
				sql.append(" and CON_TYPE ='2' ");
			}
		}
		
		List<Map> list=executeQuery(sql.toString());
		Map map=new HashMap<Integer, String>();
		if(list.size()>0){
			return list.get(0);
		}
		return null;
		
	}
}
