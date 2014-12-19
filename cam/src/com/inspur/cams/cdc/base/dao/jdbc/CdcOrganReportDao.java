package com.inspur.cams.cdc.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.cdc.base.dao.ICdcOrganReportDao;
import com.inspur.cams.cdc.base.data.CdcOrganReport;

/**
 * 基础信息社区单位组织统计信息dao接口
 * @author shgtch
 * @date 2012-1-4
 */
public class CdcOrganReportDao extends EntityDao<CdcOrganReport> implements ICdcOrganReportDao {
	
	@Override
	public Class<CdcOrganReport> getEntityClass() {
		return CdcOrganReport.class;
	}

	public DataSet queryList(ParameterSet pset) {
		StringBuffer  sql = new StringBuffer();
		sql.append("SELECT T.RECORD_ID RECORDID,T.ORGAN_NUM ORGANNUM,T.MORG_NUM MORGNUM,");
		sql.append("T.KIND_ONE_NUM KINDONENUM,T.KIND_TWO_NUM KINDTWONUM,T.ORGAN_CODE ORGANCODE,");
		sql.append("T.KIND_THREE_NUM KINDTHREENUM,T.KIND_FOUR_NUM KINDFOURNUM,");
		sql.append("T.MEMBER_NUM MEMBERNUM,T.OFFICIAL_NUM OFFICIALNUM,T.ORGAN_NAME ORGANNAME,");
		sql.append("T.OFFICIAL_AREA OFFICIALAREA,T.REPORT_DATE REPORTDATE,T.STATUS STATUS,");
		sql.append("T.SUBMIT_DATE SUBMITDATE FROM CDC_ORGAN_REPORT T WHERE 1 =1 ");
		String organCode = (String) pset.getParameter("ORGANCODE");
		String status = (String) pset.getParameter("STATUS"); 
		String reportDate = (String) pset.getParameter("REPORTDATE");
		String reportType = (String) pset.getParameter("REPORTTYPE");
		String orgCode = (String) pset.getParameter("orgCode");
		String sqFlag = (String)pset.getParameter("SQFLAG");
		String organType = (String) pset.getParameter("ORGANTYPE");
		List<Object> argsList =  new ArrayList<Object>();
		List<Integer> typeList = new ArrayList<Integer>();
		if(sqFlag!=null){
			if(organCode!=null&&!("".equals(organCode))){
				sql.append("AND  T.ORGAN_CODE = ?");
				argsList.add(organCode);
				typeList.add(Types.VARCHAR);
			}
		}else{
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
		if(reportType!=null&&!("".equals(reportType))){
			sql.append(" AND T.REPORT_TYPE=? ");
			argsList.add(reportType);
			typeList.add(Types.VARCHAR);
		}
		if(organType!=null&&!("".equals(organType))){
			sql.append(" AND T.ORGAN_TYPE= ? ");
			argsList.add(organType);
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