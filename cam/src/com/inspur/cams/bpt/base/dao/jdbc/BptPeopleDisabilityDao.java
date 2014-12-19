package com.inspur.cams.bpt.base.dao.jdbc;

import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.bpt.base.dao.IBptPeopleDisabilityDao;
import com.inspur.cams.bpt.base.data.BptPeopleDisability;
import com.inspur.cams.bpt.util.BptConstant;
import com.inspur.cams.bpt.util.BptGetAge;
import com.inspur.cams.bpt.util.FilterLimit;
import com.inspur.cams.comm.util.DateUtil;

/**
 * @title:BptPeopleDisabilityDao
 * @description:
 * @author:
 * @since:2011-05-13
 * @version:1.0
 */
public class BptPeopleDisabilityDao extends EntityDao<BptPeopleDisability>
		implements IBptPeopleDisabilityDao {

	public BptPeopleDisabilityDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class<BptPeopleDisability> getEntityClass() {
		return BptPeopleDisability.class;
	}

	public void deleteByBaseinfoPeople(String fkId) {
		executeUpdate("DELETE FROM  BPT_PEOPLE_DISABILITY WHERE PEOPLE_ID= ? ",new int[] { Types.VARCHAR }, new Object[] { fkId });
	}

	public void batchDeleteByBaseinfoPeople(String[] fkId) {
		for (int i = 0; i < fkId.length; i++) {
			executeUpdate("DELETE FROM BPT_PEOPLE_DISABILITY WHERE PEOPLE_ID= ?",new int[] { Types.VARCHAR }, new Object[] { fkId[i] });
		}
	}

	/**
	 * 查询伤残人员信息及其相应的优抚信息（优抚对象类型）
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryDisabilityBPTPeople(ParameterSet pset) {
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT   ");
						sql.append("A.PEOPLE_ID,FAMILY_ID,RELATIONSHIP_TYPE,DOMICILE_CODE,APANAGE_CODE,NAME,ID_CARD_TYPE,ID_CARD,PHOTO,SEX,BIRTHDAY,");
						sql.append("NATION,EDU_CODE,HEALTH_CODE,MARRIAGE_CODE,CAREER_CODE,POLITICAL_CODE,DOMICILE_TYPE,TEL_MOBILE,TEL_OTHER,ADDRESS,");
						sql.append("POST_CODE,INCOME_YEAR,INCOME_MONTH,EMPLOYMENT_CODE,WORK_UNIT_NAME,WORK_UNIT_TEL,WORK_UNIT_ADD,SAFEGUARD_TYPE,");
						sql.append("MEDICAL_CODE,CITY_RESI_FLAG,RURAL_RESI_FLAG,RURAL_FIVEGUA_FLAG,DISABILITY_FLAG,a.DISABILITY_LEVEL_CODE,a.DISABILITY_CASE_CODE,");
						sql.append("REDA_FLAG,DEPENDANT_FLAG,DEMOBILIZED_FLAG,WAR_FLAG,DISABILITY_NO,REDA_NO,DEPENDANT_NO,DEMOBILIZED_NO,WAR_NO,DISABILITY_STATE_CODE,");
						sql.append("REDA_STATE_CODE,DEPENDANT_STATE_CODE,DEMOBILIZED_STATE_CODE,WAR_STATE_CODE,PERSONAL_STATS_TAG,");
						sql.append("CASE    WHEN B.DISABILITY_TYPE_CODE !='00' THEN  DISABILITY_TYPE_CODE ");
						sql.append("        WHEN B.DEPENDANT_TYPE_CODE !='00' THEN DEPENDANT_TYPE_CODE  ");
						sql.append("        WHEN B.REDA_TYPE_CODE !='00' THEN REDA_TYPE_CODE  ");
						sql.append("        WHEN B.DEMOBILIZED_TYEP_CODE !='00' THEN DEMOBILIZED_TYEP_CODE ");
						sql.append("        WHEN B.WAR_TYPE_CODE !='00' THEN WAR_TYPE_CODE  ");
						sql.append("END     AS OBJECT_TYPE,c.DISABILITY_GENUS_CODE");
						sql.append(" FROM BASEINFO_PEOPLE A, BPT_PEOPLE B,BPT_PEOPLE_DISABILITY C ");
						sql.append(" WHERE A.PEOPLE_ID = B.PEOPLE_ID AND A.PEOPLE_ID = C.PEOPLE_ID AND ");
						sql.append(" A.DISABILITY_FLAG = '1'");
		
		String domicileCode = (String) pset.getParameter("domicileCode")==null?"":(String) pset.getParameter("domicileCode");
		String name = (String) pset.getParameter("name")==null?"":(String) pset.getParameter("name");
		String idCard = (String) pset.getParameter("idCard")==null?"":(String) pset.getParameter("idCard");
		String nation = (String) pset.getParameter("nation")==null?"":(String) pset.getParameter("nation");
		String marriageCode = (String) pset.getParameter("marriageCode")==null?"":(String) pset.getParameter("marriageCode");
		String careerCode = (String) pset.getParameter("careerCode")==null?"":(String) pset.getParameter("careerCode");
		String politicalCode = (String) pset.getParameter("politicalCode")==null?"":(String) pset.getParameter("politicalCode");
		String domicileType = (String) pset.getParameter("domicileType")==null?"":(String) pset.getParameter("domicileType");

		if (domicileCode != null && !domicileCode.equals("")) {
			sql.append(" AND DOMICILE_CODE = ? ");// LIKE
			typeList.add(Types.VARCHAR);
			argsList.add(domicileCode.trim());
		}

		if (name != null && !name.equals("")) {
			sql.append(" AND ME LIKE ? ");// LIKE
			typeList.add(Types.VARCHAR);
			argsList.add("%'"+name.trim()+"'%");
		}

		if (idCard != null && !idCard.equals("")) {
			sql.append(" AND ID_CARD = ?  ");// LIKE
			typeList.add(Types.VARCHAR);
			argsList.add(idCard.trim());
		}

		if (nation != null && !nation.equals("")) {
			sql.append(" AND NATION = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(nation.trim());
		}

		if (marriageCode != null && !marriageCode.equals("")) {
			sql.append(" AND MARRIAGE_CODE = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(marriageCode.trim());
		}

		if (careerCode != null && !careerCode.equals("")) {
			sql.append(" AND CAREER_CODE = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(careerCode.trim());
		}

		if (politicalCode != null && !politicalCode.equals("")) {
			sql.append(" AND POLITICAL_CODE = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(politicalCode.trim());
		}

		if (domicileType != null && !domicileType.equals("")) {
			sql.append(" AND DOMICILE_TYPE = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(domicileType.trim());
		}
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			return this.executeDataset(sql.toString(),types, args, pset.getPageStart(), pset
					.getPageLimit(), true);
		} else {
			return this.executeDataset(sql.toString(), pset.getPageStart(), pset
					.getPageLimit(), true);
		}
	}

	/**
	 * 查询人员、类别【伤残】、优抚信息-----------或替代queryDisabilityBPTPeople
	 */
	public DataSet queryDisabilityBptPeople(ParameterSet pset) {
		DataSet ds = new DataSet();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		StringBuffer sqlfind = new StringBuffer();//查询数据
		String isprovinceMigrate = (String) pset.getParameter("cisprovinceMigrate");
		sqlfind.append("SELECT p.birthday,'' people_age, P.PEOPLE_ID AS PEOPLE_ID,\n");
						sqlfind.append("       FAMILY_ID,\n");
						sqlfind.append("       DOMICILE_CODE,\n");
						sqlfind.append("       P.NAME AS NAME,\n");
						sqlfind.append("       P.DISABILITY_NO,\n");
						sqlfind.append("       P.PHOTO_ID,C.FULL_NAME||P.ADDRESS ADDRESS,\n");
						sqlfind.append("       D.NOTE,\n");
						sqlfind.append("       ID_CARD,\n");
						sqlfind.append("       SEX,\n");
						sqlfind.append("       NATION,\n");
						sqlfind.append("       DISABILITY_STATE_CODE,\n");
						sqlfind.append("       DOMICILE_TYPE,\n");
						sqlfind.append("       DISABILITY_TYPE_CODE,D.DISABILITY_BODY,\n");
						sqlfind.append("       D.DISABILITY_LEVEL_CODE AS DISABILITY_LEVEL_CODE,\n");
						sqlfind.append("       D.DISABILITY_CASE_CODE AS DISABILITY_CASE_CODE,\n");
						sqlfind.append("       DISABILITY_GENUS_CODE,\n");
						sqlfind.append("       DISABILITY_WAR_CODE,\n");
						sqlfind.append("       TEL_MOBILE,\n");
						sqlfind.append("       C.FULL_NAME DICNAME\n");
						if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
							sqlfind.append("  ,'1' as flag\n"); 
						}
						sqlfind.append("  FROM BASEINFO_PEOPLE P, BPT_PEOPLE_DISABILITY D, BPT_PEOPLE T,DIC_CITY C\n");
						if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
							sqlfind.append("  ,bpt_province_migrate e\n"); 
						}
						sqlfind.append(" WHERE P.PEOPLE_ID = D.PEOPLE_ID\n");
						sqlfind.append("   AND D.PEOPLE_ID = T.PEOPLE_ID\n");
						sqlfind.append("   AND DOMICILE_CODE = C.ID\n");
						sqlfind.append("   AND P.DISABILITY_FLAG = '1'\n");
						sqlfind.append("   AND P.PERSONAL_STATS_TAG != '4' ");
						if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
							sqlfind.append("  and p.people_id = e.people_id and e.service_type='16'\n"); 
						}
		StringBuffer sqlExcel = new StringBuffer();//导入到Excel
		sqlExcel.append("SELECT  p.birthday,'' people_age , P.PEOPLE_ID AS PEOPLE_ID,\n");
						sqlExcel.append("       DOMICILE_CODE,\n");
						sqlExcel.append("       P.NAME AS NAME,\n");
						sqlExcel.append("       P.DISABILITY_NO,\n");
						sqlExcel.append("       D.NOTE,\n");
						sqlExcel.append("       ID_CARD,\n");
						sqlExcel.append("       (case sex when '1' then '男' when '2' then '女'end) as psex ,\n");
						sqlExcel.append("       a.name as NATION,\n");
						sqlExcel.append("       (case DISABILITY_STATE_CODE when '1' then '受理' when '2' then '享受待遇' when '3' then '身份认定不享受待遇' when '4' then '停发' when '5' then '迁移' when '6' then '不予认定' when '7' then '去世' when '8' then '取消' when '9' then '中止'  end) as DISABILITY_STATE_CODE,\n");
						sqlExcel.append("       DOMICILE_TYPE,\n"); 
						sqlExcel.append("		(case T.disability_type_code when '11' then '残疾军人' when '12' then '伤残国家机关工作人员' when '13' then '伤残人民警察' when '14' then '伤残民兵民工' when '15' then '因战因公伤残人员' end ) as DISABILITY_TYPE_CODE,\n");
						sqlExcel.append("       dl.name AS DISABILITY_LEVEL_CODE,\n");
						sqlExcel.append("       dc.name AS DISABILITY_CASE_CODE,\n");
						sqlExcel.append("       g.name as DISABILITY_GENUS_CODE,\n");
						sqlExcel.append("       dbw.name as DISABILITY_WAR_CODE,\n");
						sqlExcel.append("       TEL_MOBILE,\n");
						sqlExcel.append("       C.FULL_NAME AS DICNAME\n"); 
						if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
							sqlExcel.append("  ,'1' as flag\n"); 
						}
						sqlExcel.append("  FROM BASEINFO_PEOPLE P, BPT_PEOPLE_DISABILITY D, BPT_PEOPLE T,DIC_CITY C,dic_nation a," );
						sqlExcel.append(" dic_disability_case dc,dic_disability_level dl,dic_disability_genus g,DIC_BPT_WAR dbw\n");
						if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
							sqlExcel.append("  ,bpt_province_migrate e\n"); 
						}
						sqlExcel.append(" WHERE P.PEOPLE_ID = D.PEOPLE_ID\n");
						sqlExcel.append("   AND D.PEOPLE_ID = T.PEOPLE_ID\n"); 
						sqlExcel.append("	  AND p.nation=a.code\n");
						sqlExcel.append("   AND DOMICILE_CODE = C.ID\n");
						sqlExcel.append("   AND P.DISABILITY_FLAG = '1'\n"); 
						sqlExcel.append("		and D.disability_case_code=dc.code(+) ");
						sqlExcel.append("		and D.disability_level_code=dl.code(+)" );
						sqlExcel.append("		and D.disability_genus_code=g.code" );
						sqlExcel.append("		and D.DISABILITY_WAR_CODE=dbw.code");
						sqlExcel.append("   AND P.PERSONAL_STATS_TAG != '4' ");
						if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
							sqlExcel.append("  and p.people_id = e.people_id and e.service_type='16'\n"); 
						}
		String isAll = (String) pset.getParameter("isAll");
		if("all".equals(isAll) || !pset.containsKey("limit")){
			sql.append(sqlExcel);
		}else{
			sql.append(sqlfind);
		}
		String domicileCode = (String) pset.getParameter("domicileCode");
		String name = (String) pset.getParameter("name");
		String idCard = (String) pset.getParameter("idCard");
		String domicileType = (String) pset.getParameter("domicileType");
		String disabilityStateCode = (String) pset.getParameter("disabilityStateCode");
		String disabilityTypeCode = (String) pset.getParameter("disabilityTypeCode");
		String disabilityLevelCode = (String) pset.getParameter("disabilityLevelCode");
		String disabilityCaseCode = (String) pset.getParameter("disabilityCaseCode");
		String disabilityGenusCode = (String) pset.getParameter("disabilityGenusCode");
		String disabilityWarCode = (String) pset.getParameter("disabilityWarCode");
		String organCode = (String) pset.getParameter("organCode");
		String disabilityNo = (String) pset.getParameter("disabilityNo");
		String note = (String) pset.getParameter("note");
		String phoneticCode = (String) pset.getParameter("phoneticCode");
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
						sql.append(" and domicile_code like  ? ");
						typeList.add(Types.VARCHAR);
						argsList.add(domicileCode.substring(0, 4)+"%");
					} else if("000000".equals(domicileCode.substring(6))) { //县级
						sql.append(" and domicile_code like ? ");
						typeList.add(Types.VARCHAR);
						argsList.add(domicileCode.substring(0, 6)+"%");
					} else if("000".equals(domicileCode.substring(9))) { //街道
						sql.append(" and domicile_code like ? ");
						typeList.add(Types.VARCHAR);
						argsList.add(domicileCode.substring(0, 9)+"%");
					} else { //村
						sql.append(" and domicile_code = ? ");
						typeList.add(Types.VARCHAR);
						argsList.add(domicileCode);
					}
				} else { //省级
					sql.append(" and domicile_code like  ? ");
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
			sql.append(" AND P.NAME LIKE ?");// LIKE
			typeList.add(Types.VARCHAR);
			argsList.add("%" + name.trim() + "%");
		}

		if (idCard != null && !idCard.equals("")) {
			sql.append(" AND P.ID_CARD LIKE ?");// LIKE
			typeList.add(Types.VARCHAR);
			argsList.add("%" + idCard.trim() + "%");
		}

		if (domicileType != null && !domicileType.equals("")) {
			sql.append(" AND P.DOMICILE_TYPE =?");
			typeList.add(Types.VARCHAR);
			argsList.add(domicileType.trim());
		}

		if (disabilityStateCode != null && !disabilityStateCode.equals("")) {
			sql.append(" AND DISABILITY_STATE_CODE =?");
			typeList.add(Types.VARCHAR);
			argsList.add(disabilityStateCode.trim());
		}

		if (disabilityTypeCode != null && !disabilityTypeCode.equals("")) {
			if(disabilityTypeCode.indexOf(",") != -1) {
				String[] types = disabilityTypeCode.split(",");
				for(int i=0;i<types.length;i++) {
					 if(i == 0) {
						 sql.append(" AND (DISABILITY_TYPE_CODE = ? ");
					 } else {
						 sql.append(" OR DISABILITY_TYPE_CODE = ?");
						 if(i == types.length - 1) {
							 sql.append(" )");
						 }
					 } 
					 typeList.add(Types.VARCHAR);
					 argsList.add(types[i]);
				}
			} else {
				sql.append(" AND DISABILITY_TYPE_CODE =?");
				 typeList.add(Types.VARCHAR);
				 argsList.add(disabilityTypeCode);
			}
 			
		}

		if (disabilityLevelCode != null && !disabilityLevelCode.equals("")) {
			if(disabilityLevelCode.indexOf(",") != -1) {
				String[] LevelCodes = disabilityLevelCode.split(",");
				for(int i=0;i<LevelCodes.length;i++) {
					 if(i == 0) {
						 sql.append(" AND (D.DISABILITY_LEVEL_CODE = ? ");
					 } else {
						 sql.append(" OR D.DISABILITY_LEVEL_CODE = ?");
						 if(i == LevelCodes.length - 1) {
							 sql.append(" )");
						 }
					 } 
					 typeList.add(Types.VARCHAR);
					 argsList.add(LevelCodes[i]);
				}
			} else {
				sql.append(" AND D.DISABILITY_LEVEL_CODE =?");
				 typeList.add(Types.VARCHAR);
				 argsList.add(disabilityLevelCode);
			}
		}

		if (disabilityCaseCode != null && !disabilityCaseCode.equals("")) {
			sql.append(" AND D.DISABILITY_CASE_CODE =?");
			typeList.add(Types.VARCHAR);
			argsList.add(disabilityCaseCode.trim());
		}

		if (disabilityGenusCode != null && !disabilityGenusCode.equals("")) {
			sql.append(" AND DISABILITY_GENUS_CODE =?");
			typeList.add(Types.VARCHAR);
			argsList.add(disabilityGenusCode.trim());
		}

		if (disabilityWarCode != null && !disabilityWarCode.equals("")) {
			sql.append(" AND DISABILITY_WAR_CODE =?");
			typeList.add(Types.VARCHAR);
			argsList.add(disabilityWarCode.trim());
		}

		if (disabilityNo != null && !disabilityNo.equals("")) {
			sql.append(" AND P.DISABILITY_NO =?");
			typeList.add(Types.VARCHAR);
			argsList.add(disabilityNo.trim());
		}
		if (note != null && !note.equals("")) {
			sql.append(" AND D.NOTE LIKE ?");
			typeList.add(Types.VARCHAR);
			argsList.add("%" + note.trim() + "%");
		}
		if (phoneticCode != null && !phoneticCode.equals("")) {
			sql.append(" AND P.PHONETIC_CODE= ?");
			typeList.add(Types.VARCHAR);
			argsList.add(phoneticCode.trim());
		}

		if ((endTime != null && !"".equals(endTime))
				|| (startTime != null && !"".equals(startTime))) {
			if(endTime == null || "".equals(endTime)) {
				endTime = DateUtil.getDay();
			}
			if(startTime == null || "".equals(startTime)) {
				startTime = "1900-01-01";
			}
			sql.append(" and to_date(D.approve_date, 'yyyy-mm-dd') between to_date(?, 'yyyy-mm-dd') and to_date(?, 'yyyy-mm-dd')");
			typeList.add(Types.VARCHAR);
			argsList.add(startTime);
			typeList.add(Types.VARCHAR);
			argsList.add(endTime);
		}
		if (ageBegin != null && !"".equals(ageBegin)) {
			sql.append(" AND getage(p.birthday) >= ?");
			typeList.add(Types.INTEGER);
			argsList.add(Integer.parseInt(ageBegin));
		}
		if (ageEnd != null && !"".equals(ageEnd)) {
			sql.append(" AND getage(p.birthday) <= ?");
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
	 * 查询未提交的伤残人员信息【审批】
	 */
	public DataSet queryUnCommitDisPeo(ParameterSet pset) {
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
						sql.append(" SELECT P.PHOTO_ID,C.FULL_NAME AS DOMI_NAME,D.NOTE");
						sql.append( "       DOMICILE_CODE,\n");
						sql.append( "       P.FAMILY_ID             AS FAMILY_ID,\n");
						sql.append( "       P.NAME,\n");
						sql.append( "       P.SEX,\n");
						sql.append( "       P.NATION,\n");
						sql.append( "       P.ID_CARD,\n");
						sql.append("       P.REG_TIME,\n");
						sql.append("       P.DISABILITY_STATE_CODE,\n");
						sql.append("       B.DISABILITY_TYPE_CODE,\n");
						sql.append("       D.DISABILITY_LEVEL_CODE,\n");
						sql.append("       D.DISABILITY_CASE_CODE,\n");
						sql.append("       D.DISABILITY_GENUS_CODE,\n");
						sql.append("       D.PEOPLE_ID,\n");
						sql.append("       A.APPLY_ID\n");
						sql.append(" FROM BASEINFO_PEOPLE       P,\n");
						sql.append("       BPT_PEOPLE            B,\n");
						sql.append("       BPT_PEOPLE_DISABILITY D,\n");
						sql.append("       DIC_CITY C,\n");
						sql.append("       BPT_APPLY_DISABILITY  A\n");
						sql.append(" WHERE P.PEOPLE_ID = B.PEOPLE_ID\n");
						sql.append("   AND B.PEOPLE_ID = D.PEOPLE_ID\n");
						sql.append("   AND A.PEOPLE_ID = P.PEOPLE_ID\n");
						sql.append("   AND P.DISABILITY_FLAG = '1'\n");
						sql.append("   AND A.COMMIT_FLAG = '0'\n");
						sql.append("   AND P.PERSONAL_STATS_TAG != '4' AND P.DOMICILE_CODE = C.ID");

		sql.append(" AND A.SERVICE_TYPE = ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(BptConstant.BPT_DISABILITY_ASSESS);
		String organCode = (String) pset.getParameter("organCode")==null?"":(String) pset.getParameter("organCode");
		organCode=FilterLimit.filterByOrganCode(sql,organCode);			
		typeList.add(Types.VARCHAR);
		argsList.add(organCode);
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			return this.executeDataset(sql.toString(),types, args, pset.getPageStart(), pset
					.getPageLimit(), true);
		} else {
			return this.executeDataset(sql.toString(), pset.getPageStart(), pset
					.getPageLimit(), true);
		}
	}

	/**
	 * 查询评定、调整伤残等级审批表[表头信息]
	 */
	public DataSet queryDisabilityApproveHeader(String peopleId) {
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT B.PEOPLE_ID,B.NAME,B.SEX,B.NATION,B.BIRTHDAY,B.ID_CARD,B.ADDRESS,B.DOMICILE_CODE,D.CONSCRIPT_DATE,D.VETERANS_DATE,");
		    	sql.append("D.DISABILITY_GENUS_CODE,D.UINIT_OF_DISABILITY,D.DISABILITY_CASE_CODE,D.DISABILITY_LEVEL_CODE,D.DISABILITY_DATE,");
		    	sql.append("D.DISABILITY_ADD,D.DISABILITY_BODY,D.DISABILITY_REASON,A.SERVICE_TYPE,F.FAMILY_ID");
		    	sql.append(" FROM BASEINFO_PEOPLE B,BPT_PEOPLE_DISABILITY D,BPT_APPLY_DISABILITY A,BASEINFO_FAMILY F ");
		    	sql.append("WHERE B.PEOPLE_ID = ? ");
				sql.append(" AND D.PEOPLE_ID= ? ");
				sql.append(" AND A.PEOPLE_ID= ? ");
				sql.append(" AND B.FAMILY_ID = F.FAMILY_ID");
		return this.executeDataset(sql.toString(), new int[] { Types.VARCHAR,Types.VARCHAR,Types.VARCHAR },new Object[] { peopleId,peopleId,peopleId },true);
	}

	/**
	 * 根据身份证查询伤残人员信息
	 * 
	 * @param pset
	 * @return
	 */
	public List queryDisabilityByIdCard(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT B.ID_CARD,B.PEOPLE_ID,B.FAMILY_ID,B.NAME,B.SEX,B.NATION,B.BIRTHDAY, B.DOMICILE_ADDRESS,B.ADDRESS,B.DISABILITY_NO,");
		sql.append(" D.CONSCRIPT_DATE,D.VETERANS_DATE,D.RETIRED_DATE,D.APPROVE_DATE,D.DISABILITY_LEVEL_CODE,D.DISABILITY_CASE_CODE,");
		sql.append(" D.DISABILITY_WAR_CODE,D.DISABILITY_GENUS_CODE, D.UINIT_OF_DISABILITY,D.DISABILITY_DATE,");
		sql.append(" C.FULL_NAME AS DOMICILE_NAME,E.FULL_NAME AS APANAGE_NAME,P.DISABILITY_TYPE_CODE");
		sql.append(" FROM BASEINFO_PEOPLE B,BPT_PEOPLE_DISABILITY D,DIC_CITY C ,BPT_PEOPLE P");
		sql.append(" WHERE B.PEOPLE_ID=D.PEOPLE_ID AND C.ID=B.DOMICILE_CODE AND E.ID=B.APANAGE_CODE");
		sql.append(" AND P.PEOPLE_ID=B.PEOPLE_ID AND B.DISABILITY_FLAG='1' AND B.ID_CARD=?");
		String idCard = "";
		if (pset.containsKey("idCard")) {
			idCard = (String) pset.get("idCard");
		}
		return this.executeQuery(sql.toString(), new int[] { Types.VARCHAR }, new Object[] { idCard });
	}
}
