package com.inspur.cams.fis.base.domain.support;

import java.util.Map;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.fis.base.dao.IFisImportDataDao;
import com.inspur.cams.fis.base.data.FisImportData;
import com.inspur.cams.fis.base.domain.IFisImportDataDomain;

/**
 * 数据上报信息domain
 * 
 * @author
 * @date Mon Apr 16 15:35:06 GMT+08:00 2012
 */
public class FisImportDataDomain implements IFisImportDataDomain {

	@Reference
	private IFisImportDataDao fisImportDataDao;

	/**
	 * 查询 数据上报信息
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return fisImportDataDao.query(pset);
	}

	/**
	 * 获取 数据上报信息
	 * 
	 * @param pset
	 * @return
	 */
	public FisImportData get(String recordId) {
		return fisImportDataDao.get(recordId);
	}

	/**
	 * 增加 数据上报信息
	 * 
	 * @param fisImportData
	 */
	public void insert(FisImportData fisImportData) {
		fisImportDataDao.insert(fisImportData);
	}

	/**
	 * 修改 数据上报信息
	 * 
	 * @param fisImportData
	 */
	public void update(FisImportData fisImportData) {
		fisImportDataDao.update(fisImportData);
	}

	/**
	 * 删除 数据上报信息
	 * 
	 * @param recordId
	 */
	public void delete(String recordId) {
		fisImportDataDao.delete(recordId);
	}

	public void batchImport(String[] sqls) throws Exception {
		fisImportDataDao.batchImport(sqls);
	}

	public Map getLastUploadTime(String unitId) {
		return fisImportDataDao.getLastUploadTime(unitId);
	}

	/**
	 * @Description: 查询辖区各馆上报情况
	 * @author xuexzh
	 */
	public DataSet queryForImport(ParameterSet pset) {
		return fisImportDataDao.queryForImport(pset);
	}
	
	/**
	 * @Description: 查询辖区各馆上报情况
	 * @author xuexzh
	 */
	public DataSet queryForOrganImport(ParameterSet pset) {
		return fisImportDataDao.queryForOrganImport(pset);
	}
	
	/**
	 * @Description: 查询辖区各公墓上报情况
	 * @author xuexzh
	 */
	public DataSet queryForCemeImport(ParameterSet pset) {
		return fisImportDataDao.queryForCemeImport(pset);
	}
}