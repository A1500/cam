package com.inspur.cams.bpt.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.base.dao.IBptPeopleMartyrOffspringDao;
import com.inspur.cams.bpt.base.data.BptPeopleMartyrOffspring;
import com.inspur.cams.bpt.util.FilterLimit;
import com.inspur.cams.comm.util.DateUtil;


/**
 * @title: BptPeopleMartyrOffspringDao
 * @description:部分烈士（错杀被平反人员）子女 类别信息 dao层
 * @author:
 * @since:
 * @version:
*/
 public class BptPeopleMartyrOffspringDao extends EntityDao<BptPeopleMartyrOffspring> implements IBptPeopleMartyrOffspringDao{

  	@Override
	public Class<BptPeopleMartyrOffspring> getEntityClass() {
		return BptPeopleMartyrOffspring.class;
	}
    public DataSet queryMartyrOffspring(ParameterSet pset){
 	   List<Integer> typeList = new ArrayList<Integer>();
 	   List<Object> argsList = new ArrayList<Object>();
 	   StringBuffer sql = new StringBuffer();
 	    String domicileCode = (String)pset.getParameter("domicileCode");
 		String name = (String)pset.getParameter("name");
 		String idCard = (String)pset.getParameter("idCard");
 		
 		String statusType = (String)pset.getParameter("statusType");
 		String sacrificeDate = (String)pset.getParameter("sacrificeDate");
 		String martyrStateCode = (String)pset.getParameter("martyrStateCode");
 		String domicileType = (String)pset.getParameter("domicileType");
 		String organCode = (String) pset.getParameter("organCode");
 		String lezswApproveDate = (String) pset.getParameter("lezswApproveDate");
 		
 		String startTime = (String) pset.getParameter("startTime");
		String endTime = (String) pset.getParameter("endTime");

 		StringBuffer sqlfind = new StringBuffer() ;
 		sqlfind.append("SELECT A.FAMILY_ID, A.PEOPLE_ID, A.DOMICILE_CODE, A.MARTYR_OFFSPRING_STATE_CODE,A.NAME, A.ID_CARD, A.SEX,\n");
 		sqlfind.append("       A.NATION,  C.SACRIFICE_DATE, C.LEZSW_APPROVE_DATE, C.STATUS_TYPE,\n"); 
 		sqlfind.append("       D.FULL_NAME \n"); 
 		sqlfind.append("  FROM BASEINFO_PEOPLE A, BPT_PEOPLE B, bpt_people_martyr_offspring C,DIC_CITY D\n"); 
 		sqlfind.append(" WHERE A.PEOPLE_ID = B.PEOPLE_ID AND A.PEOPLE_ID = C.PEOPLE_ID AND\n"); 
 		sqlfind.append("       B.MARTYR_OFFSPRING_CODE = 'B1' AND A.DOMICILE_CODE = D.ID AND\n"); 
 		sqlfind.append("       A.PERSONAL_STATS_TAG != '4' \n"); 
 		StringBuffer sqlExcel = new StringBuffer() ;
 		sqlExcel.append("SELECT A.DOMICILE_CODE, A.NAME, A.ID_CARD,\n");
 		sqlExcel.append("       (CASE A.SEX\n"); 
 		sqlExcel.append("          WHEN '1' THEN '男'\n"); 
 		sqlExcel.append("          WHEN '2' THEN '女'\n"); 
 		sqlExcel.append("        END) AS SEX, N.NAME AS NATION, C.NOTE,\n"); 
 		sqlExcel.append("      	D.FULL_NAME DOMICILE_NAME, A.TEL_MOBILE\n"); 
 		sqlExcel.append("  FROM BASEINFO_PEOPLE A, BPT_PEOPLE B, bpt_people_martyr_offspring C,\n"); 
 		sqlExcel.append("       DIC_CITY D, DIC_NATION N\n"); 
 		sqlExcel.append(" WHERE A.PEOPLE_ID = B.PEOPLE_ID AND A.PEOPLE_ID = C.PEOPLE_ID AND\n"); 
 		sqlExcel.append("       B.RETIRED_TYPE_CODE = 'B1' AND A.NATION = N.CODE AND\n"); 
 		sqlExcel.append("       A.DOMICILE_CODE = D.ID AND A.PERSONAL_STATS_TAG != '4' \n"); 
 		
 		String isAll = (String) pset.getParameter("isAll");
 		if("all".equals(isAll) || !pset.containsKey("limit")){
 			sql.append(sqlExcel);
 		}else{
 			sql.append(sqlfind);
 		}
 		if (domicileCode != null && !domicileCode.equals("")) {
 			if (!domicileCode.substring(0, 2).equals("00") && domicileCode.substring(2, 12).equals("0000000000")) {
 				sql.append(" AND  DOMICILE_CODE like ? ");// 省局
 				domicileCode = domicileCode.substring(0, 2)+"%";
 			}else if(!domicileCode.substring(2, 4).equals("00")&&domicileCode.substring(4, 12).equals("00000000")){
 				sql.append(" AND DOMICILE_CODE like ? ");//市局
 				domicileCode = domicileCode.substring(0, 4)+"%";
 			}else if(!domicileCode.substring(4, 6).equals("00")&&domicileCode.substring(6, 12).equals("000000")){
 				sql.append(" AND DOMICILE_CODE like ? ");//县局
 				domicileCode = domicileCode.substring(0, 6)+"%";
 			}else if(!domicileCode.substring(6, 9).equals("00")&&domicileCode.substring(9, 12).equals("000")){
 				sql.append(" AND DOMICILE_CODE like ? ");//乡镇
 				domicileCode = domicileCode.substring(0, 9)+"%";
 			}else{
 				sql.append(" AND DOMICILE_CODE= ? ");//区县
 				domicileCode = domicileCode;
 			}
 			argsList.add(domicileCode);
 		}else{
 			if (!organCode.substring(0, 2).equals("00") && organCode.substring(2, 12).equals("0000000000")) {
 				sql.append(" AND  DOMICILE_CODE like ? ");// 省局
 				organCode = organCode.substring(0, 2)+"%";
 			}else if(!organCode.substring(2, 4).equals("00")&&organCode.substring(4, 12).equals("00000000")){
 				sql.append(" AND DOMICILE_CODE like ? ");//市局
 				organCode = organCode.substring(0, 4)+"%";
 			}else if(!organCode.substring(4, 6).equals("00")&&organCode.substring(6, 12).equals("000000")){
 				sql.append(" AND DOMICILE_CODE like ? ");//县局
 				organCode = organCode.substring(0, 6)+"%";
 			}else if(!organCode.substring(6, 9).equals("00")&&organCode.substring(9, 12).equals("000")){
 				sql.append(" AND DOMICILE_CODE like ? ");//乡镇
 				organCode = organCode.substring(0, 9)+"%";
 			}else{
 				sql.append(" AND DOMICILE_CODE= ? ");//区县
 				organCode = organCode;
 			}
 			argsList.add(organCode);
 		}
 		typeList.add(Types.VARCHAR);
 		
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
 		
 		if(statusType != null && !statusType.equals("")){
 			sql.append("AND C.STATUS_TYPE= ? ");
 			typeList.add(Types.VARCHAR);
 			argsList.add(statusType);
 		}
 		
 		if(sacrificeDate != null && !sacrificeDate.equals("")){
 			sql.append("AND C.SACRIFICE_DATE= ? ");
 			typeList.add(Types.VARCHAR);
 			argsList.add(sacrificeDate);
 		}
 		
 		if(lezswApproveDate != null && !lezswApproveDate.equals("")){
 			sql.append("AND C.LEZSW_APPROVE_DATE= ? ");
 			typeList.add(Types.VARCHAR);
 			argsList.add(lezswApproveDate);
 		}
 		
 		if(martyrStateCode != null && !martyrStateCode.equals("")){
			sql.append(" AND Martyr_Offspring_State_Code=? ");
			typeList.add(Types.VARCHAR);
			argsList.add(martyrStateCode);
		}
 		
 		if(domicileType != null && !domicileType.equals("")){
 			sql.append(" AND A.DOMICILE_TYPE=? ");
 			typeList.add(Types.VARCHAR);
 			argsList.add(domicileType);
 		}
 		
 		if ((endTime != null && !"".equals(endTime))
					|| (startTime != null && !"".equals(startTime))) {
			if(endTime == null || "".equals(endTime)) {
				endTime = DateUtil.getDay();
			}
			if(startTime == null || "".equals(startTime)) {
				startTime = "1900-01-01";
			}
			sql.append(" AND TO_DATE(c.approval_date, 'YYYY-MM-DD') BETWEEN  TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD')");
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
