package com.inspur.cams.dis.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.dis.base.data.DisFundsSourceDetail;

/**
 * 资金拨付明细表domain
 * @author 
 * @date 2013-01-04
 */
public interface IDisFundsSourceDetailDomain {

	/**
	 * 查询 资金拨付明细表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 资金拨付明细表
	 * @param pset
	 * @return
	 */
	public DisFundsSourceDetail get(String allocationDetailId);

	/**
	 * 增加 资金拨付明细表
	 * @param disFundsSourceDetail
	 */
	@Trans
	public void insert(DisFundsSourceDetail disFundsSourceDetail);
	
	/**
	 * 修改 资金拨付明细表
	 * @param disFundsSourceDetail
	 */
	@Trans
	public void update(DisFundsSourceDetail disFundsSourceDetail);
	
	/**
	 * 删除 资金拨付明细表
	 * @param allocationDetailId
	 */
	@Trans
	public void delete(String allocationDetailId);

	/**
	 * @Description: 查询物资明细
	 * @author xuexzh
	 */
	public DataSet queryFundsDetails(ParameterSet pset);

}