package com.inspur.cams.sorg.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.sorg.base.data.SomElectronic;

/**
 * 社会组织电子档案dao接口
 * @author shgtch
 * @date 2011-5-11
 */
public interface ISomElectronicDao extends BaseCURD<SomElectronic> {
	
	/**
	 * 通过sql查询登记阶段法律要件信息
	 * @param pset
	 * @return
	 */
	public DataSet queryCatalogBySql(ParameterSet pset);
	
	/**
	 * 通过sql查询下载列表
	 * @param pset
	 * @return
	 */
	public DataSet queryElectronic(ParameterSet pset);
	
	/**
	 * 通过sql查询归档阶段法律要件信息
	 * @param pset
	 * @return
	 */
	public DataSet queryArchiveCatalogBySql(ParameterSet pset);
	
	/**
	 * 通过sql查询人员法律要件信息
	 * @param pset
	 * @return
	 */
	public DataSet queryPeopleCatalogBySql(ParameterSet pset);

	/**
	 * 通过sql查询人员Electronic信息
	 * @param pset
	 * @return
	 */
	public DataSet queryPeopleElectronicBySql(ParameterSet pset);
	
	/**
	 * 通过sql查询Electronic信息
	 * @param pset
	 * @return
	 */
	public DataSet queryElectronicBySql(ParameterSet pset);
	
	/**
	 * 通过ID删除档案信息
	 * @param electronicId
	 */
	public void deleteById(String electronicId);
	
	/**
	 * 创建一条SOM_DUTY_ELECTRONIC信息
	 * @param dutyId
	 * @param electronicId
	 */
	public void insertSomDutyElectronicBySql(String dutyId,String electronicId);
	
	/**
	 * 删除一条SOM_DUTY_ELECTRONIC信息
	 * @param dutyId
	 * @param electronicId
	 */
	public void deleteSomDutyElectronicBySql(String dutyId,String electronicId);
	
	/**
	 * 根据sorgId查询社会组织的所有档案
	 * @param pset
	 * @return
	 */
	public DataSet queryElectronicBySorgId(ParameterSet pset);
	/**
	 * 通过taskCode更新sorgId
	 */
	public void updateSorgId(String sorgId, String taskCode);
}
