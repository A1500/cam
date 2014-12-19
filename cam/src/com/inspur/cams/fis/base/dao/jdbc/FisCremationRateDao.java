package com.inspur.cams.fis.base.dao.jdbc;

import java.sql.Types;
import java.util.List;
import java.util.Map;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.fis.base.dao.IFisCremationRateDao;
import com.inspur.cams.fis.base.data.FisCremationRate;

/**
 * 火化率计算表dao
 * @author 
 * @date Thu Apr 19 18:46:28 GMT+08:00 2012
 */
public class FisCremationRateDao extends EntityDao<FisCremationRate> implements IFisCremationRateDao {
	
	@Override
	public Class<FisCremationRate> getEntityClass() {
		return FisCremationRate.class;
	}

	/**
	 * 获取本地区火化人数
	 * @param 
	 */
	public DataSet queryCremationSum(ParameterSet pset) {
		String organCode = (String)pset.getParameter("ORGAN_CODE");
		String sumYear = (String)pset.getParameter("SUM_YEAR");
		if(organCode.length()>6) 
			organCode= organCode.substring(0, 6);
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT COUNT(C.APPLY_ID) AS SUM FROM FIS_SERVICE_CREMATION C JOIN ");
		sql.append(" (SELECT A.APPLY_ID FROM FIS_APPLY_INFO A JOIN FIS_DEAD_INFO D ON A.DEAD_ID = D.DEAD_ID");
		sql.append(" WHERE A.APPLY_TYPE = 'B' AND A.IF_FINISH = '1'  AND D.POPULACE IS NOT NULL AND D.POPULACE LIKE ?||'%') ");
		sql.append(" AA ON C.APPLY_ID = AA.APPLY_ID WHERE SUBSTR(C.START_TIME,0,4)=?");
		int[] types = new int[2];
		types[0]=Types.VARCHAR;
		types[1]=Types.VARCHAR;
		Object[] args = new Object[2];
		args[0]=organCode;
		args[1]=sumYear;
		return this.executeDataset(sql.toString(), types, args, true);
	}
	

	/**
	 * 获取本地区火化率计算报表
	 * @param 
	 */
	public DataSet queryCremationRateList(ParameterSet pset) {
		String areaCode = (String)pset.getParameter("AREA_CODE");
		String sumYear = (String)pset.getParameter("SUM_YEAR");
		StringBuffer sql = new StringBuffer();
		sql.append("select AAA.* from (");
		sql.append(" SELECT DC.ID AS AREA_CODE, DC.NAME AS AREA_NAME, DC.FULL_NAME AS FULL_NAME,").append(sumYear).append(" AS SUM_YEAR,");
		sql.append(" CR.TOTAL_NUM AS TOTAL_NUM,CR.TOTAL_NUM AS TOTAL_NUMS,CR.DEAD_RATE AS DEAD_RATE,");
		sql.append(" CR.DEAD_NUM AS DEAD_NUM,CR.CREMATION_NUM AS CREMATION_NUM,CR.CREMATION_RATE AS CREMATION_RATE");
		sql.append(" FROM FIS_DIC_CITY DC LEFT JOIN FIS_CREMATION_RATE CR ON DC.ID = CR.AREA_CODE");
		sql.append(" WHERE DC.ID LIKE ?||'%' AND DC.LEVE=? AND (CR.SUM_YEAR=? OR CR.SUM_YEAR IS NULL)");
		sql.append(" UNION ALL");
		sql.append(" SELECT DC.ID AS AREA_CODE, DC.NAME AS AREA_NAME, DC.FULL_NAME AS FULL_NAME,").append(sumYear).append(" AS SUM_YEAR,");
		sql.append(" CR.TOTAL_NUM AS TOTAL_NUM,CR.TOTAL_NUM AS TOTAL_NUMS,CR.DEAD_RATE AS DEAD_RATE,");
		sql.append(" CR.DEAD_NUM AS DEAD_NUM,CR.CREMATION_NUM AS CREMATION_NUM,CR.CREMATION_RATE AS CREMATION_RATE");
		sql.append(" FROM FIS_DIC_CITY DC LEFT JOIN FIS_CREMATION_RATE CR ON DC.ID = CR.AREA_CODE");
		sql.append(" WHERE DC.ID LIKE ?||'%' AND DC.LEVE=? AND (CR.SUM_YEAR=? OR CR.SUM_YEAR IS NULL)");
		sql.append(" ) AAA ORDER BY AAA.AREA_CODE");
		
		int[] types = new int[6];
		types[0]=Types.VARCHAR;
		types[1]=Types.VARCHAR;
		types[2]=Types.VARCHAR;
		types[3]=Types.VARCHAR;
		types[4]=Types.VARCHAR;
		types[5]=Types.VARCHAR;
		Object[] args = new Object[6];
		args[0]=areaCode;
		args[3]=areaCode;
		if(areaCode.length()==2) {
			args[1]="1";
			args[4]="0";
		}else {
			args[1]="2";
			args[4]="1";
		}
		args[2]=sumYear;
		args[5]=sumYear;
		return this.executeDataset(sql.toString(), types, args, true);
	}
	
	public List<Map> queryTest() {
		String sql = "SELECT PUB_MENU_STRU.MENU_PATH,PUB_MENU_STRU.MENU_STRU_ID,PUB_MENU_STRU.MENU_ID,PUB_MENU_STRU.PARENT_MENU_ID,PUB_MENU_ITEM.MENU_NAME,PUB_MENU_STRU.SEQ,PUB_MENU_ITEM.FUNCTION_CODE,PUB_MENU_ITEM.MODULE_CODE,PUB_MENU_ITEM.APP_CODE,PUB_MENU_ITEM.TARGET,PUB_MENU_ITEM.REQUEST_ACTION,PUB_MENU_ITEM.IS_LEAF,PUB_MENU_ITEM.ICON FROM PUB_MENU_STRU,PUB_MENU_ITEM WHERE PUB_MENU_ITEM.MENU_ID=PUB_MENU_STRU.MENU_ID AND PUB_MENU_STRU.MENU_TYPE_ID='1' ORDER BY SEQ";
		List list = executeQuery(sql);
		for(int i=0; i<list.size();i++) {
			Map localHashMap = (Map)list.get(i);
			  localHashMap.put("menuStruId", localHashMap.get("MENU_STRU_ID"));
			  localHashMap.put("menuId", localHashMap.get("MENU_ID"));
			  localHashMap.put("menuName", localHashMap.get("MENU_NAME"));
			  localHashMap.put("parentId", localHashMap.get("PARENT_MENU_ID"));
			  localHashMap.put("text", localHashMap.get("MENU_NAME"));
			  localHashMap.put("seq", localHashMap.get("SEQ"));
			  localHashMap.put("functionCode", localHashMap.get("FUNCTION_CODE"));
			  localHashMap.put("moduleCode", localHashMap.get("MODULE_CODE"));
			  localHashMap.put("appCode", localHashMap.get("APP_CODE"));
			  localHashMap.put("target", localHashMap.get("TARGET"));
			  localHashMap.put("requestAction", localHashMap.get("REQUEST_ACTION"));
			  localHashMap.put("isLeaf", localHashMap.get("IS_LEAF"));
			  localHashMap.put("menuPath", localHashMap.get("MENU_PATH"));
			  localHashMap.put("icon", localHashMap.get("ICON"));
		}
		return list;
//		HashMap localHashMap = new HashMap();
//		  localHashMap.put("menuStruId", paramResultSet.getString("MENU_STRU_ID"));
//		  localHashMap.put("menuId", paramResultSet.getString("MENU_ID"));
//		  localHashMap.put("menuName", paramResultSet.getString("MENU_NAME"));
//		  localHashMap.put("parentId", paramResultSet.getString("PARENT_MENU_ID"));
//		  localHashMap.put("text", paramResultSet.getString("MENU_NAME"));
//		  localHashMap.put("seq", Integer.toString(paramResultSet.getInt("SEQ")));
//		  localHashMap.put("functionCode", paramResultSet.getString("FUNCTION_CODE"));
//		  localHashMap.put("moduleCode", paramResultSet.getString("MODULE_CODE"));
//		  localHashMap.put("appCode", paramResultSet.getString("APP_CODE"));
//		  localHashMap.put("target", paramResultSet.getString("TARGET"));
//		  localHashMap.put("requestAction", paramResultSet.getString("REQUEST_ACTION"));
//		  localHashMap.put("isLeaf", paramResultSet.getString("IS_LEAF"));
//		  localHashMap.put("menuPath", paramResultSet.getString("MENU_PATH"));
//		  localHashMap.put("icon", paramResultSet.getString("ICON"));
	}
}