package com.inspur.cams.fis.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.fis.base.data.FisFuneralOrganManage;

/**
 * @title:IFisFuneralOrganManageDao
 * @description:
 * @author:
 * @since:2012-04-03
 * @version:1.0
 */
public interface IFisFuneralOrganManageDao extends BaseCURD<FisFuneralOrganManage> {
	public void save(List<FisFuneralOrganManage> list);

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
