package com.inspur.cams.bpt.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.bpt.base.dao.IBptCountRetiredSoldierDao;
import com.inspur.cams.bpt.base.data.BptCountRetiredSoldier;
import com.inspur.cams.bpt.util.FilterLimit;
import com.inspur.cams.comm.util.DateUtil;

/**
 * @title:BptCountRetiredSoldierDao
 * @description:
 * @author:
 * @since:2011-08-04
 * @version:1.0
*/
 public class BptCountRetiredSoldierDao extends EntityDao<BptCountRetiredSoldier> implements IBptCountRetiredSoldierDao{

 	public BptCountRetiredSoldierDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class<BptCountRetiredSoldier> getEntityClass() {
		return BptCountRetiredSoldier.class;
	}
   
   public DataSet queryCountretiredSoldier(ParameterSet pset){
	   List<Integer> typeList = new ArrayList<Integer>();
	   List<Object> argsList = new ArrayList<Object>();
	   StringBuffer sql = new StringBuffer();
	    String domicileCode = (String)pset.getParameter("domicileCode");
		String name = (String)pset.getParameter("name");
		String idCard = (String)pset.getParameter("idCard");
		String soldierStateCode = (String)pset.getParameter("soldierStateCode");
		String isGuarant = (String)pset.getParameter("isGuarant");
		String isFiveGuarant = (String)pset.getParameter("isFiveGuarant");
		String startTime = (String)pset.getParameter("startTime");
		String endTime = (String)pset.getParameter("endTime");
		String domicileType = (String)pset.getParameter("domicileType");
		String organCode = (String) pset.getParameter("organCode");
		String isprovinceMigrate = (String) pset.getParameter("jisprovinceMigrate");
		StringBuffer sqlfind = new StringBuffer() ;
		sqlfind.append("SELECT A.FAMILY_ID, A.PEOPLE_ID, A.DOMICILE_CODE, A.RETIRED_STATE_CODE,A.NAME, A.ID_CARD, A.SEX,\n");
		sqlfind.append("       A.NATION, C.FAMILY_NUM, C.IS_GUARANT, C.IS_FIVE_GUARANT, C.SOLDIER_YEARS, C.NOTE,\n"); 
		sqlfind.append("       D.FULL_NAME DOMICILE_NAME, A.DOMICILE_TYPE,\n"); 
		sqlfind.append("       A.TEL_MOBILE\n"); 
		if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
			sqlfind.append("  ,'1' as flag\n"); 
		}
		sqlfind.append("  FROM BASEINFO_PEOPLE A, BPT_PEOPLE B, BPT_PEOPLE_RETIRED_SOLDIER C,DIC_CITY D\n"); 
		if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
			sqlfind.append("  ,bpt_province_migrate e\n"); 
		}
		sqlfind.append(" WHERE A.PEOPLE_ID = B.PEOPLE_ID AND A.PEOPLE_ID = C.PEOPLE_ID AND\n"); 
		sqlfind.append("       B.RETIRED_TYPE_CODE = '81' AND A.DOMICILE_CODE = D.ID AND\n"); 
		sqlfind.append("       A.PERSONAL_STATS_TAG != '4' \n"); 
		if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
			sqlfind.append("  and A.people_id = e.people_id and e.service_type='83'\n"); 
		}
		StringBuffer sqlExcel = new StringBuffer() ;
		sqlExcel.append("SELECT A.DOMICILE_CODE, A.NAME, A.ID_CARD, C.SOLDIER_YEARS AS SOLDIER_YEARS, \n");
		sqlExcel.append("       (CASE A.SEX\n"); 
		sqlExcel.append("          WHEN '1' THEN '男'\n"); 
		sqlExcel.append("          WHEN '2' THEN '女'\n"); 
		sqlExcel.append("        END) AS SEX, N.NAME AS NATION, C.FAMILY_NUM,\n"); 
		sqlExcel.append("       (CASE C.IS_GUARANT\n"); 
		sqlExcel.append("          WHEN '0' THEN '否'\n"); 
		sqlExcel.append("          WHEN '1' THEN '是'\n"); 
		sqlExcel.append("        END) AS IS_GUARANT,\n"); 
		sqlExcel.append("       (CASE C.IS_FIVE_GUARANT\n"); 
		sqlExcel.append("          WHEN '0' THEN '否'\n"); 
		sqlExcel.append("          WHEN '1' THEN '是'\n"); 
		sqlExcel.append("        END) AS IS_FIVE_GUARANT, C.NOTE,\n"); 
		sqlExcel.append("      	D.FULL_NAME DOMICILE_NAME,\n"); 
		sqlExcel.append("       (CASE A.DOMICILE_TYPE\n"); 
		sqlExcel.append("          WHEN '1' THEN '农村'\n"); 
		sqlExcel.append("          WHEN '2' THEN '城镇'\n"); 
		sqlExcel.append("        END) AS DOMICILE_TYPE, A.TEL_MOBILE\n"); 
		sqlExcel.append("  FROM BASEINFO_PEOPLE A, BPT_PEOPLE B, BPT_PEOPLE_RETIRED_SOLDIER C,\n"); 
		sqlExcel.append("       DIC_CITY D, DIC_NATION N\n"); 
		if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
			sqlExcel.append("  ,bpt_province_migrate e\n"); 
		}
		sqlExcel.append(" WHERE A.PEOPLE_ID = B.PEOPLE_ID AND A.PEOPLE_ID = C.PEOPLE_ID AND\n"); 
		sqlExcel.append("       B.RETIRED_TYPE_CODE = '81' AND A.NATION = N.CODE AND\n"); 
		sqlExcel.append("       A.DOMICILE_CODE = D.ID AND A.PERSONAL_STATS_TAG != '4' \n"); 
		if (isprovinceMigrate != null && !isprovinceMigrate.equals("")&& !isprovinceMigrate.equals("0")){
			sqlExcel.append("  and A.people_id = e.people_id and e.service_type='83'\n"); 
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
				domicileCode=FilterLimit.filterByOrganCode(sql,domicileCode);
				argsList.add(domicileCode);
			}else{
				organCode=FilterLimit.filterByOrganCode(sql,organCode);
				argsList.add(organCode);
			}
			typeList.add(Types.VARCHAR);
		}
		if(name != null && !name.equals("")){
			sql.append(" AND A.NAME LIKE ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(name+"%");
		}
		
		if(idCard !=null && !idCard.equals("")){
			sql.append(" AND A.ID_CARD = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(idCard);		
		}
		
		if(isGuarant != null && !isGuarant.equals("")){
			sql.append("AND C.IS_GUARANT= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(isGuarant);
		}
		
		if(isFiveGuarant != null && !isFiveGuarant.equals("")){
			sql.append("AND C.IS_FIVE_GUARANT= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(isFiveGuarant);
		}
		
		if(domicileType != null && !domicileType.equals("")){
			sql.append(" AND A.DOMICILE_TYPE=? ");
			typeList.add(Types.VARCHAR);
			argsList.add(domicileType);
		}
		if(soldierStateCode != null && !soldierStateCode.equals("")){
			sql.append(" AND RETIRED_STATE_CODE=? ");
			typeList.add(Types.VARCHAR);
			argsList.add(soldierStateCode);
		}
		if ((endTime != null && !"".equals(endTime))
				|| (startTime != null && !"".equals(startTime))) {
			if(endTime == null || "".equals(endTime)) {
				endTime = DateUtil.getDay();
			}
			if(startTime == null || "".equals(startTime)) {
				startTime = "1900-01-01";
			}
			sql.append(" and to_date(c.approval_date, 'yyyy-mm-dd') between to_date(?, 'yyyy-mm-dd') and to_date(?, 'yyyy-mm-dd')");
			typeList.add(Types.VARCHAR);
			argsList.add(startTime);
			typeList.add(Types.VARCHAR);
			argsList.add(endTime);
		}
		sql.append(" ORDER BY A.DOMICILE_CODE,A.NAME");
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			if("all".equals(isAll) || !pset.containsKey("limit")){
				ds = this.executeDataset(sql.toString(),types,args, true);
			}else{
				ds = this.executeDataset(sql.toString(),types,args, pset.getPageStart(), pset.getPageLimit(), true);
			}
		}
		return ds;
   }
   
}
