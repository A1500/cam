package com.inspur.cams.sorg.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.sorg.base.data.SomOrgan;

/**
 * 社会组织dao接口
 * @author jiangzhaobao
 * @date 2011年6月14日10:34:08
 */
public interface ISomOrganDao extends BaseCURD<SomOrgan> {
	
	public void updateRegPartyById(String sorgId, String status);

	public void updateElectionDate(String sorgId, String electionDate,
			Integer electionPriod);
	/**
	 * 分支基本信息的综合查询
	 * 
	 * @param pset
	 * @return DataSet
	 */
	public DataSet totalQueryBranch(ParameterSet pset);
	
}
