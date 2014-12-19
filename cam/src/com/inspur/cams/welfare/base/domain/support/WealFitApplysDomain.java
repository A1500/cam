package com.inspur.cams.welfare.base.domain.support;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.welfare.base.dao.support.WealFitApplyDao;
import com.inspur.cams.welfare.base.data.WealFitApply;
import com.inspur.cams.welfare.base.domain.IWealFitApplyDomain;

/**
 * 假矫装配企业业务表domain
 * @author 
 * @date 2013-04-19
 */
public class WealFitApplysDomain implements IWealFitApplyDomain {

	private WealFitApplyDao wealFitApplyDao = (WealFitApplyDao) DaoFactory
	.getDao("com.inspur.cams.welfare.base.dao.support.WealFitApplyDao");

	/**
	 * 查询 假矫装配企业业务表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return wealFitApplyDao.query(pset);
	}


	/**
	 * 增加 假矫装配企业业务表
	 * @param wealFitApply
	 */
	public void insert(WealFitApply wealFitApply) {
		//wealFitApply.setTaskCode(IdHelp.getUUID32());
		wealFitApplyDao.insert(wealFitApply);
	}
	
	/**
	 * 修改 假矫装配企业业务表
	 * @param wealFitApply
	 */
	public void update(WealFitApply wealFitApply) {
		wealFitApplyDao.update(wealFitApply);
	}
	
	/**
	 * 删除 假矫装配企业业务表
	 * @param taskCode
	 */
	public void delete(String taskCode) {
		wealFitApplyDao.delete(taskCode);
	}

	//查询认定信息采集任务列表
	public DataSet queryQualificationList(ParameterSet pset) {
		// TODO Auto-generated method stub
		return wealFitApplyDao.queryQualificationList(pset);
	}
	public DataSet queryQualificationPrintList(ParameterSet pset) {
		// TODO Auto-generated method stub
		return wealFitApplyDao.queryQualificationPrintList(pset);
	}

}