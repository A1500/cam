package com.inspur.cams.fis.base.dao;

import java.util.Map;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.fis.base.data.FisImportData;

/**
 * 数据上报信息dao
 * 
 * @author
 * @date Mon Apr 16 15:35:06 GMT+08:00 2012
 */
public interface IFisImportDataDao extends BaseCURD<FisImportData> {
	/**
	 * @Description: 批量执行sql语句
	 * @author xuexzh
	 * @throws Exception
	 */
	public void batchImport(String[] sqls) throws Exception;

	public Map getLastUploadTime(String unitId);

	/**
	 * @Description: 查询辖区各馆上报情况
	 * @author xuexzh
	 */
	public DataSet queryForImport(ParameterSet pset);
	
	/**
	 * @Description: 查询辖区各馆上报情况
	 * @author xuexzh
	 */
	public DataSet queryForOrganImport(ParameterSet pset);

	/**
	 * @Description: 查询辖区各公墓上报情况
	 * @author xuexzh
	 */
	public DataSet queryForCemeImport(ParameterSet pset);
}