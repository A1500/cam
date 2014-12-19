package com.inspur.cams.bpt.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.base.data.BptDisabilityOpen;

public interface IBptDisabilityOpenDomain {
	
	public DataSet queryDisabilityOpen(ParameterSet pset);
	
	public void updateOpen(BptDisabilityOpen bptDisabilityOpen);
	
	public void saveOpen(BptDisabilityOpen bptDisabilityOpen);
	
}
