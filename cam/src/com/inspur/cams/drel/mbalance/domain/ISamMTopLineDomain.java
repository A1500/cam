package com.inspur.cams.drel.mbalance.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
/**
 * @author luguosui
 * 救助金额封顶线domain接口
 */
public interface ISamMTopLineDomain {
	/**
	 * 查询救助金额封顶线
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);
}
