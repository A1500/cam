package com.inspur.cams.dis.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.dis.base.data.DisCurrentMoneyDetail;

/**
 * 单位当前物资情况表domain
 * @author 
 * @date 2012-11-05
 */
public interface IDisCurrentMoneyDetailDomain {

	/**
	 * 查询 单位当前物资情况表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 单位当前物资情况表
	 * @param pset
	 * @return
	 */
	public DisCurrentMoneyDetail get(String meterialRecordId);

	/**
	 * 增加 单位当前物资情况表
	 * @param disCurrentMoneyDetail
	 */
	@Trans
	public void insert(DisCurrentMoneyDetail disCurrentMoneyDetail);
	
	/**
	 * 修改 单位当前物资情况表
	 * @param disCurrentMoneyDetail
	 */
	@Trans
	public void update(DisCurrentMoneyDetail disCurrentMoneyDetail);
	
	/**
	 * 删除 单位当前物资情况表
	 * @param meterialRecordId
	 */
	@Trans
	public void delete(String meterialRecordId);

	
	/**
	 * 保存 单位当前物资情况表
	 * @param meterialRecordId
	 */
	@Trans
	public void save(List<DisCurrentMoneyDetail> disCurrentMoneyDetailsList);

}