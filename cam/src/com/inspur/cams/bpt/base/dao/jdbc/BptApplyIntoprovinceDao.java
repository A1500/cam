package com.inspur.cams.bpt.base.dao.jdbc;

import java.sql.Types;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.bpt.base.dao.IBptApplyIntoprovinceDao;
import com.inspur.cams.bpt.base.data.BptApplyIntoprovince;
import com.inspur.cams.bpt.util.BptConstant;
import com.inspur.cams.bpt.util.FilterLimit;

import flex.messaging.io.ArrayList;

/**
 * @description:外省优抚人员抚恤关系迁入我省
 * @author:
 * @since:2011-07-14
 * @version:1.0
*/
 public class BptApplyIntoprovinceDao extends EntityDao<BptApplyIntoprovince> implements IBptApplyIntoprovinceDao{

 	public BptApplyIntoprovinceDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class<BptApplyIntoprovince> getEntityClass() {
		return BptApplyIntoprovince.class;
	}
   
   /**
	 * 查询未发起流程的外省残疾人员抚恤关系迁入我省人员信息列表
	 */
	public DataSet queryUnCommitDisaIntoprovi(ParameterSet pset){
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT C.NAME AS DOMI_NAME, P.FAMILY_ID AS FAMILY_ID, P.NAME, P.SEX,\n");
		sql.append("       P.NATION, P.ID_CARD, P.DISABILITY_NO, P.DISABILITY_STATE_CODE,\n"); 
		sql.append("       B.DISABILITY_TYPE_CODE, D.DISABILITY_LEVEL_CODE,\n"); 
		sql.append("       D.DISABILITY_CASE_CODE, D.DISABILITY_GENUS_CODE, D.PEOPLE_ID,\n"); 
		sql.append("       A.APPLY_ID, A.SERVICE_TYPE N\n"); 
		sql.append("  FROM BASEINFO_PEOPLE P, BPT_PEOPLE B, BPT_PEOPLE_DISABILITY D, DIC_CITY C,\n"); 
		sql.append("       BPT_APPLY_INTOPROVINCE A\n"); 
		sql.append(" WHERE P.PEOPLE_ID = B.PEOPLE_ID AND B.PEOPLE_ID = D.PEOPLE_ID AND\n"); 
		sql.append("       P.PEOPLE_ID = A.PEOPLE_ID AND P.DISABILITY_FLAG = '1' AND\n"); 
		sql.append("       P.DOMICILE_CODE = C.ID AND A.COMMIT_FLAG = '0'");
		sql.append(" AND A.SERVICE_TYPE = ? ");
		
		String organCode = (String)pset.getParameter("organCode");
		organCode =FilterLimit.filterByOrganCode(sql,organCode);
		
		return this.executeDataset(sql.toString(),new int[]{Types.VARCHAR,Types.VARCHAR},new Object[]{BptConstant.BPT_DISABILITY_INGOINGPROVINCE,organCode}, pset.getPageStart(), pset.getPageLimit(), true);
	}
	

	/**
	 * 查询未提交的三属外省迁入我省信息列表
	 * @param pset
	 * @return
	 */
	public DataSet queryUncommitDependIntoprovin(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		
		sql.append(" SELECT A.OLD_PAPER_NO, A.SERVICE_TYPE, A.APPLY_ID, P.PEOPLE_ID AS PEOPLE_ID,FAMILY_ID,DOMICILE_CODE,P.NAME AS NAME,");
		sql.append(" D.LEZSW_SEX,ID_CARD, SEX,NATION,DOMICILE_TYPE,DEPENDANT_TYPE_CODE,D.REG_TIME,");
		sql.append(" P.DEPENDANT_STATE_CODE,LEZSW_NAME,LEZSW_APPROVE_DATE,C.FULL_NAME AS DICNAME,D.NOTE");
		sql.append(" FROM BASEINFO_PEOPLE P, BPT_PEOPLE_DEPENDANT D, BPT_PEOPLE T,DIC_CITY C,BPT_APPLY_INTOPROVINCE A");
		sql.append(" WHERE P.PEOPLE_ID = D.PEOPLE_ID AND D.PEOPLE_ID = T.PEOPLE_ID AND DOMICILE_CODE = C.ID AND A.PEOPLE_ID= D.PEOPLE_ID");
		sql.append(" AND P.DEPENDANT_FLAG = '1' AND P.PERSONAL_STATS_TAG != '4' AND A.COMMIT_FLAG='0'");
		sql.append(" AND A.SERVICE_TYPE = ? ");
		String organCode = (String) pset.getParameter("organCode");
		organCode =FilterLimit.filterByOrganCode(sql,organCode);
		
		return this.executeDataset(sql.toString(),new int[]{Types.VARCHAR,Types.VARCHAR},new Object[]{BptConstant.BPT_DEPENDANT_INGOINGPROVINCE,organCode}, pset.getPageStart(), pset.getPageLimit(),true);
	}
//******************************************参战迁入我省**********************************************************
	
	/**
	 * 查询未发起流程的外省参战人员抚恤关系迁入我省人员信息列表
	 */
	public DataSet queryUnCommitWarIntoprovi(ParameterSet pset){
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT C.NAME AS DOMI_NAME, P.FAMILY_ID AS FAMILY_ID,\n");
		sql.append("       P.PEOPLE_ID AS PEOPLE_ID, P.NAME, P.SEX, P.NATION, P.ID_CARD,\n"); 
		sql.append("       A.APPLY_ID, A.SERVICE_TYPE, W.FORCES_NO, W.POSITION, W.ASDP_NO,\n"); 
		sql.append("       W.WAR_TYPE_CODE\n"); 
		sql.append("  FROM BASEINFO_PEOPLE P, BPT_PEOPLE B, BPT_PEOPLE_WAR W, DIC_CITY C,\n"); 
		sql.append("       BPT_APPLY_INTOPROVINCE A\n"); 
		sql.append(" WHERE P.PEOPLE_ID = B.PEOPLE_ID AND B.PEOPLE_ID = W.PEOPLE_ID AND\n"); 
		sql.append("       P.PEOPLE_ID = A.PEOPLE_ID AND P.WAR_FLAG = '1' AND\n"); 
		sql.append("       P.DOMICILE_CODE = C.ID AND A.COMMIT_FLAG = '0'");
			
		String organCode = (String)pset.getParameter("organCode");
		sql.append(" AND A.SERVICE_TYPE = ? ");
		organCode =FilterLimit.filterByOrganCode(sql,organCode);
		return this.executeDataset(sql.toString(),new int[]{Types.VARCHAR,Types.VARCHAR},new Object[]{BptConstant.BPT_WAR_INGOINGPROVINCE,organCode}, pset.getPageStart(), pset.getPageLimit(), true);
	}
	
	
	/**
	 * 查询未提交的外省迁入我省参试抚恤关系列表
	 * 
	 */
	public DataSet queryUncommitTestedIntoprovin(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		
		sql.append(" SELECT A.OLD_PAPER_NO, A.SERVICE_TYPE, A.APPLY_ID, P.PEOPLE_ID AS PEOPLE_ID,FAMILY_ID,DOMICILE_CODE, P.NAME AS NAME,ID_CARD,");
		sql.append(" SEX,NATION,DOMICILE_TYPE, D.DISABILITY_LEVEL_CODE,D.FORCES_NO,D.REG_TIME,");
		sql.append(" D.TESTED_TYPE,C.FULL_NAME AS DICNAME,D.NOTE");
		sql.append(" FROM BASEINFO_PEOPLE P, BPT_PEOPLE_TESTED D, BPT_PEOPLE T, DIC_CITY C,BPT_APPLY_INTOPROVINCE A");
		sql.append(" WHERE P.PEOPLE_ID = D.PEOPLE_ID AND D.PEOPLE_ID = T.PEOPLE_ID");
		sql.append(" AND DOMICILE_CODE = C.ID  AND P.WAR_FLAG = '1'  AND A.PEOPLE_ID = P.PEOPLE_ID");
		sql.append(" AND P.PERSONAL_STATS_TAG != '4' AND T.WAR_TYPE_CODE='62' AND A.COMMIT_FLAG='0' ");
		sql.append(" AND A.SERVICE_TYPE = ? ");
		String organCode = (String) pset.getParameter("organCode");
		organCode =FilterLimit.filterByOrganCode(sql,organCode);
		return this.executeDataset(sql.toString(),new int[]{Types.VARCHAR,Types.VARCHAR},new Object[]{BptConstant.BPT_TESTED_INGOINGPROVINCE,organCode},  pset.getPageStart(), pset.getPageLimit(), true);
	}
   
	
	/**
	 * 查询抚恤关系外省迁入
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public DataSet queryIntoprovin(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		DataSet ds = new DataSet();
		sql.append(" SELECT A.SERVICE_TYPE, A.APPLY_ID, P.PEOPLE_ID AS PEOPLE_ID,FAMILY_ID,DOMICILE_CODE,P.NAME AS NAME,");
		sql.append(" ID_CARD, SEX,NATION,D.NAME AS OBJECT_NAME,C.FULL_NAME AS DICNAME");
		sql.append(" FROM BASEINFO_PEOPLE P,DIC_CITY C,BPT_APPLY_INTOPROVINCE A,DIC_BPT_SERVICE_TYPE D");
		sql.append(" WHERE P.PEOPLE_ID = A.PEOPLE_ID AND DOMICILE_CODE = C.ID AND D.CODE=A.SERVICE_TYPE");
		sql.append(" AND P.PERSONAL_STATS_TAG != '4' AND A.COMMIT_FLAG='0'");
		 
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
	public void deleteIntoprovince(ParameterSet pset){
		 String applyId = (String)pset.getParameter("applyId");
		   String peopleId = (String)pset.getParameter("peopleId");
		   String disType = (String)pset.getParameter("type");
		   int[] type = new int[1];
		   Object[] applyid = new Object[1];
		   Object[] peopleid = new Object[1];
		   type[0]=Types.VARCHAR;
		   applyid[0] = applyId;
		   peopleid[0] = peopleId;
		   StringBuffer sql = new StringBuffer();
		   
		   if("15".equals(disType)){//残疾
			   sql.append("UPDATE BASEINFO_PEOPLE B SET B.DISABILITY_FLAG='0',");
			   sql.append("b.DISABILITY_LEVEL_CODE='',");
			   sql.append("b.DISABILITY_CASE_CODE='',");
			   sql.append("b.DISABILITY_NO='',");
			   sql.append("b.DISABILITY_STATE_CODE='0' ");
			   sql.append("WHERE PEOPLE_ID=?");
			   this.executeUpdate(sql.toString(), type, peopleid);
			   this.executeUpdate( "UPDATE BPT_PEOPLE B SET B.DISABILITY_TYPE_CODE='00' WHERE PEOPLE_ID=?", type, peopleid);
		   }else if("22".equals(disType)){//三属
			   this.executeUpdate("UPDATE BPT_PEOPLE C  SET C.DEPENDANT_TYPE_CODE='00' WHERE C.PEOPLE_ID=?",type,peopleid);
			   this.executeUpdate("UPDATE BASEINFO_PEOPLE B  SET B.DEPENDANT_FLAG='', B.DEPENDANT_NO='', B.DEPENDANT_STATE_CODE='0'  WHERE B.PEOPLE_ID=?",type,peopleid);
		   }else if("52".equals(disType)){//参战
			   this.executeUpdate("UPDATE BPT_PEOPLE C  SET C.WAR_TYPE_CODE='00' WHERE C.PEOPLE_ID=?",type,peopleid);
				this.executeUpdate("UPDATE BASEINFO_PEOPLE B  SET B.WAR_FLAG='', B.WAR_NO='', B.WAR_STATE_CODE='0' WHERE B.PEOPLE_ID=?",type,peopleid);
		   }else if("62".equals(disType)){//参试
			   this.executeUpdate("UPDATE BPT_PEOPLE C  SET C.WAR_TYPE_CODE='00' WHERE C.PEOPLE_ID=?",type,peopleid);
				this.executeUpdate("UPDATE BASEINFO_PEOPLE B  SET B.WAR_FLAG='', B.WAR_NO='', B.WAR_STATE_CODE='0' WHERE B.PEOPLE_ID=?",type,peopleid);
		   }else if("46".equals(disType)){//病退
			   this.executeUpdate("UPDATE BPT_PEOPLE C  SET C.DEMOBILIZED_TYEP_CODE='00' WHERE C.PEOPLE_ID=?",type,peopleid);
				this.executeUpdate("UPDATE BASEINFO_PEOPLE B  SET B.DEMOBILIZED_FLAG='', B.DEMOBILIZED_NO='', B.DEMOBILIZED_STATE_CODE='0' WHERE B.PEOPLE_ID=?",type,peopleid);
		   }else if("42".equals(disType)){//在乡
			   this.executeUpdate("UPDATE BPT_PEOPLE C  SET C.DEMOBILIZED_TYEP_CODE='00' WHERE C.PEOPLE_ID=?",type,peopleid);
				this.executeUpdate("UPDATE BASEINFO_PEOPLE B  SET B.DEMOBILIZED_FLAG='', B.DEMOBILIZED_NO='', B.DEMOBILIZED_STATE_CODE='0' WHERE B.PEOPLE_ID=?",type,peopleid);
		   }else if("B2".equals(disType)){//平反子女
			   executeUpdate("UPDATE BPT_PEOPLE T SET T.MARTYR_OFFSPRING_CODE = '00' WHERE PEOPLE_ID = ?",type,peopleid);
				this.executeUpdate("UPDATE BASEINFO_PEOPLE B  SET B.MARTYR_OFFSPRING_FLAG='', B.MARTYR_OFFSPRING_NO='', B.MARTYR_OFFSPRING_STATE_CODE='0'  WHERE B.PEOPLE_ID=?",type,peopleid);
		   }else if("82".equals(disType)){//60周岁
			   executeUpdate("UPDATE BPT_PEOPLE T SET T.RETIRED_TYPE_CODE = '00' WHERE PEOPLE_ID = ?",type,peopleid);
				this.executeUpdate("UPDATE BASEINFO_PEOPLE B  SET B.RETIRED_FLAG='', B.RETIRED_NO='', B.RETIRED_STATE_CODE='0'  WHERE B.PEOPLE_ID=?",type,peopleid);
		   }
		   this.executeUpdate("delete  BPT_APPLY_INTOPROVINCE B  WHERE B.apply_id=?",type,applyid);
	}
}
