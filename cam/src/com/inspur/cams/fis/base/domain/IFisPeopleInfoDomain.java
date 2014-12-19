package com.inspur.cams.fis.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.fis.base.data.FisPeopleInfo;

/**
 * @Path com.inspur.cams.fis.base.domain.IFisPeopleInfoDomain
 * @Description: TODO 殡葬业务工作人员信息表domain的接口
 * @author jiangzhaobao
 * @date 2011-11-15
 */
public interface IFisPeopleInfoDomain {
	public DataSet query(ParameterSet pset);

	public DataSet queryForService(ParameterSet pset);

	public DataSet queryForPeopleRecords(ParameterSet pset);

	public DataSet queryForPeopleService(ParameterSet pset);

	public DataSet querySumForServer(ParameterSet pset);

	@Trans
	public void insert(FisPeopleInfo bean);

	@Trans
	public void update(FisPeopleInfo bean);

	@Trans
	public void delete(String[] delIds);

	@Trans
	public void open(String peopleId);

	@Trans
	public void cencel(String peopleId);

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