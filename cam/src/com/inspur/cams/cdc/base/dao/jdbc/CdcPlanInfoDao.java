package com.inspur.cams.cdc.base.dao.jdbc;


import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.cdc.base.dao.ICdcPlanInfoDao;
import com.inspur.cams.cdc.base.data.CdcPlanInfo;

/**
 * 社区建设规划信息�?Dao�???�类
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
public class CdcPlanInfoDao extends EntityDao<CdcPlanInfo> implements ICdcPlanInfoDao {
	
	@Override
	public Class<CdcPlanInfo> getEntityClass() {
		return CdcPlanInfo.class;
	}
	
	public DataSet queryList(ParameterSet pset){
		StringBuffer  sql = new StringBuffer();
		sql.append("SELECT T.PLAN_ID PLANID,T.ORGAN_CODE ORGANCODE,T.PLAN_NUM PLANNUM ,T.COMPLETE_NUM COMPLETENUM,");
		sql.append("T.ORGAN_NAME ORGANNAME,T.REPORT_DATE REPORTDATE,T.STATUS,T.PARENT_CODE PARENTCODE,T.FILE_NAME FILENAME," );
		sql.append("T.FILE_ID FILEID,T.SUBMIT_DATE SUBMITDATE,T.YEAR_COMPLETE_NUM  FROM CDC_PLAN_INFO T  WHERE 1 = 1 ");
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