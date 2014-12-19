package com.inspur.cams.dis.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.dis.base.dao.IDisCurrentMoneyDetailDao;
import com.inspur.cams.dis.base.data.DisCurrentMoneyDetail;
import com.inspur.cams.dis.base.domain.IDisCurrentMoneyDetailDomain;

/**
 * 单位当前物资情况表domain
 * @author 
 * @date 2012-11-05
 */
public class DisCurrentMoneyDetailDomain implements IDisCurrentMoneyDetailDomain {

	@Reference
	private IDisCurrentMoneyDetailDao disCurrentMoneyDetailDao;

	/**
	 * 查询 单位当前物资情况表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return disCurrentMoneyDetailDao.query(pset);
	}

	/**
	 * 获取 单位当前物资情况表
	 * @param pset
	 * @return
	 */
	public DisCurrentMoneyDetail get(String meterialRecordId) {
		return disCurrentMoneyDetailDao.get(meterialRecordId);
	}

	/**
	 * 增加 单位当前物资情况表
	 * @param disCurrentMoneyDetail
	 */
	public void insert(DisCurrentMoneyDetail disCurrentMoneyDetail) {
		disCurrentMoneyDetailDao.insert(disCurrentMoneyDetail);
	}
	
	/**
	 * 修改 单位当前物资情况表
	 * @param disCurrentMoneyDetail
	 */
	public void update(DisCurrentMoneyDetail disCurrentMoneyDetail) {
		disCurrentMoneyDetailDao.update(disCurrentMoneyDetail);
	}
	
	/**
	 * 删除 单位当前物资情况表
	 * @param meterialRecordId
	 */
	public void delete(String meterialRecordId) {
		disCurrentMoneyDetailDao.delete(meterialRecordId);
	}
	
	/**
	 * 保存 单位当前物资情况表
	 * @param meterialRecordId
	 */
	public void save(List<DisCurrentMoneyDetail> disCurrentMoneyDetailsList) {
		disCurrentMoneyDetailDao.save(disCurrentMoneyDetailsList);
	}
}