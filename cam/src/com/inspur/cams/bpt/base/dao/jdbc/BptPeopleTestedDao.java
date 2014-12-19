package com.inspur.cams.bpt.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.base.dao.IBptPeopleTestedDao;
import com.inspur.cams.bpt.base.data.BptPeopleTested;
import com.inspur.cams.bpt.util.BptGetAge;
import com.inspur.cams.bpt.util.FilterLimit;
import com.inspur.cams.comm.util.DateUtil;

/**
 * @title:BptPeopleTestedDao
 * @description:
 * @author:
 * @since:2011-05-14
 * @version:1.0
*/
 public class BptPeopleTestedDao extends EntityDao<BptPeopleTested> implements IBptPeopleTestedDao{

 	
  	@Override
	public Class<BptPeopleTested> getEntityClass() {
		return BptPeopleTested.class;
	}

	public DataSet getEmployment() {
		
		return this.executeDataset("SELECT CODE,NAME FROM DIC_BPT_PUB WHERE TYPE=13", false);
	}

	//删除参战参试
  	public void deleteWarTest(ParameterSet pset){
		String applyId =(String)pset.get("applyId");
		String peopleId =(String)pset.get("peopleId");
		String warOrTest =(String)pset.get("warOrTest");
		int[] type = new int[1];
		Object[] applyid = new Object[1];
		Object[] peopleid= new Object[1];
		type[0]=Types.VARCHAR;
		applyid[0]=applyId;
		peopleid[0]=peopleId;
		if(warOrTest!=null&&"war".equals(warOrTest)){
			this.executeUpdate("DELETE FROM BPT_PEOPLE_WAR D WHERE D.PEOPLE_ID=?",type,peopleid);
		}else{
			this.executeUpdate("DELETE FROM BPT_PEOPLE_TESTED D WHERE D.PEOPLE_ID=?",type,peopleid);
		}
		this.executeUpdate("DELETE BPT_DISABILITY_OPEN WHERE APPLY_ID=?", type, applyid);
		this.executeUpdate("DELETE BPT_DECISION_LETTER WHERE APPLY_ID=?", type, applyid);
		this.executeUpdate(" DELETE FROM BPT_APPLY_DEPENDANT A WHERE A.APPLY_ID=?",type,applyid);
		this.executeUpdate("UPDATE BPT_PEOPLE C  SET C.WAR_TYPE_CODE='00' WHERE C.PEOPLE_ID=?",type,peopleid);
		this.executeUpdate("UPDATE BASEINFO_PEOPLE B  SET B.WAR_FLAG='', B.WAR_NO='', B.WAR_STATE_CODE='0' WHERE B.PEOPLE_ID=?",type,peopleid);
	}
  	public DataSet queryTested(ParameterSet pset) {
  		DataSet ds = new DataSet();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		String isprovinceMigrate = (String) pset.getParameter("csisprovinceMigrate");
		StringBuffer sqlfind = new StringBuffer();
		sqlfind.append("SELECT P.BIRTHDAY,'' PEOPLE_AGE, P.PEOPLE_ID AS PEOPLE_ID, FAMILY_ID,\n");
		sqlfind.append("       DOMICILE_CODE, P.NAME AS NAME, ID_CARD, SEX, NATION, WAR_STATE_CODE,\n"); 
		sqlfind.append("       DOMICILE_TYPE, D.DISABILITY_LEVEL_CODE, D.FORCES_NO, D.TESTED_TYPE,\n"); 
		sqlfind.append("       C.FULL_NAME AS DICNAME, D.NOTE\n"); 
		if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
			sqlfind.append("  ,'1' as flag\n"); 
		}
		sqlfind.append("  FROM BASEINFO_PEOPLE P, BPT_PEOPLE_TESTED D, BPT_PEOPLE T, DIC_CITY C\n"); 
		if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
				sqlfind.append("  ,bpt_province_migrate e\n"); 
		}
		sqlfind.append(" WHERE P.PEOPLE_ID = D.PEOPLE_ID AND D.PEOPLE_ID = T.PEOPLE_ID AND\n"); 
		sqlfind.append("       DOMICILE_CODE = C.ID AND P.WAR_FLAG = '1' AND\n"); 
		sqlfind.append("       P.PERSONAL_STATS_TAG != '4' AND T.WAR_TYPE_CODE = '61'");
		if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
			sqlfind.append("  and P.people_id = e.people_id and e.service_type='63'\n"); 
		}
		StringBuffer sqlExcel = new StringBuffer();
		sqlExcel.append("SELECT DISTINCT P.BIRTHDAY,'' PEOPLE_AGE, P.PEOPLE_ID AS PEOPLE_ID,\n");
		sqlExcel.append("                FAMILY_ID, DOMICILE_CODE, P.NAME AS NAME, ID_CARD,\n"); 
		sqlExcel.append("                (CASE SEX\n"); 
		sqlExcel.append("                   WHEN '1' THEN '男'\n"); 
		sqlExcel.append("                   WHEN '2' THEN '女'\n"); 
		sqlExcel.append("                 END) AS SEX, N.NAME AS NATION,\n"); 
		sqlExcel.append("                (CASE WAR_STATE_CODE\n"); 
		sqlExcel.append("                   WHEN '1' THEN '受理'\n"); 
		sqlExcel.append("                   WHEN '2' THEN '享受待遇'\n"); 
		sqlExcel.append("                   WHEN '3' THEN '身份认定不享受待遇'\n"); 
		sqlExcel.append("                   WHEN '4' THEN '停发'\n"); 
		sqlExcel.append("                   WHEN '5' THEN '迁移'\n"); 
		sqlExcel.append("                   WHEN '6' THEN '不予认定'\n"); 
		sqlExcel.append("                   WHEN '7' THEN '去世'\n"); 
		sqlExcel.append("                   WHEN '8' THEN '取消'\n"); 
		sqlExcel.append("                   WHEN '9' THEN '中止'\n"); 
		sqlExcel.append("                 END) AS WAR_STATE_CODE, DOMICILE_TYPE,\n"); 
		sqlExcel.append("                DL.NAME AS DISABILITY_LEVEL_CODE, D.FORCES_NO,\n"); 
		sqlExcel.append("                (CASE D.TESTED_TYPE\n"); 
		sqlExcel.append("                   WHEN '1' THEN '原8023部队退役人员'\n"); 
		sqlExcel.append("                   WHEN '2' THEN '其他参加核试验军队退役人员'\n"); 
		sqlExcel.append("                 END) AS TESTED_TYPE, C.FULL_NAME AS DICNAME, D.NOTE\n"); 
		sqlExcel.append("  FROM BASEINFO_PEOPLE P, BPT_PEOPLE_TESTED D\n"); 
		sqlExcel.append("  LEFT JOIN DIC_DISABILITY_LEVEL DL\n"); 
		sqlExcel.append("    ON DL.CODE = D.DISABILITY_LEVEL_CODE, DIC_NATION N, BPT_PEOPLE T,\n"); 
		sqlExcel.append(" DIC_CITY C, DIC_DISABILITY_LEVEL L\n");
		if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
			sqlExcel.append("  ,bpt_province_migrate e\n"); 
		}
		sqlExcel.append(" WHERE P.PEOPLE_ID = D.PEOPLE_ID AND D.PEOPLE_ID = T.PEOPLE_ID AND\n"); 
		sqlExcel.append("       DOMICILE_CODE = C.ID AND P.NATION = N.CODE  AND P.WAR_FLAG = '1' AND\n"); 
		sqlExcel.append("       P.PERSONAL_STATS_TAG != '4' AND T.WAR_TYPE_CODE = '61'");
		if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
			sqlExcel.append("  and P.people_id = e.people_id and e.service_type='63'\n"); 
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
		String forcesNo = (String)pset.getParameter("forcesNo");
		String testedType = (String)pset.getParameter("testedType");
		String disabilityLevelCode = (String)pset.getParameter("disabilityLevelCode");
		String organCode = (String) pset.getParameter("organCode");
		String warStateCode = (String) pset.getParameter("warStateCode");
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
						sql.append(" AND DOMICILE_CODE like  ? ");
						typeList.add(Types.VARCHAR);
						argsList.add(domicileCode.substring(0, 2)+"%");
					}
				} else {
					organCode=FilterLimit.filterByOrganCode(sql,organCode);	
					typeList.add(Types.VARCHAR);
					argsList.add(organCode);
				}
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
		
		if (domicileType != null && !domicileType.equals("")) {
			sql.append(" AND DOMICILE_TYPE = ? ") ;
			typeList.add(Types.VARCHAR);
			argsList.add(domicileType.trim());
		}
		
		if (forcesNo != null && !forcesNo.equals("")) {
			sql.append(" AND D.FORCES_NO =?") ;
			typeList.add(Types.VARCHAR);
			argsList.add(forcesNo.trim());
		}
		
		if (testedType != null && !testedType.equals("")) {
			sql.append(" AND D.TESTED_TYPE =?") ;
			typeList.add(Types.VARCHAR);
			argsList.add(testedType.trim());
		}
		
		if (disabilityLevelCode != null && !disabilityLevelCode.equals("")) {
			sql.append(" AND D.DISABILITY_LEVEL_CODE =?") ;
			typeList.add(Types.VARCHAR);
			argsList.add( disabilityLevelCode.trim());
		}
		
		if (warStateCode != null && !warStateCode.equals("")) {
			sql.append(" AND WAR_STATE_CODE =?") ;
			typeList.add(Types.VARCHAR);
			argsList.add(warStateCode.trim());
		}
		if (note != null && !note.equals("")) {
			sql.append(" AND D.NOTE LIKE ?") ;
			typeList.add(Types.VARCHAR);
			argsList.add("%" +  note.trim() + "%");
		}
		if ((endTime != null && !"".equals(endTime))
				|| (startTime != null && !"".equals(startTime))) {
			if(endTime == null || "".equals(endTime)) {
				endTime = DateUtil.getDay();
			}
			if(startTime == null || "".equals(startTime)) {
				startTime = "1900-01-01";
			}
			sql.append(" AND TO_DATE(D.APPROVAL_DATE, 'YYYY-MM-DD') BETWEEN");
			sql.append("   TO_DATE(?, 'YYYY-MM-DD') AND");
			sql.append("   TO_DATE(?, 'YYYY-MM-DD')");
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
				ds = this.executeDataset(sql.toString(),types,args, pset.getPageStart(), pset
						.getPageLimit(), true);
			}
		} else {
			if("all".equals(isAll) || !pset.containsKey("limit")){
				ds = this.executeDataset(sql.toString(),true);
			} else {
				ds = this.executeDataset(sql.toString(), pset.getPageStart(), pset
						.getPageLimit(), true);
			}
		}
		for (int i = 0; i < ds.getCount(); i++) {
			
			String birth=(String)ds.getRecord(i).get("BIRTHDAY");
			ds.getRecord(i).set("PEOPLE_AGE",BptGetAge.getAgeByBirthday(birth));
		}
		return ds;
	}
	
	/**
	 * 查询未提交的参试人员信息
	 * @param pset
	 * @return
	 */
	public DataSet queryUnCommitTest(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT A.APPLY_ID, P.PEOPLE_ID AS PEOPLE_ID,FAMILY_ID,DOMICILE_CODE, P.NAME AS NAME,ID_CARD,");
		sql.append(" SEX,NATION,DOMICILE_TYPE, D.DISABILITY_LEVEL_CODE,D.FORCES_NO,D.REG_TIME,");
		sql.append(" D.TESTED_TYPE,C.FULL_NAME AS DICNAME,D.NOTE");
		sql.append(" FROM BASEINFO_PEOPLE P, BPT_PEOPLE_TESTED D, BPT_PEOPLE T, DIC_CITY C,BPT_APPLY_DEPENDANT A");
		sql.append(" WHERE P.PEOPLE_ID = D.PEOPLE_ID AND D.PEOPLE_ID = T.PEOPLE_ID");
		sql.append(" AND DOMICILE_CODE = C.ID  AND P.WAR_FLAG = '1'  AND A.PEOPLE_ID = P.PEOPLE_ID");
		sql.append(" AND P.PERSONAL_STATS_TAG != '4' AND T.WAR_TYPE_CODE='61' ");
		sql.append(" AND A.COMMIT_FLAG='0' AND A.OBJECT_TYPE='6'");
		String domicileCode = (String)pset.getParameter("domicileCode");
		String organCode = (String) pset.getParameter("organCode");
		String arg = "";
		if (domicileCode != null && !domicileCode.equals("")) {
			domicileCode=FilterLimit.filterByOrganCode(sql,domicileCode);
			arg = domicileCode;
		}else{
			organCode=FilterLimit.filterByOrganCode(sql,organCode);
			arg = organCode;
		}
		return this.executeDataset(sql.toString(),new int[]{Types.VARCHAR},new Object[]{arg},pset.getPageStart(),pset.getPageLimit(),true);
	}
	
	public DataSet queryTongJiTested(ParameterSet pset) {
  		DataSet ds = new DataSet();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		String isdemobilizedill = (String) pset.getParameter("isdemobilizedill");
		StringBuffer sqlfind = new StringBuffer();
		sql.append("SELECT b.PEOPLE_ID AS PEOPLE_ID, FAMILY_ID,\n");
		sql.append("       DOMICILE_CODE, b.NAME AS NAME, ID_CARD, SEX, NATION, WAR_STATE_CODE,\n"); 
		sql.append("       DOMICILE_TYPE, t.DISABILITY_LEVEL_CODE, t.FORCES_NO, t.TESTED_TYPE,\n"); 
		sql.append("       C.FULL_NAME AS DICNAME, t.NOTE\n"); 
		sql.append("  from baseinfo_people b, bpt_people p, bpt_people_tested t, DIC_CITY C\n"); 
		if("1".equals(isdemobilizedill)){
			sql.append("  ,bpt_people_demobilized_illness i \n"); 
		}

		sql.append("where b.people_id = p.people_id \n");
		sql.append("               and b.people_id = t.people_id \n"); 
		sql.append("               and b.domicile_code=c.id \n"); 
		
		if("1".equals(isdemobilizedill)){
			sql.append("               and i.people_id = b.people_id \n"); 
			sql.append("               and b.demobilized_flag='1' \n"); 
			sql.append("               and p.demobilized_tyep_code='42' \n"); 
			sql.append("               and b.demobilized_state_code='2'");
		}
		

		sql.append("               and b.war_flag = '1' \n");
		sql.append("               and b.war_state_code = '2' \n"); 
		sql.append("               and p.war_type_code = '61' \n"); 
		

		
		String domicileCode = (String)pset.getParameter("domicileCode");
		String name = (String)pset.getParameter("name");
		String idCard = (String)pset.getParameter("idCard");
		String domicileType = (String)pset.getParameter("domicileType");
		String forcesNo = (String)pset.getParameter("forcesNo");
		String testedType = (String)pset.getParameter("testedType");
		String disabilityLevelCode = (String)pset.getParameter("disabilityLevelCode");
		String organCode = (String) pset.getParameter("organCode");
		String warStateCode = (String) pset.getParameter("warStateCode");
		String lifehardorill = (String) pset.getParameter("lifehardorill");
		String note = (String) pset.getParameter("note");
		String startTime = (String) pset.getParameter("startTime");
		String endTime = (String) pset.getParameter("endTime");
		String ageBegin = (String) pset.getParameter("ageBegin");
		String ageEnd = (String) pset.getParameter("ageEnd");
		if (domicileCode != null && !domicileCode.equals("")) {
			if (!domicileCode.substring(0, 2).equals("00")
					&& domicileCode.substring(2, 4).equals("00")) {
				sql.append(" AND b.domicile_code like ?");// 省局
				typeList.add(Types.VARCHAR);
				argsList.add(domicileCode.substring(0, 2)+"%");
			} else if (!domicileCode.substring(2, 4).equals("00")
					&& domicileCode.substring(4).equals("00000000")) {
				sql.append(" AND b.domicile_code like ?");// 市局
				typeList.add(Types.VARCHAR);
				argsList.add(domicileCode.substring(0, 4)+"%");
			} else if (!domicileCode.substring(4, 6).equals("00")
					&& domicileCode.substring(6, 9).equals("000")) {
				sql.append(" AND b.domicile_code like ?");// 区县
				typeList.add(Types.VARCHAR);
				argsList.add(domicileCode.substring(0, 6)+"%");
			} else if (!domicileCode.substring(6, 9).equals("000")
					&& domicileCode.substring(9, 12).equals("000")) {
				sql.append(" AND b.domicile_code like ?");// 街道
				typeList.add(Types.VARCHAR);
				argsList.add(domicileCode.substring(0, 9)+"%");
			} else {
				sql.append(" AND p.domicile_code=?");// 社区
				typeList.add(Types.VARCHAR);
				argsList.add(domicileCode);
			}
		}else{
			if (!organCode.substring(0, 2).equals("00")
					&& organCode.substring(2, 4).equals("00")) {
				sql.append(" AND  b.domicile_code like ?");// 省局
				typeList.add(Types.VARCHAR);
				argsList.add(organCode.substring(0, 2)+"%");
			} else if (!organCode.substring(2, 4).equals("00")
					&& organCode.substring(4, 6).equals("00")) {
				sql.append(" AND b.domicile_code like ?");// 市局
				typeList.add(Types.VARCHAR);
				argsList.add(organCode.substring(0, 4)+"%");
			} else {
				sql.append(" AND b.domicile_code like ?");// 区县
				typeList.add(Types.VARCHAR);
				argsList.add(organCode.substring(0, 6)+"%");
			}
		}
		
		if (name != null && !name.equals("")) {
			sql.append(" AND b.NAME LIKE ? ") ;
			typeList.add(Types.VARCHAR);
			argsList.add("%" + name.trim() + "%");
		}
		
		if (idCard != null && !idCard.equals("")) {
			sql.append(" AND b.ID_CARD LIKE ? ") ;
			typeList.add(Types.VARCHAR);
			argsList.add("%" + idCard.trim() + "%");
		}
		
		if (domicileType != null && !domicileType.equals("")) {
			sql.append(" AND b.DOMICILE_TYPE = ? ") ;
			typeList.add(Types.VARCHAR);
			argsList.add(domicileType.trim());
		}
		
		if (forcesNo != null && !forcesNo.equals("")) {
			sql.append(" AND t.FORCES_NO =?") ;
			typeList.add(Types.VARCHAR);
			argsList.add(forcesNo.trim());
		}
		
		if (testedType != null && !testedType.equals("")) {
			sql.append(" AND t.TESTED_TYPE =?") ;
			typeList.add(Types.VARCHAR);
			argsList.add(testedType.trim());
		}
		if("all".equals(disabilityLevelCode)){
			
		}else if (disabilityLevelCode != null && !disabilityLevelCode.equals("")) {
			sql.append(" AND t.DISABILITY_LEVEL_CODE =?") ;
			typeList.add(Types.VARCHAR);
			argsList.add( disabilityLevelCode.trim());
		}else{
			sql.append(" AND t.DISABILITY_LEVEL_CODE in ('01','02','03','04','05','06','07','08','09','10') ") ;
		}
		
		if (warStateCode != null && !warStateCode.equals("")) {
			sql.append(" AND WAR_STATE_CODE =?") ;
			typeList.add(Types.VARCHAR);
			argsList.add(warStateCode.trim());
		}
		if (note != null && !note.equals("")) {
			sql.append(" AND t.NOTE LIKE ?") ;
			typeList.add(Types.VARCHAR);
			argsList.add("%" +  note.trim() + "%");
		}
		if (lifehardorill != null && !lifehardorill.equals("")) {
			if("1".equals(lifehardorill)){
				sql.append("               and (t.health_state_code='10' or t.health_state_code ='20') \n"); 
			}else if("2".equals(lifehardorill)){
				sql.append("               and (t.health_state_code='30' or t.health_state_code ='60') \n"); 
			}else if("3".equals(lifehardorill)){
				sql.append("               and (t.health_state_code='10' or t.health_state_code ='20' or t.health_state_code='30' or t.health_state_code ='60') \n"); 
			}
		}
		if ((endTime != null && !"".equals(endTime))
				|| (startTime != null && !"".equals(startTime))) {
			if(endTime == null || "".equals(endTime)) {
				endTime = DateUtil.getDay();
			}
			if(startTime == null || "".equals(startTime)) {
				startTime = "1900-01-01";
			}
			sql.append(" AND TO_DATE(t.APPROVAL_DATE, 'YYYY-MM-DD') BETWEEN");
			sql.append("   TO_DATE(?, 'YYYY-MM-DD') AND");
			sql.append("   TO_DATE(?, 'YYYY-MM-DD')");
			typeList.add(Types.VARCHAR);
			argsList.add(startTime);
			typeList.add(Types.VARCHAR);
			argsList.add(endTime);
		}
		
		if (ageBegin != null && !"".equals(ageBegin)) {
			sql.append(" AND GETAGE(b.BIRTHDAY) >= ?");
			typeList.add(Types.INTEGER);
			argsList.add(Integer.parseInt(ageBegin));
		}

		if (ageEnd != null && !"".equals(ageEnd)) {
			sql.append(" AND GETAGE(b.BIRTHDAY) <= ?");
			typeList.add(Types.INTEGER);
			argsList.add(Integer.parseInt(ageEnd));
		}
		sql.append(" ORDER BY b.DOMICILE_CODE,b.NAME");
		if(typeList.size() != 0 && argsList.size()!= 0) {
			int[] types = new int[typeList.size()];
			for(int i=0;i<typeList.size();i++) {
				types[i]=(Integer)(typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			if( !pset.containsKey("limit")){
				ds = this.executeDataset(sql.toString(), types,args,true);
			} else {
				ds = this.executeDataset(sql.toString(),types,args, pset.getPageStart(), pset
						.getPageLimit(), true);
			}
		}
		return ds;
	}
}
