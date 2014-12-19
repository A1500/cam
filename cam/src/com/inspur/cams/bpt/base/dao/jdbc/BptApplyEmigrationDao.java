package com.inspur.cams.bpt.base.dao.jdbc;

import java.sql.Types;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import com.inspur.cams.bpt.base.dao.IBptApplyEmigrationDao;
import com.inspur.cams.bpt.base.data.BptApplyEmigration;
import com.inspur.cams.bpt.util.BptConstant;
import com.inspur.cams.bpt.util.FilterLimit;

import flex.messaging.io.ArrayList;
/**
 * @description:优抚_抚恤关系跨省迁出
 * @author:
 * @since:2011-07-29
 * @version:1.0
*/
 public class BptApplyEmigrationDao extends EntityDao<BptApplyEmigration> implements IBptApplyEmigrationDao{

 	public BptApplyEmigrationDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class<BptApplyEmigration> getEntityClass() {
		return BptApplyEmigration.class;
	}
   
   /**
	 * 查询未提交的伤残人员抚恤关系跨省迁出人员列表
	 * @param pset
	 * @return
	 */
	public DataSet queryUnCommiDisaEmigrate(ParameterSet pset){
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT C.FULL_NAME AS DOMI_NAME, P.FAMILY_ID AS FAMILY_ID, P.NAME, P.SEX,\n");
		sql.append("       P.NATION, P.ID_CARD, P.DISABILITY_NO, P.DISABILITY_STATE_CODE,\n"); 
		sql.append("       B.DISABILITY_TYPE_CODE, D.DISABILITY_LEVEL_CODE,\n"); 
		sql.append("       D.DISABILITY_CASE_CODE, D.DISABILITY_GENUS_CODE, D.PEOPLE_ID,\n"); 
		sql.append("       A.APPLY_ID, A.SERVICE_TYPE N\n"); 
		sql.append("  FROM BASEINFO_PEOPLE P, BPT_PEOPLE B, BPT_PEOPLE_DISABILITY D, DIC_CITY C,\n"); 
		sql.append("       BPT_APPLY_EMIGRATION A\n"); 
		sql.append(" WHERE P.PEOPLE_ID = B.PEOPLE_ID AND B.PEOPLE_ID = D.PEOPLE_ID AND\n"); 
		sql.append("       P.PEOPLE_ID = A.PEOPLE_ID AND P.DISABILITY_FLAG = '1' AND\n"); 
		sql.append("       P.DOMICILE_CODE = C.ID AND A.COMMIT_FLAG = '0'");

		String organCode = (String)pset.getParameter("organCode");
		sql.append(" AND A.SERVICE_TYPE = ? ");
		
		organCode =FilterLimit.filterByOrganCode(sql,organCode);
		
		return this.executeDataset(sql.toString(),new int[]{Types.VARCHAR,Types.VARCHAR},new Object[]{BptConstant.BPT_DISABILITY_EMIGRATION,organCode}, pset.getPageStart(), pset.getPageLimit(), true);
	}
	
	/**
	 * 查询未提交的三属人员抚恤关系跨省迁出人员列表
	 * @param pset
	 * @return
	 */
	public DataSet queryUncommitDependent(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT A.SERVICE_TYPE, A.APPLY_ID, P.PEOPLE_ID AS PEOPLE_ID,FAMILY_ID,DOMICILE_CODE,P.NAME AS NAME,");
		sql.append(" D.LEZSW_SEX,ID_CARD, SEX,NATION,DOMICILE_TYPE,DEPENDANT_TYPE_CODE,D.REG_TIME,");
		sql.append(" P.DEPENDANT_STATE_CODE,LEZSW_NAME,LEZSW_APPROVE_DATE,C.FULL_NAME AS DICNAME,D.NOTE");
		sql.append(" FROM BASEINFO_PEOPLE P, BPT_PEOPLE_DEPENDANT D, BPT_PEOPLE T,DIC_CITY C,BPT_APPLY_EMIGRATION A");
		sql.append(" WHERE P.PEOPLE_ID = D.PEOPLE_ID AND D.PEOPLE_ID = T.PEOPLE_ID AND DOMICILE_CODE = C.ID AND A.PEOPLE_ID= D.PEOPLE_ID");
		sql.append(" AND P.DEPENDANT_FLAG = '1' AND P.PERSONAL_STATS_TAG != '4' AND A.COMMIT_FLAG='0' ");
		sql.append(" AND A.SERVICE_TYPE = ? ");
		String organCode = (String) pset.getParameter("organCode");
		organCode =FilterLimit.filterByOrganCode(sql,organCode);
		return this.executeDataset(sql.toString(),new int[]{Types.VARCHAR,Types.VARCHAR},new Object[]{BptConstant.BPT_DEPENDANT_EMIGRATION,organCode}, pset.getPageStart(),pset.getPageLimit(),true);
	}
	//******************************************参战人员跨省迁出*****************************************************
	/**
	 * 查询未提交的参战人员跨省迁出列表
	 * @param pset
	 * @return
	 */
	public DataSet queryUnComWarEmigrate(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		
		sql.append("SELECT C.NAME AS DOMI_NAME, P.FAMILY_ID AS FAMILY_ID,\n");
		sql.append("       P.PEOPLE_ID AS PEOPLE_ID, P.NAME, P.SEX, P.NATION, P.ID_CARD,\n"); 
		sql.append("       A.APPLY_ID, A.SERVICE_TYPE, W.FORCES_NO, W.POSITION, W.ASDP_NO,\n"); 
		sql.append("       W.WAR_TYPE_CODE\n"); 
		sql.append("  FROM BASEINFO_PEOPLE P, BPT_PEOPLE B, BPT_PEOPLE_WAR W, DIC_CITY C,\n"); 
		sql.append("       BPT_APPLY_EMIGRATION A\n"); 
		sql.append(" WHERE P.PEOPLE_ID = B.PEOPLE_ID AND B.PEOPLE_ID = W.PEOPLE_ID AND\n"); 
		sql.append("       P.PEOPLE_ID = A.PEOPLE_ID AND P.WAR_FLAG = '1' AND\n"); 
		sql.append("       P.DOMICILE_CODE = C.ID AND A.COMMIT_FLAG = '0'");
	
		String organCode = (String)pset.getParameter("organCode");
		sql.append(" AND A.SERVICE_TYPE = ? ");
		organCode =FilterLimit.filterByOrganCode(sql,organCode);
		return this.executeDataset(sql.toString(),new int[]{Types.VARCHAR,Types.VARCHAR},new Object[]{BptConstant.BPT_WAR_EMIGRATION,organCode}, pset.getPageStart(), pset.getPageLimit(), true);
	 }
	
	
	public DataSet queryWarDetailByPeopleId(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT B.PEOPLE_ID, B.FAMILY_ID, B.ID_CARD, B.SEX, B.NAME, W.WAR_TYPE_CODE,\n");
		sql.append("       W.FORCES_NO, W.POSITION, W.ASDP_NO, BEM.ALLOWANCE_MONTH,\n"); 
		sql.append("       BEM.TOWN_CHECK_PHONE, BEM.INGOING_ADDRESS\n"); 
		sql.append("  FROM BASEINFO_PEOPLE B, BPT_PEOPLE_WAR W, BPT_APPLY_EMIGRATION BEM\n"); 
		sql.append(" WHERE B.PEOPLE_ID = W.PEOPLE_ID AND BEM.PEOPLE_ID = B.PEOPLE_ID");
//		String idCard = (String)pset.getParameter("idCard");
		String peopleId = (String)pset.getParameter("peopleId");
//		String applyId = (String)pset.getParameter("applyId");
//		String familyId = (String)pset.getParameter("familyId");
		if(StringUtils.isNotEmpty(peopleId)){
			sql.append(" AND BEM.PEOPLE_ID= ? ");
		}
		return super.executeDataset(sql.toString(),new int[]{Types.VARCHAR},new Object[]{peopleId}, true);
	}
	
	//******************************************参战人员跨省迁出*****************************************************

	/**
	 * 查询未提交的参试人员跨省迁出列表
	 * @param pset
	 * @return
	 */
	public DataSet queryUncommitTested(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT A.SERVICE_TYPE, A.APPLY_ID, P.PEOPLE_ID AS PEOPLE_ID,FAMILY_ID,DOMICILE_CODE, P.NAME AS NAME,ID_CARD,");
		sql.append(" SEX,NATION,DOMICILE_TYPE, D.DISABILITY_LEVEL_CODE,D.FORCES_NO,D.REG_TIME,");
		sql.append(" D.TESTED_TYPE,C.FULL_NAME AS DICNAME,D.NOTE");
		sql.append(" FROM BASEINFO_PEOPLE P, BPT_PEOPLE_TESTED D, BPT_PEOPLE T, DIC_CITY C,BPT_APPLY_EMIGRATION A");
		sql.append(" WHERE P.PEOPLE_ID = D.PEOPLE_ID AND D.PEOPLE_ID = T.PEOPLE_ID");
		sql.append(" AND DOMICILE_CODE = C.ID  AND P.WAR_FLAG = '1'  AND A.PEOPLE_ID = P.PEOPLE_ID");
		sql.append(" AND P.PERSONAL_STATS_TAG != '4' AND T.WAR_TYPE_CODE='61' ");
		sql.append(" AND A.COMMIT_FLAG='0' ");
		sql.append(" AND A.SERVICE_TYPE = ? ");
		String organCode = (String) pset.getParameter("organCode");
		organCode =FilterLimit.filterByOrganCode(sql,organCode);
		return this.executeDataset(sql.toString(),new int[]{Types.VARCHAR,Types.VARCHAR},new Object[]{BptConstant.BPT_TESTED_EMIGRATION,organCode}, pset.getPageStart(), pset.getPageLimit(), true);
	}
	
	
	
	/**
	 * 查询抚恤关系跨省迁出
	 * @param pset
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public DataSet queryEmigration(ParameterSet pset) {
		DataSet ds = new DataSet();
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT A.SERVICE_TYPE, A.APPLY_ID, P.PEOPLE_ID AS PEOPLE_ID,FAMILY_ID,DOMICILE_CODE,P.NAME AS NAME,");
		sql.append(" ID_CARD, SEX,NATION,D.NAME AS OBJECT_NAME, C.FULL_NAME AS DICNAME ");
		sql.append(" FROM BASEINFO_PEOPLE P ,DIC_CITY C,BPT_APPLY_EMIGRATION A,DIC_BPT_SERVICE_TYPE D");
		sql.append(" WHERE P.PEOPLE_ID = A.PEOPLE_ID  AND DOMICILE_CODE = C.ID AND D.CODE=A.SERVICE_TYPE");
		sql.append(" AND P.PERSONAL_STATS_TAG != '4' AND A.COMMIT_FLAG='0' ");
		 
		List typeList = new ArrayList();
		List<Object> argsList = new ArrayList();
		
		String organCode = (String) pset.getParameter("organCode");
		
		organCode =FilterLimit.filterByOrganCode(sql,organCode);	
		
		typeList.add(Types.VARCHAR);
		argsList.add(organCode);
		
		sql.append(" ORDER BY P.DOMICILE_CODE,A.SERVICE_TYPE");
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
