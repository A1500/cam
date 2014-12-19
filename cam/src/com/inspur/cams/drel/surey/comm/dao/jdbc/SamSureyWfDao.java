package com.inspur.cams.drel.surey.comm.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.surey.comm.dao.ISamSureyWfDao;
import com.inspur.cams.drel.surey.comm.data.SamSureyWf;

/**
 * @title:SamSureyWfDao
 * @description:
 * @author:
 * @since:2011-09-29
 * @version:1.0
 */
public class SamSureyWfDao extends EntityDao<SamSureyWf> implements ISamSureyWfDao {

	public SamSureyWfDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return SamSureyWf.class;
	}

	public void deleteStruAll() {
		executeUpdate("delete from SamSureyWf");
	}
	
	public DataSet queryWf(ParameterSet pset){
		String CUR_ACTIVITY = (String) pset.getParameter("CUR_ACTIVITY");
		String CUR_STATUS = (String) pset.getParameter("CUR_STATUS");
		String CUR_ACTIVITY_ORGAN_TYPE = (String) pset.getParameter("CUR_ACTIVITY_ORGAN_TYPE");
		String CUR_ACTIVITY_AREA = (String) pset.getParameter("CUR_ACTIVITY_AREA");

		String name = (String) pset.getParameter("name");//姓名
		String idCard = (String) pset.getParameter("idCard");//身份证号
		String domicileCode = (String) pset.getParameter("domicileCode");//户籍地址
		String apanageCode = (String) pset.getParameter("apanageCode");//居住地址
		String applyDateQ = (String) pset.getParameter("applyDateQ");//申请日期
		String applyDateZ = (String) pset.getParameter("applyDateZ");//申请日期
		String assistanceType = (String) pset.getParameter("assistanceType");//核对项目
		String sureyDateQ = (String) pset.getParameter("sureyDateQ");//核对日期
		String sureyDateZ = (String) pset.getParameter("sureyDateZ");//核对日期
		String result = (String) pset.getParameter("result");//核对结果
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argList = new ArrayList<Object>();
		
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT W.FLOW_ID,W.SURVEY_ID,W.NAME,W.ID_CARD,W.DOMICILE_CODE,C.NAME AS DOMICILE_NAME,W.APANAGE_CODE,D.NAME AS APANAGE_NAME,W.APPLY_TITLE,S.ASSISTANCE_TYPE,P.PEOPLE_ID,S.APPLY_DATE,R.RESULT,S.SURVEY_ORGAN_NAME,S.SURVEY_DATE,R.SIGN_ORGAN,R.SIGN_DATE ");
		sql.append("FROM SAM_SUREY_WF W LEFT JOIN DIC_CITY C ON W.DOMICILE_CODE = C.ID LEFT JOIN DIC_CITY D ON W.APANAGE_CODE = D.ID JOIN SAM_SUREY S ON W.SURVEY_ID = S.SURVEY_ID ");
		sql.append("JOIN SAM_ESUREY_PEOPLE P ON W.SURVEY_ID = P.SURVEY_ID LEFT JOIN SAM_SUREY_ASSISTANCE_RESULT R ON W.SURVEY_ID = R.SURVEY_ID WHERE 1=1 ");
		sql.append("and w.SURVEY_TYPE in (02,03) ");
		sql.append(" and w.PARENT_FLOW_ID is null ");
		sql.append("and w.CUR_ACTIVITY=? ");
		typeList.add(Types.VARCHAR);
		argList.add(CUR_ACTIVITY);
		sql.append("and w.CUR_STATUS=? ");
		typeList.add(Types.VARCHAR);
		argList.add(CUR_STATUS);
		sql.append("and w.CUR_ACTIVITY_ORGAN_TYPE=? ");
		typeList.add(Types.VARCHAR);
		argList.add(CUR_ACTIVITY_ORGAN_TYPE);
		sql.append("and w.CUR_ACTIVITY_AREA=? ");
		typeList.add(Types.VARCHAR);
		argList.add(CUR_ACTIVITY_AREA);
		if (name != null && !"".equals(name)) {
			sql.append(" AND w.NAME=? ");
			typeList.add(Types.VARCHAR);
			argList.add(name);
		}
		if (idCard != null && !"".equals(idCard)) {
			sql.append(" AND w.ID_CARD=? ");
			typeList.add(Types.VARCHAR);
			argList.add(idCard);
		}
		if (domicileCode != null && !"".equals(domicileCode)) {
			sql.append(" AND w.DOMICILE_CODE=? ");
			typeList.add(Types.VARCHAR);
			argList.add(domicileCode);
		}
		if (apanageCode != null && !"".equals(apanageCode)) {
			sql.append(" AND w.APANAGE_CODE=? ");
			typeList.add(Types.VARCHAR);
			argList.add(apanageCode);
		}		
		if (applyDateQ != null && !"".equals(applyDateQ)) {
			sql.append(" AND s.APPLY_DATE>=? ");
			typeList.add(Types.VARCHAR);
			argList.add(applyDateQ);
		}
		if (applyDateZ != null && !"".equals(applyDateZ)) {
			sql.append(" AND s.APPLY_DATE<=? ");
			typeList.add(Types.VARCHAR);
			argList.add(applyDateZ);
		}			
		if (assistanceType != null && !"".equals(assistanceType)) {
			sql.append(" AND s.ASSISTANCE_TYPE=? ");
			typeList.add(Types.VARCHAR);
			argList.add(assistanceType);
		}
		if (sureyDateQ != null && !"".equals(sureyDateQ)) {
			sql.append(" AND s.SURVEY_DATE>=? ");
			typeList.add(Types.VARCHAR);
			argList.add(sureyDateQ);
		}
		if (sureyDateZ != null && !"".equals(sureyDateZ)) {
			sql.append(" AND s.SURVEY_DATE<=? ");
			typeList.add(Types.VARCHAR);
			argList.add(sureyDateZ);
		}
		if (result != null && !"".equals(result)) {
			sql.append(" AND r.RESULT=? ");
			typeList.add(Types.VARCHAR);
			argList.add(result);
		}			
		//说明：加上 order by 之后，页面分页查询有问题，因此暂时去掉！
	     sql.append(" order by s.APPLY_DATE desc");
		if(typeList.size()==argList.size() && typeList.size()!=0){
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = argList.toArray(new Object[argList.size()]);
			return executeDataset(sql.toString(), types, args, getDsStart(pset), getDsLimit(pset), true);
		}else{
			return executeDataset(sql.toString(), getDsStart(pset), getDsLimit(pset) , true);
		}
	}
	private int getDsStart(ParameterSet pset) {
		String excelType = (String)pset.getParameter("excelType");
		if(null==excelType||"0,1".indexOf(excelType)==-1) {
			return pset.getPageStart();
		}
		int start = 0;
		if("0".equals(excelType)) {  //导出当前页
			Integer startExcel = (java.lang.Integer) pset.getParameter("startExcel");
			if(startExcel!=null) {
				start = startExcel.intValue();
			}
		}
		return start;
	}
	private int getDsLimit(ParameterSet pset) {
		String excelType = (String)pset.getParameter("excelType");
		if(null==excelType||"0,1".indexOf(excelType)==-1) {
			return pset.getPageLimit();
		}
		int limit = ((java.lang.Integer) pset.getParameter("limitExcel")).intValue();
		return limit>1000?1000:limit;
	}
	public DataSet extStatsReport(ParameterSet pset){
		String APPLY_ORGAN_TYPE = (String) pset.getParameter("APPLY_ORGAN_TYPE");
		String APPLY_ORGAN_AREA = (String) pset.getParameter("APPLY_ORGAN_AREA");
		String SURVEY_ORGAN_TYPE = (String) pset.getParameter("SURVEY_ORGAN_TYPE");
		String SURVEY_ORGAN_AREA = (String) pset.getParameter("SURVEY_ORGAN_AREA");
		String IS_FINISH = (String) pset.getParameter("IS_FINISH");
		
		String applyDateQ = (String) pset.getParameter("applyDateQ");//申请日期
		String applyDateZ = (String) pset.getParameter("applyDateZ");//申请日期
		String assistanceType = (String) pset.getParameter("assistanceType");//核对项目
		String assistanceTypeQuery = (String) pset.getParameter("assistanceTypeQuery");//核对项目
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argList = new ArrayList<Object>();
		
		StringBuffer sql = new StringBuffer();
		sql.append("select w.FLOW_ID,w.SURVEY_ID,w.NAME,w.ID_CARD,w.DOMICILE_CODE,w.APANAGE_CODE,w.APPLY_TITLE,s.ASSISTANCE_TYPE,p.PEOPLE_ID,s.APPLY_DATE,r.RESULT,s.SURVEY_ORGAN_NAME,s.SURVEY_DATE,r.SIGN_ORGAN,r.SIGN_DATE,w.IS_FINISH from SAM_SUREY_WF w ,SAM_SUREY s ,SAM_ESUREY_PEOPLE p,SAM_SUREY_ASSISTANCE_RESULT r where w.SURVEY_ID=s.SURVEY_ID and w.SURVEY_ID=p.SURVEY_ID and w.SURVEY_ID=r.SURVEY_ID(+) ");
		sql.append(" and w.SURVEY_TYPE in (02,03) ");
		sql.append(" and w.PARENT_FLOW_ID is null ");
		sql.append(" and w.IS_FINISH is not null ");
		sql.append(" and s.APPLY_ORGAN_TYPE=? ");//申请单位
		typeList.add(Types.VARCHAR);
		argList.add(APPLY_ORGAN_TYPE);
		sql.append(" and s.APPLY_ORGAN_AREA=? ");
		typeList.add(Types.VARCHAR);
		argList.add(APPLY_ORGAN_AREA);
		sql.append(" and s.SURVEY_ORGAN_TYPE=? ");// 审核单位
		typeList.add(Types.VARCHAR);
		argList.add(SURVEY_ORGAN_TYPE);
		sql.append(" and S.SURVEY_ORGAN_AREA=? ");
		typeList.add(Types.VARCHAR);
		argList.add(SURVEY_ORGAN_AREA);
		
		if (IS_FINISH != null && !"".equals(IS_FINISH)) {
			sql.append(" and w.IS_FINISH=? ");
			typeList.add(Types.VARCHAR);
			argList.add(IS_FINISH);
		}
		if (applyDateQ != null && !"".equals(applyDateQ)) {
			sql.append(" AND s.APPLY_DATE>=? ");
			typeList.add(Types.VARCHAR);
			argList.add(applyDateQ);
		}
		if (applyDateZ != null && !"".equals(applyDateZ)) {
			sql.append(" AND s.APPLY_DATE<=? ");
			typeList.add(Types.VARCHAR);
			argList.add(applyDateZ);
		}			
		if (assistanceType != null && !"".equals(assistanceType)) {
			sql.append(" AND s.ASSISTANCE_TYPE=? ");
			typeList.add(Types.VARCHAR);
			argList.add(assistanceType);
		}
		if (assistanceTypeQuery != null && !"".equals(assistanceTypeQuery)) {
			sql.append(" AND s.ASSISTANCE_TYPE=? ");
			typeList.add(Types.VARCHAR);
			argList.add(assistanceTypeQuery);
		}
		
		sql.append(" order by w.IS_FINISH,s.APPLY_DATE desc");
		if(typeList.size()==argList.size() && typeList.size()!=0){
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = argList.toArray(new Object[argList.size()]);
			return executeDataset(sql.toString(), types, args, pset.getPageStart(), pset.getPageLimit(), true);
		}else{
			return executeDataset(sql.toString(), pset.getPageStart(), pset.getPageLimit(), true);
		}
	}
	
	public DataSet statsReport(ParameterSet pset){
		String APPLY_ORGAN_TYPE = (String) pset.getParameter("APPLY_ORGAN_TYPE");
		String APPLY_ORGAN_AREA = (String) pset.getParameter("APPLY_ORGAN_AREA");
		String SURVEY_ORGAN_TYPE = (String) pset.getParameter("SURVEY_ORGAN_TYPE");
		String SURVEY_ORGAN_AREA = (String) pset.getParameter("SURVEY_ORGAN_AREA");
		String IS_FINISH = (String) pset.getParameter("IS_FINISH");
		
		String applyDateQ = (String) pset.getParameter("applyDateQ");//申请日期
		String applyDateZ = (String) pset.getParameter("applyDateZ");//申请日期
		String assistanceType = (String) pset.getParameter("assistanceType");//核对项目
		String assistanceTypeQuery = (String) pset.getParameter("assistanceTypeQuery");//核对项目
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argList = new ArrayList<Object>();
		
		StringBuffer sql = new StringBuffer();
		sql.append("select w.FLOW_ID,w.SURVEY_ID,w.NAME,w.ID_CARD,w.DOMICILE_CODE,w.APANAGE_CODE,w.APPLY_TITLE,s.ASSISTANCE_TYPE,p.PEOPLE_ID,s.APPLY_DATE,r.RESULT,s.SURVEY_ORGAN_NAME,s.SURVEY_DATE,r.SIGN_ORGAN,r.SIGN_DATE,w.IS_FINISH from SAM_SUREY_WF w ,SAM_SUREY s ,SAM_ESUREY_PEOPLE p,SAM_SUREY_ASSISTANCE_RESULT r where w.SURVEY_ID=s.SURVEY_ID and w.SURVEY_ID=p.SURVEY_ID and w.SURVEY_ID=r.SURVEY_ID(+) ");
		sql.append(" and w.SURVEY_TYPE in (02,03) ");
		sql.append(" and w.PARENT_FLOW_ID is null ");
		sql.append(" and w.IS_FINISH is not null ");
		if (APPLY_ORGAN_TYPE != null && !"".equals(APPLY_ORGAN_TYPE)) {
			sql.append(" and s.APPLY_ORGAN_TYPE=? ");//申请单位
			typeList.add(Types.VARCHAR);
			argList.add(APPLY_ORGAN_TYPE);
		}
		sql.append(" and s.APPLY_ORGAN_AREA=? ");
		typeList.add(Types.VARCHAR);
		argList.add(APPLY_ORGAN_AREA);
		sql.append(" and s.SURVEY_ORGAN_TYPE=? ");// 审核单位
		typeList.add(Types.VARCHAR);
		argList.add(SURVEY_ORGAN_TYPE);
		sql.append(" and S.SURVEY_ORGAN_AREA=? ");
		typeList.add(Types.VARCHAR);
		argList.add(SURVEY_ORGAN_AREA);
		
		if (IS_FINISH != null && !"".equals(IS_FINISH)) {
			sql.append(" and w.IS_FINISH=? ");
			typeList.add(Types.VARCHAR);
			argList.add(IS_FINISH);
		}
		if (applyDateQ != null && !"".equals(applyDateQ)) {
			sql.append(" AND s.APPLY_DATE>=? ");
			typeList.add(Types.VARCHAR);
			argList.add(applyDateQ);
		}
		if (applyDateZ != null && !"".equals(applyDateZ)) {
			sql.append(" AND s.APPLY_DATE<=? ");
			typeList.add(Types.VARCHAR);
			argList.add(applyDateZ);
		}			
		if (assistanceType != null && !"".equals(assistanceType)) {
			sql.append(" AND s.ASSISTANCE_TYPE=? ");
			typeList.add(Types.VARCHAR);
			argList.add(assistanceType);
		}
		if (assistanceTypeQuery != null && !"".equals(assistanceTypeQuery)) {
			sql.append(" AND s.ASSISTANCE_TYPE=? ");
			typeList.add(Types.VARCHAR);
			argList.add(assistanceTypeQuery);
		}
		
		sql.append(" order by w.IS_FINISH,s.APPLY_DATE desc");
		if(typeList.size()==argList.size() && typeList.size()!=0){
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = argList.toArray(new Object[argList.size()]);
			return executeDataset(sql.toString(), types, args, pset.getPageStart(), pset.getPageLimit(), true);
		}else{
			return executeDataset(sql.toString(), pset.getPageStart(), pset.getPageLimit(), true);
		}
	}
	
	public String queryPeopleId(String sureyId) {
		StringBuffer sql=new StringBuffer();
		sql.append("SELECT PEOPLE_ID FROM SAM_ESUREY_PEOPLE WHERE 1=1   ");
		sql.append(" AND SURVEY_ID='");
		sql.append(sureyId);
		sql.append("'");
		String peopleId = (String)((Map)executeQuery(sql.toString()).get(0)).get("PEOPLE_ID");
		return peopleId;
}

	public String queryOrganNameByArea(String organArea) {
		String sql = "select t.NAME from dic_city t where t.id='"+organArea+"'";
		Map map = (Map) this.executeQuery(sql).get(0);
		String organName = (String) map.get("NAME");
		return organName+"民政局";
	}	
	/**
	 * 经济中心设置
	 * @param organArea
	 * @return
	 */
	public String queryCenterNameByArea(String organArea) {
		String sql = "select t.NAME from dic_city t where t.id='"+organArea+"'";
		Map map = (Map) this.executeQuery(sql).get(0);
		String organName = (String) map.get("NAME");
		return organName+"经济核对中心";
	}	
	public DataSet queryWfHisAndResult(ParameterSet pset){
		String name = (String) pset.getParameter("NAME");
		String idCard = (String) pset.getParameter("ID_CARD");
		String opinionCode = (String) pset.getParameter("OPINION_CODE");
		String assistanceType = (String) pset.getParameter("ASSISTANCE_TYPE");
		String organArea = (String) pset.getParameter("ORGAN_AREA");
		String organType = (String) pset.getParameter("ORGAN_TYPE");
		String createOrgan="";
		if (organArea.substring(4, 12).equals("00000000")) {
			createOrgan = organArea.substring(0, 4)+"%";
		} else if (organArea.substring(6, 12).equals("000000")|| organArea.substring(6, 12) == "000000") {
			createOrgan = organArea.substring(0, 6)+"%";
		} else {
			createOrgan = organArea;
		}
		 
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		sql.append("select w.APPLY_TITLE,");
		sql.append("w.NAME,");	
		sql.append("w.ID_CARD,");
		sql.append("w.DOMICILE_CODE,");
		sql.append("w.APANAGE_CODE,");
		sql.append("w.ASSISTANCE_TYPE,");
		sql.append("s.APPLY_DATE,");
		sql.append("h.OPINION_CODE,");
		sql.append("h.CUR_ACTIVITY_ST,");
		sql.append("h.CUR_ACTIVITY_ET,");
		sql.append("r.SURVEY_RESULT,");
		sql.append("r.SIGN_ORGAN,");
		sql.append("r.SIGN_DATE ");
		sql.append("from sam_surey              s,");
		sql.append("sam_surey_wf                w,");
		sql.append("sam_surey_wf_his            h,");
		sql.append("sam_surey_wf_assistance_his r ");
		sql.append("where 1=1");
		if(!"".equals(createOrgan) && createOrgan!=null){
			sql.append(" and h.activity_organ_area like ?");
			typeList.add(Types.VARCHAR);
			argList.add(createOrgan);
		}
		if(!"".equals(organType) && organType!=null){
			sql.append(" and h.activity_organ_type = ?");
			typeList.add(Types.VARCHAR);
			argList.add(organType);
		}
		sql.append(" and s.survey_id =w.survey_id ");
		sql.append(" and r.his_id = h.his_id(+)");
		sql.append(" and h.flow_id = w.flow_id(+)");
		if(!"".equals(name) && name!=null){
			sql.append(" and w.name = ?");
			typeList.add(Types.VARCHAR);
			argList.add(name);
		}
		if(!"".equals(idCard) && idCard!=null){
			sql.append(" and w.id_card = ?");
			typeList.add(Types.VARCHAR);
			argList.add(idCard);
		}
		if(!"".equals(assistanceType) && assistanceType!=null){
			sql.append(" and w.assistance_type = ?");
			typeList.add(Types.VARCHAR);
			argList.add(assistanceType);
		}
		if(!"".equals(opinionCode) && opinionCode!=null){
			sql.append(" and h.opinion_code = ?");
			typeList.add(Types.VARCHAR);
			argList.add(opinionCode);
		}
		sql.append(" ORDER BY h.CUR_ACTIVITY_ET DESC");
		if(typeList.size()==argList.size() && typeList.size()!=0){
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = argList.toArray(new Object[argList.size()]);
			return executeDataset(sql.toString(), types, args, pset.getPageStart(), pset.getPageLimit(), true);
		}else{
			return executeDataset(sql.toString(), pset.getPageStart(), pset.getPageLimit(), true);
		}
	}
	
}
