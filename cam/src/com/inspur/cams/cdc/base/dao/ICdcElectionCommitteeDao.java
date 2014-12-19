package com.inspur.cams.cdc.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.cdc.base.data.CdcElectionCommittee;

/**
 * @title:ICdcElectionCommitteeDao
 * @description:
 * @author:
 * @since:2012-02-13
 * @version:1.0
*/
 public interface ICdcElectionCommitteeDao extends BaseCURD<CdcElectionCommittee>{
	public void save(List<CdcElectionCommittee> list);

	public DataSet querySum(ParameterSet pset);
}

