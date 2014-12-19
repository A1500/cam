package com.inspur.cams.bpt.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.base.data.BptTemporaryHelp;

public interface IBptTemporaryHelpDomain {
 
	public DataSet queryTemporary(ParameterSet params);
	
	public void batchInsertTemporaryHelp(List list);
	
	public DataSet queryTemporaryHelp(ParameterSet params);
    
	public DataSet queryUpdateTemporaryHelp(ParameterSet params);
	
	public void updateTemporaryHelp(BptTemporaryHelp bean);
	
	public void deleteTemporaryHelp(String[] delIds);
	
	public void insertTemporaryHelp(BptTemporaryHelp bptTemporaryHelp);
	
	public DataSet query(ParameterSet pset);
}
