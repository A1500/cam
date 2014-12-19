package com.inspur.cams.bpt.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.base.dao.IBptPeopleWarDao;
import com.inspur.cams.bpt.base.data.BptPeopleWar;
import com.inspur.cams.bpt.util.BptGetAge;
import com.inspur.cams.bpt.util.FilterLimit;
import com.inspur.cams.comm.util.DateUtil;


/**
 * @title:BptPeopleWarDao
 * @description:
 * @author:
 * @since:2011-05-12
 * @version:1.0
*/
 public class BptPeopleWarDao extends EntityDao<BptPeopleWar> implements IBptPeopleWarDao{
  	@Override
	public Class<BptPeopleWar> getEntityClass() {
		return BptPeopleWar.class;
	}
	/**
	 * 查询人员、类别【参战】、优抚信息
	 */
  	public DataSet queryWar(ParameterSet pset) {
  		DataSet ds = new DataSet();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		String isprovinceMigrate = (String) pset.getParameter("czisprovinceMigrate");
  		StringBuffer sql = new StringBuffer();
  			StringBuffer sqlfind = new StringBuffer();
  			sqlfind.append("SELECT P.BIRTHDAY,'' PEOPLE_AGE, P.PEOPLE_ID AS PEOPLE_ID, FAMILY_ID,\n");
  			sqlfind.append("       DOMICILE_CODE, P.NAME AS NAME, ID_CARD, SEX, NATION, WAR_STATE_CODE,\n"); 
  			sqlfind.append("       DOMICILE_TYPE, D.ASDP_NO, D.FORCES_NO, D.WAR_TYPE_CODE,\n"); 
  			sqlfind.append("       C.FULL_NAME AS DICNAME, D.NOTE\n"); 
  			if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
				sqlfind.append("  ,'1' as flag\n"); 
			}
  			sqlfind.append("  FROM BASEINFO_PEOPLE P, BPT_PEOPLE_WAR D, BPT_PEOPLE T, DIC_CITY C\n"); 
  			if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
  				sqlfind.append("  ,bpt_province_migrate e\n"); 
  			}
  			sqlfind.append(" WHERE P.PEOPLE_ID = D.PEOPLE_ID AND D.PEOPLE_ID = T.PEOPLE_ID AND\n"); 
  			sqlfind.append("       DOMICILE_CODE = C.ID AND P.WAR_FLAG = '1' AND\n"); 
  			sqlfind.append("       P.PERSONAL_STATS_TAG != '4' AND T.WAR_TYPE_CODE = '51'");
  			if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
  				sqlfind.append("  and P.people_id = e.people_id and e.service_type='53'\n"); 
  			}
  			StringBuffer sqlExcel = new StringBuffer();
  			sqlExcel.append("SELECT P.BIRTHDAY,'' PEOPLE_AGE, P.PEOPLE_ID AS PEOPLE_ID, FAMILY_ID,\n");
  			sqlExcel.append("       DOMICILE_CODE, P.NAME AS NAME, ID_CARD,\n"); 
  			sqlExcel.append("       (CASE P.SEX\n"); 
  			sqlExcel.append("          WHEN '1' THEN '男'\n"); 
  			sqlExcel.append("          WHEN '2' THEN '女'\n"); 
  			sqlExcel.append("        END) AS SEX, N.NAME AS NATION,\n"); 
  			sqlExcel.append("       (CASE WAR_STATE_CODE\n"); 
  			sqlExcel.append("            WHEN '1' THEN '受理'\n"); 
  			sqlExcel.append("            WHEN '2' THEN '享受待遇'\n"); 
  			sqlExcel.append("            WHEN '3' THEN '身份认定不享受待遇'\n"); 
  			sqlExcel.append("            WHEN '4' THEN '停发'\n"); 
  			sqlExcel.append("            WHEN '5' THEN '迁移'\n"); 
  			sqlExcel.append("            WHEN '6' THEN '不予认定'\n"); 
  			sqlExcel.append("            WHEN '7' THEN '去世'\n"); 
  			sqlExcel.append("            WHEN '8' THEN '取消'\n"); 
  			sqlExcel.append("            WHEN '9' THEN '中止'\n"); 
  			sqlExcel.append("          END) AS WAR_STATE_CODE, DOMICILE_TYPE, D.ASDP_NO, D.FORCES_NO,\n"); 
  			sqlExcel.append("       (CASE D.WAR_TYPE_CODE\n"); 
  			sqlExcel.append("          WHEN '01' THEN '解放一江山岛'\n"); 
  			sqlExcel.append("          WHEN '02' THEN '川、甘、青滇藏地区平叛作战'\n"); 
  			sqlExcel.append("          WHEN '03' THEN '炮击金门作战'\n"); 
  			sqlExcel.append("          WHEN '04' THEN '中缅边境勘界警卫作战'\n"); 
  			sqlExcel.append("          WHEN '05' THEN '中印边境自卫反击战'\n"); 
  			sqlExcel.append("          WHEN '06' THEN '八六海战'\n"); 
  			sqlExcel.append("          WHEN '07' THEN '崇武以东海战'\n"); 
  			sqlExcel.append("          WHEN '08' THEN '援越抗美作战'\n"); 
  			sqlExcel.append("          WHEN '09' THEN '援老抗美作战'\n"); 
  			sqlExcel.append("          WHEN '10' THEN '珍宝岛自卫反击作战'\n"); 
  			sqlExcel.append("          WHEN '11' THEN '西沙群岛自卫反击作战'\n"); 
  			sqlExcel.append("          WHEN '12' THEN '中越边境自卫还击作战'\n"); 
  			sqlExcel.append("          WHEN '13' THEN '老山、者阴山地区对越防御作战'\n"); 
  			sqlExcel.append("          WHEN '14' THEN '南沙群岛自卫反击作战'\n"); 
  			sqlExcel.append("          WHEN '15' THEN '需经军委、总部认定的其他作战行动'\n"); 
  			sqlExcel.append("          WHEN '16' THEN '其他'\n"); 
  			sqlExcel.append("        END) AS WAR_TYPE_CODE, C.FULL_NAME AS DICNAME, D.NOTE\n"); 
  			sqlExcel.append("  FROM BASEINFO_PEOPLE P, DIC_NATION N, BPT_PEOPLE_WAR D, BPT_PEOPLE T,\n"); 
  			sqlExcel.append("       DIC_CITY C\n"); 
  			if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
  				sqlExcel.append("  ,bpt_province_migrate e\n"); 
  			}
  			sqlExcel.append(" WHERE P.PEOPLE_ID = D.PEOPLE_ID AND D.PEOPLE_ID = T.PEOPLE_ID AND\n"); 
  			sqlExcel.append("       DOMICILE_CODE = C.ID AND P.NATION = N.CODE AND P.WAR_FLAG = '1' AND\n"); 
  			sqlExcel.append("       P.PERSONAL_STATS_TAG != '4' AND T.WAR_TYPE_CODE = '51'");
  			if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
  				sqlExcel.append("  and P.people_id = e.people_id and e.service_type='53'\n"); 
  			}
  			String isAll = (String) pset.getParameter("isAll");
  			if("all".equals(isAll) || !pset.containsKey("limit")){
  				sql.append(sqlExcel);
  			}else{
  				sql.append(sqlfind);
  			}
  			String domicileCode = (String)pset.getParameter("domicileCode");
  			String name = (String)pset.getParameter("name");
  			String idCard = (String)pset.getParameter("idCard");
  			String domicileType = (String)pset.getParameter("domicileType");
  			String asdpNo = (String)pset.getParameter("asdpNo");
  			String forcesNo = (String)pset.getParameter("forcesNo");
  			String warTypeCode = (String)pset.getParameter("warTypeCode");
  			String organCode = (String) pset.getParameter("organCode");
  			String objectState = (String) pset.getParameter("objectState");
  			String note = (String) pset.getParameter("note");
  			String startTime = (String) pset.getParameter("startTime");
  			String endTime = (String) pset.getParameter("endTime");
  			String ageBegin = (String) pset.getParameter("ageBegin");
  			String ageEnd = (String) pset.getParameter("ageEnd");
  			if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
  				if (domicileCode != null && !domicileCode.equals("")) {
  					if (!domicileCode.substring(0, 2).equals("00")
  							&& domicileCode.substring(2, 4).equals("00")) {
  						sql.append(" AND e.OUT_DOMICILE_CODE like ?");// 省局
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
  						sql.append(" AND  e.OUT_DOMICILE_CODE like ?");// 省局
  						typeList.add(Types.VARCHAR);
  						argsList.add(organCode.substring(0, 2)+"%");
  					} else if (!organCode.substring(2, 4).equals("00")
  							&& organCode.substring(4, 6).equals("00")) {
  						sql.append(" AND e.OUT_DOMICILE_CODE like ?");// 市局
  						typeList.add(Types.VARCHAR);
  						argsList.add(organCode.substring(0, 4)+"%");
  					} else {
  						sql.append(" AND e.OUT_DOMICILE_CODE like ?");// 区县
  						typeList.add(Types.VARCHAR);
  						argsList.add(organCode.substring(0, 6)+"%");
  					}
  				}
  			}else {
	  			if (domicileCode != null && !domicileCode.equals("")) {
	  				if(!"00".equals(domicileCode.substring(2, 4))) { //非省级
	  					if ("00".equals(domicileCode.substring(4, 6))
	  							&& "00000000".equals(domicileCode.substring(4))) { // 市级
	  						sql.append(" AND DOMICILE_CODE like  ? ");
	  						argsList.add(domicileCode.substring(0, 4)+"%");
	  					} else if("000000".equals(domicileCode.substring(6))) { //县级
	  						sql.append(" AND DOMICILE_CODE like  ? ");
	  						argsList.add(domicileCode.substring(0, 6)+"%");
	  					} else if("000".equals(domicileCode.substring(9))) { //街道
	  						sql.append(" AND DOMICILE_CODE like  ? ");
	  						argsList.add(domicileCode.substring(0, 9)+"%");
	  					} else { //村
	  						sql.append(" AND DOMICILE_CODE = ? ");
	  						argsList.add(domicileCode);
	  					}
	  				} else { //省级
	  					sql.append(" AND DOMICILE_CODE like  ? ");
	  					argsList.add(domicileCode.substring(0, 2)+"%");
	  				}
	  			} else {
	  				organCode=FilterLimit.filterByOrganCode(sql,organCode);
	  				argsList.add(organCode);
	  			}
	  			typeList.add(Types.VARCHAR);
  			}
  			if (name != null && !name.equals("")) {
  				sql.append(" AND P.NAME LIKE ?") ;
  				typeList.add(Types.VARCHAR);
  				argsList.add("%" + name.trim() + "%");
  			}
  			if (idCard != null && !idCard.equals("")) {
  				sql.append(" AND P.ID_CARD LIKE ?") ;
  				typeList.add(Types.VARCHAR);
  				argsList.add("%" + idCard.trim() + "%");
  			}
  			if (domicileType != null && !domicileType.equals("")) {
  				sql.append(" AND DOMICILE_TYPE = ?") ;
  				typeList.add(Types.VARCHAR);
  				argsList.add(domicileType.trim());
  			}
  			if (asdpNo != null && !asdpNo.equals("")) {
  				sql.append(" AND D.ASDP_NO = ? ") ;
  				typeList.add(Types.VARCHAR);
  				argsList.add(asdpNo.trim());
  			}
  			if (forcesNo != null && !forcesNo.equals("")) {
  				sql.append(" AND D.FORCES_NO = ? ") ;
  				typeList.add(Types.VARCHAR);
  				argsList.add(forcesNo.trim());
  			}
  			if (warTypeCode != null && !warTypeCode.equals("")) {
  				sql.append(" AND D.WAR_TYPE_CODE = ? ") ;
  				typeList.add(Types.VARCHAR);
  				argsList.add(warTypeCode.trim());
  			}
  			if (objectState != null && !objectState.equals("")) {
  				sql.append(" AND WAR_STATE_CODE = ? ") ;
  				typeList.add(Types.VARCHAR);
  				argsList.add(objectState.trim());
  			}
  			if (note != null && !note.equals("")) {
  				sql.append(" AND D.NOTE LIKE ?") ;
  				typeList.add(Types.VARCHAR);
  				argsList.add("%" + note.trim() + "%");
  			}
  			if ((endTime != null && !"".equals(endTime))
  					|| (startTime != null && !"".equals(startTime))) {
  				if(endTime == null || "".equals(endTime)) {
  					endTime = DateUtil.getDay();
  				}
  				if(startTime == null || "".equals(startTime)) {
  					startTime = "1900-01-01";
  				}
  				sql.append(" AND TO_DATE(D.APPROVAL_DATE, 'YYYY-MM-DD') BETWEEN  TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD')");
  				typeList.add(Types.VARCHAR);
  				argsList.add(startTime);
  				typeList.add(Types.VARCHAR);
  				argsList.add(endTime);
  			}
  			if (ageBegin != null && !"".equals(ageBegin)) {
  				sql.append(" AND GETAGE(P.BIRTHDAY) >= ?");
  				typeList.add(Types.INTEGER);
  				argsList.add(Integer.parseInt(ageBegin));
  			}
  			if (ageEnd != null && !"".equals(ageEnd)) {
  				sql.append(" AND GETAGE(P.BIRTHDAY) <= ?");
  				typeList.add(Types.INTEGER);
  				argsList.add(Integer.parseInt(ageEnd));
  			}
  			sql.append(" ORDER BY P.DOMICILE_CODE,P.NAME");
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
	 * 查询未提交参战人员
	 * @param pSet
	 * @return
	 */
	public DataSet queryUnCommitWar(ParameterSet pset) {
		StringBuffer bf = new StringBuffer();
		bf.append(" SELECT BA.APPLY_ID, P.PEOPLE_ID AS PEOPLE_ID,FAMILY_ID,DOMICILE_CODE,P.NAME AS NAME,");
		bf.append(" ID_CARD,SEX, NATION, WAR_STATE_CODE,DOMICILE_TYPE,D.ASDP_NO, D.FORCES_NO,");
		bf.append(" D.WAR_TYPE_CODE,C.FULL_NAME AS DICNAME,D.NOTE,D.REG_TIME");
		bf.append(" FROM BASEINFO_PEOPLE P, BPT_PEOPLE_WAR D, BPT_PEOPLE T, DIC_CITY C,BPT_APPLY_DEPENDANT BA");
		bf.append(" WHERE P.PEOPLE_ID = D.PEOPLE_ID  AND D.PEOPLE_ID = T.PEOPLE_ID");
		bf.append(" AND DOMICILE_CODE = C.ID AND P.WAR_FLAG = '1' AND BA.PEOPLE_ID = P.PEOPLE_ID");
		bf.append(" AND BA.COMMIT_FLAG = '0' AND  P.PERSONAL_STATS_TAG != '4' AND T.WAR_TYPE_CODE='51' AND BA.OBJECT_TYPE='5' ");
		String domicileCode = (String)pset.getParameter("domicileCode");
		String organCode = (String) pset.getParameter("organCode");
		DataSet ds = new DataSet();
		if (domicileCode != null && !domicileCode.equals("")) {
			domicileCode=FilterLimit.filterByOrganCode(bf,domicileCode);
			ds = executeDataset(bf.toString(),new int[]{Types.VARCHAR},new Object[]{domicileCode},pset.getPageStart(),pset.getPageLimit(), true);
		}else{
			organCode=FilterLimit.filterByOrganCode(bf,organCode);
			ds = executeDataset(bf.toString(),new int[]{Types.VARCHAR},new Object[]{organCode},pset.getPageStart(),pset.getPageLimit(), true);
		}
		return ds;
	}
}
