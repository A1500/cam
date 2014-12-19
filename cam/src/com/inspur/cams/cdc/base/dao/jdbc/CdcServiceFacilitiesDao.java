package com.inspur.cams.cdc.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.cdc.base.dao.ICdcServiceFacilitiesDao;
import com.inspur.cams.cdc.base.data.CdcServiceFacilities;

/**
 * @title:CdcServiceFacilitiesDao
 * @description:
 * @author:
 * @since:2012-02-29
 * @version:1.0
*/
 public class CdcServiceFacilitiesDao extends EntityDao<CdcServiceFacilities> implements ICdcServiceFacilitiesDao{

 	public CdcServiceFacilitiesDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class<CdcServiceFacilities> getEntityClass() {
		return CdcServiceFacilities.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from CdcServiceFacilities");
	}
   public DataSet queryList(ParameterSet pset){
	   StringBuffer sql = new StringBuffer("SELECT T.CONSTRUCTION_ID,T.OFF_CON_STATUS,T.OFF_CON_KIND,T.OFF_YEAR,T.OFF_CON_AREA,T.OFF_HOUSE_AREA,"); 
		sql.append("T.OFF_COMPUTE_NUM,T.SER_CON_TYPE,T.SER_CON_STATUS,T.SER_PLACE,T.SER_VILLAGE_NUM,T.SER_TOTLE_AREA," ); 
		sql.append("T.SER_CON_AREA,T.SER_CON_KIND,T.SER_CON_FLAG,T.SER_LEN,T.FUN_OFFICE_FLAG,T.FUN_SERVICE_FLAG,"); 
		sql.append("T.FUN_MULTI_FLAG,T.FUN_POLICE_FLAG,T.FUN_HEALTH_FLAG,T.FUN_ACTIVITY_FLAG,T.FUN_LIBRARY_FLAG,");
		sql.append("T.FUN_OLD_FLAG,T.FUN_KINDERGARTEN_FLAG,T.FUN_AGRICULTURAL_FLAG,T.FUN_SUPERMARK_FLAG,T.FUN_BANK_FLAG,");
		sql.append("T.FUN_POST_FLAG,T.ORGAN_CODE,T.ORGAN_NAME,T.PARENT_CODE,T.REPORT_TYPE,T.REPORT_DATE,T.STATUS,T.SUBMIT_DATE");
		sql.append(" FROM CDC_SERVICE_FACILITIES T WHERE 1 = 1 ");
	    String organCode = (String) pset.getParameter("ORGANCODE");
		String status = (String) pset.getParameter("STATUS"); 
		String reportDate = (String) pset.getParameter("REPORTDATE");
		String orgCode = (String) pset.getParameter("orgCode");
		List<Object> argsList =  new ArrayList<Object>();
		List<Integer> typeList = new ArrayList<Integer>();
		if(organCode!=null&&!("".equals(organCode))){
			sql.append("AND (( T.PARENT_CODE = ?  AND T.STATUS ='1') ");
			argsList.add(organCode);
			typeList.add(Types.VARCHAR);
			sql.append(" OR T.ORGAN_CODE = ?  ");
			argsList.add(organCode);
			typeList.add(Types.VARCHAR);
			if (orgCode!=null&&!("".equals(orgCode))){
				sql.append(" OR T.ORGAN_CODE = ?  ");
				argsList.add(orgCode);
				typeList.add(Types.VARCHAR);
			}
			sql.append(" ) ");
		}
		if(status!=null &&(!"".equals(status))){
			sql.append(" AND T.STATUS = ? ");
			argsList.add(status);
			typeList.add(Types.VARCHAR);
		}
		if(reportDate!=null&&!("".equals(reportDate))){
			sql.append(" AND T.REPORT_DATE = ? ");
			argsList.add(reportDate);
			typeList.add(Types.VARCHAR);
		}
		sql.append(" ORDER BY T.REPORT_DATE, T.ORGAN_CODE DESC ");
		int[] types = new int[typeList.size()];
		for(int i = 0;i<typeList.size();i++){
			types[i] = typeList.get(i);
		}
		Object[] args = argsList.toArray();
		
		return this.executeDataset(sql.toString(),types,args,pset.getPageStart(),pset.getPageLimit(),true);
   }
   
}
