package com.inspur.cams.bpt.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.base.data.BptApplyDisabilityNotice;
/**
 * @description:添加和查询伤残受理通知书的Domain层接口
 * @author 王宝才
 * @since:2011-05-18
 */
public interface IDisabilityNoticeDomain{
	/**
	 * 添加伤残受理通知书
	 */
	public void insert(BptApplyDisabilityNotice bptApplyDisabilityNotice);
	
	/**
	 * 更新
	 */
	public void update(BptApplyDisabilityNotice bptApplyDisabilityNotice);

	/**
	 * 查询
	 */	
	public DataSet query(ParameterSet pset);
}