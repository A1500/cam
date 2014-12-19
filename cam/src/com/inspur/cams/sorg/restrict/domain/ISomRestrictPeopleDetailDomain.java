package com.inspur.cams.sorg.restrict.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.sorg.restrict.data.SomRestrictPeopleDetail;
/**
 * 社会组织受限制人员明细表domain接口
 *
 */
public interface ISomRestrictPeopleDetailDomain {

	public DataSet query(ParameterSet pset);

	public DataSet queryPeople(ParameterSet pset);
	/**
	 * 保存受限:添加/更新受限人员，添加受限人员明细
	 * @param somRestrictPeopleDetailList
	 */
	public void saveRestrict(List<SomRestrictPeopleDetail> somRestrictPeopleDetailList);
	/**
	 * 添加受限:添加/更新受限人员，添加受限人员明细
	 * @param somRestrictPeopleDetailList
	 */
	public void addRestrict(List<SomRestrictPeopleDetail> somRestrictPeopleDetailList);
	/**
	 * 根据taskCode删除受限人员明细
	 * @param taskCode
	 */
	public void deleteByTaskCode(ParameterSet pset);
	
}
