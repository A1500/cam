package com.inspur.cams.fis.ep.base.dao.jdbc;

import java.util.ArrayList;
import java.util.List;
import java.sql.Types;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.fis.ep.base.cmd.FisCemeCheckResultQueryCommand;
import com.inspur.cams.fis.ep.base.dao.IFisCemeDao;
import com.inspur.cams.fis.ep.base.data.FisCeme;

/**
 * @title:FisCemeDao
 * @description:公墓行业库dao
 * @author:lidongdong
 * @since:2011-11-11
 * @version:1.0
 */
public class FisCemeDao extends EntityDao<FisCeme> implements IFisCemeDao {

	public FisCemeDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return FisCeme.class;
	}

	public void deleteStruAll() {
		executeUpdate("delete from FisCeme");
	}
	
	//获取当前单位下属公墓信息（带年检信息）
	public DataSet queryCemeBySql(ParameterSet pset) {

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
		
		sqlYes.append("SELECT NVL(S.CHECK_YEAR, '");
		sqlYes.append(checkYear).append("') AS CHECK_YEAR,NVL(S.CHECK_RESULT, '0') AS CHECK_RESULT,C.* ");
		sqlYes.append(" FROM FIS_CEME_INFO C RIGHT JOIN FIS_CEME_CHECK_RESULT S ON C.CEME_ID=S.CEME_ID WHERE S.IS_REPORT='1' ");
		
		sqlNo.append("SELECT '");
		sqlNo.append(checkYear).append("' AS CHECK_YEAR,'0' AS CHECK_RESULT,C.* ");
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
		areaLevelId = BspUtil.getOrganCode();
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
//				System.out.println(sqlYes.toString());
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
//			System.out.println(sqlGroup.toString());
			ds = this.executeDataset(sqlGroup.toString(),types,args, getDsStart(pset), getDsLimit(pset), true);
		}
		return ds;
	}
	
	public DataSet queryResult(ParameterSet pset) {
		String year = (String) pset.getParameter("year");
		String state = (String) pset.getParameter("state");
		/*
		 * 通过state判断查询区间
		 * all为全部，checked已年检，unChecked为未参检，qualified为年检合格，unQualified为年检不合格，firstqQualified为初审不合格
		 * firstUnQualified为初审合格，secondQualified为复审合格，secondUnQualified为复审不合格
		 * */
		String cityCode = (String) pset.getParameter("cityCode");
		String ifSum = (String) pset.getParameter("ifSum");
		String isP = (String) pset.getParameter("isP");
		String prop = (String) pset.getParameter("prop");

		StringBuffer sql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		int index = 6;//管理机构代码
		if (StringUtils.isNotEmpty(isP) && !"null".equalsIgnoreCase(isP)) {
			if (StringUtils.isNotEmpty(cityCode)) {
				if (cityCode.indexOf("0000000000") > 0) {
					index = cityCode.indexOf("0000000000");
				} else if (cityCode.indexOf("00000000") > 0) {
					index = cityCode.indexOf("00000000");
				}
			}
		} else {
			if (StringUtils.isNotEmpty(cityCode)) {
				if (cityCode.indexOf("0000000000") > 0) {
					index = cityCode.indexOf("0000000000");
				} else if (cityCode.indexOf("00000000") > 0
						&& "1".equals(ifSum)) {
					index = cityCode.indexOf("00000000");
				}
			}
		}
		if("all".equals(state)){
			//下属全部公墓
			sql.append(" SELECT A.CEME_ID,A.CEME_NAME,A.AREA_LEVEL,A.MANA_LEVEL, ");
			sql.append(" A.ORGANIZER,A.ADDRESS,A.LEGAL_PERSON,A.PROP,");
			sql.append(" A.DIRECTOR_MOBILE,A.GESTION_TIME,A.TOTAL_STAFF ");
			sql.append("  FROM FIS_CEME_INFO A WHERE 1=1 ");
		}else if("checked".equals(state)){
			//参检
			sql.append(" SELECT A.CEME_ID,A.CEME_NAME,A.AREA_LEVEL,A.MANA_LEVEL, ");
			sql.append(" A.ORGANIZER,A.ADDRESS,A.LEGAL_PERSON,A.PROP,");
			sql.append(" A.DIRECTOR_MOBILE,A.GESTION_TIME,A.TOTAL_STAFF ");
			sql.append("  FROM FIS_CEME_INFO A,FIS_CEME_CHECK_RESULT B WHERE B.CEME_ID = A.CEME_ID AND B.IS_REPORT='1'  ");
			if ((year != null)&&!"null".equalsIgnoreCase(year)) {
				sql.append(" AND B.CHECK_YEAR = ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(year);
			}
		}else if("unChecked".equals(state)){
			//未参检
			sql.append(" SELECT A.CEME_ID,A.CEME_NAME,A.AREA_LEVEL,A.MANA_LEVEL, ");
			sql.append(" A.ORGANIZER,A.ADDRESS,A.LEGAL_PERSON,A.PROP,");
			sql.append(" A.DIRECTOR_MOBILE,A.GESTION_TIME,A.TOTAL_STAFF ");
			sql.append(" FROM FIS_CEME_INFO A WHERE A.CEME_ID NOT IN ");
			sql.append(" (SELECT S.CEME_ID FROM FIS_CEME_CHECK_RESULT S WHERE 1=1 AND S.IS_REPORT='1' ");
			if(!("null".equals(year))&&(year!=null)){
				sql.append(" AND S.CHECK_YEAR= ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(year);
			}
			sql.append(" ) ");
		}else if("qualified".equals(state)){
			//合格
			sql.append(" SELECT A.CEME_ID,A.CEME_NAME,A.AREA_LEVEL,A.MANA_LEVEL, ");
			sql.append(" A.ORGANIZER,A.ADDRESS,A.LEGAL_PERSON,A.PROP,");
			sql.append(" A.DIRECTOR_MOBILE,A.GESTION_TIME,A.TOTAL_STAFF ");
			sql.append("  FROM FIS_CEME_INFO A, FIS_CEME_CHECK_RESULT B ");
			sql.append(" WHERE B.CEME_ID = A.CEME_ID AND B.IS_REPORT='1' ");
			sql.append(" AND B.CHECK_RESULT= '1' ");
			if ((year != null)&&!"null".equalsIgnoreCase(year)) {
				sql.append(" AND B.CHECK_YEAR = ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(year);
			}
		}else if("unQualified".equals(state)){
			//不合格
			sql.append(" SELECT A.CEME_ID,A.CEME_NAME,A.AREA_LEVEL,A.MANA_LEVEL, ");
			sql.append(" A.ORGANIZER,A.ADDRESS,A.LEGAL_PERSON,A.PROP,");
			sql.append(" A.DIRECTOR_MOBILE,A.GESTION_TIME,A.TOTAL_STAFF ");
			sql.append("  FROM FIS_CEME_INFO A , FIS_CEME_CHECK_RESULT B ");
			sql.append(" WHERE B.CEME_ID = A.CEME_ID AND B.IS_REPORT='1' ");
			sql.append(" AND B.CHECK_RESULT= '2' ");
			if ((year != null)&&!"null".equalsIgnoreCase(year)) {
				sql.append(" AND B.CHECK_YEAR = ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(year);
			}
		}else if("firstUnQualified".equals(state)){
			//整改
			sql.append(" SELECT A.CEME_ID,A.CEME_NAME,A.AREA_LEVEL,A.MANA_LEVEL, ");
			sql.append(" A.ORGANIZER,A.ADDRESS,A.LEGAL_PERSON,A.PROP,");
			sql.append(" A.DIRECTOR_MOBILE,A.GESTION_TIME,A.TOTAL_STAFF ");
			sql.append(" FROM FIS_CEME_INFO A , FIS_CEME_CHECK_RESULT B ");
			sql.append(" WHERE B.CEME_ID = A.CEME_ID AND B.IS_REPORT='1' ");
			sql.append(" AND B.CHECK_RESULT  = '5' ");
			if ((year != null)&&!("null".equalsIgnoreCase(year))) {
				sql.append(" AND B.CHECK_YEAR = ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(year);
			}
		}else if("firstqQualified".equals(state)){
			sql.append(" SELECT A.CEME_ID,A.CEME_NAME,A.AREA_LEVEL,A.MANA_LEVEL, ");
			sql.append(" A.ORGANIZER,A.ADDRESS,A.LEGAL_PERSON,A.PROP,");
			sql.append(" A.DIRECTOR_MOBILE,A.GESTION_TIME,A.TOTAL_STAFF ");
			sql.append(" FROM FIS_CEME_INFO A , FIS_CEME_CHECK_RESULT B ");
			sql.append(" WHERE B.CEME_ID = A.CEME_ID ");
			sql.append(" AND B.FIRST_RESULT  = '1' ");
			if ((year != null)&&!"null".equalsIgnoreCase(year)) {
				sql.append(" AND B.CHECK_YEAR = ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(year);
			}
		}else if("secondQualified".equals(state)){
			sql.append(" SELECT A.CEME_ID,A.CEME_NAME,A.AREA_LEVEL,A.MANA_LEVEL, ");
			sql.append(" A.ORGANIZER,A.ADDRESS,A.LEGAL_PERSON,A.PROP,");
			sql.append(" A.DIRECTOR_MOBILE,A.GESTION_TIME,A.TOTAL_STAFF ");
			sql.append(" FROM FIS_CEME_INFO A , FIS_CEME_CHECK_RESULT B ");
			sql.append(" WHERE B.CEME_ID = A.CEME_ID ");
			sql.append(" AND B.SECOND_RESULT  = '1' ");
			if ((year != null)&&!("null".equalsIgnoreCase(year))) {
				sql.append(" AND B.CHECK_YEAR  = ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(year);
			}
		}else{
			sql.append(" SELECT A.CEME_ID,A.CEME_NAME,A.AREA_LEVEL,A.MANA_LEVEL, ");
			sql.append(" A.ORGANIZER,A.ADDRESS,A.LEGAL_PERSON,A.PROP,");
			sql.append(" A.DIRECTOR_MOBILE,A.GESTION_TIME,A.TOTAL_STAFF ");
			sql.append(" FROM FIS_CEME_INFO A , FIS_CEME_CHECK_RESULT B ");
			sql.append(" WHERE B.CEME_ID = A.CEME_ID ");
			sql.append(" AND B.SECOND_RESULT   = '2' ");
			if ((year != null)&&!("null".equalsIgnoreCase(year))) {
				sql.append(" AND B.CHECK_YEAR = ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(year);
			}
		}
		if(!("0".equals(prop))){
			if((prop!=null)&&!("null".equalsIgnoreCase(prop))){
				sql.append(" AND A.PROP = ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(prop);
			}
		}
		if ((cityCode!=null)&&!("null".equalsIgnoreCase(cityCode))) {
			sql.append(" AND A.AREA_LEVEL_ID LIKE ?||'%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(cityCode.substring(0, index));
		}
		
		sql.append(" ORDER BY A.CEME_ID ");
		
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object[] args = argsList.toArray();
		DataSet ds = executeDataset(sql.toString(), types, args,pset.getPageStart(),pset.getPageLimit(), true);
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
	
	//获取当前单位下最大的顺序号
	public DataSet queryCemeMaxNum(ParameterSet pset) {
		String manaLevelId = (String) pset.getParameter("manaLevelId");
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT NVL(MAX(T.CEME_ID),'01') AS MAX_NUM FROM FIS_CEME_INFO T WHERE T.MANA_LEVEL_ID =?");
		int[] types = new int[1];
		Object[] args = new Object[1];
		types[0]=Types.VARCHAR;
		args[0]=manaLevelId;
		return this.executeDataset(sql.toString(),types,args, true);
	}
	
	public DataSet queryForPrintInfo(ParameterSet pset){
		DataSet ds = new DataSet();
		// 公墓ID
		String cemeId = (String) pset.getParameter("CEME_ID");
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT FIS_CEME_INFO.TOTAL_AREA,FIS_CEME_INFO.FUND_SOURCES, ");
		sql.append("FIS_CEME_INFO.CEME_NAME,FIS_CEME_INFO.AREA_LEVEL,");
		sql.append("FIS_CEME_INFO.SERVICE_SCOPE,FIS_CEME_INFO.ADDRESS,");
		sql.append("FIS_CEME_INFO.TOTAL_STAFF, FIS_CEME_INFO.BUILT_AREA, FIS_CEME_INFO.LEGAL_PERSON,");
		sql.append("FIS_CEME_INFO.MANA_LEVEL,FIS_CEME_INFO.BUILT_TOTAL_AREA,FIS_CEME_INFO.ORGANIZER,");
		sql.append("FIS_CEME_INFO.CEME_ID,FIS_CEME_INFO.MANA_LEVEL_ID,");
		sql.append("   (CASE FIS_CEME_INFO.PROP ");
		sql.append("      WHEN '1' THEN '公益性'");
		sql.append("      WHEN '2' THEN '经营性'");
		sql.append(" 	END) AS PROP,");
		sql.append("FIS_CEME_INFO.DIRECTOR_MOBILE,FIS_CEME_INFO.POSTALCODE,FIS_CEME_INFO.TOTAL_INVESTMENT,");
		sql.append("   (CASE FIS_CEME_INFO.UNIT_PROPERTIES ");
		sql.append("      WHEN '1' THEN '全额拨款事业单位'");
		sql.append("      WHEN '2' THEN '差额拨款事业单位'");
		sql.append(" 	  WHEN '3' THEN '自收自支事业单位'");
		sql.append(" 	  WHEN '4' THEN '企业'");
		sql.append(" 	  WHEN '5' THEN '其他'");
		sql.append(" 	END) AS UNIT_PROPERTIES,");
		sql.append("FIS_CEME_INFO.GESTION_TIME,FIS_CEME_INFO.FIXE_DASSETS,");
		sql.append("FIS_CEME_INFO.OFFICE_PHONE,FIS_CEME_INFO.AREA_LEVEL_ID ");
		sql.append(" FROM FIS_CEME_INFO ");
		sql.append(" WHERE 1=1 ");
		sql.append(" AND  FIS_CEME_INFO.CEME_ID = ? ");
		int[] types = new int[1];
		Object[] args = new Object[1];
		types[0]=Types.VARCHAR;
		args[0]=cemeId;
		ds = this.executeDataset(sql.toString(),types,args, true);
		return ds;
	}


	/**
	 * 查询公墓系统上报信息（公墓部署）
	 * @return
	 */
	public DataSet queryImportCemeInfo(ParameterSet pset) {
		DataSet ds = new DataSet();
		// 公墓ID
		String cemeId = (String) pset.getParameter("CEME_ID");
		StringBuffer sql = new StringBuffer();
		sql.append("select * from fis_cemetery_organ t ");
		sql.append(" where t.organ_id=? ");
		int[] types = new int[1];
		Object[] args = new Object[1];
		types[0]=Types.VARCHAR;
		args[0]=cemeId;
		ds = this.executeDataset(sql.toString(),types,args, true);
		return ds;
	}

	/**
	 * @Description: 公墓树查询
	 * @author xuexzh
	 */
	public DataSet queryOrganByUnitId(ParameterSet pset) {
		String UNIT_ID = (String) pset.getParameter("unitId");

		List<Integer> typeList = new ArrayList<Integer>();
		List<String> objsList = new ArrayList<String>();

		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT ORGAN_ID ORGAN_CODE, ORGAN_ID UNIT_ID,NAME UNIT_NAME FROM FIS_CEMETERY_ORGAN WHERE 1=1 ");
		if (StringUtils.isNotEmpty(UNIT_ID)
				&& !(UNIT_ID.substring(2).equals("0000"))) {
			if (UNIT_ID.substring(4).equals("00")) {
				sql.append(" AND SUBSTR(ORGAN_ID,3,4) = ? ");
				typeList.add(Types.VARCHAR);
				objsList.add(UNIT_ID.substring(0, 4));
			} else {
				sql.append(" AND SUBSTR(ORGAN_ID,3,6) = ? ");
				typeList.add(Types.VARCHAR);
				objsList.add(UNIT_ID);
			}
		}

		sql.append(" ORDER BY ORGAN_ID");
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, true);
		} else {
			ds = this.executeDataset(sql.toString(), true);
		}
		return ds;
	}
	
}
