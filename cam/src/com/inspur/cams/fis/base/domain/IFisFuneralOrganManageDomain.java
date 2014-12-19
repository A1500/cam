package com.inspur.cams.fis.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.fis.base.data.FisFuneralOrganManage;

public interface IFisFuneralOrganManageDomain {

	public DataSet query(ParameterSet pset);

	public void insert(FisFuneralOrganManage bean);

	public Boolean queryUserIfExist(String organCode);

	/**
	 * @Title: queryOrganByUnitId
	 * @Description: 殡仪馆树的查询
	 * @return DataSet
	 * @throws
	 * @author jiangzhaobao
	 */
	public DataSet queryOrganByUnitId(ParameterSet pset);

	public DataSet queryInfoByArea(ParameterSet pset);

	public void deleteById(String organCode);

	public void update(FisFuneralOrganManage bean);

	/**
	 * @Description: 馆基本信息统计
	 * @author xuexzh
	 */
	public DataSet queryFuneralOrganSum(ParameterSet pset);

	/**
	 * @Description: 馆建设情况统计
	 * @author xuexzh
	 */
	public DataSet queryFuneralOrganBuildSum(ParameterSet pset);

	/**
	 * @Description: 馆设备情况统计
	 * @author xuexzh
	 */
	public DataSet queryFuneralOrganEquSum(ParameterSet pset);
}
