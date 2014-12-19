package com.inspur.cams.sorg.penalty.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.sorg.penalty.base.data.SomPenalty;

/**
 * 行政执法基本信息domain接口
 * 
 * @author zhangjian
 * @date 2011-12-21
 */
public interface ISomPenaltyBaseDomain {
	/**
	 * 查询行政执法基本信息
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	public void insert(SomPenalty somPenalty);
	
	public void update(SomPenalty somPenalty);
}
