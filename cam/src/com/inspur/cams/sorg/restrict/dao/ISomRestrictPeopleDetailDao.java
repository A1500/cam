package com.inspur.cams.sorg.restrict.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.sorg.restrict.data.SomRestrictPeopleDetail;

/**
 * @title:社会组织受限制人员明细表dao接口
 * @description:
 * @author:
 * @since:2012-03-19
 * @version:1.0
*/
public interface ISomRestrictPeopleDetailDao extends BaseCURD<SomRestrictPeopleDetail>{
	public DataSet queryPeople(ParameterSet pset);
	/**
	 * 根据taskCode删除受限人员明细
	 * @param taskCode
	 */
	public void deleteByTaskCode(ParameterSet pset);
}

