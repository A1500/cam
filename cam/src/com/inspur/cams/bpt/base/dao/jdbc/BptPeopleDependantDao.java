package com.inspur.cams.bpt.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.bpt.base.dao.IBptPeopleDependantDao;
import com.inspur.cams.bpt.base.data.BptPeopleDependant;
import com.inspur.cams.bpt.util.BptGetAge;
import com.inspur.cams.bpt.util.FilterLimit;
import com.inspur.cams.comm.util.DateUtil;

/**
 * @title:BptPeopleDependantDao
 * @description:
 * @author:
 * @since:2011-05-19
 * @version:1.0
*/
 public class BptPeopleDependantDao extends EntityDao<BptPeopleDependant> implements IBptPeopleDependantDao{
 	public BptPeopleDependantDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}
  	@Override
	public Class<BptPeopleDependant> getEntityClass() {
		return BptPeopleDependant.class;
	}
   /**
	 * 查找人员、三属和优抚信息
	 */
   public DataSet queryDepePeo(ParameterSet pset){
	   DataSet ds = new DataSet();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
	   StringBuffer sql = new StringBuffer();
		StringBuffer sqlfind = new StringBuffer();
		String isprovinceMigrate = (String) pset.getParameter("sisprovinceMigrate");
		sqlfind.append("SELECT P.BIRTHDAY,'' PEOPLE_AGE, P.PEOPLE_ID AS PEOPLE_ID, FAMILY_ID,\n");
		sqlfind.append("       DOMICILE_CODE, P.NAME AS NAME, ID_CARD, SEX, NATION, DOMICILE_TYPE,\n"); 
		sqlfind.append("       DEPENDANT_STATE_CODE, DEPENDANT_TYPE_CODE, TEL_MOBILE, LEZSW_NAME,\n"); 
		sqlfind.append("       LEZSW_APPROVE_DATE, DEPENDANT_NO, C.FULL_NAME AS DICNAME, D.NOTE\n"); 
		if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
			sqlfind.append("  ,'1' as flag\n"); 
		}
		sqlfind.append("  FROM BASEINFO_PEOPLE P, BPT_PEOPLE_DEPENDANT D, BPT_PEOPLE T, DIC_CITY C\n"); 
		if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
			sqlfind.append("  ,bpt_province_migrate e\n"); 
		}
		sqlfind.append(" WHERE P.PEOPLE_ID = D.PEOPLE_ID AND D.PEOPLE_ID = T.PEOPLE_ID AND\n"); 
		sqlfind.append("       DOMICILE_CODE = C.ID AND P.DEPENDANT_FLAG = '1' AND\n"); 
		sqlfind.append("       P.PERSONAL_STATS_TAG != '4'");
		if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
			sqlfind.append("  and p.people_id = e.people_id \n"); 
		}
		StringBuffer sqlExcel = new StringBuffer();
		sqlExcel.append("SELECT P.BIRTHDAY,'' PEOPLE_AGE, P.PEOPLE_ID AS PEOPLE_ID,\n");
		sqlExcel.append("       DOMICILE_CODE, P.NAME AS NAME, ID_CARD,\n"); 
		sqlExcel.append("       (CASE SEX\n"); 
		sqlExcel.append("          WHEN '1' THEN '男'\n"); 
		sqlExcel.append("          WHEN '2' THEN '女'\n"); 
		sqlExcel.append("        END) AS SEX, A.NAME AS NATION, DOMICILE_TYPE,\n"); 
		sqlExcel.append("       (CASE DEPENDANT_TYPE_CODE\n"); 
		sqlExcel.append("          WHEN '11' THEN '残疾军人'\n"); 
		sqlExcel.append("          WHEN '12' THEN '伤残国家机关工作人员'\n"); 
		sqlExcel.append("          WHEN '13' THEN '伤残人民警察'\n"); 
		sqlExcel.append("          WHEN '14' THEN '伤残民兵民工'\n"); 
		sqlExcel.append("          WHEN '15' THEN '因战因公伤残人员'\n"); 
		sqlExcel.append("          WHEN '21' THEN '烈士家属'\n"); 
		sqlExcel.append("          WHEN '22' THEN '因公牺牲军人家属'\n"); 
		sqlExcel.append("          WHEN '23' THEN '病故军人家属'\n"); 
		sqlExcel.append("          WHEN '31' THEN '在乡退伍红军老战士'\n"); 
		sqlExcel.append("          WHEN '32' THEN '在乡西路军红军老战士'\n"); 
		sqlExcel.append("          WHEN '33' THEN '红军失散人员'\n"); 
		sqlExcel.append("          WHEN '41' THEN '在乡复员军人'\n"); 
		sqlExcel.append("          WHEN '42' THEN '带病回乡复员军人'\n"); 
		sqlExcel.append("          WHEN '51' THEN '参战'\n"); 
		sqlExcel.append("          WHEN '61' THEN '参试'\n"); 
		sqlExcel.append("        END) AS DEPENDANT_TYPE,\n"); 
		sqlExcel.append("       (CASE DEPENDANT_STATE_CODE\n"); 
		sqlExcel.append("          WHEN '1' THEN '受理'\n"); 
		sqlExcel.append("          WHEN '2' THEN '享受待遇'\n"); 
		sqlExcel.append("          WHEN '3' THEN '身份认定不享受待遇'\n"); 
		sqlExcel.append("          WHEN '4' THEN '停发'\n"); 
		sqlExcel.append("          WHEN '5' THEN '迁移'\n"); 
		sqlExcel.append("          WHEN '6' THEN '不予认定'\n"); 
		sqlExcel.append("          WHEN '7' THEN '去世'\n"); 
		sqlExcel.append("          WHEN '8' THEN '取消'\n"); 
		sqlExcel.append("          WHEN '9' THEN '中止'\n"); 
		sqlExcel.append("        END) AS DEPENDANT_STATE, TEL_MOBILE, LEZSW_NAME, LEZSW_APPROVE_DATE,\n"); 
		sqlExcel.append("       DEPENDANT_NO, C.FULL_NAME AS DICNAME, D.NOTE\n"); 
		sqlExcel.append("  FROM BASEINFO_PEOPLE P, BPT_PEOPLE_DEPENDANT D, BPT_PEOPLE T, DIC_CITY C,\n"); 
		sqlExcel.append("       DIC_NATION A\n"); 
		if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
			sqlExcel.append("  ,bpt_province_migrate e\n"); 
		}
		sqlExcel.append(" WHERE P.PEOPLE_ID = D.PEOPLE_ID AND D.PEOPLE_ID = T.PEOPLE_ID AND\n"); 
		sqlExcel.append("       P.NATION = A.CODE AND DOMICILE_CODE = C.ID AND\n"); 
		sqlExcel.append("       P.DEPENDANT_FLAG = '1' AND P.PERSONAL_STATS_TAG != '4'");
		if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
			sqlExcel.append("  and p.people_id = e.people_id and e.service_type='23'\n"); 
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
		String disabilityStateCode = (String)pset.getParameter("disabilityStateCode");
		String dependantTypeCode = (String)pset.getParameter("dependantTypeCode");
		String organCode = (String) pset.getParameter("organCode");
		String dependantNo = (String) pset.getParameter("dependantNo");
		String note = (String) pset.getParameter("note");
		String startTime = (String)pset.getParameter("startTime");
		String endTime = (String)pset.getParameter("endTime");
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
						sql.append(" and domicile_code like ? ");
						typeList.add(Types.VARCHAR);
						argsList.add(domicileCode.substring(0, 4)+"%");
					} else if("000000".equals(domicileCode.substring(6))) { //县级
						sql.append(" and domicile_code like  ? ");
						typeList.add(Types.VARCHAR);
						argsList.add(domicileCode.substring(0, 6)+"%");
					} else if("000".equals(domicileCode.substring(9))) { //街道
						sql.append(" and domicile_code like  ? ");
						typeList.add(Types.VARCHAR);
						argsList.add(domicileCode.substring(0, 9)+"%");
					} else { //村
						sql.append(" and domicile_code = ? ");
						typeList.add(Types.VARCHAR);
						argsList.add(domicileCode);
					}
				} else { //省级
					sql.append(" and domicile_code like ? ");
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
			sql.append(" AND P.NAME LIKE ?") ;//LIKE
			typeList.add(Types.VARCHAR);
			argsList.add("%" + name.trim() + "%");
		}
		if (idCard != null && !idCard.equals("")) {
			sql.append(" AND P.ID_CARD LIKE ?") ;//LIKE
			typeList.add(Types.VARCHAR);
			argsList.add("%" + idCard.trim() + "%");
		}
		if (domicileType != null && !domicileType.equals("")) {
			sql.append(" AND DOMICILE_TYPE =?") ;
			typeList.add(Types.VARCHAR);
			argsList.add(domicileType.trim());
		}
		if (disabilityStateCode != null && !disabilityStateCode.equals("")) {
			sql.append(" AND DEPENDANT_STATE_CODE =?");
			typeList.add(Types.VARCHAR);
			argsList.add(disabilityStateCode.trim());
		}
		if (dependantTypeCode != null && !dependantTypeCode.equals("")) {
			if(dependantTypeCode.indexOf(",") != -1) {
				String[] types = dependantTypeCode.split(",");
				for(int i=0;i<types.length;i++) {
					 if(i == 0) {
						 sql.append(" AND (DEPENDANT_TYPE_CODE = ? ");
					 } else {
						 sql.append(" OR DEPENDANT_TYPE_CODE = ?");
						 if(i == types.length - 1) {
							 sql.append(" )");
						 }
					 } 
					 typeList.add(Types.VARCHAR);
					 argsList.add(types[i]);
				}
			} else {
				sql.append(" AND DEPENDANT_TYPE_CODE =?");
				 typeList.add(Types.VARCHAR);
				 argsList.add(dependantTypeCode);
			}
		}
		if (dependantNo != null && !dependantNo.equals("")) {
			sql.append(" AND DEPENDANT_NO = ?") ;
			typeList.add(Types.VARCHAR);
			argsList.add(dependantNo.trim());
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
			sql.append(" and to_date(D.approval_date, 'yyyy-mm-dd') between to_date(?, 'yyyy-mm-dd') and to_date(?, 'yyyy-mm-dd')");
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
		sql.append(" ORDER BY P.DOMICILE_CODE,P.NAME") ;
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
	 * 查询未提交的三属信息
	 * @param pset
	 * @return
	 */
	public DataSet queryUncommitDependant(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT BP.APPLY_ID,P.PHOTO_ID, P.PEOPLE_ID AS PEOPLE_ID,FAMILY_ID,DOMICILE_CODE,P.NAME AS NAME,");
		sql.append(" D.LEZSW_SEX,ID_CARD, SEX,NATION,DOMICILE_TYPE,DEPENDANT_TYPE_CODE,D.REG_TIME,");
		sql.append(" TEL_MOBILE,LEZSW_NAME,LEZSW_APPROVE_DATE,C.FULL_NAME AS DICNAME,D.NOTE");
		sql.append(" FROM BASEINFO_PEOPLE P, BPT_PEOPLE_DEPENDANT D, BPT_PEOPLE T,DIC_CITY C,BPT_APPLY_DEPENDANT BP");
		sql.append(" WHERE P.PEOPLE_ID = D.PEOPLE_ID AND D.PEOPLE_ID = T.PEOPLE_ID AND DOMICILE_CODE = C.ID AND BP.PEOPLE_ID= D.PEOPLE_ID");
		sql.append(" AND P.DEPENDANT_FLAG = '1' AND P.PERSONAL_STATS_TAG != '4' AND BP.COMMIT_FLAG='0' AND BP.OBJECT_TYPE='2'");
		String organCode = (String) pset.getParameter("organCode");
		organCode=FilterLimit.filterByOrganCode(sql,organCode);			
		return this.executeDataset(sql.toString(),new int[]{Types.VARCHAR},new Object[]{organCode}, pset.getPageStart(), pset.getPageLimit(), true);
	} 

	/**
	 * 查询三属人员申请审批表头信息
	 * @param peopleId
	 * @return
	 */
	public DataSet queryApplyHeader(String peopleId) {
		StringBuffer sql = new StringBuffer();
		sql.append("  SELECT B.PEOPLE_ID,B.FAMILY_ID, B.NAME ,B.SEX,B.ID_CARD, B.BIRTHDAY ,B.DOMICILE_TYPE,D.NAME AS SERVICETYPE,");
		sql.append("  P.DEPENDANT_TYPE_CODE,BD.RELATIONSHIP,B.ADDRESS,BD.LEZSW_NAME,");
		sql.append("  BD.LEZSW_SEX,BD.LEZSW_BIRTHDAY,BD.CONSCRIPT_DATE,");
		sql.append("  BD.WORK_UNIT,BD.POSITION,BD.DEATH_DATE,BD.DEATH_ADDRESS,BD.DEATH_REASON");
		sql.append("  FROM BASEINFO_PEOPLE B,BPT_PEOPLE P,BPT_PEOPLE_DEPENDANT BD,BPT_APPLY_DEPENDANT BA,DIC_BPT_SERVICE_TYPE D");
		sql.append("  WHERE B.PEOPLE_ID=P.PEOPLE_ID AND  B.DEPENDANT_FLAG='1' AND BD.PEOPLE_ID=B.PEOPLE_ID ");
		sql.append("  AND BA.PEOPLE_ID=B.PEOPLE_ID AND D.CODE = BA.SERVICE_TYPE AND BA.OBJECT_TYPE='2'");
		sql.append("  AND B.PEOPLE_ID = ? ");
		return this.executeDataset(sql.toString(),new int[]{Types.VARCHAR},new Object[]{peopleId},true);
	}
}
