package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

public interface ICdcNoticeDomain {
	public DataSet getUnReport(ParameterSet pset);
}
