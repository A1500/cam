package com.inspur.cams.fis.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.fis.base.dao.IFisPeopleInfoDao;
import com.inspur.cams.fis.base.data.FisPeopleInfo;
import com.inspur.cams.fis.base.domain.IFisDutyInfoDomain;
import com.inspur.cams.fis.base.domain.IFisPeopleInfoDomain;

/**
 * @Path com.inspur.cams.fis.base.domain.support.FisPeopleInfoDomain
 * @Description: TODO 殡葬业务工作人员信息表domain的实现
 * @author jiangzhaobao
 * @date 2011-11-15
 */
public class FisPeopleInfoDomain implements IFisPeopleInfoDomain {

	@Reference
	private IFisPeopleInfoDao fisPeopleInfoDao;

	@Reference
	private IFisDutyInfoDomain fisDutyInfoDomain;

	public void delete(String[] delIds) {
	}

	public void insert(FisPeopleInfo bean) {
	}

	public DataSet query(ParameterSet pset) {
		return fisPeopleInfoDao.query(pset);
	}

	/**
	 * 
	 * @Title: queryForPeopleService
	 * @Description: TODO(查询人员服务量方法)
	 * @param
	 * @return 设定文件
	 * @return DataSet 返回类型
	 * @author wangziming
	 * @date 2011-12-13
	 */
	public DataSet queryForService(ParameterSet pset) {
		return fisPeopleInfoDao.queryForService(pset);
	}

	/**
	 * 
	 * @Title: update
	 * @Description: TODO(工作人员信息--修改)
	 * @param 设定文件
	 * @return void 返回类型
	 * @author wangziming
	 * @date 2011-12-3
	 */
	public void update(FisPeopleInfo bean) {
	}

	/**
	 * 
	 * @Title: open
	 * @Description: TODO(工作人员信息--开启职务)
	 * @param 设定文件
	 * @return void 返回类型
	 * @author wangziming
	 * @date 2011-12-3
	 */
	public void open(String peopleId) {
		fisPeopleInfoDao.open(peopleId);
	}

	/**
	 * 
	 * @Title: cencel
	 * @Description: TODO(工作人员信息--注销职务)
	 * @param 设定文件
	 * @return void 返回类型
	 * @author wangziming
	 * @date 2011-12-3
	 */
	public void cencel(String peopleId) {
		fisPeopleInfoDao.cencel(peopleId);
	}

	public DataSet queryForPeopleRecords(ParameterSet pset) {
		return fisPeopleInfoDao.queryForPeopleRecords(pset);
	}

	/**
	 * 
	 * @Title: queryForPeopleService
	 * @Description: TODO(查询人员服务量方法)
	 * @param
	 * @return 设定文件
	 * @return DataSet 返回类型
	 * @author wangziming
	 * @date 2011-12-13
	 */
	public DataSet queryForPeopleService(ParameterSet pset) {
		return fisPeopleInfoDao.queryForPeopleService(pset);
	}

	/**
	 * @Description: TODO(查询人员服务量)
	 */
	public DataSet querySumForServer(ParameterSet pset) {
		return fisPeopleInfoDao.querySumForServer(pset);
	}

	/**
	 * @Title: queryForExport
	 * @Description: TODO(数据上报导出数据方法)
	 * @param set
	 * @return DataSet
	 * @throws
	 * @author luguosui
	 */
	public DataSet queryForExport(ParameterSet set) {
		return fisPeopleInfoDao.queryForExport(set);
	}

	/**
	 * @Description: 馆工作人员统计一
	 * @author xuexzh
	 */
	public DataSet queryFuneralOrganPeoSum(ParameterSet pset) {
		return fisPeopleInfoDao.queryFuneralOrganPeoSum(pset);
	}

	/**
	 * @Description: 馆工作人员统计二
	 * @author xuexzh
	 */
	public DataSet queryFuneralOrganPeo2Sum(ParameterSet pset) {
		return fisPeopleInfoDao.queryFuneralOrganPeo2Sum(pset);
	}

	/**
	 * @Description: 馆技术人员统计
	 * @author xuexzh
	 */
	public DataSet queryFuneralOrganTePeoSum(ParameterSet pset) {
		return fisPeopleInfoDao.queryFuneralOrganTePeoSum(pset);
	}
}
