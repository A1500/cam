package com.inspur.cams.fis.base.domain;

import java.util.Map;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.fis.base.data.FisImportData;

/**
 * 数据上报信息domain
 * 
 * @author
 * @date Mon Apr 16 15:35:06 GMT+08:00 2012
 */
public interface IFisImportDataDomain {

	/**
	 * 查询 数据上报信息
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 数据上报信息
	 * 
	 * @param pset
	 * @return
	 */
	public FisImportData get(String recordId);

	/**
	 * 增加 数据上报信息
	 * 
	 * @param fisImportData
	 */
	@Trans
	public void insert(FisImportData fisImportData);

	/**
	 * 修改 数据上报信息
	 * 
	 * @param fisImportData
	 */
	@Trans
	public void update(FisImportData fisImportData);

	/**
	 * 删除 数据上报信息
	 * 
	 * @param recordId
	 */
	@Trans
	public void delete(String recordId);

	/**
	 * 批量执行sql语句
	 * 
	 * @param sqls
	 * @throws Exception
	 */
	@Trans
	public void batchImport(String[] sqls) throws Exception;

	/**
	 * @Description: 获取最后一次上报时间，参数为馆编号
	 * @author xuexzh
	 */
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