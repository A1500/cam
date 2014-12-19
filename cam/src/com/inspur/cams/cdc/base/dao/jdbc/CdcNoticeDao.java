package com.inspur.cams.cdc.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.persistent.util.domain.BaseJdbcDao;
import org.loushang.poi.util.SystemOutLogger;

import com.inspur.cams.cdc.base.dao.ICdcNoticeDao;

public class CdcNoticeDao extends BaseJdbcDao implements ICdcNoticeDao{
	
	public CdcNoticeDao(){
		this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
	}

	@Override
	protected void initDao() {
		
	}
	
	public DataSet getUnReport(ParameterSet pset){
		String OrganCode = (String) pset.getParameter("organCode");
		String OrganC = (String) pset.getParameter("organC");
		
		String communityType = (String) pset.getParameter("communityType");
 		StringBuffer sql = new StringBuffer();
 		List<Object> argsList = new ArrayList<Object>();
 		List<Integer> typesList = new ArrayList<Integer>();
 		sql.append("SELECT T.WORK_ID,T.REPORT_DATE,T.REPORT_ID,");//人员状况
		sql.append("CASE WHEN T.REPORT_ID = 'report1' THEN '社区建设' ");
		sql.append("WHEN T.REPORT_ID = 'report2' THEN '民主选举' ");
		sql.append("WHEN T.REPORT_ID = 'report3' THEN '民主管理、决策及监督' END  REPORTTYPE,");
 		
 		if("T".equals(communityType)||"".equals(communityType)){//社区、乡镇级
 			sql.append("CASE WHEN (SELECT COUNT(1)FROM CDC_FACILITIES_REPORT A ");//城市社区基础设施
 	 		sql.append("WHERE A.REPORT_DATE = T.WORK_ID AND A.ORGAN_CODE = ? AND A.STATUS ='1') > 0 ");
 	 		typesList.add(Types.VARCHAR);
 	 		argsList.add(OrganC);
 	 		sql.append("THEN 1 ELSE 0 END FACILITIES,");
 	 		
 	 		sql.append("CASE WHEN (SELECT COUNT(1)FROM CDC_ORGAN_REPORT A ");//城市社区民间组织
	 	 	sql.append("WHERE A.REPORT_DATE = T.WORK_ID AND A.ORGAN_TYPE = '1' AND A.ORGAN_CODE IN( ?,?) AND A.STATUS ='1') > 0 ");
	 	 	typesList.add(Types.VARCHAR);
	 	 	argsList.add(OrganC);
	 	 	typesList.add(Types.VARCHAR);
	 	 	argsList.add(OrganCode);
	 	 	sql.append("THEN 1 ELSE 0 END ORGAN1,");
	 	 	
	 	 	sql.append("CASE WHEN (SELECT COUNT(1)FROM CDC_COORDINATE_INFO A ");//农村社区领导协调组织
	 	 	sql.append("WHERE A.REPORT_DATE = T.WORK_ID AND A.ORGAN_CODE IN( ?,?) AND A.STATUS ='1') > 0 ");
	 	 	typesList.add(Types.VARCHAR);
	 	 	argsList.add(OrganC);
	 	 	typesList.add(Types.VARCHAR);
	 	 	argsList.add(OrganCode);
	 	 	sql.append("THEN 1 ELSE 0 END COORDINATE,");
	 	 	
	 	 	sql.append("CASE WHEN (SELECT COUNT(1)FROM CDC_PLAN_INFO A ");//农村社区建设规划
	 	 	sql.append("WHERE A.REPORT_DATE = T.WORK_ID AND A.ORGAN_CODE IN( ?,?) AND A.STATUS ='1') > 0 ");
	 	 	typesList.add(Types.VARCHAR);
	 	 	argsList.add(OrganC);
	 	 	typesList.add(Types.VARCHAR);
	 	 	argsList.add(OrganCode);
	 	 	sql.append("THEN 1 ELSE 0 END PLAN,");
	 	 	
	 	 	sql.append("CASE WHEN (SELECT COUNT(1)FROM CDC_FINANCE_INFO A ");//农村社区经济基本情况
	 	 	sql.append("WHERE A.REPORT_DATE = T.WORK_ID AND A.ORGAN_CODE IN( ?,?) AND A.STATUS ='1') > 0 ");
	 	 	typesList.add(Types.VARCHAR);
	 	 	argsList.add(OrganC);
	 	 	typesList.add(Types.VARCHAR);
	 	 	argsList.add(OrganCode);
	 	 	sql.append("THEN 1 ELSE 0 END FINANCE,");
	 	 	
	 	 	sql.append("CASE WHEN (SELECT COUNT(1)FROM CDC_SERVICE_FACILITIES A ");//农村社区服务设施
	 	 	sql.append("WHERE A.REPORT_DATE = T.WORK_ID AND A.ORGAN_CODE IN( ?,?) AND A.STATUS ='1') > 0 ");
	 	 	typesList.add(Types.VARCHAR);
	 	 	argsList.add(OrganC);
	 	 	typesList.add(Types.VARCHAR);
	 	 	argsList.add(OrganCode);
	 	 	sql.append("THEN 1 ELSE 0 END SERVICE,");
	 	 	
	 	 	sql.append("CASE WHEN (SELECT COUNT(1)FROM CDC_SERVICE_MODE A ");//农村社区服务情况
	 	 	sql.append("WHERE A.REPORT_DATE = T.WORK_ID AND A.ORGAN_CODE IN( ?,?) AND A.STATUS ='1') > 0 ");
	 	 	typesList.add(Types.VARCHAR);
	 	 	argsList.add(OrganC);
	 	 	typesList.add(Types.VARCHAR);
	 	 	argsList.add(OrganCode);
	 	 	sql.append("THEN 1 ELSE 0 END SERVICEMODE ");
//	 	 	
//	 	 	sql.append("CASE WHEN (SELECT COUNT(1)FROM CDC_SERVICE_MODE A ");//农村社区下辖村情况进本信息填报
//	 	 	sql.append("WHERE A.REPORT_DATE = T.WORK_ID AND A.ORGAN_CODE IN( ?,?)) > 0 ");
//	 	 	typesList.add(Types.VARCHAR);
//	 	 	argsList.add(OrganC);
//	 	 	typesList.add(Types.VARCHAR);
//	 	 	argsList.add(OrganCode);
//	 	 	sql.append("THEN 1 ELSE 0 END SERVICEMODE ");
//	 	 	
 		}else{//社区，村级
 			
 	 		sql.append("CASE WHEN (SELECT COUNT(1)FROM CDC_POPULATE_INFO A ");
 	 		sql.append("WHERE A.REPORT_DATE = T.WORK_ID AND A.ORGAN_CODE = ? AND A.STATUS ='1') > 0 ");
 	 		typesList.add(Types.VARCHAR);
 	 		argsList.add(OrganCode);
 	 		sql.append("THEN 1 ELSE 0 END POPULATE,");
 	 		
 	 		sql.append("CASE WHEN (SELECT COUNT(1)FROM CDC_PEOPLE_REPORT A ");//人员信息
 	 		sql.append("WHERE A.REPORT_DATE = T.WORK_ID AND A.ORGAN_CODE = ? AND A.STATUS ='1') > 0 ");
 	 		typesList.add(Types.VARCHAR);
 	 		argsList.add(OrganCode);
 	 		sql.append("THEN 1 ELSE 0 END PEOPLE,");
 	 		
 	 		sql.append("CASE WHEN (SELECT COUNT(1)FROM CDC_SERVICE_REPORT A ");//社区服务
 	 		sql.append("WHERE A.REPORT_DATE = T.WORK_ID AND A.ORGAN_CODE = ? AND A.STATUS ='1') > 0 ");
 	 		typesList.add(Types.VARCHAR);
 	 		argsList.add(OrganCode);
 	 		sql.append("THEN 1 ELSE 0 END SERVICE,");
 	 		
 	 		sql.append("CASE WHEN (SELECT COUNT(1)FROM CDC_FUND_INFO A ");//社区经费
 	 		sql.append("WHERE A.REPORT_DATE = T.WORK_ID AND A.ORGAN_CODE = ? AND A.STATUS ='1') > 0 ");
 	 		typesList.add(Types.VARCHAR);
 	 		argsList.add(OrganCode);
 	 		sql.append("THEN 1 ELSE 0 END FUND,");
 	 		
 	 		sql.append("CASE WHEN (SELECT COUNT(1)FROM CDC_ECONOMY_INFO A ");//社区资产
 	 		sql.append("WHERE A.REPORT_DATE = T.WORK_ID AND A.ORGAN_CODE = ? AND A.STATUS ='1') > 0 ");
 	 		typesList.add(Types.VARCHAR);
 	 		argsList.add(OrganCode);
 	 		sql.append("THEN 1 ELSE 0 END ECONOMY,");
 	 		
 	 		sql.append("CASE WHEN (SELECT COUNT(1)FROM CDC_ORGAN_REPORT A ");//社区共建
 	 		sql.append("WHERE A.REPORT_DATE = T.WORK_ID AND A.ORGAN_TYPE = '2' AND A.ORGAN_CODE = ? AND A.STATUS ='1') > 0 ");
 	 		typesList.add(Types.VARCHAR);
 	 		argsList.add(OrganCode);
 	 		sql.append("THEN 1 ELSE 0 END ORGAN2,");
 	 		sql.append("CASE WHEN (");
 	 		sql.append("(SELECT COUNT(1) FROM CDC_ELECTION_INFO INFO WHERE INFO.ORGAN_CODE = ? AND INFO.REPORT_DATE = T.WORK_ID)  ");
 	 		typesList.add(Types.VARCHAR);
	 	 	argsList.add(OrganCode);
 	 		sql.append("< (SELECT COUNT(1) FROM COM_EXT_USER U ");
 	 		if("C".equals(communityType)){
 	 			sql.append("WHERE U.USER_ID = ?) ");//民主选举
 	 			typesList.add(Types.VARCHAR);
 	 	 		argsList.add(OrganCode);
 	 		}else{
 	 			sql.append(" WHERE (U.IF_VILLAGE = '0' and U.COMMUNITY_BELONGS = ? )");//民主选举
 	 			sql.append("OR (U.IF_VILLAGE = '1' AND U.COMMUNITY_BELONGS = ? AND U.USER_ID != ?) )");
 	 			typesList.add(Types.VARCHAR);
 	 	 		argsList.add(OrganCode);
 	 			typesList.add(Types.VARCHAR);
 	 	 		argsList.add(OrganCode);
 	 	 		typesList.add(Types.VARCHAR);
 	 	 		argsList.add(OrganCode);
 	 		}
 	 		sql.append(")THEN 0 ELSE 1 END ELECTION,");
 	 		
 	 		sql.append("CASE WHEN (SELECT COUNT(1)FROM CDC_DECISION_REPORT A ");//民主决策
 	 		sql.append("WHERE A.REPORT_DATE = T.WORK_ID AND A.ORGAN_CODE = ? AND A.STATUS ='1') > 0 ");
 	 		typesList.add(Types.VARCHAR);
 	 		argsList.add(OrganCode);
 	 		sql.append("THEN 1 ELSE 0 END DECISION,");
 	 		
 	 		sql.append("CASE WHEN (SELECT COUNT(1)FROM CDC_MANAGE_REPORT A ");//民主管理
 	 		sql.append("WHERE A.REPORT_DATE = T.WORK_ID AND A.ORGAN_CODE = ? AND A.STATUS ='1') > 0 ");
 	 		typesList.add(Types.VARCHAR);
 	 		argsList.add(OrganCode);
 	 		sql.append("THEN 1 ELSE 0 END MANAGE,");
 	 		
 	 		sql.append("CASE WHEN (SELECT COUNT(1)FROM CDC_SUPERVISE_REPORT A ");//民主监督
 	 		sql.append("WHERE A.REPORT_DATE = T.WORK_ID AND A.ORGAN_CODE = ? AND A.STATUS ='1') > 0 ");
 	 		typesList.add(Types.VARCHAR);
 	 		argsList.add(OrganCode);
 	 		sql.append("THEN 1 ELSE 0 END SUPERVISE,");
 			
 	 		sql.append("CASE WHEN (SELECT COUNT(1)FROM CDC_CONSTRUCT_REPORT A ");//社区规划
	 	 	sql.append("WHERE A.REPORT_DATE = T.WORK_ID AND A.ORGAN_CODE = ? AND A.STATUS ='1') > 0 ");
	 	 	typesList.add(Types.VARCHAR);
	 	 	argsList.add(OrganCode);
	 	 	sql.append("THEN 1 ELSE 0 END CONSTRUCT,");
	 	 		
	 	 	sql.append("CASE WHEN (SELECT COUNT(1)FROM CDC_NATURE_REPORT A ");//社区自然状况
	 	 	sql.append("WHERE A.REPORT_DATE = T.WORK_ID AND A.ORGAN_CODE = ? AND A.STATUS ='1') > 0 ");
	 	 	typesList.add(Types.VARCHAR);
	 	 	argsList.add(OrganCode);
	 	 	sql.append("THEN 1 ELSE 0 END NATURE,");
	 	 		
	 	 	sql.append("CASE WHEN (SELECT COUNT(1)FROM CDC_ORGAN_REPORT A ");//民间组织
	 	 	sql.append("WHERE A.REPORT_DATE = T.WORK_ID AND A.ORGAN_TYPE = '1' AND A.ORGAN_CODE = ? AND A.STATUS ='1') > 0 ");
	 	 	typesList.add(Types.VARCHAR);
	 	 	argsList.add(OrganCode);
	 	 	sql.append("THEN 1 ELSE 0 END ORGAN1,");
	 	 	
	 	 	sql.append("CASE WHEN (SELECT COUNT(1)FROM CDC_TENEMENT_INFO A ");//城市社区物业情况
	 	 	sql.append("WHERE A.REPORT_DATE = T.WORK_ID AND A.ORGAN_CODE IN( ?,?) AND A.STATUS ='1') > 0 ");
	 	 	typesList.add(Types.VARCHAR);
	 	 	argsList.add(OrganC);
	 	 	typesList.add(Types.VARCHAR);
	 	 	argsList.add(OrganCode);
	 	 	sql.append("THEN 1 ELSE 0 END TENEMENT ,");
	 	 	
	 	 	sql.append("CASE WHEN (SELECT COUNT(1)FROM CDC_FACILITIES_REPORT A ");//基础设施
	 	 	sql.append("WHERE A.REPORT_DATE = T.WORK_ID AND A.ORGAN_CODE = ? AND A.STATUS ='1') > 0 ");
	 	 	typesList.add(Types.VARCHAR);
	 	 	argsList.add(OrganCode);
	 	 	sql.append("THEN 1 ELSE 0 END FACILITIES");
 	 	 		
 		}
 		sql.append(" FROM CDC_REPORT_WORK T WHERE T.STATUS = '1' ORDER  BY T.REPORT_ID ");
 		int[] types = new int[typesList.size()];
		for(int i = 0;i<typesList.size();i++){
			types[i] = typesList.get(i);
		}
		Object[] args = argsList.toArray();
 		DataSet ds = executeDataset(sql.toString(),types,args,true);
 		return ds;
 	} 
	
}

