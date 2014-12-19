package com.inspur.cams.drel.mbalance.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
/**
 * @author luguosui
 * 救助状态domain接口
 */
public interface ISamMStatusDomain {
	/**
	 * 查询救助状态
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);
}
