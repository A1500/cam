package com.inspur.cams.dis.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.dis.base.dao.IDisFundsSourceDetailDao;
import com.inspur.cams.dis.base.data.DisFundsSourceDetail;
import com.inspur.cams.dis.base.domain.IDisFundsSourceDetailDomain;

/**
 * 资金拨付明细表domain
 * @author 
 * @date 2013-01-04
 */
public class DisFundsSourceDetailDomain implements IDisFundsSourceDetailDomain {

	@Reference
	private IDisFundsSourceDetailDao disFundsSourceDetailDao;

	/**
	 * 查询 资金拨付明细表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return disFundsSourceDetailDao.query(pset);
	}

	/**
	 * 获取 资金拨付明细表
	 * @param pset
	 * @return
	 */
	public DisFundsSourceDetail get(String allocationDetailId) {
		return disFundsSourceDetailDao.get(allocationDetailId);
	}

	/**
	 * 增加 资金拨付明细表
	 * @param disFundsSourceDetail
	 */
	public void insert(DisFundsSourceDetail disFundsSourceDetail) {
		disFundsSourceDetailDao.insert(disFundsSourceDetail);
	}
	
	/**
	 * 修改 资金拨付明细表
	 * @param disFundsSourceDetail
	 */
	public void update(DisFundsSourceDetail disFundsSourceDetail) {
		disFundsSourceDetailDao.update(disFundsSourceDetail);
	}
	
	/**
	 * 删除 资金拨付明细表
	 * @param allocationDetailId
	 */
	public void delete(String allocationDetailId) {
		disFundsSourceDetailDao.delete(allocationDetailId);
	}
	
	/**
	 * @Description: 查询物资明细
	 * @author xuexzh
	 */
	public DataSet queryFundsDetails(ParameterSet pset) {
		return disFundsSourceDetailDao.queryFundsDetails(pset);
	}

}