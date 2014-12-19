package com.inspur.cams.cdc.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.cdc.base.dao.ICdcServiceModeDao;
import com.inspur.cams.cdc.base.data.CdcServiceMode;

/**
 * 基础信息社区服务方式信息�?Dao�???�类
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
public class CdcServiceModeDao extends EntityDao<CdcServiceMode> implements ICdcServiceModeDao {
	
	@Override
	public Class<CdcServiceMode> getEntityClass() {
		return CdcServiceMode.class;
	}

	public DataSet queryList(ParameterSet pset) {
		StringBuffer  sql = new StringBuffer();
		sql.append(" SELECT T.MODE_ID MODEID, T.PUBLIC_CONTENT PUBLICCONTENT,T.PUBLIC_PEOPLE_NUM PUBLICPEOPLENUM,");
		sql.append("T.COMMERCE_CONTENT COMMERCECONTENT,T.COMMERCE_ADDRESS COMMERCEADDRESS, T.IF_SERVICE IFSERCICE,");
		sql.append("T.SERVICE_PHONE SERVICEPHONE,T.SERVICE_WEB SERVICEWEB,T.COMMERCE_NAME COMMERCENAME,");
		sql.append("T.VOLUNT_CONTENT VOLUNTCONTENT, T.VOLUNT_PEOPLE_NUM VOLUNTPEOPLENUM, ");
		sql.append("T.ORGAN_CODE ORGANCODE,T.ORGAN_NAME ORGANNAME,T.PARENT_CODE PARENTCODE,T.REPORT_DATE REPORTDATE,");
		sql.append("T.STATUS STATUS,T.SUBMIT_DATE SUBMITDATE FROM CDC_SERVICE_MODE T WHERE 1=1 ");
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