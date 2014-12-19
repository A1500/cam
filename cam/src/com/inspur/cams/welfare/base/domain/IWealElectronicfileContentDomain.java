package com.inspur.cams.welfare.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.welfare.base.data.WealElectronicfileContent;

/**
 * 
 * @author 
 *
 */
public interface IWealElectronicfileContentDomain {
	public DataSet query(ParameterSet pset);

	public void insert(WealElectronicfileContent wealElectronicfileContent);
	
	public void update(WealElectronicfileContent wealElectronicfileContent);
	
}
