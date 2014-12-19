package com.inspur.cams.sorg.restrict.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.sorg.restrict.data.SomRestrictPeople;


/**
 * 社会组织受限制人员表domain接口
 * 
 */
public interface ISomRestrictPeopleDomain {

	public DataSet query(ParameterSet pset);
	/**
	 * 保存受限人员：添加/更新受限人员表
	 * @param somRestrictPeople
	 * @return
	 */
	public String saveRestrictPeople(SomRestrictPeople somRestrictPeople);
	public void update(SomRestrictPeople somRestrictPeople);
	public void delete(String peopleId);
}
