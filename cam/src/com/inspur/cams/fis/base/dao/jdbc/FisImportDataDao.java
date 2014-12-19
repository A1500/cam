package com.inspur.cams.fis.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.fis.base.dao.IFisImportDataDao;
import com.inspur.cams.fis.base.data.FisImportData;
import com.inspur.sdmz.comm.util.CrjDownloadPhoto;

/**
 * 数据上报信息dao
 * 
 * @author
 * @date Mon Apr 16 15:35:06 GMT+08:00 2012
 */
public class FisImportDataDao extends EntityDao<FisImportData> implements IFisImportDataDao {

//	private static final Log logger = LogFactory.getLog(CrjDownloadPhoto.class);
	
	@Override
	public Class<FisImportData> getEntityClass() {
		return FisImportData.class;
	}

	public void batchImport(String[] sqls) throws Exception {
		for (int i = 0; i < sqls.length; i++) {
			sqls[i] = sqls[i].trim();
			if (!"".equals(sqls[i])) {
				try {
					executeUpdate(sqls[i]);
				} catch (Exception e) {
					// System.out.println("sql执行错误:"+e.getMessage()+"="+e.getMessage().indexOf("ORA-00001"));
					// logger.debug("sql执行错误:"+e.getMessage()+"="+e.getMessage().indexOf("ORA-00001")+"\n\t"+sqls[i]);
					// if (e.getMessage().indexOf("ORA-00001") == -1)
					// throw new Exception("CUSTOM未知错误：" + e.getMessage());
				}
			}
		}
	}

	public Map getLastUploadTime(String unitId) {
		String sql = "SELECT MAX(T.END_TIME) FROM FIS_IMPORT_DATA T WHERE T.UPLOAD_UNIT=?";

		List<Integer> typeList = new ArrayList<Integer>();
		List<String> objsList = new ArrayList<String>();
		typeList.add(Types.VARCHAR);
		objsList.add(unitId);

		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object[] args = objsList.toArray(new Object[objsList.size()]);
		Object[] result = this.executeDetail(sql.toString(), types, args);
		
		Map map = new HashMap();
		if(result.length > 0)
			map.put("END_TIME", result[0]==null ? null : result[0].toString());
		return map;
	}
	
	/**
	 * @Description: 查询辖区各馆上报情况
	 * @author xuexzh
	 */
	public DataSet queryForImport(ParameterSet pset) {
		String organCode = (String) pset.getParameter("organCode");
		String fId = (String) pset.getParameter("fId");
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT F.PARENT_ORGAN_CODE,F.UNIT_NAME,F.UNIT_ID,A.END_TIME,ROUND(TO_NUMBER(SYSDATE - TO_DATE(SUBSTR(A.END_TIME,0,10),'YYYY-MM-DD'))) DAY_DIFF");
		sql.append(" FROM FIS_FUNERAL_ORGAN_MANAGE F LEFT JOIN (SELECT T.UPLOAD_UNIT,MAX(T.END_TIME) END_TIME FROM FIS_IMPORT_DATA T GROUP BY T.UPLOAD_UNIT");
		sql.append(" ) A ON F.UNIT_ID = A.UPLOAD_UNIT WHERE 1=1 ");

		List<Integer> typeList = new ArrayList<Integer>();
		List<String> objsList = new ArrayList<String>();
		
		if(StringUtils.isNotEmpty(organCode)) {
			sql.append(" AND F.PARENT_ORGAN_CODE LIKE ?||'%'");
			typeList.add(Types.VARCHAR);
			objsList.add(organCode);
		}
		
		if(StringUtils.isNotEmpty(fId)) {
			sql.append(" AND F.UNIT_ID = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(fId);
		}

		sql.append(" ORDER BY F.UNIT_ID");
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object[] args = objsList.toArray(new Object[objsList.size()]);
		
		DataSet ds = new DataSet();
		ds = this.executeDataset(sql.toString(), types, args, pset.getPageStart(), pset.getPageLimit(), true);
		return ds;
	}
	
	/**
	 * @Description: 查询辖区各馆上报情况
	 * @author xuexzh
	 */
	public DataSet queryForOrganImport(ParameterSet pset) {
		String organCode = (String) pset.getParameter("organCode");
		String fId = (String) pset.getParameter("fName");
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT F.PARENT_ORGAN_CODE,F.UNIT_NAME,F.UNIT_ID,A.END_TIME,ROUND(TO_NUMBER(SYSDATE - TO_DATE(SUBSTR(A.END_TIME,0,10),'YYYY-MM-DD'))) DAY_DIFF");
		sql.append(" FROM FIS_FUNERAL_ORGAN_MANAGE F LEFT JOIN (SELECT T.UPLOAD_UNIT,MAX(T.END_TIME) END_TIME FROM FIS_IMPORT_DATA T GROUP BY T.UPLOAD_UNIT");
		sql.append(" ) A ON F.UNIT_ID = A.UPLOAD_UNIT WHERE 1=1 ");

		List<Integer> typeList = new ArrayList<Integer>();
		List<String> objsList = new ArrayList<String>();
		
		if(StringUtils.isNotEmpty(organCode)) {
			sql.append(" AND F.PARENT_ORGAN_CODE LIKE ?||'%'");
			typeList.add(Types.VARCHAR);
			objsList.add(organCode);
		}
		
		if(StringUtils.isNotEmpty(fId)) {
			sql.append(" AND F.UNIT_NAME LIKE '%"+fId+"%' ");
		}

		sql.append(" ORDER BY DAY_DIFF DESC,F.UNIT_ID");
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object[] args = objsList.toArray(new Object[objsList.size()]);
		
		DataSet ds = new DataSet();
		ds = this.executeDataset(sql.toString(), types, args, getDsStart(pset),getDsLimit(pset), true);
		return ds;
	}
	
	private int getDsStart(ParameterSet pset) {
		String excelType = (String)pset.getParameter("excelType");
		if(null==excelType||"0,1".indexOf(excelType)==-1) {
			return pset.getPageStart();
		}
		int start = 0;
		if("0".equals(excelType)) {  //导出当前页
			Integer startExcel = (java.lang.Integer) pset.getParameter("startExcel");
			if(startExcel!=null) {
				start = startExcel.intValue();
			}
		}
		return start;
	}
	private int getDsLimit(ParameterSet pset) {
		String excelType = (String)pset.getParameter("excelType");
		if(null==excelType||"0,1".indexOf(excelType)==-1) {
			return pset.getPageLimit();
		}
		int limit = ((java.lang.Integer) pset.getParameter("limitExcel")).intValue();
		return limit>1000?1000:limit;
	}
	
	/**
	 * @Description: 查询辖区各公墓上报情况
	 * @author xuexzh
	 */
	public DataSet queryForCemeImport(ParameterSet pset) {
		String organCode = (String) pset.getParameter("organCode");
		String fId = (String) pset.getParameter("fId");
		StringBuffer sql = new StringBuffer();
//		sql.append("SELECT A.*, TO_CHAR(TEMP_TIME, 'YYYY-MM-DD') END_TIME,FLOOR(SYSDATE - TEMP_TIME) DAY_DIFF  FROM (");
//		sql.append(" SELECT F.MANA_LEVEL_ID PARENT_ORGAN_CODE,F.CEME_NAME UNIT_NAME,F.CEME_ID UNIT_ID,");
//		sql.append(" TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_NUMBER(TO_CHAR(TO_DATE('20121111','YYYYMMDD'),'J')),");
//		sql.append(" TO_NUMBER(TO_CHAR(TO_DATE('20121130','YYYYMMDD')+1,'J')))),'J')+");
//		sql.append(" DBMS_RANDOM.VALUE(1,3600)/3600 TEMP_TIME FROM FIS_CEME_INFO F WHERE F.PROP='2' ");
		sql.append("SELECT F.MANA_LEVEL_ID PARENT_ORGAN_CODE,F.NAME UNIT_NAME,F.ORGAN_ID UNIT_ID,A.END_TIME,");
		sql.append(" ROUND(TO_NUMBER(SYSDATE-TO_DATE(SUBSTR(A.END_TIME, 0, 10), 'YYYY-MM-DD'))) DAY_DIFF");
		sql.append(" FROM FIS_CEMETERY_ORGAN F LEFT JOIN (SELECT T.UPLOAD_UNIT, MAX(T.END_TIME) END_TIME");
		sql.append(" FROM FIS_IMPORT_DATA T GROUP BY T.UPLOAD_UNIT) A ON F.ORGAN_ID = A.UPLOAD_UNIT WHERE 1=1 AND F.PROP = '2'");

		List<Integer> typeList = new ArrayList<Integer>();
		List<String> objsList = new ArrayList<String>();
		
		if(StringUtils.isNotEmpty(organCode)) {
			sql.append(" AND F.MANA_LEVEL_ID LIKE ?||'%'");
			typeList.add(Types.VARCHAR);
			objsList.add(organCode);
		}
		
		if(StringUtils.isNotEmpty(fId)) {
			sql.append(" AND F.CEME_ID = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(fId);
		}

		sql.append(" ORDER BY F.ORGAN_ID");
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object[] args = objsList.toArray(new Object[objsList.size()]);
		
		DataSet ds = new DataSet();
		ds = this.executeDataset(sql.toString(), types, args, pset.getPageStart(), pset.getPageLimit(), true);
		return ds;
	}

}