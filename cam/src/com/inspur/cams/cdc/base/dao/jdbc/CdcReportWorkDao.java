package com.inspur.cams.cdc.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;

import com.inspur.cams.cdc.base.dao.ICdcReportWorkDao;
import com.inspur.cams.cdc.base.data.CdcReportWork;
import com.inspur.cams.comm.dicm.DicBean;
import com.inspur.cams.comm.util.ProceduresUtil;
import com.inspur.cams.comm.util.ProceduresUtil.Proc;

/**
 * 基层民主填报工作信息表Dao实现类
 * @author shgtch
 * @date 2011-12-20
 */
@SuppressWarnings("unchecked")
public class CdcReportWorkDao extends EntityDao<CdcReportWork> implements ICdcReportWorkDao {

	private static String WORK_DIC_SQL = "SELECT WORK_ID CODE, REPORT_DATE NAME FROM CDC_REPORT_WORK WHERE REPORT_ID=? AND STATUS!='0'";
	private static String WORK_DIC_SQL_II = "SELECT WORK_ID CODE, REPORT_DATE NAME FROM CDC_REPORT_WORK WHERE REPORT_ID=? AND STATUS='1'";
	
	@Override
	public Class<CdcReportWork> getEntityClass() {
		return CdcReportWork.class;
	}

	/**
	 * 查询 填报工作字典，如果organCode为空则查询全部工作任务，如果不为空则查询当前单位未填报工作任务
	 * 参数：reportType 报表类型
	 * 参数：organCode 单位行政区划
	 * @param pset
	 * @return
	 */
	public DataSet getDic(ParameterSet pset) {
		String reportType = (String) pset.get("reportType");
		String reportId = getReportId(reportType);
		String organCode = (String) pset.get("organCode");
		String organType = (String) pset.get("organType");
		
		List<Map> list;
		if (organCode == null || "".equals(organCode)) {
			list = executeQuery(WORK_DIC_SQL, new int[]{ Types.VARCHAR }, new Object[]{ reportId });
		} else {
			if("R09".equals(reportType)||"R10".equals(reportType)){
				list = getOrganWorkSql(pset);
			}else{
				list = executeQuery(getWorkSql(reportType), new int[]{ Types.VARCHAR, Types.VARCHAR, Types.VARCHAR }, new Object[]{ reportId, organCode, organType });
			}
		}
		DataSet ds = new DataSet();
		for (int i = 0; i < list.size(); i++) {
			Map map = (Map) list.get(i);
			DicBean dicBean = new DicBean();
			dicBean.setValue((String) map.get("CODE"));
			dicBean.setText((String) map.get("NAME"));
			ds.addRecord(dicBean);
		}
		return ds;
	}

	
	private List<Map> getOrganWorkSql(ParameterSet pset) {
		StringBuffer sql = new StringBuffer(WORK_DIC_SQL_II);
		
		String organCode = (String) pset.get("organCode");
		String organType = (String) pset.get("organType");
		String type = (String) pset.get("type");
		
		List<Integer> typesList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		
		sql.append(" AND WORK_ID NOT IN(SELECT REPORT_DATE FROM CDC_ORGAN_REPORT ");
		sql.append(" WHERE ORGAN_CODE=? AND REPORT_TYPE=? ");
		typesList.add(Types.VARCHAR);
		argsList.add("report1");
		typesList.add(Types.VARCHAR);
		argsList.add(organCode);
		typesList.add(Types.VARCHAR);
		argsList.add(organType);
		
		if(type!=null){
			sql.append(" AND ORGAN_TYPE = ? ");
			typesList.add(Types.VARCHAR);
			argsList.add(type);
		}
		sql.append(" )");
		int [] types = new int[typesList.size()];
		for(int i = 0 ;i<typesList.size();i++){
			types[i] = typesList.get(i);
		}
		Object[] args = argsList.toArray();
		List<Map> temp =  executeQuery(sql.toString(),types,args);
		return temp;
	}
	private static String getReportId(String reportType) {
		if ("R01".equals(reportType)) { // R01:社区人口状况
			return "report1";
		} else if ("R02".equals(reportType)) { // R02:社区自然状况
			return "report1";
		} else if ("R03".equals(reportType)) {	 // R03:社区资产状况
			return "report1";
		} else if ("R04".equals(reportType)) {
			return "report1";
		} else if ("R05".equals(reportType)) { // R05:社区经费状况
			return "report1";
		} else if ("R06".equals(reportType)) { //R06:社区基础设施
			return "report1";
		} else if ("R07".equals(reportType)) { //R07  社区服务
			return "report1";
		} else if ("R08".equals(reportType)) { //R08：社区工作者情况
			return "report1";
		} else if ("R09".equals(reportType)) {	// 社区单位
			return "report1";
		} else if ("R10".equals(reportType)) {	// 民间组织
			return "report1";
		} else if ("R11".equals(reportType)) {  // 民主选举填报
			return "report2";
		} else if ("R12".equals(reportType)) {
			return "report1";
		} else if ("R13".equals(reportType)) {	// 民主决策
			return "report3";
		} else if ("R14".equals(reportType)) {  // 民主管理
			return "report3";
		} else if ("R15".equals(reportType)) {  // 民主监督
			return "report3";
		} else if ("R16".equals(reportType)) {
			return "report1";
		} else if("R17".equals(reportType)){
			return "report1";
		}else if("R18".equals(reportType)){
			return "report1";
		}else if("R19".equals(reportType)){
			return "report1";
		}else if("R20".equals(reportType)){
			return "report1";
		}else if("R21".equals(reportType)){
			return "report1";
		}else if("R22".equals(reportType)){
			return "report1";
		}else if("R23".equals(reportType)){
			return "report1";
		}else if("R24".equals(reportType)){
			return "report1";
		}else{
			throw new RuntimeException("无法找到对应的工作任务，请联系管理员。");
		}
	}

	private static String getWorkSql(String reportType) {
		StringBuffer sql = new StringBuffer(WORK_DIC_SQL_II);
		sql.append(" AND WORK_ID NOT IN(SELECT REPORT_DATE FROM ");
		if ("R01".equals(reportType)) {
			sql.append("CDC_POPULATE_INFO"); // R01:社区人口状况
		} else if ("R02".equals(reportType)) {
			sql.append("CDC_NATURE_REPORT"); // R02:社区自然状况
		} else if ("R03".equals(reportType)) {
			sql.append("CDC_ECONOMY_INFO");	 // R03:社区资产状况
		} else if ("R04".equals(reportType)) {
			
		} else if ("R05".equals(reportType)) {
			sql.append("CDC_FUND_INFO");	 // R05:社区经费状况
		} else if ("R06".equals(reportType)) {
			sql.append("CDC_FACILITIES_REPORT"); //R06:社区基础设施
		} else if ("R07".equals(reportType)) {
			sql.append("CDC_SERVICE_REPORT"); //R07  社区服务
		} else if ("R08".equals(reportType)) {
			sql.append("CDC_PEOPLE_REPORT"); //R08：社区工作者情况
		} else if ("R09".equals(reportType)) {
			sql.append("CDC_ORGAN_REPORT");	// 社区单位
		} else if ("R10".equals(reportType)) {
			sql.append("CDC_ORGAN_REPORT");	// 民间组织
		} else if ("R11".equals(reportType)) {
			sql.append("CDC_ELECTION_INFO");//R11 民主选举填报
		} else if ("R12".equals(reportType)) {
			
		} else if ("R13".equals(reportType)) {	// 民主决策
			sql.append("CDC_DECISION_REPORT");
		} else if ("R14".equals(reportType)) {//民主管理
			sql.append("CDC_MANAGE_REPORT");
		} else if ("R15".equals(reportType)) {
			sql.append("CDC_SUPERVISE_REPORT");// 民主监督
		} else if ("R16".equals(reportType)) {
			
		} else if("R17".equals(reportType)){//领导协调
			sql.append("CDC_COORDINATE_INFO");
		} else if("R18".equals(reportType)){
			sql.append("CDC_PLAN_INFO");
		} else if("R19".equals(reportType)){
			sql.append("CDC_FINANCE_INFO");
		}else if("R20".equals(reportType)){
			sql.append("CDC_SERVICE_MODE");
		}else if("R21".equals(reportType)){//社区服务设施
			sql.append("CDC_SERVICE_FACILITIES");
		}else if("R22".equals(reportType)){//农村社区规划
			sql.append("CDC_CONSTRUCT_REPORT");
		}else if("R23".equals(reportType)){//城市社区物业情况
			sql.append("CDC_TENEMENT_INFO");
		}else if("R24".equals(reportType)){//农村社区下辖村情况进本信息
			sql.append("CDC_UNDER_GOVEMNS_INFO");
		}else {
			throw new RuntimeException("无法找到对应的工作任务，请联系管理员。");
		}
		sql.append(" WHERE ORGAN_CODE=? AND REPORT_TYPE=?)");
		return sql.toString();
	}
	
	/**
	 * 基层政权与社区建设社区级统计分析
	 */
	public DataSet queryInfo(ParameterSet pset) {
		String releaseArea=(String)pset.getParameter("releaseArea");
		String reportDate=(String)pset.getParameter("reportDate");
		String areaCode= getAreaCode(releaseArea);
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("procedureName", "CDC_PEO_NUM");
		map.put("parameterNum", 3);
		map.put("parameterName_1", "releaseArea");
		map.put("parameterName_2", "reportDate");
		map.put("parameterName_3", "areaCode");
		map.put("NumberOfResultSet",1);
		Proc procduce = new ProceduresUtil().init(getDataSource(),map);
		map.put("parameterValue_1", releaseArea);
		map.put("parameterValue_2", reportDate);
		map.put("parameterValue_3", areaCode);
		DataSet set = new DataSet();
		List results = null;
		Object object = null;
		object = procduce.call(map).get("results");
		if (object instanceof ArrayList) {
			results = (List) object;
			for (Object o : results) {
				set.add((Record) o);
			}
		}
		set = ProceduresUtil.fixDataSet(set);
		return set;
	}
	
	/**
	 * 基层政权与社区建设街道及以上单位统计分析
	 */
	public DataSet queryStreetInfo(ParameterSet pset) {
		String releaseArea=(String)pset.getParameter("releaseArea");
		String reportDate=(String)pset.getParameter("reportDate");
		String areaCode= getAreaCode(releaseArea);
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("procedureName", "VCDC_PEO_NUM");
		map.put("parameterNum", 3);
		map.put("parameterName_1", "releaseArea");
		map.put("parameterName_2", "reportDate");
		map.put("parameterName_3", "areaCode");
		map.put("NumberOfResultSet",1);
		Proc procduce = new ProceduresUtil().init(getDataSource(),map);
		map.put("parameterValue_1", releaseArea);
		map.put("parameterValue_2", reportDate);
		map.put("parameterValue_3", areaCode);
		DataSet set = new DataSet();
		List results = null;
		Object object = null;
		object = procduce.call(map).get("results");
		if (object instanceof ArrayList) {
			results = (List) object;
			for (Object o : results) {
				set.add((Record) o);
			}
		}
		set = ProceduresUtil.fixDataSet(set);
		return set;
	}
	
	private String getAreaCode(String areaCode) {
       if(areaCode.endsWith("0000000000")){//省370000000000
			return areaCode.substring(0,2);
		} else if (areaCode.endsWith("00000000")){//市370100000000
			return areaCode.substring(0,4);
		} else if (areaCode.endsWith("000000")){//县370104000000
			return areaCode.substring(0,6);
		} else if (areaCode.endsWith("000")){//乡370104003000
			return areaCode.substring(0,9);
		}
       return areaCode;
	}
}