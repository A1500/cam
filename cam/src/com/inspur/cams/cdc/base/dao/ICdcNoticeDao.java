package com.inspur.cams.cdc.base.dao;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

public interface ICdcNoticeDao {
	
	public DataSet getUnReport(ParameterSet pset);
	
}
