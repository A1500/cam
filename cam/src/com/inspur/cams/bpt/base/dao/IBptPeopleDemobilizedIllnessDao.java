package com.inspur.cams.bpt.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.base.data.BptPeopleDemobilizedIllness;

/**
 * @title:IBptPeopleDemobilizedIllnessDao
 * @description:
 * @author:
 * @since:2011-05-21
 * @version:1.0
*/
 public interface IBptPeopleDemobilizedIllnessDao extends BaseCURD<BptPeopleDemobilizedIllness>{
	public void save(List<BptPeopleDemobilizedIllness> list);
	
	/**
	 * 查询带病回乡退伍军人信息和相应的优抚人员信息
	 */
	public DataSet queryDemobilizedIllnessPeople(ParameterSet pset);
	/**
	 * 查询未提交的 带病回乡退伍军人信息和相应的优抚人员信息
	 */
	public DataSet queryApplyDemobilizedIllnessPeople(ParameterSet pset);

	public DataSet queryApplyIntoDemobilizedIllnessPeople(ParameterSet pset);
	
	public String queryIdCardByPeopleId(ParameterSet pset);
}

