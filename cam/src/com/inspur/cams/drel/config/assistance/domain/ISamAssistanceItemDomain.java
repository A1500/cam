package com.inspur.cams.drel.config.assistance.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.config.assistance.data.SamAssistanceItem;

/**
 * @title:救助项目Domain接口
 * @description:
 * @author:
 * @date:2012年5月29日
 * @version:1.0
 */
public interface ISamAssistanceItemDomain {
	/**
	 * 查询
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加
	 * 
	 * @param samAssistanceItem
	 */
	@Trans
	public void insert(SamAssistanceItem samAssistanceItem);

	/**
	 * 更新
	 * 
	 * @param samAssistanceItem
	 */
	@Trans
	public void update(SamAssistanceItem samAssistanceItem);
}
