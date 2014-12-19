package com.inspur.cams.welfare.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.base.data.BptPeopleWar;
import com.inspur.cams.welfare.base.data.WealCert;

/**
 * 
 * @author 
 *
 */
public interface IWealCertDomain {
	public DataSet query(ParameterSet pset);

	public void insert(WealCert wealCert);
	
	public void update(WealCert wealCert);
	
	public void delete(String taskCode);
}
