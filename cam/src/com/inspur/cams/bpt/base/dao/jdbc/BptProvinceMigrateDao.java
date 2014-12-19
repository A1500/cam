package com.inspur.cams.bpt.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.bpt.base.dao.IBptProvinceMigrateDao;
import com.inspur.cams.bpt.base.data.BptProvinceMigrate;
import com.inspur.cams.bpt.util.BptConstant;
import com.inspur.cams.bpt.util.FilterLimit;
/**
 * @description:优抚人员省内迁移
 * @author:
 * @since:2011-08-04
 * @version:1.0
*/
 public class BptProvinceMigrateDao extends EntityDao<BptProvinceMigrate> implements IBptProvinceMigrateDao{

 	public BptProvinceMigrateDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class<BptProvinceMigrate> getEntityClass() {
		return BptProvinceMigrate.class;
	}
   
   /**
	 * 查询未提交的伤残人员省内迁移列表
	 * @param pset
	 * @return
	 */
	public DataSet queryUnCommiDisaProvinceEmigrate(ParameterSet pset){
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT C.NAME AS DOMI_NAME, P.FAMILY_ID AS FAMILY_ID, P.NAME, P.SEX,\n");
		sql.append("       P.NATION, P.ID_CARD, P.DISABILITY_NO, P.DISABILITY_STATE_CODE,\n"); 
		sql.append("       B.DISABILITY_TYPE_CODE, D.DISABILITY_LEVEL_CODE,\n"); 
		sql.append("       D.DISABILITY_CASE_CODE, D.DISABILITY_GENUS_CODE, D.PEOPLE_ID,\n"); 
		sql.append("       A.APPLY_ID, A.SERVICE_TYPE N +\n"); 
		sql.append("  FROM BASEINFO_PEOPLE P, BPT_PEOPLE B, BPT_PEOPLE_DISABILITY D, DIC_CITY C,\n"); 
		sql.append("       BPT_PROVINCE_MIGRATE A\n"); 
		sql.append(" WHERE P.PEOPLE_ID = B.PEOPLE_ID AND B.PEOPLE_ID = D.PEOPLE_ID AND\n"); 
		sql.append("       P.PEOPLE_ID = A.PEOPLE_ID AND P.DISABILITY_FLAG = '1' AND\n"); 
		sql.append("       P.DOMICILE_CODE = C.ID AND A.COMMIT_FLAG = '0'");
		String organCode = (String)pset.getParameter("organCode");
		sql.append(" AND A.SERVICE_TYPE = ? ");
		organCode=FilterLimit.filterByOrganCode(sql,organCode);	
		return this.executeDataset(sql.toString(),new int[]{Types.VARCHAR,Types.VARCHAR},new Object[]{BptConstant.BPT_DISABILITY_PROVINCEMIGRATION,organCode}, pset.getPageStart(), pset.getPageLimit(), true);
	}
	//***************************************s参战**********************************************************
	/**
	 * 查询未提交的参战人员省内迁移列表
	 * @param pset
	 * @return
	 */
	public DataSet queryUnComWarProvinceEmigrate(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT C.NAME AS DOMI_NAME, P.FAMILY_ID AS FAMILY_ID,\n");
		sql.append("       P.PEOPLE_ID AS PEOPLE_ID, P.NAME, P.SEX, P.NATION, P.ID_CARD,\n"); 
		sql.append("       A.APPLY_ID, A.SERVICE_TYPE, W.FORCES_NO, W.POSITION, W.ASDP_NO,\n"); 
		sql.append("       W.WAR_TYPE_CODE\n"); 
		sql.append("  FROM BASEINFO_PEOPLE P, BPT_PEOPLE B, BPT_PEOPLE_WAR W, DIC_CITY C,\n"); 
		sql.append("       BPT_PROVINCE_MIGRATE A\n"); 
		sql.append(" WHERE P.PEOPLE_ID = B.PEOPLE_ID AND B.PEOPLE_ID = W.PEOPLE_ID AND\n"); 
		sql.append("       P.PEOPLE_ID = A.PEOPLE_ID AND P.WAR_FLAG = '1' AND\n"); 
		sql.append("       P.DOMICILE_CODE = C.ID AND A.COMMIT_FLAG = '0'");
		String organCode = (String)pset.getParameter("organCode");
		sql.append(" AND A.SERVICE_TYPE = ? ");
		organCode=FilterLimit.filterByOrganCode(sql,organCode);	
		return this.executeDataset(sql.toString(),new int[]{Types.VARCHAR,Types.VARCHAR},new Object[]{BptConstant.BPT_WAR_PROVINCEMIGRATION,organCode}, pset.getPageStart(), pset.getPageLimit(), true);
	 }
	//参战人员详细信息列表
	public DataSet queryWarDetail(ParameterSet pset) {
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT B.PEOPLE_ID, B.FAMILY_ID, B.DOMICILE_CODE, B.NAME, B.ID_CARD, B.SEX,\n");
		sql.append("       B.NATION, B.DOMICILE_TYPE, W.FORCES_NO, W.POSITION, W.WAR_TYPE_CODE,\n"); 
		sql.append("       W.ENJOY_MON, W.LIFE_STATE_CODE, W.HEALTH_STATE_CODE,\n"); 
		sql.append("       W.CONSCRIPTC_DATE, W.DECRUITMENT_DATE, W.ASDP_NO, W.NOTE,\n"); 
		sql.append("       C.FULL_NAME AS DOMI_NAME\n"); 
		sql.append("  FROM BASEINFO_PEOPLE B, BPT_PEOPLE_WAR W, DIC_CITY C\n"); 
		sql.append(" WHERE B.PEOPLE_ID = W.PEOPLE_ID AND B.WAR_FLAG = '1' AND\n"); 
		sql.append("       B.DOMICILE_CODE = C.ID AND\n"); 
		sql.append("       B.PERSONAL_STATS_TAG != '4'");
		String domicileCode = (String)pset.getParameter("domicileCode");
		String organCode = (String) pset.getParameter("organCode");
		String idCard = (String)pset.getParameter("idCard");
		String name = (String) pset.getParameter("name");
		String domicileType = (String)pset.getParameter("domicileType");
		String warTypeCode = (String) pset.getParameter("warTypeCode");
		String forcesNo = (String) pset.getParameter("forcesNo");
		String position = (String)pset.getParameter("position");
//		String enjoyMon = (String) pset.getParameter("enjoyMon");
		String asdpNo = (String) pset.getParameter("asdpNo");
		String warStateCode = (String)pset.getParameter("warStateCode");
		if(StringUtils.isNotEmpty(warStateCode)){
			sql.append(" AND B.WAR_STATE_CODE= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(warStateCode);
		}
		if(StringUtils.isNotEmpty(name)){
			sql.append("AND B.NAME like '%' || ? || '%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(name);
		}
		if(StringUtils.isNotEmpty(idCard)){
			sql.append("AND B.ID_CARD= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(idCard);
		}
		if(StringUtils.isNotEmpty(domicileType)){
			sql.append("AND B.DOMICILE_TYPE= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(domicileType);
		}
		if(StringUtils.isNotEmpty(warTypeCode)){
			sql.append("AND W.WAR_TYPE_CODE= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(warTypeCode);
		}
		if(StringUtils.isNotEmpty(forcesNo)){
			sql.append("AND W.FORCES_NO= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(forcesNo);
		}
		if(StringUtils.isNotEmpty(position)){
			sql.append("AND W.POSITION= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(position);
		}
		if(StringUtils.isNotEmpty(asdpNo)){
			sql.append("AND W.ASDP_NO= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(asdpNo);
		}
		if (StringUtils.isNotEmpty(domicileCode)) {
			if(domicileCode.substring(9, 12).equals("000")){
				sql.append(" AND B.DOMICILE_CODE like ? ");//市局
				argsList.add(domicileCode.substring(0, 9)+"%");
			}else{
				sql.append(" AND B.DOMICILE_CODE= ? ");//区县
				argsList.add(domicileCode);
			}
		}else{
			organCode=FilterLimit.filterByOrganCode(sql,organCode);
			argsList.add(organCode);
		}
		typeList.add(Types.VARCHAR);
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = executeDataset(sql.toString(),types,args,pset.getPageStart(), pset.getPageLimit(), true);;
		}
		return ds;
	}

	public DataSet queryWarDetailByIdCard(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT B.PEOPLE_ID, B.FAMILY_ID, B.ID_CARD, B.SEX, B.NAME, W.WAR_TYPE_CODE,\n");
		sql.append("       W.FORCES_NO, W.POSITION, W.ASDP_NO\n"); 
		sql.append("  FROM BASEINFO_PEOPLE B, BPT_PEOPLE_WAR W\n"); 
		sql.append(" WHERE B.PEOPLE_ID = W.PEOPLE_ID");
		String idCard = (String)pset.getParameter("idCard");
		if(StringUtils.isNotEmpty(idCard)){
			sql.append("AND b.ID_CARD= ? ");
		}
		return super.executeDataset(sql.toString(),new int[]{Types.VARCHAR},new Object[]{idCard}, true);
	}
	
	
	public DataSet queryWarEProvinceByPeopleId(ParameterSet pset) {
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT B.PEOPLE_ID, B.FAMILY_ID, B.ID_CARD, B.SEX, B.NAME, W.WAR_TYPE_CODE,\n");
		sql.append("       W.FORCES_NO, W.POSITION, W.ASDP_NO\n"); 
		sql.append("  FROM BASEINFO_PEOPLE B, BPT_PEOPLE_WAR W\n"); 
		sql.append(" WHERE B.PEOPLE_ID = W.PEOPLE_ID  \n"); 
		String peopleId = (String)pset.getParameter("peopleId");
		if(StringUtils.isNotEmpty(peopleId)){
			sql.append(" AND W.PEOPLE_ID= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(peopleId);
		}
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = executeDataset(sql.toString(),types,args,true);
		}
		return ds;
	}
	
	public DataSet queryWarDetailByPeopleId(ParameterSet pset) {
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT B.PEOPLE_ID, B.FAMILY_ID, B.ID_CARD, B.SEX, B.NAME, W.WAR_TYPE_CODE,\n");
		sql.append("       W.FORCES_NO, W.POSITION, W.ASDP_NO, BM.ALLOWANCE_MONTH,\n"); 
		sql.append("       BM.OUT_TOWN_CHECK_PHONE, BM.INGOING_CODE, C.NAME AS INGOING_NAME\n"); 
		sql.append("  FROM BASEINFO_PEOPLE B, BPT_PEOPLE_WAR W, BPT_PROVINCE_MIGRATE BM,\n"); 
		sql.append("       DIC_CITY C\n"); 
		sql.append(" WHERE B.PEOPLE_ID = W.PEOPLE_ID AND BM.PEOPLE_ID = B.PEOPLE_ID AND\n"); 
		sql.append("       BM.INGOING_CODE = C.ID");
		String idCard = (String)pset.getParameter("idCard");
		String peopleId = (String)pset.getParameter("peopleId");
		String applyId = (String)pset.getParameter("applyId");
		String familyId = (String)pset.getParameter("familyId");
		if(StringUtils.isNotEmpty(idCard)){
			sql.append(" AND B.ID_CARD= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(idCard);
		}
		if(StringUtils.isNotEmpty(peopleId)){
			sql.append(" AND W.PEOPLE_ID= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(peopleId);
		}
		if(StringUtils.isNotEmpty(applyId)){
			sql.append(" ANxY_ID= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(applyId);
		}
		if(StringUtils.isNotEmpty(familyId)){
			sql.append(" AND B.FAMILY_ID= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(familyId);
		}
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = executeDataset(sql.toString(),types,args,true);
		}
		return ds;
	}
	
	/**
	 * 查询添加参战抚恤省内迁移信息
	 */
	public DataSet queryWarMigrateAddPeopleId(ParameterSet pset) {
		String peopleId = (String)pset.getParameter("peopleId");
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT B.PEOPLE_ID, B.FAMILY_ID, B.ID_CARD, B.SEX, B.NAME, W.WAR_TYPE_CODE,\n");
		sql.append("       W.FORCES_NO, W.POSITION, W.ASDP_NO\n"); 
		sql.append("  FROM BASEINFO_PEOPLE B, BPT_PEOPLE_WAR W, BPT_PEOPLE P\n"); 
		sql.append(" WHERE B.PEOPLE_ID = W.PEOPLE_ID AND W.PEOPLE_ID = P.PEOPLE_ID AND\n"); 
		sql.append("       B.PEOPLE_ID = ?");
		return executeDataset(sql.toString(),new int[]{Types.VARCHAR},new Object[]{peopleId}, true);
	}
	
	//***************************************e参战**********************************************************
	
	/**
	 * 查询未提交的三属人员省内迁移列表
	 * @param pset
	 * @return
	 */
	public DataSet queryUnCommiDependProEmigrate(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT A.SERVICE_TYPE, A.APPLY_ID, P.PEOPLE_ID AS PEOPLE_ID,FAMILY_ID,DOMICILE_CODE,P.NAME AS NAME,");
		sql.append(" D.LEZSW_SEX,ID_CARD, SEX,NATION,DOMICILE_TYPE,DEPENDANT_TYPE_CODE,D.REG_TIME,");
		sql.append(" P.DEPENDANT_STATE_CODE,LEZSW_NAME,LEZSW_APPROVE_DATE,C.FULL_NAME AS DICNAME,D.NOTE");
		sql.append(" FROM BASEINFO_PEOPLE P, BPT_PEOPLE_DEPENDANT D, BPT_PEOPLE T,DIC_CITY C,BPT_PROVINCE_MIGRATE A");
		sql.append(" WHERE P.PEOPLE_ID = D.PEOPLE_ID AND D.PEOPLE_ID = T.PEOPLE_ID AND DOMICILE_CODE = C.ID AND A.PEOPLE_ID= D.PEOPLE_ID");
		sql.append(" AND P.DEPENDANT_FLAG = '1' AND P.PERSONAL_STATS_TAG != '4' AND A.COMMIT_FLAG='0' ");
		sql.append(" AND A.SERVICE_TYPE = '"+BptConstant.BPT_DEPENDANT_PROVINCEMIGRATION+"'");
		String organCode = (String) pset.getParameter("organCode");
		organCode=FilterLimit.filterByOrganCode(sql,organCode);	
		sql.append("order by p.domicile_code");
		return this.executeDataset(sql.toString(),new int[]{Types.VARCHAR},new Object[]{organCode},pset.getPageStart(),pset.getPageLimit(), true);
	}
	//***************************************在乡【start】**********************************************************
	/**
	 * 查询未提交的在乡人员省内迁移列表
	 * @param pset
	 * @return
	 */
	public DataSet queryUnCommiDemoProvinceEmigrate(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT C.NAME AS DOMI_NAME, P.FAMILY_ID AS FAMILY_ID, P.NAME, P.SEX,\n");
		sql.append("       P.NATION, P.ID_CARD, D.BELONGDATE, D.PEOPLE_ID, A.APPLY_ID,\n"); 
		sql.append("       P.DEMOBILIZED_NO, P.TEL_MOBILE, P.NOTE, D.CONSCRIPT_DATE,\n"); 
		sql.append("       D.DECRUITMENT_DATE, A.SERVICE_TYPE\n"); 
		sql.append("  FROM BASEINFO_PEOPLE P, BPT_PEOPLE B, BPT_PEOPLE_DEMOBILIZED D, DIC_CITY C,\n"); 
		sql.append("       BPT_PROVINCE_MIGRATE A\n"); 
		sql.append(" WHERE P.PEOPLE_ID = B.PEOPLE_ID AND B.PEOPLE_ID = D.PEOPLE_ID AND\n"); 
		sql.append("       P.PEOPLE_ID = A.PEOPLE_ID AND P.DOMICILE_CODE = C.ID AND\n"); 
		sql.append("       A.COMMIT_FLAG = '0'");
	    String organCode = (String)pset.getParameter("organCode");
		sql.append(" AND A.SERVICE_TYPE = ? ");
		organCode=FilterLimit.filterByOrganCode(sql,organCode);	
		return this.executeDataset(sql.toString(),new int[]{Types.VARCHAR,Types.VARCHAR},new Object[]{BptConstant.BPT_DEMOBILIZED_PROVINCEMIGRATION,organCode}, pset.getPageStart(), pset.getPageLimit(), true);
	}

	public DataSet queryDemoDetailByPeopleId(ParameterSet pset) {
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT B.PEOPLE_ID, B.FAMILY_ID, B.ID_CARD, B.SEX, B.NAME, T.FORCES_NO,\n");
		sql.append("       T.POSITION, T.ASDP_NO, B.NATION, B.BIRTHDAY, BM.ALLOWANCE_MONTH,\n"); 
		sql.append("       BM.OUT_TOWN_CHECK_PHONE, BM.INGOING_CODE, C.NAME AS INGOING_NAME,\n"); 
		sql.append("       T.IS_KOREANWAR, T.BELONGDATE, T.CONSCRIPT_DATE, T.DECRUITMENT_DATE\n"); 
		sql.append("  FROM BASEINFO_PEOPLE B, BPT_PEOPLE_DEMOBILIZED T, BPT_PROVINCE_MIGRATE BM,\n"); 
		sql.append("       DIC_CITY C\n"); 
		sql.append(" WHERE B.PEOPLE_ID = T.PEOPLE_ID AND BM.PEOPLE_ID = B.PEOPLE_ID AND\n"); 
		sql.append("       BM.INGOING_CODE = C.ID");
		String idCard = (String)pset.getParameter("idCard");
		String peopleId = (String)pset.getParameter("peopleId");
		String applyId = (String)pset.getParameter("applyId");
		String familyId = (String)pset.getParameter("familyId");
		if(StringUtils.isNotEmpty(idCard)){
			sql.append(" AND B.ID_CARD= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(idCard);
		}
		if(StringUtils.isNotEmpty(peopleId)){
			sql.append(" AND T.PEOPLE_ID= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(peopleId);
		}
		if(StringUtils.isNotEmpty(applyId)){
			sql.append(" AND BM.APPLY_ID= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(applyId);
		}
		if(StringUtils.isNotEmpty(familyId)){
			sql.append(" AND B.FAMILY_ID= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(familyId);
		}
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds =  executeDataset(sql.toString(),types,args, true);
		}
		return ds;
	}
	
	/**
	 * 查询未提交的参试人员省内迁移列表
	 */
	public DataSet queryUncommitTestProEmigrate(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT A.SERVICE_TYPE, A.APPLY_ID, P.PEOPLE_ID AS PEOPLE_ID,FAMILY_ID,DOMICILE_CODE, P.NAME AS NAME,ID_CARD,");
		sql.append(" SEX,NATION,DOMICILE_TYPE, D.DISABILITY_LEVEL_CODE,D.FORCES_NO,D.REG_TIME,");
		sql.append(" D.TESTED_TYPE,C.FULL_NAME AS DICNAME,D.NOTE");
		sql.append(" FROM BASEINFO_PEOPLE P, BPT_PEOPLE_TESTED D, BPT_PEOPLE T, DIC_CITY C,BPT_PROVINCE_MIGRATE A");
		sql.append(" WHERE P.PEOPLE_ID = D.PEOPLE_ID AND D.PEOPLE_ID = T.PEOPLE_ID");
		sql.append(" AND DOMICILE_CODE = C.ID  AND P.WAR_FLAG = '1'  AND A.PEOPLE_ID = P.PEOPLE_ID");
		sql.append(" AND P.PERSONAL_STATS_TAG != '4' AND T.WAR_TYPE_CODE='61' ");
		sql.append(" AND A.COMMIT_FLAG='0' ");
		sql.append(" AND A.SERVICE_TYPE = ? ");
		String organCode = (String) pset.getParameter("organCode");
		organCode=FilterLimit.filterByOrganCode(sql,organCode);
		return this.executeDataset(sql.toString(),new int[]{Types.VARCHAR,Types.VARCHAR},new Object[]{BptConstant.BPT_TESTED_PROVINCEMIGRATION,organCode}, pset.getPageStart(), pset.getPageLimit(), true);
	}
	
	/**
	 * 查询其他抚恤关系省内迁移列表
	 * @param pset
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public DataSet queryProvinceEmigrate(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		DataSet ds = new DataSet();
		sql.append(" SELECT A.SERVICE_TYPE, A.APPLY_ID, P.PEOPLE_ID AS PEOPLE_ID,FAMILY_ID,DOMICILE_CODE,P.NAME AS NAME,");
		sql.append(" ID_CARD, SEX,NATION,DOMICILE_TYPE,D.NAME AS OBJECT_NAME,");
		sql.append(" C.FULL_NAME AS DICNAME");
		sql.append(" FROM BASEINFO_PEOPLE P,DIC_CITY C,BPT_PROVINCE_MIGRATE A,DIC_BPT_SERVICE_TYPE D");
		sql.append(" WHERE P.PEOPLE_ID = A.PEOPLE_ID AND DOMICILE_CODE = C.ID AND D.CODE=A.SERVICE_TYPE");
		sql.append(" AND P.PERSONAL_STATS_TAG != '4' AND A.COMMIT_FLAG='0'");
		List typeList = new ArrayList();
		List<Object> argsList = new ArrayList();
		String organCode = (String) pset.getParameter("organCode");
		organCode=FilterLimit.filterByOrganCode(sql,organCode);
		typeList.add(Types.VARCHAR);
		argsList.add(organCode);
		sql.append(" order by p.domicile_code,a.service_type");
		if(typeList.size() != 0 && argsList.size()!= 0) {
			int[] types = new int[typeList.size()];
			for(int i=0;i<typeList.size();i++) {
				types[i]=(Integer)(typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sql.toString(),types,args,pset.getPageStart(),pset.getPageLimit(), true);
		} else {
			ds = this.executeDataset(sql.toString(), pset.getPageStart(),pset.getPageLimit(),true);
		}
		return ds;
	}
}
