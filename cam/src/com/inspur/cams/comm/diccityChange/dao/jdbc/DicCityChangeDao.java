package com.inspur.cams.comm.diccityChange.dao.jdbc;

import java.sql.Types;
import java.util.HashMap;
import java.util.Map;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.diccityChange.dao.IDicCityChangeDao;
import com.inspur.cams.comm.diccityChange.data.DicCityChange;
import com.inspur.cams.comm.util.ProceduresUtil;
/**
 * 行政区划变更dao
 * @author 
 * @date 2013-12-23
 */
public class DicCityChangeDao extends EntityDao<DicCityChange> implements IDicCityChangeDao {
	
	@Override
	public Class<DicCityChange> getEntityClass() {
		return DicCityChange.class;
	}

	/**
	 * 调用存储过程更新行政区划
	 */
	public void changeDicCity(DicCityChange dicCityChange,String changeType) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("procedureName", "BP_ADMSTRAT_DIVISION_CHANGES");
		map.put("parameterNum",	6);
		map.put("parameterName_1", "P_PRE_CHANGE_CODE");
		map.put("parameterName_2", "P_PRE_CHANGE_NAME");
		map.put("parameterName_3", "P_POST_CHANGE_CODE");
		map.put("parameterName_4", "P_POST_CHANGE_NAME");
		map.put("parameterName_5", "P_UPS_CODE");
		map.put("parameterName_6", "P_CHANGE_TYPE");
		map.put("parameterValue_1", dicCityChange.getPreChangeCode());
		map.put("parameterValue_2", dicCityChange.getPreChangeName());
		map.put("parameterValue_3", dicCityChange.getPostChangeCode());
		map.put("parameterValue_4", dicCityChange.getPostChangeName());
		map.put("parameterValue_5", dicCityChange.getPreUpsCode());
		map.put("parameterValue_6", changeType);
		map.put("NumberOfResultSet",0);
		new ProceduresUtil().init(getDataSource(),map).call(map);
	}
	
	public String getNumber(String batchId) {
		String maxNum;
		 String sql = "SELECT nvl(MAX(T.SERIAL_NUM),0) AS MAX_NUM FROM DIC_CITY_CHANGE T WHERE T.BATCH_ID= ? ";
	     DataSet ds =  this.executeDataset(sql.toString(), new int[]{Types.VARCHAR},new Object[]{batchId},true);
	     maxNum=  ds.getRecord(0).get("MAX_NUM")+"";
		 return maxNum;
	}
	
	public DataSet queryTrans(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		String batchId = (String) pset.getParameter("batchId");
		sql.append("SELECT * FROM DIC_CITY_CHANGE T ");
		sql.append(" WHERE T.BATCH_ID = ? ");
		sql.append(" AND T.CHANGE_TYPE='03' ");
		sql.append(" AND T.CHANGE_ID NOT IN (SELECT M.CHANGE_ID FROM DIC_CITY_DATA_TRANS M) ");
	     DataSet ds =  this.executeDataset(sql.toString(), new int[]{Types.VARCHAR},new Object[]{batchId},true);
		 return ds;
	}
}