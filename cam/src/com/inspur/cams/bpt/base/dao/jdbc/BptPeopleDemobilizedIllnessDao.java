package com.inspur.cams.bpt.base.dao.jdbc;



import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.bpt.base.dao.IBptPeopleDemobilizedIllnessDao;
import com.inspur.cams.bpt.base.data.BptPeopleDemobilizedIllness;
import com.inspur.cams.bpt.util.BptGetAge;
import com.inspur.cams.bpt.util.FilterLimit;
import com.inspur.cams.comm.util.DateUtil;

/**
 * @title:BptPeopleDemobilizedIllnessDao
 * @description:
 * @author:
 * @since:2011-05-21
 * @version:1.0
*/
 public class BptPeopleDemobilizedIllnessDao extends EntityDao<BptPeopleDemobilizedIllness> implements IBptPeopleDemobilizedIllnessDao{

 	public BptPeopleDemobilizedIllnessDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}
  	@Override
	public Class<BptPeopleDemobilizedIllness> getEntityClass() {
		return BptPeopleDemobilizedIllness.class;
	}
   /**
	 * 查询带病回乡退伍军人信息和相应的优抚人员信息
	 */
   public DataSet queryDemobilizedIllnessPeople(ParameterSet pset){
	   	DataSet ds = new DataSet();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		String startTime = (String) pset.getParameter("startTime");
		String endTime = (String) pset.getParameter("endTime");
		String domicileCode = (String)pset.getParameter("domicileCode");
		String name = (String)pset.getParameter("name");
		String idCard = (String)pset.getParameter("idCard");
		String isWar = (String)pset.getParameter("isWar");
		String isInnuclear = (String)pset.getParameter("isInnuclear");
		String objectState = (String)pset.getParameter("objectState");
		String domicileType = (String)pset.getParameter("domicileType");
		String organCode = (String) pset.getParameter("organCode");
		String note = (String) pset.getParameter("note");
		String ageBegin = (String) pset.getParameter("ageBegin");
		String ageEnd = (String) pset.getParameter("ageEnd");
		String isprovinceMigrate = (String) pset.getParameter("bisprovinceMigrate");
		StringBuffer sql = new StringBuffer();
		StringBuffer sqlfind = new StringBuffer() ;
		sqlfind.append("SELECT A.BIRTHDAY,'' PEOPLE_AGE, A.FAMILY_ID, A.DEMOBILIZED_STATE_CODE,\n");
		sqlfind.append("       A.PEOPLE_ID, A.DOMICILE_CODE, A.NAME, A.ID_CARD, A.SEX, A.NATION,\n"); 
		sqlfind.append("       C.IS_WAR, C.IS_INNUCLEAR, C.CONSCRIPT_DATE, C.DECRUITMENT_DATE,\n"); 
		sqlfind.append("       D.FULL_NAME DOMICILE_NAME, A.DOMICILE_TYPE, A.TEL_MOBILE, C.NOTE\n");
		if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
			sqlfind.append("  ,'1' as flag\n"); 
		}
		sqlfind.append("  FROM BASEINFO_PEOPLE A, BPT_PEOPLE B, BPT_PEOPLE_DEMOBILIZED_ILLNESS C,\n"); 
		sqlfind.append("       DIC_CITY D\n");
		if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
			sqlfind.append("  ,bpt_province_migrate e\n"); 
		}
		sqlfind.append(" WHERE A.PEOPLE_ID = C.PEOPLE_ID AND A.PEOPLE_ID = B.PEOPLE_ID AND\n"); 
		sqlfind.append("       A.DEMOBILIZED_FLAG = '1' AND A.PERSONAL_STATS_TAG != '4' AND\n"); 
		sqlfind.append("       A.DOMICILE_CODE = D.ID");
		if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
			sqlfind.append("  and A.people_id = e.people_id and e.service_type='47'\n"); 
		}
		StringBuffer sqlExcel = new StringBuffer();
		sqlExcel.append("SELECT A.BIRTHDAY,'' PEOPLE_AGE, A.FAMILY_ID,\n");
		sqlExcel.append("       (CASE A.DEMOBILIZED_STATE_CODE\n"); 
		sqlExcel.append("          WHEN '1' THEN '受理'\n"); 
		sqlExcel.append("          WHEN '2' THEN '享受待遇'\n"); 
		sqlExcel.append("          WHEN '3' THEN '身份认定不享受待遇'\n"); 
		sqlExcel.append("          WHEN '4' THEN '停发'\n"); 
		sqlExcel.append("          WHEN '5' THEN '迁移'\n"); 
		sqlExcel.append("          WHEN '6' THEN '不予认定'\n"); 
		sqlExcel.append("          WHEN '7' THEN '去世'\n"); 
		sqlExcel.append("          WHEN '8' THEN '取消'\n"); 
		sqlExcel.append("          WHEN '9' THEN '中止'\n"); 
		sqlExcel.append("        END) AS DEMOBILIZED_STATE_CODE,A.PEOPLE_ID, A.DOMICILE_CODE,\n"); 
		sqlExcel.append("       A.NAME, A.ID_CARD,\n"); 
		sqlExcel.append("       (CASE A.SEX\n"); 
		sqlExcel.append("          WHEN '1' THEN '男'\n"); 
		sqlExcel.append("          WHEN '2' THEN '女'\n"); 
		sqlExcel.append("        END) AS SEX, N.NAME AS NATION,\n"); 
		sqlExcel.append("       (CASE C.IS_WAR\n"); 
		sqlExcel.append("            WHEN '0' THEN '否'\n"); 
		sqlExcel.append("            WHEN '1' THEN '是'\n"); 
		sqlExcel.append("          END) AS IS_WAR,\n"); 
		sqlExcel.append("       (CASE C.IS_INNUCLEAR\n"); 
		sqlExcel.append("          WHEN '0' THEN '否'\n"); 
		sqlExcel.append("          WHEN '1' THEN '是'\n"); 
		sqlExcel.append("        END) AS IS_INNUCLEAR, C.CONSCRIPT_DATE, C.DECRUITMENT_DATE,\n"); 
		sqlExcel.append("       D.FULL_NAME DOMICILE_NAME, A.DOMICILE_TYPE, A.TEL_MOBILE, C.NOTE\n"); 
		sqlExcel.append("  FROM BASEINFO_PEOPLE A, BPT_PEOPLE B, BPT_PEOPLE_DEMOBILIZED_ILLNESS C,\n"); 
		sqlExcel.append("       DIC_NATION N, DIC_CITY D\n"); 
		if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
			sqlExcel.append("  ,bpt_province_migrate e\n"); 
		}
		sqlExcel.append(" WHERE A.PEOPLE_ID = C.PEOPLE_ID AND A.PEOPLE_ID = B.PEOPLE_ID AND\n"); 
		sqlExcel.append("       A.DEMOBILIZED_FLAG = '1' AND A.PERSONAL_STATS_TAG != '4' AND\n"); 
		sqlExcel.append("       A.DOMICILE_CODE = D.ID AND A.NATION = N.CODE");
		if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
			sqlExcel.append("  and A.people_id = e.people_id and e.service_type='47'\n"); 
		}
		String isAll = (String) pset.getParameter("isAll");
		if("all".equals(isAll) || !pset.containsKey("limit")){
			sql.append(sqlExcel);
		}else{
			sql.append(sqlfind);
		}
		if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
			if (domicileCode != null && !domicileCode.equals("")) {
				if (!domicileCode.substring(0, 2).equals("00")
						&& domicileCode.substring(2, 4).equals("00")) {
					sql.append(" AND e.OUT_DOMICILE_CODE like ? ");// 省局
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 2)+"%");
				} else if (!domicileCode.substring(2, 4).equals("00")
						&& domicileCode.substring(4).equals("00000000")) {
					sql.append(" AND e.OUT_DOMICILE_CODE like ?");// 市局
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 4)+"%");
				} else if (!domicileCode.substring(4, 6).equals("00")
						&& domicileCode.substring(6, 9).equals("000")) {
					sql.append(" AND e.OUT_DOMICILE_CODE like ?");// 区县
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 6)+"%");
				} else if (!domicileCode.substring(6, 9).equals("000")
						&& domicileCode.substring(9, 12).equals("000")) {
					sql.append(" AND e.OUT_DOMICILE_CODE like ?");// 街道
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 9)+"%");
				} else {
					sql.append(" AND e.OUT_DOMICILE_CODE=?");// 社区
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode);
				}
			}else{
				if (!organCode.substring(0, 2).equals("00")
						&& organCode.substring(2, 4).equals("00")) {
					sql.append(" AND  e.OUT_DOMICILE_CODE like ? ");// 省局
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0, 2)+"%");
				} else if (!organCode.substring(2, 4).equals("00")
						&& organCode.substring(4, 6).equals("00")) {
					sql.append(" AND e.OUT_DOMICILE_CODE like ? ");// 市局
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0, 4)+"%");
				} else {
					sql.append(" AND e.OUT_DOMICILE_CODE like ? ");// 区县
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0, 6)+"%");
				}
			}
		}else {
			//domicileCode为暂时的，挂行政区划代码后，需写在上面
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
			}else {
				organCode=FilterLimit.filterByOrganCode(sql,organCode);
					typeList.add(Types.VARCHAR);
					argsList.add(organCode);
			}
		}
		if(name != null && !name.equals("")){
			sql.append(" AND A.NAME LIKE ?");
			typeList.add(Types.VARCHAR);
			argsList.add("%"+name+"%");
		}
		if(idCard !=null && !idCard.equals("")){
			sql.append(" AND A.ID_CARD LIKE ?");
			typeList.add(Types.VARCHAR);
			argsList.add("%"+idCard+"%");
		}
		if(isWar != null && !isWar.equals("")){
			sql.append(" AND C.IS_WAR=?");
			typeList.add(Types.VARCHAR);
			argsList.add(isWar);
		}
		if(isInnuclear != null && !isInnuclear.equals("")){
			sql.append(" AND C.IS_INNUCLEAR=?");
			typeList.add(Types.VARCHAR);
			argsList.add(isInnuclear);
		}
		if(objectState != null && !objectState.equals("")){
			sql.append(" AND A.DEMOBILIZED_STATE_CODE=?");
			typeList.add(Types.VARCHAR);
			argsList.add(objectState);
		}
		if(domicileType != null && !domicileType.equals("")){
			sql.append(" AND A.DOMICILE_TYPE=?");
			typeList.add(Types.VARCHAR);
			argsList.add(domicileType);
		}
		if(note != null && !note.equals("")){
			sql.append(" AND C.NOTE LIKE ?");
			typeList.add(Types.VARCHAR);
			argsList.add("%"+note+"%");
		}
		if ((endTime != null && !"".equals(endTime))
				|| (startTime != null && !"".equals(startTime))) {
			if(endTime == null || "".equals(endTime)) {
				endTime = DateUtil.getDay();
			}
			if(startTime == null || "".equals(startTime)) {
				startTime = "1900-01-01";
			}
			sql.append(" AND TO_DATE(C.APPROVAL_DATE, 'YYYY-MM-DD') BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD')");
			typeList.add(Types.VARCHAR);
			argsList.add(startTime);
			typeList.add(Types.VARCHAR);
			argsList.add(endTime);
		}
		if (ageBegin != null && !"".equals(ageBegin)) {
			sql.append(" AND GETAGE(A.BIRTHDAY) >= ?");
			typeList.add(Types.INTEGER);
			argsList.add(Integer.parseInt(ageBegin));
		}
		if (ageEnd != null && !"".equals(ageEnd)) {
			sql.append(" AND GETAGE(A.BIRTHDAY) <= ?");
			typeList.add(Types.INTEGER);
			argsList.add(Integer.parseInt(ageEnd));
		}
		sql.append(" ORDER BY A.DOMICILE_CODE,A.NAME");
		if(typeList.size() != 0 && argsList.size()!= 0) {
			int[] types = new int[typeList.size()];
			for(int i=0;i<typeList.size();i++) {
				types[i]=(Integer)(typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			if("all".equals(isAll) || !pset.containsKey("limit")){
				ds = this.executeDataset(sql.toString(), types,args,true);
			} else {
				ds = this.executeDataset(sql.toString(),types,args, pset.getPageStart(), pset.getPageLimit(), true);
			}
		} else {
			if("all".equals(isAll) || !pset.containsKey("limit")){
				ds = this.executeDataset(sql.toString(),true);
			} else {
				ds = this.executeDataset(sql.toString(), pset.getPageStart(), pset.getPageLimit(), true);
			}
		}
		for (int i = 0; i < ds.getCount(); i++) {
			
			String birth=(String)ds.getRecord(i).get("BIRTHDAY");
			ds.getRecord(i).set("PEOPLE_AGE",BptGetAge.getAgeByBirthday(birth));
		}
		return ds;
	}
	/**
	 * 查询未提交的 带病回乡退伍军人信息和相应的优抚人员信息
	 */
	public DataSet queryApplyDemobilizedIllnessPeople(ParameterSet pset) {
		String organCode = (String) pset.getParameter("organCode");
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT A.FAMILY_ID, A.DEMOBILIZED_STATE_CODE, A.PEOPLE_ID, A.DOMICILE_CODE,\n");
		sql.append("       A.NAME, A.ID_CARD, A.SEX, A.NATION, C.IS_WAR, C.IS_INNUCLEAR,\n"); 
		sql.append("       C.CONSCRIPT_DATE, C.DECRUITMENT_DATE,\n"); 
		sql.append("       D.FULL_NAME DOMICILE_NAME, A.DOMICILE_TYPE,\n"); 
		sql.append("       A.TEL_MOBILE, C.NOTE, T.APPLY_ID\n"); 
		sql.append("  FROM BPT_APPLY_DEMOBILIZED T, BASEINFO_PEOPLE A, BPT_PEOPLE B,\n"); 
		sql.append("       BPT_PEOPLE_DEMOBILIZED_ILLNESS C, DIC_CITY D \n"); 
		sql.append(" WHERE A.PEOPLE_ID = C.PEOPLE_ID AND A.PEOPLE_ID = B.PEOPLE_ID AND\n"); 
		sql.append("       A.DEMOBILIZED_FLAG = '1' AND A.PERSONAL_STATS_TAG != '4' AND\n"); 
		sql.append("       A.DOMICILE_CODE = D.ID AND\n"); 
		sql.append("       T.PEOPLE_ID = A.PEOPLE_ID AND T.COMMIT_FLAG = '0'"); 
		organCode=FilterLimit.filterByOrganCode(sql,organCode);
		DataSet ds = this.executeDataset(sql.toString(),new int[]{Types.VARCHAR},new Object[]{organCode},pset.getPageStart(),pset.getPageLimit(), true);
		return ds;
	}
	/**
	 * 查询未提交的 外省迁入带病回乡退伍军人信息和相应的优抚人员信息
	 */
	public DataSet queryApplyIntoDemobilizedIllnessPeople(ParameterSet pset) {
		String organCode = (String) pset.getParameter("organCode");
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT T.SERVICE_TYPE, A.FAMILY_ID, A.DEMOBILIZED_STATE_CODE, A.PEOPLE_ID,\n");
		sql.append("       A.DOMICILE_CODE, A.NAME, A.ID_CARD, A.SEX, A.NATION, C.IS_WAR,\n"); 
		sql.append("       C.IS_INNUCLEAR, C.CONSCRIPT_DATE, C.DECRUITMENT_DATE,\n"); 
		sql.append("       D.FULL_NAME DOMICILE_NAME, A.DOMICILE_TYPE,\n"); 
		sql.append("       A.TEL_MOBILE, C.NOTE, T.APPLY_ID\n"); 
		sql.append("  FROM BPT_APPLY_INTOPROVINCE T, BASEINFO_PEOPLE A, BPT_PEOPLE B,\n"); 
		sql.append("       BPT_PEOPLE_DEMOBILIZED_ILLNESS C, DIC_CITY D \n"); 
		sql.append(" WHERE A.PEOPLE_ID = C.PEOPLE_ID AND A.PEOPLE_ID = B.PEOPLE_ID AND\n"); 
		sql.append("       A.DEMOBILIZED_FLAG = '1' AND A.PERSONAL_STATS_TAG != '4' AND\n"); 
		sql.append("       A.DOMICILE_CODE = D.ID AND\n"); 
		sql.append("       T.PEOPLE_ID = A.PEOPLE_ID AND T.COMMIT_FLAG = '0' "); 
		organCode=FilterLimit.filterByOrganCode(sql,organCode);
		DataSet ds = this.executeDataset(sql.toString(),new int[]{Types.VARCHAR},new Object[]{organCode},pset.getPageStart(),pset.getPageLimit(), true);
		return ds;
	}
	/**
	 * 根据peopleId查询Id_card
	 */
	public String queryIdCardByPeopleId(ParameterSet pset) {
		String peopleId = (String) pset.getParameter("peopleId");
		String sql="SELECT ID_CARD FROM BASEINFO_PEOPLE WHERE PEOPLE_ID= ? ";
		DataSet ds = this.executeDataset(sql.toString(),new int[]{Types.VARCHAR},new Object[]{peopleId},true);
		String idCard =(String) ds.getRecord(0).get("ID_CARD");
		return idCard;
	}
}
