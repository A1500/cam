package com.inspur.cams.welfare.base.domain.support;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.welfare.base.dao.support.WealFitChangerecordDetailDao;
import com.inspur.cams.welfare.base.data.WealFitChangerecordDetail;
import com.inspur.cams.welfare.base.domain.IWealFitChangerecordDetailDomain;

/**
 *假矫装配企业变更备案明细表domain
 * @author 
 * @date 2013-04-19
 */
public class WealFitChangerecordDetailDomain implements IWealFitChangerecordDetailDomain {

	private WealFitChangerecordDetailDao wealFitChangerecordDetailDao = (WealFitChangerecordDetailDao) DaoFactory
	.getDao("com.inspur.cams.welfare.base.dao.support.WealFitChangerecordDetailDao");

	/**
	 * 查询假矫装配企业变更备案明细表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return wealFitChangerecordDetailDao.query(pset);
	}


	/**
	 * 增加假矫装配企业变更备案明细表
	 * @param wealFitChangerecordDetail
	 */
	public void insert(WealFitChangerecordDetail wealFitChangerecordDetail) {
		wealFitChangerecordDetail.setDetailId(IdHelp.getUUID32());
		wealFitChangerecordDetailDao.insert(wealFitChangerecordDetail);
	}
	
	/**
	 * 修改假矫装配企业变更备案明细表
	 * @param wealFitChangerecordDetail
	 */
	public void update(WealFitChangerecordDetail wealFitChangerecordDetail) {
		wealFitChangerecordDetailDao.update(wealFitChangerecordDetail);
	}
	
	/**
	 * 删除假矫装配企业变更备案明细表
	 * @param detailId
	 */
	public void delete(String detailId) {
		wealFitChangerecordDetailDao.delete(detailId);
	}


}