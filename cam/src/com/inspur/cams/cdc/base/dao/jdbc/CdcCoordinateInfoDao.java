package com.inspur.cams.cdc.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.cdc.base.dao.ICdcCoordinateInfoDao;
import com.inspur.cams.cdc.base.data.CdcCoordinateInfo;

/**
 * 社区建设领导协调机制信息表dao
 * @author shgtch
 * @date 2012-2-24
 */
public class CdcCoordinateInfoDao extends EntityDao<CdcCoordinateInfo> implements ICdcCoordinateInfoDao {
	
	@Override
	public Class<CdcCoordinateInfo> getEntityClass() {
		return CdcCoordinateInfo.class;
	}

	public DataSet queryList(ParameterSet pset) {
		StringBuffer  sql = new StringBuffer();
		sql.append("SELECT T.COORDINATE_ID COORDINATEID,T.IF_FOUND IFFOUND,T.NAME NAME,");
		sql.append("T.DUTY DUTY,T.DEPARTMENT DEPARTMENT,T.LINK_PEOPLE LINKPEOPLE,");
		sql.append("T.PHONE PHONE,T.POSITION POSITION,T.IF_BUDGET IFBUDGET,T.ORGAN_CODE ORGANCODE,");
		sql.append("T.ORGAN_NAME ORGANNAME,T.PARENT_CODE PARENTCODE,T.REPORT_DATE REPORTDATE, T.STATUS STATUS,");
		sql.append("T.SUBMIT_DATE SUBMITDATE,T.CRITERION CRITERION FROM CDC_COORDINATE_INFO T WHERE 1 = 1 ");
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
//		if(status!=null &&(!"".equals(status))){
//			sql.append(" AND T.STATUS = ? ");
//			argsList.add(status);
//			typeList.add(Types.VARCHAR);
//		}
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