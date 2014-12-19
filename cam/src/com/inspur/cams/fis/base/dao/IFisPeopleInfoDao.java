package com.inspur.cams.fis.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.fis.base.data.FisPeopleInfo;

/**
 * @Path com.inspur.cams.fis.base.dao.IFisPeopleInfoDao
 * @Description: TODO 殡葬业务工作人员信息表dao的接口
 * @author jiangzhaobao
 * @date 2011-11-15
 */
public interface IFisPeopleInfoDao extends BaseCURD<FisPeopleInfo> {
	public DataSet queryForService(ParameterSet pset);

	public void open(String peopleId);

	public void cencel(String peopleId);

	public DataSet queryForPeopleRecords(ParameterSet pset);

	public DataSet queryForPeopleService(ParameterSet pset);

	public DataSet querySumForServer(ParameterSet pset);

	/**
	 * @Title: queryForExport
	 * @Description: TODO(数据上报导出数据方法)
	 * @param set
	 * @return DataSet
	 * @throws
	 * @author luguosui
	 */
	public DataSet queryForExport(ParameterSet set);

	/**
	 * @Description: 馆工作人员统计一
	 * @author xuexzh
	 */
	public DataSet queryFuneralOrganPeoSum(ParameterSet pset);

	/**
	 * @Description: 馆工作人员统计二
	 * @author xuexzh
	 */
	public DataSet queryFuneralOrganPeo2Sum(ParameterSet pset);

	/**
	 * @Description: 馆技术人员统计
	 * @author xuexzh
	 */
	public DataSet queryFuneralOrganTePeoSum(ParameterSet pset);
}