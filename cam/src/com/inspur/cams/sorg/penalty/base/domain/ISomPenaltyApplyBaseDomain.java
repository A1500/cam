package com.inspur.cams.sorg.penalty.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

/**
 * 行政执法审批domain接口
 * 
 * @author zhangjian
 * @date 2011-12-21
 */
public interface ISomPenaltyApplyBaseDomain {
	/**
	 * 查询行政执法审批
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

}
