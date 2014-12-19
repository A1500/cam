package com.inspur.cams.marry.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.marry.base.data.MrmElectronic;

/**
 * 婚姻电子档案dao接口
 */
public interface IMrmElectronicDao extends BaseCURD<MrmElectronic> {
	
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
	 * 通过sql查询Electronic信息
	 * @param pset
	 * @return
	 */
	public DataSet queryElectronicBySql(ParameterSet pset);
	
	/**
	 * 根据applyId删除
	 */
	public void delByApplyId(String applyId);
	
	/**
	 * 创建一条MRM_DUTY_ELECTRONIC信息
	 * @param dutyId
	 * @param electronicId
	 */
	public void insertMrmDutyElectronicBySql(String dutyId,String electronicId);
	
	/**
	 * 删除一条MRM_DUTY_ELECTRONIC信息
	 * @param dutyId
	 * @param electronicId
	 */
	public void deleteMrmDutyElectronicBySql(String dutyId,String electronicId);
	
	/**
	 * 根据deptId查询
	 * @param pset
	 * @return
	 */
	public DataSet queryElectronicByDeptId(ParameterSet pset);
}
