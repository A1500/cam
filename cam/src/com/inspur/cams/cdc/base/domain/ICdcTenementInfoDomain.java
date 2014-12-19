package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcTenementInfo;

public interface ICdcTenementInfoDomain {

	/**
	 * 默认查询
	 * @param pset
	 * @return
	 */
	DataSet query(ParameterSet pset);

	/**
	 * 新增
	 * @param dataBean
	 */
	@Trans
	void insert(CdcTenementInfo dataBean);

	/**
	 * 更新
	 * @param dataBean
	 */
	@Trans
	void update(CdcTenementInfo dataBean);

	/**
	 * 批量删除
	 * @param id
	 */
	void delete(String  id);
	/**
	 * 汇总数据
	 * @param dataBean
	 */
	@Trans
	void sum(CdcTenementInfo dataBean);

}
