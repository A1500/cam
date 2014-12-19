package com.inspur.cams.cdc.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.cdc.base.dao.ICdcFinanceInfoDao;
import com.inspur.cams.cdc.base.data.CdcFinanceInfo;

/**
 * @title:CdcFinanceInfoDao
 * @description:
 * @author:
 * @since:2012-02-29
 * @version:1.0
*/
 public class CdcFinanceInfoDao extends EntityDao<CdcFinanceInfo> implements ICdcFinanceInfoDao{

 	public CdcFinanceInfoDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class<CdcFinanceInfo> getEntityClass() {
		return CdcFinanceInfo.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from CdcFinanceInfo");
	}

	public DataSet queryList(ParameterSet pset) {
		StringBuffer  sql = new StringBuffer();
		sql.append("SELECT T.YEARLY YEARLY,T.FINANCEID FINANCEID,");
		sql.append("T.GDP_MON GDPMON,T.AGRICULTURE_MON AGRICULTUREMON,");
		sql.append("T.PERSON_MON PERSONMON,T.FINANCE_MON FINANCEMON,");
		sql.append("T.ORGAN_CODE ORGANCODE,T.ORGAN_NAME ORGANNAME,");
		sql.append("T.PARENT_CODE PARENTCODE,T.REPORT_TYPE REPORTTYPE,");
		sql.append("T.REPORT_DATE REPORTDATE,T.STATUS STATUS,T.SUBMIT_DATE SUBMITDATE ");
		sql.append("  FROM CDC_FINANCE_INFO T WHERE 1=1 ");       
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
		return executeDataset(sql.toString(),types,args,pset.getPageStart(),pset.getPageLimit(),true);
	}
   
}
