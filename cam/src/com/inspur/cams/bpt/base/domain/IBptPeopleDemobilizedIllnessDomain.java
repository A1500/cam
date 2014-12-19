package com.inspur.cams.bpt.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.base.data.BptPeopleDemobilizedIllness;

/**
 * 带病回乡退伍军人Domain接口
 * @author 王宝才
 *
 */
public interface IBptPeopleDemobilizedIllnessDomain{
	/**
	 * 带病回乡退伍军人Domain接口方法
	 */
	public void insert(BptPeopleDemobilizedIllness  bptPeopleDemobilizedIllness);
	
	/**
	 * 查询带病回乡退伍军人信息
	 */
	public DataSet query(ParameterSet pset);
	public void updateBptPeopleDemobilizedIllness(BptPeopleDemobilizedIllness  bptPeopleDemobilizedIllness);
}