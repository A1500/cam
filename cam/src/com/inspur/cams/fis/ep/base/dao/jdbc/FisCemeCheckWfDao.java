package com.inspur.cams.fis.ep.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.bsp.util.StringUtil;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.fis.ep.base.dao.IFisCemeCheckWfDao;
import com.inspur.cams.fis.ep.base.data.FisCemeCheckWf;

/**
 * @title: FisCemeCheckInfoDao
 * @description:
 * @version:1.0
 */
public class FisCemeCheckWfDao extends EntityDao<FisCemeCheckWf> implements
		IFisCemeCheckWfDao {

	public FisCemeCheckWfDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return FisCemeCheckWf.class;
	}

	public void deleteStruAll() {
	}

	//查询需要进行年检的公益性公墓
	public DataSet cemeNoProfitCheckQuery(ParameterSet pset) {
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
		// 上报状态
		String isReport = (String) pset.getParameter("IS_REPORT");
		
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		
		sqlYes.append("SELECT C.CEME_ID,C.CEME_NAME,C.PROP,C.MANA_LEVEL,C.AREA_LEVEL,S.WF_ID,S.CHECK_NUM,S.CHECK_YEAR AS CHECK_YEAR,S.CHECK_RESULT,S.IS_REPORT AS IS_REPORT,S.CURRENT_ORGAN,S.IS_EDIT,S.END_APPLY_ID");
		sqlYes.append(" FROM FIS_CEME_INFO C RIGHT JOIN FIS_CEME_CHECK_WF S ON C.CEME_ID = S.CEME_ID");
		sqlYes.append(" WHERE 1=1 AND C.PROP='1' ");
		
		sqlNo.append("SELECT C.CEME_ID,C.CEME_NAME,C.PROP,C.MANA_LEVEL,C.AREA_LEVEL,'' AS WF_ID,'0' AS CHECK_NUM,'");
		sqlNo.append(checkYear).append("' AS CHECK_YEAR,'0' AS CHECK_RESULT, '0' AS IS_REPORT,'0' AS CURRENT_ORGAN,'0' AS IS_EDIT,'' AS END_APPLY_ID ");
		sqlNo.append(" FROM FIS_CEME_INFO C WHERE 1=1 AND C.PROP='1' ");
		
		// 判断公墓ID是否为空
		if (cemeId != null) {
			sqlYes.append(" AND S.CEME_ID=? ");
			sqlNo.append(" AND C.CEME_ID=? ");
			typeList.add(Types.VARCHAR);
			argsList.add(cemeId);
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
			sqlNo.append(" AND C.CEME_ID NOT IN (SELECT S.CEME_ID FROM FIS_CEME_CHECK_WF S WHERE S.CHECK_YEAR=? )");
			typeList.add(Types.VARCHAR);
			argsList.add(checkYear);
		}
		
		if("1".equals(isReport)) {
			//查询已经上报的
			sqlYes.append(" AND S.CURRENT_ORGAN='1' AND S.IS_REPORT='1' ");
			int[] types = new int[typeList.size()];
			
			for(int i = 0;i<typeList.size();i++){
				types[i] = typeList.get(i);
			}
			Object[] args = argsList.toArray();
			sqlYes.append(" ORDER BY C.CEME_ID");
			
			ds = this.executeDataset(sqlYes.toString(),types,args, pset.getPageStart(), pset.getPageLimit(), true);
		}else {
			//查询全部年检结果
			if("0".equals(isReport))
				sqlYes.append(" AND S.CURRENT_ORGAN='0' AND S.IS_REPORT='0' ");
			
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
//			System.out.println(sqlGroup.toString());
			ds = this.executeDataset(sqlGroup.toString(),types,args, pset.getPageStart(), pset.getPageLimit(), true);
		}
		
		return ds;
	}
	
	//查询需要进行检查的经营性公墓
	public DataSet cemeProfitCheckQuery(ParameterSet pset) {
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
		
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		
		sqlYes.append("SELECT C.CEME_ID,C.CEME_NAME,C.PROP,C.MANA_LEVEL,C.AREA_LEVEL,S.WF_ID,S.CHECK_NUM,S.CHECK_YEAR AS CHECK_YEAR,S.CHECK_RESULT,S.IS_REPORT AS IS_REPORT,S.CURRENT_ORGAN,S.IS_EDIT,S.END_APPLY_ID");
		sqlYes.append(" FROM FIS_CEME_INFO C RIGHT JOIN FIS_CEME_CHECK_WF S ON C.CEME_ID = S.CEME_ID");
		sqlYes.append(" WHERE 1=1 AND C.PROP='2' AND S.CURRENT_ORGAN='0' AND S.IS_REPORT='0' ");
		
		sqlNo.append("SELECT C.CEME_ID,C.CEME_NAME,C.PROP,C.MANA_LEVEL,C.AREA_LEVEL,'' AS WF_ID,'0' AS CHECK_NUM,'");
		sqlNo.append(checkYear).append("' AS CHECK_YEAR,'0' AS CHECK_RESULT, '0' AS IS_REPORT,'0' AS CURRENT_ORGAN,'0' AS IS_EDIT,'' AS END_APPLY_ID ");
		sqlNo.append(" FROM FIS_CEME_INFO C WHERE 1=1 AND C.PROP='2' ");
		
		// 判断公墓ID是否为空
		if (cemeId != null) {
			sqlYes.append(" AND S.CEME_ID=? ");
			sqlNo.append(" AND C.CEME_ID=? ");
			typeList.add(Types.VARCHAR);
			argsList.add(cemeId);
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
			sqlNo.append(" AND C.CEME_ID NOT IN (SELECT S.CEME_ID FROM FIS_CEME_CHECK_WF S WHERE S.CHECK_YEAR=? )");
			typeList.add(Types.VARCHAR);
			argsList.add(checkYear);
		}
		
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
//		System.out.println(sqlGroup.toString());
		ds = this.executeDataset(sqlGroup.toString(),types,args, pset.getPageStart(), pset.getPageLimit(), true);
		
		return ds;
	}
	
	//查询需要进行年检的经营性公墓
	public DataSet cemeProfitFinalCheckQuery(ParameterSet pset) {
		StringBuffer sqlYes = new StringBuffer();	//已参检的
		DataSet ds = new DataSet();
		
		// 公墓ID
		String cemeId = (String) pset.getParameter("CEME_ID");
		// 所属区划
		String areaLevelId = (String) pset.getParameter("AREA_LEVEL_ID");
		// 主管单位
		String manaLevelId = (String) pset.getParameter("MANA_LEVEL_ID");
		// 年检年份
		String checkYear = (String) pset.getParameter("CHECK_YEAR");
		// 上报状态
		String isReport = (String) pset.getParameter("IS_REPORT");
		
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		
		sqlYes.append("SELECT C.CEME_ID,C.CEME_NAME,C.PROP,C.MANA_LEVEL,C.AREA_LEVEL,S.WF_ID,S.CHECK_NUM,S.CHECK_YEAR AS CHECK_YEAR,S.CHECK_RESULT,S.IS_REPORT AS IS_REPORT,S.CURRENT_ORGAN,S.IS_EDIT,S.END_APPLY_ID");
		sqlYes.append(" FROM FIS_CEME_INFO C RIGHT JOIN FIS_CEME_CHECK_WF S ON C.CEME_ID = S.CEME_ID");
		sqlYes.append(" WHERE 1=1 AND C.PROP='2' ");
		
		// 判断公墓ID是否为空
		if (cemeId != null) {
			sqlYes.append(" AND S.CEME_ID=? ");
			typeList.add(Types.VARCHAR);
			argsList.add(cemeId);
		}
		//判断主管单位是否为空
		if (manaLevelId != null) {
			sqlYes.append(" AND C.MANA_LEVEL_ID=? ");
			typeList.add(Types.VARCHAR);
			argsList.add(manaLevelId);
		}
		// 判断所属区划是否为空
		if (areaLevelId != null) {
			if (areaLevelId.endsWith("0000000000")) {	//省
				
			}else if (areaLevelId.endsWith("00000000")) {	//市
				sqlYes.append(" AND C.AREA_LEVEL_ID like ?||'%' " );
				typeList.add(Types.VARCHAR);
				argsList.add(areaLevelId.substring(0, 4));
			} else {	//县
				sqlYes.append(" AND C.AREA_LEVEL_ID=? ");
				typeList.add(Types.VARCHAR);
				argsList.add(areaLevelId);
			}
		}
		// 判断年检年份是否为空
		if (checkYear != null) {
			sqlYes.append(" AND S.CHECK_YEAR=? ");
			typeList.add(Types.VARCHAR);
			argsList.add(checkYear);
		}
		
		if("1".equals(isReport)) {
			//查询已经上报的
			sqlYes.append(" AND S.CURRENT_ORGAN='2' ");
		}else if("0".equals(isReport)){
			sqlYes.append(" AND S.CURRENT_ORGAN='1' AND S.IS_REPORT='0' ");
		}
		
		int[] types = new int[typeList.size()];
		
		for(int i = 0;i<typeList.size();i++){
			types[i] = typeList.get(i);
		}
		Object[] args = argsList.toArray();
		sqlYes.append(" ORDER BY C.CEME_ID");
		
		ds = this.executeDataset(sqlYes.toString(),types,args, pset.getPageStart(), pset.getPageLimit(), true);
		
		return ds;
	}
	
	//上报公益性公墓
	public void reportNoProfitCheck(String wfId) {
		String date = com.inspur.cams.comm.util.DateUtil.getTime();
		String user = BspUtil.getEmpOrganId();
		
		StringBuffer sql = new StringBuffer();
		sql.append("UPDATE FIS_CEME_CHECK_WF T SET T.IS_REPORT='1',T.IS_EDIT='0',T.CURRENT_ORGAN='1',T.REPORT_TIME=?,T.REPORT_PERSON=? WHERE T.WF_ID=?");
		
		int[] types = new int[3];
		Object[] args = new Object[3];
		
		types[0]=Types.VARCHAR;
		types[1]=Types.VARCHAR;
		types[2]=Types.VARCHAR;
		args[0]=date;
		args[1]=user;
		args[2]=wfId;
		
		executeUpdate(sql.toString(), types, args);
	}
	
	//整改公益性公墓
	public void fullChangeNoProfitCheck(String wfId) {
		String date = com.inspur.cams.comm.util.DateUtil.getTime();
		String user = BspUtil.getEmpOrganId();
		
		StringBuffer sql = new StringBuffer();
		sql.append("UPDATE FIS_CEME_CHECK_WF T SET T.IS_REPORT='0',T.IS_EDIT='0',T.CURRENT_ORGAN='0',T.REPORT_TIME=?,T.REPORT_PERSON=? WHERE T.WF_ID=?");
		
		int[] types = new int[3];
		Object[] args = new Object[3];
		
		types[0]=Types.VARCHAR;
		types[1]=Types.VARCHAR;
		types[2]=Types.VARCHAR;
		args[0]=date;
		args[1]=user;
		args[2]=wfId;
		
		executeUpdate(sql.toString(), types, args);
	}
	
	//上报经营性公墓-检查
	public void reportProfitCheck(String wfId) {
		String date = com.inspur.cams.comm.util.DateUtil.getTime();
		String user = BspUtil.getEmpOrganId();
		
		StringBuffer sql = new StringBuffer();
		sql.append("UPDATE FIS_CEME_CHECK_WF T SET T.IS_REPORT='0',T.IS_EDIT='0',T.CURRENT_ORGAN='1',T.REPORT_TIME=?,T.REPORT_PERSON=? WHERE T.WF_ID=?");
		
		int[] types = new int[3];
		Object[] args = new Object[3];
		
		types[0]=Types.VARCHAR;
		types[1]=Types.VARCHAR;
		types[2]=Types.VARCHAR;
		args[0]=date;
		args[1]=user;
		args[2]=wfId;
		
		executeUpdate(sql.toString(), types, args);
	}

	//上报经营性公墓-年检
	public void reportProfitFinalCheck(String wfId) {
		String date = com.inspur.cams.comm.util.DateUtil.getTime();
		String user = BspUtil.getEmpOrganId();
		
		StringBuffer sql = new StringBuffer();
		sql.append("UPDATE FIS_CEME_CHECK_WF T SET T.IS_REPORT='1',T.IS_EDIT='0',T.CURRENT_ORGAN='2',T.REPORT_TIME=?,T.REPORT_PERSON=? WHERE T.WF_ID=?");
		
		int[] types = new int[3];
		Object[] args = new Object[3];
		
		types[0]=Types.VARCHAR;
		types[1]=Types.VARCHAR;
		types[2]=Types.VARCHAR;
		args[0]=date;
		args[1]=user;
		args[2]=wfId;
		
		executeUpdate(sql.toString(), types, args);
	}

	//整改经营性公墓
	public void fullChangeProfitFinalCheck(String wfId) {
		String date = com.inspur.cams.comm.util.DateUtil.getTime();
		String user = BspUtil.getEmpOrganId();
		
		StringBuffer sql = new StringBuffer();
		sql.append("UPDATE FIS_CEME_CHECK_WF T SET T.IS_REPORT='0',T.IS_EDIT='0',T.CURRENT_ORGAN='0',T.REPORT_TIME=?,T.REPORT_PERSON=? WHERE T.WF_ID=?");
		
		int[] types = new int[3];
		Object[] args = new Object[3];
		
		types[0]=Types.VARCHAR;
		types[1]=Types.VARCHAR;
		types[2]=Types.VARCHAR;
		args[0]=date;
		args[1]=user;
		args[2]=wfId;
		
		executeUpdate(sql.toString(), types, args);
	}
}
