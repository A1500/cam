package com.inspur.cams.fis.base.domain.support;


import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.fis.base.dao.IFisCemeChangeDetailDao;
import com.inspur.cams.fis.base.data.FisCemeChangeDetail;
import com.inspur.cams.fis.base.domain.IFisCemeChangeDetailDomain;

/**
 * 公墓信息变更备案明细表domain
 * @author 
 * @date 2013-08-01
 */
public class FisCemeChangeDetailDomain implements IFisCemeChangeDetailDomain {

	@Reference
	private IFisCemeChangeDetailDao fisCemeChangeDetailDao;

	/**
	 * 查询 公墓信息变更备案明细表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return fisCemeChangeDetailDao.query(pset);
	}

	/**
	 * 获取 公墓信息变更备案明细表
	 * @param pset
	 * @return
	 */
	public FisCemeChangeDetail get(String detailId) {
		return fisCemeChangeDetailDao.get(detailId);
	}

	/**
	 * 增加 公墓信息变更备案明细表
	 * @param fisCemeChangeDetail
	 */
	public void insert(FisCemeChangeDetail fisCemeChangeDetail) {
		fisCemeChangeDetailDao.insert(fisCemeChangeDetail);
	}
	
	/**
	 * 修改 公墓信息变更备案明细表
	 * @param fisCemeChangeDetail
	 */
	public void update(FisCemeChangeDetail fisCemeChangeDetail) {
		fisCemeChangeDetailDao.update(fisCemeChangeDetail);
	}
	
	/**
	 * 删除 公墓信息变更备案明细表
	 * @param detailId
	 */
	public void delete(String detailId) {
		fisCemeChangeDetailDao.delete(detailId);
	}

	public void deleteByChangeId(String changeId) {
		fisCemeChangeDetailDao.deleteByChangeId(changeId);
	}

}