package com.inspur.cams.fis.ep.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.fis.ep.base.dao.IFisCemeCheckResultDao;
import com.inspur.cams.fis.ep.base.data.FisCemeCheckResult;

/**
 * @title:FisCemeCheckResultDao
 * @description:
 * @author:
 * @since:2011-11-28
 * @version:1.0
 */
public class FisCemeCheckResultDao extends EntityDao<FisCemeCheckResult>
		implements IFisCemeCheckResultDao {

	public FisCemeCheckResultDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return FisCemeCheckResult.class;
	}

	public void deleteStruAll() {
		executeUpdate("delete from FisCemeCheckResult");
	}

	public DataSet cemecheckQuery(ParameterSet pset) {
		StringBuffer sqlYes = new StringBuffer();	//已参检的
		StringBuffer sqlNo = new StringBuffer(); //未参检的
		DataSet ds = new DataSet();
		
		// 公墓ID
		String cemeId = (String) pset.getParameter("CEME_ID");
		// 所属区划
		String areaLevelId = (String) pset.getParameter("AREA_LEVEL_ID");
		// 主管单位
		String manaLevelId = (String) pset.getParameter("MANA_LEVEL_ID");
		// 年检年份
		String checkYear = (String) pset.getParameter("CHECK_YEAR");
		// 年检结果
		String checkResult = (String) pset.getParameter("CHECK_RESULT");
		
		//公墓性质
		String prop = (String) pset.getParameter("PROP");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		
		sqlYes.append("SELECT S.CEME_APPLY_ID AS APPLY_ID, C.RECORD_ID, C.ORGAN_ID, C.NAME,C.PROP,C.MANA_LEVEL,C.DEPT_NAME,S.CHECK_NUM,S.FIRST_TIME,S.FIRST_RESULT,");
		sqlYes.append("S.SECOND_TIME,S.SECOND_RESULT,S.SECOND_TOTAL_SCORE,S.SECOND_UNIT,S.CHECK_YEAR AS CHECK_YEAR,");
		sqlYes.append("S.CHECK_RESULT AS CHECK_RESULT,S.IS_REPORT AS IS_REPORT FROM FIS_CEME_INFO C, FIS_CEME_APPLY_INFO S WHERE C.RECORD_ID=S.RECORD_ID ");
		
		sqlNo.append("SELECT '00' AS APPLY_ID,C.RECORD_ID, C.ORGAN_ID, C.NAME,C.PROP,C.MANA_LEVEL,C.DEPT_NAME,'' AS CHECK_NUM,'' AS FIRST_TIME,'' AS FIRST_RESULT,");
		sqlNo.append("'' AS SECOND_TIME,'' AS SECOND_RESULT,0 AS SECOND_TOTAL_SCORE,'' AS SECOND_UNIT,'");
		sqlNo.append(checkYear).append("' AS CHECK_YEAR,'0' AS CHECK_RESULT,'0' AS IS_REPORT ");
		sqlNo.append("FROM FIS_CEME_INFO C WHERE 1=1 ");
		
		// 判断公墓ID是否为空
		if (cemeId != null) {
			sqlYes.append(" AND C.ORGAN_ID=? ");
			sqlNo.append(" AND  C.ORGAN_ID=? ");
			typeList.add(Types.VARCHAR);
			argsList.add(cemeId);
		}
		//判断公墓性质是否为空
		if (prop != null) {
			sqlYes.append(" AND C.PROP=? ");
			sqlNo.append(" AND C.PROP=? ");
			typeList.add(Types.VARCHAR);
			argsList.add(prop);
		}
		//判断主管单位是否为空
		if (manaLevelId != null) {
			sqlYes.append(" AND C.MANA_LEVEL_ID=? ");
			sqlNo.append(" AND C.MANA_LEVEL_ID=? ");
			typeList.add(Types.VARCHAR);
			argsList.add(manaLevelId);
		}
		// 判断所属区划是否为空
		if (areaLevelId != null) {
			if (areaLevelId.endsWith("0000000000")) {	//省
				
			}else if (areaLevelId.endsWith("00000000")) {	//市
				sqlYes.append(" AND C.DEPT_CODE like ?||'%' " );
				sqlNo.append("  AND C.DEPT_CODE like ?||'%' " );
				typeList.add(Types.VARCHAR);
				argsList.add(areaLevelId.substring(0, 4));
			} else {	//县
				sqlYes.append(" AND C.DEPT_CODE=? ");
				sqlNo.append(" AND C.DEPT_CODE=? ");
				typeList.add(Types.VARCHAR);
				argsList.add(areaLevelId);
			}
		}
		// 判断年检年份是否为空
		if (checkYear != null) {
			sqlYes.append(" AND S.CHECK_YEAR=? ");
			sqlNo.append(" AND C.RECORD_ID NOT IN (SELECT S.RECORD_ID FROM FIS_CEME_APPLY_INFO S WHERE S.CHECK_YEAR=? )");
			typeList.add(Types.VARCHAR);
			argsList.add(checkYear);
		}
		
		// 判断年检结果是否为空
		if (checkResult != null) {
			if("0".equals(checkResult)) {
				//仅查询未参检的
				int[] types = new int[typeList.size()];
				
				for(int i = 0;i<typeList.size();i++){
					types[i] = typeList.get(i);
				}
				Object[] args = argsList.toArray();
				sqlNo.append(" ORDER BY C.RECORD_ID");
				ds = this.executeDataset(sqlNo.toString(),types,args, getDsStart(pset), getDsLimit(pset), true);
			}else{
				
				//查询已参检的
				typeList.add(Types.VARCHAR);
				argsList.add(checkResult);
				
				int[] types = new int[typeList.size()];
				for(int i = 0;i<typeList.size();i++){
					types[i] = typeList.get(i);
				}
				Object[] args = argsList.toArray();
				sqlYes.append(" AND S.CHECK_RESULT=? ORDER BY C.RECORD_ID");
				//System.out.println(sqlYes.toString());
				ds = this.executeDataset(sqlYes.toString(),types,args, getDsStart(pset), getDsLimit(pset), true);
			}
		}else {
			//查询全部年检结果
			StringBuffer sqlGroup = new StringBuffer("SELECT * FROM ((");
			sqlGroup.append(sqlYes.toString()).append(") UNION ALL (");
			sqlGroup.append(sqlNo.toString()).append(")) A ORDER BY A.RECORD_ID");
			int[] types = new int[typeList.size()*2];
			
			for(int i = 0;i<typeList.size();i++){
				types[i] = typeList.get(i);
				types[i+typeList.size()] = typeList.get(i);
			}
			Object[] args = new Object[argsList.size()*2];
			for(int i = 0;i<argsList.size();i++){
				args[i] = argsList.get(i);
				args[i+argsList.size()] = argsList.get(i);
			}
			//System.out.println(sqlGroup.toString());
			ds = this.executeDataset(sqlGroup.toString(),types,args, getDsStart(pset), getDsLimit(pset), true);
		}
		return ds;
		/*// 所属区划
		String areaLevelId = (String) pset.getParameter("AREA_LEVEL_ID");
		// 主管单位
		String manaLevelId = (String) pset.getParameter("MANA_LEVEL_ID");
		// 年检年份
		String checkYear = (String) pset.getParameter("CHECK_YEAR");
		// 年检结果
		String checkResult = (String) pset.getParameter("CHECK_RESULT");
		
		//公墓性质
		String prop = (String) pset.getParameter("PROP");
		String cemeId = (String)pset.getParameter("CEME_ID");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		
		sql.append("select D.RECORD_ID,D.ORGAN_ID,D.NAME,E.APPLY_STATE,E.CHECK_YEAR,E.CHECK_RESULT,E.CEME_APPLY_ID,E.APPLY_FLAG,E.FILL_ORGAN_NAME,E.SECOND_TIME ");
		sql.append(",E.FIRST_TIME,E.REC_TIME,E.COM_TIME,E.IS_REPORT,E.CUR_ACTIVITY,E.CUR_ORGAN,F.SCORE_ID FROM FIS_CEME_INFO D , FIS_CEME_APPLY_INFO E , FIS_CEME_CHECK_SCORE F WHERE ");
		sql.append("D.RECORD_ID = E.RECORD_ID AND E.CEME_APPLY_ID = F.CEME_APPLY_ID");

		if (StringUtils.isNotEmpty(manaLevelId)) {
			sql.append(" AND D.MANA_LEVEL_ID =?  ");
			objList.add(manaLevelId);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(cemeId)) {
			sql.append(" and D.CEME_ID LIKE ?  ");
			objList.add(cemeId);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(checkResult)) {
			sql.append(" and E.CHECK_RESULT=?  ");
			objList.add(checkResult);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(checkYear)) {
			sql.append(" and E.CHECK_YEAR=?  ");
			objList.add(checkYear);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(prop)) {
			sql.append(" and D.PROP=?  ");
			objList.add(prop);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(areaLevelId)) {
			sql.append(" and D.DEPT_CODE=?  ");
			objList.add(areaLevelId);
			typeList.add(Types.VARCHAR);
		}
		
		DataSet ds = new DataSet();
		if (typeList.size() > 0 && objList.size() > 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < types.length; i++) {
				types[i] = typeList.get(i);
			}
			Object[] objs = objList.toArray(new Object[objList.size()]);
			ds = this.executeDataset(sql.toString(), types, objs, true);
		}
		return ds;
		*/
		
		
		/*StringBuffer sqlYes = new StringBuffer();	//已参检的
		StringBuffer sqlNo = new StringBuffer(); //未参检的
		DataSet ds = new DataSet();
		
		// 公墓ID
		String cemeId = (String) pset.getParameter("CEME_ID");
		// 所属区划
		String areaLevelId = (String) pset.getParameter("AREA_LEVEL_ID");
		// 主管单位
		String manaLevelId = (String) pset.getParameter("MANA_LEVEL_ID");
		// 年检年份
		String checkYear = (String) pset.getParameter("CHECK_YEAR");
		// 年检结果
		String checkResult = (String) pset.getParameter("CHECK_RESULT");
		
		//公墓性质
		String prop = (String) pset.getParameter("PROP");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		
		sqlYes.append("SELECT C.CEME_ID,C.CEME_NAME,C.PROP,C.MANA_LEVEL,C.AREA_LEVEL,S.RESULT_ID,S.CHECK_NUM,S.FIRST_TIME,S.FIRST_RESULT,");
		sqlYes.append("S.FIRST_APPLY_ID,S.SECOND_TIME,S.SECOND_RESULT,NVL(S.IS_TAKEPROOF, '0') AS IS_TAKEPROOF,S.SECOND_TOTAL_SCORE,S.SECOND_UNIT,S.CHECK_YEAR AS CHECK_YEAR,");
		sqlYes.append("S.CHECK_RESULT AS CHECK_RESULT,S.IS_REPORT AS IS_REPORT FROM FIS_CEME_INFO C RIGHT JOIN FIS_CEME_CHECK_RESULT S ON C.CEME_ID=S.CEME_ID WHERE S.IS_REPORT='1' ");
		
		sqlNo.append("SELECT C.CEME_ID,C.CEME_NAME,C.PROP,C.MANA_LEVEL,C.AREA_LEVEL,'' AS RESULT_ID,'' AS CHECK_NUM,'' AS FIRST_TIME,'' AS FIRST_RESULT,'' AS FIRST_APPLY_ID,");
		sqlNo.append("'' AS SECOND_TIME,'' AS SECOND_RESULT,'0' AS IS_TAKEPROOF,0 AS SECOND_TOTAL_SCORE,'' AS SECOND_UNIT,'");
		sqlNo.append(checkYear).append("' AS CHECK_YEAR,'0' AS CHECK_RESULT,'0' AS IS_REPORT ");
		sqlNo.append("FROM FIS_CEME_INFO C WHERE 1=1 ");
		
		// 判断公墓ID是否为空
		if (cemeId != null) {
			sqlYes.append(" AND S.CEME_ID=? ");
			sqlNo.append(" AND C.CEME_ID=? ");
			typeList.add(Types.VARCHAR);
			argsList.add(cemeId);
		}
		//判断公墓性质是否为空
		if (prop != null) {
			sqlYes.append(" AND C.PROP=? ");
			sqlNo.append(" AND C.PROP=? ");
			typeList.add(Types.VARCHAR);
			argsList.add(prop);
		}
		//判断主管单位是否为空
		if (manaLevelId != null) {
			sqlYes.append(" AND C.MANA_LEVEL_ID=? ");
			sqlNo.append(" AND C.MANA_LEVEL_ID=? ");
			typeList.add(Types.VARCHAR);
			argsList.add(manaLevelId);
		}
		// 判断所属区划是否为空
		if (areaLevelId != null) {
			if (areaLevelId.endsWith("0000000000")) {	//省
				
			}else if (areaLevelId.endsWith("00000000")) {	//市
				sqlYes.append(" AND C.AREA_LEVEL_ID like ?||'%' " );
				sqlNo.append("  AND C.AREA_LEVEL_ID like ?||'%' " );
				typeList.add(Types.VARCHAR);
				argsList.add(areaLevelId.substring(0, 4));
			} else {	//县
				sqlYes.append(" AND C.AREA_LEVEL_ID=? ");
				sqlNo.append(" AND C.AREA_LEVEL_ID=? ");
				typeList.add(Types.VARCHAR);
				argsList.add(areaLevelId);
			}
		}
		// 判断年检年份是否为空
		if (checkYear != null) {
			sqlYes.append(" AND S.CHECK_YEAR=? ");
			sqlNo.append(" AND C.CEME_ID NOT IN (SELECT S.CEME_ID FROM FIS_CEME_CHECK_RESULT S WHERE S.IS_REPORT='1' AND S.CHECK_YEAR=? )");
			typeList.add(Types.VARCHAR);
			argsList.add(checkYear);
		}
		
		// 判断年检结果是否为空
		if (checkResult != null) {
			if("0".equals(checkResult)) {
				//仅查询未参检的
				int[] types = new int[typeList.size()];
				
				for(int i = 0;i<typeList.size();i++){
					types[i] = typeList.get(i);
				}
				Object[] args = argsList.toArray();
				sqlNo.append(" ORDER BY C.CEME_ID");
				ds = this.executeDataset(sqlNo.toString(),types,args, getDsStart(pset), getDsLimit(pset), true);
			}else{
				
				//查询已参检的
				typeList.add(Types.VARCHAR);
				argsList.add(checkResult);
				
				int[] types = new int[typeList.size()];
				for(int i = 0;i<typeList.size();i++){
					types[i] = typeList.get(i);
				}
				Object[] args = argsList.toArray();
				sqlYes.append(" AND S.CHECK_RESULT=? ORDER BY C.CEME_ID");
				//System.out.println(sqlYes.toString());
				ds = this.executeDataset(sqlYes.toString(),types,args, getDsStart(pset), getDsLimit(pset), true);
			}
		}else {
			//查询全部年检结果
			StringBuffer sqlGroup = new StringBuffer("SELECT * FROM ((");
			sqlGroup.append(sqlYes.toString()).append(") UNION ALL (");
			sqlGroup.append(sqlNo.toString()).append(")) A ORDER BY A.CEME_ID");
			int[] types = new int[typeList.size()*2];
			
			for(int i = 0;i<typeList.size();i++){
				types[i] = typeList.get(i);
				types[i+typeList.size()] = typeList.get(i);
			}
			Object[] args = new Object[argsList.size()*2];
			for(int i = 0;i<argsList.size();i++){
				args[i] = argsList.get(i);
				args[i+argsList.size()] = argsList.get(i);
			}
			//System.out.println(sqlGroup.toString());
			ds = this.executeDataset(sqlGroup.toString(),types,args, getDsStart(pset), getDsLimit(pset), true);
		}
		return ds;
		*/
	}
	
	
	//年检历史查询
	public DataSet inspectionhistoryQuery(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		// 公墓ID
		String cemeId = (String) pset.getParameter("CEME_ID");
		// 管辖单位
		String manaLevelId = (String) pset.getParameter("MANA_LEVEL_ID");
		// 年检年份
		String checkYear = (String) pset.getParameter("CHECK_YEAR");
		
		String checkResult = (String) pset.getParameter("CHECK_RESULT");
		//公墓性质
		String prop = (String) pset.getParameter("PROP");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		
		sql.append("SELECT C.APPLY_ID,C.CEME_ID, C.CEME_NAME,C.MANA_LEVEL, C.PROP, R.CHECK_RESULT,");
		sql.append("C.CHECK_YEAR, C.CHECK_NUM,S.FIRST_TIME CHECK_TIME,R.RESULT_ID, C.ORGANIZER,");
		sql.append("S.FIRST_RESULT CHEKC_RESULT,S.FIRST_UNIT CHECK_UNIT,S.TOTAL_SCORE CHECK_SCORE ");
		sql.append("FROM FIS_CEME_CHECK_INFO C, FIS_CEME_CHECK_AUDIT S ,FIS_CEME_CHECK_RESULT R ");
		sql.append(" WHERE C.APPLY_ID = S.APPLY_ID AND R.FIRST_APPLY_ID = C.APPLY_ID  AND C.CHECK_NUM = '1'");
		//判断公墓性质是否为空
		if (prop != null) {
			sql.append(" AND C.PROP=? ");
			typeList.add(Types.VARCHAR);
			argsList.add(prop);
		}
		// 判断公墓ID是否为空
		if (cemeId != null) {
			sql.append(" AND C.CEME_ID=?");
			typeList.add(Types.VARCHAR );
			argsList.add(cemeId);
		}
		// 判断管辖单位是否为空
		if (manaLevelId != null) {
			if (manaLevelId.endsWith("0000000000")) {
				
			}else if (manaLevelId.endsWith("00000000")) {
				sql.append(" AND C.MANA_LEVEL_ID like '%'||?||'%' " );
				typeList.add(Types.VARCHAR );
				argsList.add(manaLevelId.substring(0, 4));
			} else {
				sql.append(" AND C.MANA_LEVEL_ID=? ");
				typeList.add(Types.VARCHAR );
				argsList.add(manaLevelId);
			}
		}
		// 判断年检年份是否为空
		if (checkYear != null) {
			sql.append(" AND C.CHECK_YEAR LIKE '%'||?||'%' ");
			typeList.add(Types.VARCHAR );
			argsList.add(checkYear);
		}
		
		if(checkResult!=null) {
			sql.append(" AND R.CHECK_RESULT = ? ");
			typeList.add(Types.VARCHAR );
			argsList.add(checkResult);
		}
		
		sql.append(" UNION SELECT C.APPLY_ID,C.CEME_ID, C.CEME_NAME,C.MANA_LEVEL ,C.PROP, R.CHECK_RESULT,");
		sql.append("C.CHECK_YEAR, C.CHECK_NUM,S.SECOND_TIME CHECK_TIME, R.RESULT_ID,C.ORGANIZER,");
		sql.append("S.SECOND_RESULT CHEKC_RESULT,S.SECOND_UNIT CHECK_UNIT,S.TOTAL_SCORE CHECK_SCORE ");
		sql.append("FROM FIS_CEME_CHECK_INFO C, FIS_CEME_CHECK_AUDIT S ,FIS_CEME_CHECK_RESULT R ");
		sql.append(" WHERE C.APPLY_ID = S.APPLY_ID  AND R.SECOND_APPLY_ID =C.APPLY_ID  AND C.CHECK_NUM = '2'");
		//判断公墓性质是否为空
		if (prop != null) {
			sql.append(" AND C.PROP=? ");
			typeList.add(Types.VARCHAR);
			argsList.add(prop);
		}
		// 判断公墓ID是否为空
		if (cemeId != null) {
			sql.append(" AND C.CEME_ID=?");
			typeList.add(Types.VARCHAR );
			argsList.add(cemeId);
		}
		// 判断管辖单位是否为空
		if (manaLevelId != null) {
			if (manaLevelId.endsWith("0000000000")) {
				
			}else if (manaLevelId.endsWith("00000000")) {
				sql.append(" AND C.MANA_LEVEL_ID like '%'||?||'%' " );
				typeList.add(Types.VARCHAR );
				argsList.add(manaLevelId.substring(0, 4));
			} else {
				sql.append(" AND C.MANA_LEVEL_ID=? ");
				typeList.add(Types.VARCHAR );
				argsList.add(manaLevelId);
			}
		}
		// 判断年检年份是否为空
		if (checkYear != null) {
			sql.append(" AND C.CHECK_YEAR LIKE '%'||?||'%' ");
			typeList.add(Types.VARCHAR );
			argsList.add(checkYear);
		}
		
		if(checkResult!=null) {
			sql.append(" AND R.CHECK_RESULT = ? ");
			typeList.add(Types.VARCHAR );
			argsList.add(checkResult);
		}
		sql.append(" ORDER BY CEME_NAME,CHECK_YEAR,CHECK_NUM ");
		int[] types = new int[typeList.size()];
		
		for(int i = 0;i<typeList.size();i++){
			types[i] = typeList.get(i);
		}
		Object[] args = argsList.toArray();
		
		DataSet ds = this.executeDataset(sql.toString(),types,args, pset.getPageStart(),
				pset.getPageLimit(), true);
		return ds;
	}
	
	//上报-公益性公墓
	public void reportNoProfitCheck(String wfId,String checkResult) {
		StringBuffer sql = new StringBuffer();
		sql.append("UPDATE FIS_CEME_CHECK_RESULT T SET T.IS_REPORT='1',T.CHECK_RESULT=? WHERE T.WF_ID=?");
		
		int[] types = new int[2];
		Object[] args = new Object[2];
		
		types[0]=Types.VARCHAR;
		args[0]=checkResult;
		types[1]=Types.VARCHAR;
		args[1]=wfId;
		
		executeUpdate(sql.toString(), types, args);
	}
	
	//整改-公益性公墓
	public void fullChangeNoProfitCheck(String wfId) {
		StringBuffer sql = new StringBuffer();
		sql.append("UPDATE FIS_CEME_CHECK_RESULT T SET T.IS_REPORT='1',T.CHECK_RESULT='5' WHERE T.WF_ID=?");
		
		int[] types = new int[1];
		Object[] args = new Object[1];
		
		types[0]=Types.VARCHAR;
		args[0]=wfId;
		
		executeUpdate(sql.toString(), types, args);
	}

	//上报-经营性公墓
	public void reportProfitFinalCheck(String wfId, String checkResult) {
		StringBuffer sql = new StringBuffer();
		sql.append("UPDATE FIS_CEME_CHECK_RESULT T SET T.IS_REPORT='1',T.CHECK_RESULT=? WHERE T.WF_ID=?");
		
		int[] types = new int[2];
		Object[] args = new Object[2];
		
		types[0]=Types.VARCHAR;
		args[0]=checkResult;
		types[1]=Types.VARCHAR;
		args[1]=wfId;
		
		executeUpdate(sql.toString(), types, args);
	}

	//整改-经营性公墓
	public void fullChangeProfitFinalCheck(String wfId) {
		StringBuffer sql = new StringBuffer();
		sql.append("UPDATE FIS_CEME_CHECK_RESULT T SET T.IS_REPORT='1',T.CHECK_RESULT='5' WHERE T.WF_ID=?");
		
		int[] types = new int[1];
		Object[] args = new Object[1];
		
		types[0]=Types.VARCHAR;
		args[0]=wfId;
		
		executeUpdate(sql.toString(), types, args);
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

	
	
	//	/**
//	 * @Title: queryForCheckReport 
//	 * @Description: TODO(年检结果统计查询) 
//	 * @param @param pset
//	 * @param @return 设定文件 
//	 * @return DataSet    返回类型
//	 */
//	public DataSet queryForCheckReport(ParameterSet pset) {
//		String year=(String)pset.getParameter("year");
//		String organCode=(String)pset.getParameter("organCode");
//		DataSet ds = null;
//		if(StringUtils.isNotEmpty(organCode)){
//			ds = queryForCheckReportSub(pset);
//			
//			if("PROVINCE".equals(organCode)){
//				pset.setParameter("organCode", "370000000000");
//				DataSet dsTemp = queryForCheckReportSub(pset);
//				for(int i=0; i < dsTemp.getCount(); i++) {
//					ds.addRecord(dsTemp.getRecord(i));
//				}
//			}
//		}
//		return ds;
//	}
//	
//	private DataSet queryForCheckReportSub(ParameterSet pset){
//		StringBuffer sql=new StringBuffer();
//		String year=(String)pset.getParameter("year");
//		String organCode=(String)pset.getParameter("organCode");
//		List<Integer> typeList = new ArrayList<Integer>();
//		List<Object> argsList = new ArrayList<Object>();
//		int index=6;
//		if(StringUtils.isNotEmpty(organCode)){
//			if(organCode.indexOf("0000000000")>0){
//				index=organCode.indexOf("0000000000");
//			}else if(organCode.indexOf("00000000")>0){
//				index=organCode.indexOf("00000000");
//			}else if("PROVINCE".equals(organCode)){
//				organCode="370000000000";
//				index=0;
//			}
//		}
//		sql.append(" SELECT   ");
//		sql.append("     GET_CITY_NAME(RPAD(SUBSTR(A.MANA_LEVEL_ID,1,").append(index+2).append("),12,'0')) CITYNAME,  ");
//		sql.append("  RPAD(SUBSTR(A.MANA_LEVEL_ID,1,").append(index+2).append("),12,'0') CITYCODE,  ");
//		sql.append("  COUNT(A.CEME_ID) TOTALNUM, ");
//		sql.append("  SUM(CASE WHEN A.CEME_ID = B.CEME_ID THEN  1 ELSE 0 END) TOTALCHECKNUM, ");
//		sql.append("  SUM(CASE WHEN A.CEME_ID NOT IN (SELECT CEME_ID FROM FIS_CEME_CHECK_RESULT) THEN 1 ELSE  0 END) UNDOCHECKNUM,");
//		sql.append("  SUM(CASE WHEN A.CEME_ID = B.CEME_ID AND B.CHECK_RESULT = '1' THEN 1 ELSE 0 END) PASSNUM,");
//		sql.append("  SUM(CASE WHEN A.CEME_ID = B.CEME_ID AND B.CHECK_RESULT = '2' THEN 1 ELSE 0 END) NOTPASSNUM,  ");
//		sql.append("  SUM(CASE WHEN A.CEME_ID = B.CEME_ID AND B.FIRST_RESULT = '1' THEN 1 ELSE  0 END) FIRPASSNUM,  ");
//		sql.append("  SUM(CASE WHEN A.CEME_ID = B.CEME_ID AND B.FIRST_RESULT = '2' THEN 1 ELSE 0 END) FIRNOTPASSNUM, ");
//		sql.append("  SUM(CASE WHEN A.CEME_ID = B.CEME_ID AND B.SECOND_RESULT = '1' THEN 1 ELSE  0 END) SECPASSNUM, ");
//		sql.append("  SUM(CASE WHEN A.CEME_ID = B.CEME_ID AND B.SECOND_RESULT = '2' THEN 1 ELSE 0 END) SECNOTPASSNUM ");
//		sql.append("  FROM FIS_CEME_INFO A  ");
//		sql.append("  LEFT JOIN FIS_CEME_CHECK_RESULT B ON A.CEME_ID = B.CEME_ID ");
//		if(StringUtils.isNotEmpty(organCode)){
//			sql.append("  WHERE A.MANA_LEVEL_ID LIKE ?");
//			typeList.add(Types.VARCHAR);
//			argsList.add(organCode.substring(0, index)+"%");
//		}
//		if(StringUtils.isNotEmpty(year)){
//			sql.append("  and B.CHECK_YEAR= ?");
//			typeList.add(Types.VARCHAR);
//			argsList.add(year);
//			
//		}
//		sql.append("  GROUP BY RPAD(SUBSTR(A.MANA_LEVEL_ID,1,").append(index+2).append("),12,'0')");
//		System.out.println(sql.toString());
//		DataSet ds = null;
//		if (typeList.size() != 0 && argsList.size() != 0) {
//			//有参数时执行方法
//			int[] types = new int[typeList.size()];
//			for(int i=0;i<typeList.size();i++) {
//				types[i]=(Integer)(typeList.get(i));
//			}
//			Object[] args = argsList.toArray(new Object[argsList.size()]);
//			ds = this.executeDataset(sql.toString(),types,args,pset.getPageStart(),pset.getPageLimit(),false);
//						
//		}else {
//			//无参数时执行方法
//			ds = this.executeDataset(sql.toString(),pset.getPageStart(),pset.getPageLimit(),false);
//						
//		}
//		return ds;
//	}
}
