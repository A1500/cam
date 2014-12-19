package com.inspur.cams.welfare.base.domain.support;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.welfare.base.dao.support.WealFitChangerecordDao;
import com.inspur.cams.welfare.base.data.WealFitChangerecord;
import com.inspur.cams.welfare.base.domain.IWealFitChangerecordDomain;

/**
 * 假矫装配企业变更备案表domain
 * @author 
 * @date 2013-04-19
 */
public class WealFitChangerecordDomain implements IWealFitChangerecordDomain {

	private WealFitChangerecordDao wealFitChangerecordDao = (WealFitChangerecordDao) DaoFactory
	.getDao("com.inspur.cams.welfare.base.dao.support.WealFitChangerecordDao");

	/**
	 * 查询 假矫装配企业变更备案表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return wealFitChangerecordDao.query(pset);
	}


	/**
	 * 增加 假矫装配企业变更备案表
	 * @param wealFitChangerecord
	 */
	public void insert(WealFitChangerecord wealFitChangerecord) {
		wealFitChangerecord.setChangId(IdHelp.getUUID32());
		wealFitChangerecordDao.insert(wealFitChangerecord);
	}
	
	/**
	 * 修改 假矫装配企业变更备案表
	 * @param wealFitChangerecord
	 */
	public void update(WealFitChangerecord wealFitChangerecord) {
		wealFitChangerecordDao.update(wealFitChangerecord);
	}
	
	/**
	 * 删除 假矫装配企业变更备案表
	 * @param changeId
	 */
	public void delete(String changeId) {
		wealFitChangerecordDao.delete(changeId);
	}


}