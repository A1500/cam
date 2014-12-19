package com.inspur.cams.cdc.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.cdc.base.dao.ICdcFacilitiesReportDao;
import com.inspur.cams.cdc.base.data.CdcFacilitiesReport;

/**
 * 社区建设基础设施统计�?Dao�???�类
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
public class CdcFacilitiesReportDao extends EntityDao<CdcFacilitiesReport> implements ICdcFacilitiesReportDao {
	
	@Override
	public Class<CdcFacilitiesReport> getEntityClass() {
		return CdcFacilitiesReport.class;
	}

	public DataSet queryList(ParameterSet pset) {
		StringBuffer  sql = new StringBuffer();
		sql.append("SELECT T.RECORD_ID RECORDID, T.OFF_NUM OFFNUM, T.OFF_AREA OFFAREA, T.OFF_MON OFFMON,");
		sql.append("T.OFF_FINANCE_MON OFFFINACEMON,T.OFF_SELF_MON OFFSELFMON,T.OFF_ENDOW_MON OFFEMDOWNUM,");
		sql.append("T.OFF_OTHER_MON OFFOTHERMON, T.OFF_YEAR OFFYEAR,T.SERVICE_NUM SERVICENUM,T.SERVICE_AREA SERVICEAREA,");
		sql.append("T.SERVICE_MON SERVICEMON,T.SERVICE_FINANCE_MON SERVICEFINANCEMON,T.SERVICE_SELF_MON SERVICESELFMON,");
		sql.append("T.SERVICE_YEAR SERVICEYEAR, T.SERVICE_ENDOW_MON SERVICEENDOWMON, T.SERVICE_OTHER_MON SERVICEOTHERMON,T.POLICE_NUM POLICENUM,T.POLICE_AREA POLICEAREA,T.POLICE_MON POLICEMON,");
		sql.append("T.POLICE_FINANCE_MON POLICEFINANCEMON,T.POLICE_SELF_MON POLICESELFMON,T.POLICE_ENDOW_MON POLICEENDOWMON,");
		sql.append("T.POLICE_OTHER_MON POLICEOTHERMON,T.POLICE_YEAR POLICEYEAR,T.CLINIC_NUM CLINICNUM,T.CLINIC_AREA CLINICAREA,");
		sql.append("T.CLINIC_MON CLINICMON,T.CLINIC_FINANCE_MON CLINICFINANCEMON,T.CLINIC_SELF_MON CLINICSELFMON,T.CLINIC_ENDOW_MON CLINICENDOWMON,");
		sql.append("T.CLINIC_OTHER_MON CLINICOTHERMON,T.CLINIC_YEAR CLINICYEAR,T.ACTION_AREA ACTIONAREA,T.ACTION_ENDOW_MON ACTIONENDOWMON,");
		sql.append("T.ACTION_NUM ACTIONNUM,T.ACTION_MON ACTIONMON,T.ACTION_FINANCE_MON ACTIONFINANCEMON,T.ACTION_SELF_MON ACTIONSELFMON,");
		sql.append("T.ACTION_OTHER_MON ACTIONOTHERMON,T.ACTION_YEAR ACTIONYEAR,T.LIB_NUM LIBNUM,T.LIB_AREA LIBAREA,T.LIB_MON LIBMON, T.LIB_FINANCE_MON LIBFINANCEMON,");
		sql.append("T.LIB_SELF_MON LIBSELFMON,T.LIB_ENDOW_MON LIBENDOWMON,T.LIB_OTHER_MON LIBOTHERMON,T.LIB_YEAR LIBYEAR,T.HAND_NUM HANDNUM,T.HAND_AREA HANDAREA,");
		sql.append("T.HAND_MON HANDMON,T.HAND_FINANCE_MON HANDFINANCEMON,T.HAND_SELF_MON HANDSELFMON,T.HAND_ENDOW_MON HANDENDOWMON,T.HAND_OTHER_MON HANDOTHERMON,");
		sql.append("T.HAND_YEAR HANDYEAR,T.OUT_NUM OUTNUM,T.OUT_AREA OUTAREA,T.OUT_MON OUTMON,T.OUT_FINANCE_MON OUTFINANCEMON,T.OUT_SELF_MON OUTSELFMON,T.OUT_ENBOW_MON OUTENBOWMON,");
		sql.append("T.OUT_OTHER_MON OUTOTHERMON,T.OUT_YEAR OUTYEAR,T.ORGAN_CODE ORGANCODE,T.ORGAN_NAME ORGANNAME, T.REPORT_DATE REPORTDATE,T.STATUS STATUS,");
		sql.append("T.SUBMIT_DATE SUBMITDATE,T.PARENT_CODE PARENTCODE FROM CDC_FACILITIES_REPORT T WHERE 1 = 1 ");
		String organCode = (String) pset.getParameter("ORGANCODE");
		String status = (String) pset.getParameter("STATUS"); 
		String reportDate = (String) pset.getParameter("REPORTDATE");
		String reportType = (String) pset.getParameter("REPORTTYPE");
		String orgCode = (String) pset.getParameter("orgCode");
		String sqFlag = (String)pset.getParameter("SQFLAG");
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
			sql.append(" AND T.REPORT_TYPE= ? ");
			argsList.add(reportType);
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