package com.inspur.cams.bpt.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.base.dao.IBptApplyMartyrOffspringDao;
import com.inspur.cams.bpt.base.data.BptApplyMartyrOffspring;
import com.inspur.cams.bpt.util.BptGetAge;
import com.inspur.cams.bpt.util.FilterLimit;


/**
 * @title: BptApplyMartyrOffspringDao
 * @description:部分烈士（错杀被平反人员）子女、60周岁以上农村籍退役士兵 申请信息 dao层
 * @author:
 * @since:
 * @version:
*/
 public class BptApplyMartyrOffspringDao extends EntityDao<BptApplyMartyrOffspring> implements IBptApplyMartyrOffspringDao{

  	@Override
	public Class<BptApplyMartyrOffspring> getEntityClass() {
		return BptApplyMartyrOffspring.class;
	}
  	
  	/**
  	 * 查询未提交部分烈士（错杀被平反人员）子女人员信息
  	 * @param pset
  	 * @return
  	 */
  	public DataSet queryUnCommitRecord(ParameterSet pset){
  		String organCode = (String)pset.getParameter("organCode");
  		StringBuffer sql = new StringBuffer();
  		sql.append("SELECT P.PEOPLE_ID, P.FAMILY_ID, A.APPLY_ID, P.PHOTO_ID, C.FULL_NAME, P.NAME,\n");
  		sql.append("       P.SEX, P.NATION, P.ID_CARD, P.BIRTHDAY,'' AGE, O.STATUS_TYPE,\n"); 
  		sql.append("       O.SACRIFICE_DATE, O.LEZSW_APPROVE_DATE\n"); 
  		sql.append("  FROM BASEINFO_PEOPLE P, BPT_PEOPLE_MARTYR_OFFSPRING O, BPT_PEOPLE T,\n"); 
  		sql.append("       BPT_APPLY_MARTYR_OFFSPRING A, DIC_CITY C\n"); 
  		sql.append(" WHERE P.PEOPLE_ID = O.PEOPLE_ID AND O.PEOPLE_ID = T.PEOPLE_ID AND\n"); 
  		sql.append("       T.PEOPLE_ID = A.PEOPLE_ID AND P.DOMICILE_CODE = C.ID AND\n"); 
  		sql.append("       P.MARTYR_OFFSPRING_FLAG = ? AND P.PERSONAL_STATS_TAG != ? AND\n"); 
  		sql.append("       A.COMMIT_FLAG = ?  AND A.SERVICE_TYPE = 'B1' ");
  		organCode =FilterLimit.filterByOrganCode(sql,organCode);
  		DataSet ds = this.executeDataset(sql.toString(), new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR},new Object[]{1,4,0,organCode},true);
  		for (int i = 0; i < ds.getCount(); i++) {
			
			String birth=(String)ds.getRecord(i).get("BIRTHDAY");
			ds.getRecord(i).set("AGE",BptGetAge.getAgeByBirthday(birth));
		}
		return ds;
  	}
  	
  	/**
	  * 删除部分烈士（错杀被平反人员）子女申请信息
	  */
	public void deleteMartyrOffspring(ParameterSet pset){
		String applyId = (String)pset.getParameter("applyId");
		String peopleId = (String)pset.getParameter("peopleId");
		int[] type = new int[1];
		type[0] = Types.VARCHAR;
		Object[] peopleIdPara = new Object[1];
		Object[] applyIdPara = new Object[1];
		peopleIdPara[0] = peopleId;
		applyIdPara[0] = applyId;
		this.executeUpdate("DELETE BPT_DISABILITY_OPEN WHERE APPLY_ID=?", type, applyIdPara);
		executeUpdate("DELETE FROM BPT_APPLY_MARTYR_OFFSPRING WHERE APPLY_ID = ? ", type, applyIdPara);
		executeUpdate("DELETE FROM BPT_PEOPLE_MARTYR_OFFSPRING WHERE PEOPLE_ID = ?",type,peopleIdPara);
		executeUpdate("UPDATE BPT_PEOPLE T SET T.MARTYR_OFFSPRING_CODE = '00' WHERE PEOPLE_ID = ?",type,peopleIdPara);
		this.executeUpdate("UPDATE BASEINFO_PEOPLE B  SET B.MARTYR_OFFSPRING_FLAG='', B.MARTYR_OFFSPRING_NO='', B.MARTYR_OFFSPRING_STATE_CODE='0'  WHERE B.PEOPLE_ID=?",type,peopleIdPara);
	}
	
	/**
	 * 
	 * 查询 已提交 部分烈士（错杀被平反人员）子女申请信息
	 * @param pset
	 * @return
	 */
	public DataSet queryMartyrOffspirng(ParameterSet pset){
		DataSet ds = new DataSet();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT P.PEOPLE_ID, C.FULL_NAME, P.NAME, P.SEX, P.NATION,\n");
		sql.append("       P.ID_CARD, P.BIRTHDAY,'' AGE, O.STATUS_TYPE, O.SACRIFICE_DATE,\n"); 
		sql.append("       O.LEZSW_APPROVE_DATE\n"); 
		sql.append("  FROM BASEINFO_PEOPLE P, BPT_PEOPLE_MARTYR_OFFSPRING O, BPT_PEOPLE T,\n"); 
		sql.append("        DIC_CITY C\n"); 
		sql.append(" WHERE P.PEOPLE_ID = O.PEOPLE_ID AND O.PEOPLE_ID = T.PEOPLE_ID AND\n"); 
		sql.append("       P.DOMICILE_CODE = C.ID AND\n"); 
		sql.append("       p.martyr_offspring_flag='1' and t.martyr_offspring_code='B1' \n");
		String domicileCode = (String)pset.getParameter("domicileCode");
		String name = (String)pset.getParameter("name");
		String idCard = (String)pset.getParameter("idCard");
		String organCode = (String) pset.getParameter("organCode");
		String statusType = (String)pset.getParameter("statusType");
		String sacrificeDate = (String)pset.getParameter("sacrificeDate");
		String lezswApproveDate = (String) pset.getParameter("lezswApproveDate");
		if (domicileCode != null && !domicileCode.equals("")) {
			if(!"00".equals(domicileCode.substring(2, 4))) { //非省级
				if ("00".equals(domicileCode.substring(4, 6))
						&& "00000000".equals(domicileCode.substring(4))) { // 市级
					sql.append(" AND DOMICILE_CODE like  ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 4)+"%");
				} else if("000000".equals(domicileCode.substring(6))) { //县级
					sql.append(" AND DOMICILE_CODE like  ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 6)+"%");
				} else if("000".equals(domicileCode.substring(9))) { //街道
					sql.append(" AND DOMICILE_CODE like  ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 9)+"%");
				} else { //村
					sql.append(" AND DOMICILE_CODE = ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode);
				}
			} else { //省级
				sql.append(" AND DOMICILE_CODE like ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(domicileCode.substring(0, 2)+"%");
			}
		} else {
			organCode=FilterLimit.filterByOrganCode(sql,organCode);	
			typeList.add(Types.VARCHAR);
			argsList.add(organCode);
		}
		
		if (name != null && !name.equals("")) {
			sql.append(" AND P.NAME LIKE ? ") ;
			typeList.add(Types.VARCHAR);
			argsList.add("%" + name.trim() + "%");
		}
		
		if (idCard != null && !idCard.equals("")) {
			sql.append(" AND P.ID_CARD LIKE ? ") ;
			typeList.add(Types.VARCHAR);
			argsList.add("%" + idCard.trim() + "%");
		}
		
		if (statusType != null && !statusType.equals("")) {
			sql.append(" AND O.STATUS_TYPE = ? ") ;
			typeList.add(Types.VARCHAR);
			argsList.add(statusType);
		}
		
		if (sacrificeDate != null && !sacrificeDate.equals("")) {
			sql.append(" AND O.SACRIFICE_DATE = ? ") ;
			typeList.add(Types.VARCHAR);
			argsList.add(sacrificeDate);
		}

		if (lezswApproveDate != null && !lezswApproveDate.equals("")) {
			sql.append(" AND O.LEZSW_APPROVE_DATE =? ") ;
			typeList.add(Types.VARCHAR);
			argsList.add(lezswApproveDate);
		}
		
		sql.append(" ORDER BY P.DOMICILE_CODE,P.NAME");
		if(typeList.size() != 0 && argsList.size()!= 0) {
			int[] types = new int[typeList.size()];
			for(int i=0;i<typeList.size();i++) {
				types[i]=(Integer)(typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sql.toString(),types,args, pset.getPageStart(), pset
						.getPageLimit(), true);
		}else{
			ds = this.executeDataset(sql.toString(), pset.getPageStart(), pset
					.getPageLimit(), true);
		}
		for (int i = 0; i < ds.getCount(); i++) {
			
			String birth=(String)ds.getRecord(i).get("BIRTHDAY");
			ds.getRecord(i).set("AGE",BptGetAge.getAgeByBirthday(birth));
		}
		return ds;
	}
	
	/**
	 * 查询未提交60周岁以上农村籍退役士兵列表信息
	 */
	public DataSet queryUnComCountSold(ParameterSet pset){
		String organCode = (String)pset.getParameter("organCode");
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT A.APPLY_ID, P.PEOPLE_ID, P.PHOTO_ID, P.FAMILY_ID, P.DOMICILE_CODE,\n");
		sql.append("       P.NAME, P.ID_CARD, P.SEX, P.NATION, P.DOMICILE_TYPE,\n"); 
		sql.append("       P.BIRTHDAY,'' AGE, S.SOLDIER_YEARS, S.SOLDIER_START_DATE,\n");
		sql.append("       S.SOLDIER_END_DATE, C.FULL_NAME\n");
		sql.append("  FROM BASEINFO_PEOPLE P, BPT_PEOPLE_RETIRED_SOLDIER S, BPT_PEOPLE T,\n");
		sql.append("       DIC_CITY C, BPT_APPLY_MARTYR_OFFSPRING A\n"); 
		sql.append(" WHERE P.PEOPLE_ID = S.PEOPLE_ID AND S.PEOPLE_ID = T.PEOPLE_ID AND\n"); 
		sql.append("       T.PEOPLE_ID = A.PEOPLE_ID AND C.ID = P.DOMICILE_CODE AND\n"); 
		sql.append("       P.PERSONAL_STATS_TAG != ? AND A.COMMIT_FLAG = ?\n");
		sql.append("       AND A.SERVICE_TYPE = '81' \n");
		organCode =FilterLimit.filterByOrganCode(sql,organCode);
		DataSet ds = this.executeDataset(sql.toString(),new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR},new Object[]{4,0,organCode},true);
		
		for (int i = 0; i < ds.getCount(); i++) {
			
			String birth=(String)ds.getRecord(i).get("BIRTHDAY");
			ds.getRecord(i).set("AGE",BptGetAge.getAgeByBirthday(birth));
		}
		return ds;
	}
	
	

	/**
	 * 删除60周岁以上农村籍退役士兵相关信息
	 */
	public void deleteCountrySoldier(ParameterSet pset){
		String applyId = (String)pset.getParameter("applyId");
		String peopleId = (String)pset.getParameter("peopleId");
		int[] type = new int[1];
		type[0] = Types.VARCHAR;
		Object[] peopleIdPara = new Object[1];
		Object[] applyIdPara = new Object[1];
		peopleIdPara[0] = peopleId;
		applyIdPara[0] = applyId;
		executeUpdate("DELETE FROM BPT_APPLY_MARTYR_OFFSPRING WHERE APPLY_ID = ? ", type, applyIdPara);
		executeUpdate("DELETE FROM BPT_PEOPLE_RETIRED_SOLDIER WHERE PEOPLE_ID = ?",type,peopleIdPara);
		executeUpdate("UPDATE BPT_PEOPLE T SET T.RETIRED_TYPE_CODE = '00' WHERE PEOPLE_ID = ?",type,peopleIdPara);
		this.executeUpdate("UPDATE BASEINFO_PEOPLE B  SET B.RETIRED_FLAG='', B.RETIRED_NO='', B.RETIRED_STATE_CODE='0'  WHERE B.PEOPLE_ID=?",type,peopleIdPara);
	}
	/**
	 * 
	 * 查询 已提交 60周岁以上农村籍退役士兵
	 * @param pset
	 * @return
	 */
	public DataSet queryCountrysoldier(ParameterSet pset){
		DataSet ds = new DataSet();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT  P.PEOPLE_ID, P.PHOTO_ID, P.FAMILY_ID, P.DOMICILE_CODE,\n");
		sql.append("       P.NAME, P.ID_CARD, P.SEX, P.NATION, P.DOMICILE_TYPE,\n"); 
		sql.append("       P.BIRTHDAY,'' AGE, S.SOLDIER_YEARS, S.SOLDIER_START_DATE,\n"); 
		sql.append("       S.SOLDIER_END_DATE, C.FULL_NAME\n"); 
		sql.append("  FROM BASEINFO_PEOPLE P, BPT_PEOPLE_RETIRED_SOLDIER S, BPT_PEOPLE T,\n"); 
		sql.append("       DIC_CITY C \n"); 
		sql.append(" WHERE P.PEOPLE_ID = S.PEOPLE_ID AND S.PEOPLE_ID = T.PEOPLE_ID AND\n"); 
		sql.append("       C.ID = P.DOMICILE_CODE AND\n"); 
		sql.append("       P.PERSONAL_STATS_TAG != '4' \n");
		sql.append("       and p.retired_flag='1' and t.retired_type_code='81' ");
		String domicileCode = (String)pset.getParameter("domicileCode");
		String name = (String)pset.getParameter("name");
		String idCard = (String)pset.getParameter("idCard");
		String organCode = (String) pset.getParameter("organCode");
		String forcesName = (String)pset.getParameter("forcesName");
		String soldierStartDate = (String)pset.getParameter("soldierStartDate");
		String soldierEndDate = (String) pset.getParameter("soldierEndDate");
		if (domicileCode != null && !domicileCode.equals("")) {
			if(!"00".equals(domicileCode.substring(2, 4))) { //非省级
				if ("00".equals(domicileCode.substring(4, 6))
						&& "00000000".equals(domicileCode.substring(4))) { // 市级
					sql.append(" AND DOMICILE_CODE like ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 4)+"%");
				} else if("000000".equals(domicileCode.substring(6))) { //县级
					sql.append(" AND DOMICILE_CODE like ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 6)+"%");
				} else if("000".equals(domicileCode.substring(9))) { //街道
					sql.append(" AND DOMICILE_CODE like ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 9)+"%");
				} else { //村
					sql.append(" AND DOMICILE_CODE = ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode);
				}
			} else { //省级
				sql.append(" AND DOMICILE_CODE like ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(domicileCode.substring(0, 2)+"%");
			}
		} else {
			organCode=FilterLimit.filterByOrganCode(sql,organCode);	
			typeList.add(Types.VARCHAR);
			argsList.add(organCode);
		}
		
		if (name != null && !name.equals("")) {
			sql.append(" AND P.NAME LIKE ? ") ;
			typeList.add(Types.VARCHAR);
			argsList.add("%" + name.trim() + "%");
		}
		
		if (idCard != null && !idCard.equals("")) {
			sql.append(" AND P.ID_CARD LIKE ? ") ;
			typeList.add(Types.VARCHAR);
			argsList.add("%" + idCard.trim() + "%");
		}
		
		if (forcesName != null && !forcesName.equals("")) {
			sql.append(" AND S.forces_name LIKE ? ") ;
			typeList.add(Types.VARCHAR);
			argsList.add("%" + forcesName.trim() + "%");
		}
		
		if (soldierStartDate != null && !soldierStartDate.equals("")) {
			sql.append(" AND S.soldier_start_date = ? ") ;
			typeList.add(Types.VARCHAR);
			argsList.add(soldierStartDate);
		}

		if (soldierEndDate != null && !soldierEndDate.equals("")) {
			sql.append(" AND S.soldier_end_date =? ") ;
			typeList.add(Types.VARCHAR);
			argsList.add(soldierEndDate);
		}
		
		sql.append(" ORDER BY P.DOMICILE_CODE,P.NAME");
		if(typeList.size() != 0 && argsList.size()!= 0) {
			int[] types = new int[typeList.size()];
			for(int i=0;i<typeList.size();i++) {
				types[i]=(Integer)(typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sql.toString(),types,args, pset.getPageStart(), pset
						.getPageLimit(), true);
		}else{
			ds = this.executeDataset(sql.toString(), pset.getPageStart(), pset
					.getPageLimit(), true);
		}
		for (int i = 0; i < ds.getCount(); i++) {
			
			String birth=(String)ds.getRecord(i).get("BIRTHDAY");
			ds.getRecord(i).set("AGE",BptGetAge.getAgeByBirthday(birth));
		}
		return ds;
	}
	
}
