package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.cdc.base.data.CdcElectionCityMember;

public interface ICdcElectionCityMemberDomain {

	void insert(CdcElectionCityMember dataBean);

	void update(CdcElectionCityMember dataBean);

	void delete(String[] delIds);

	DataSet query(ParameterSet pset);

	DataSet querySum(ParameterSet pset);

}
