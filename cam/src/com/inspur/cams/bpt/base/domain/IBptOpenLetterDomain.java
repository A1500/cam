package com.inspur.cams.bpt.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.base.data.BptOpenLetter;

public interface IBptOpenLetterDomain {
	
	public DataSet queryOpenLetter(ParameterSet pset);
	
	public void updateOpen(BptOpenLetter bptOpenLetter);
	
	public void saveOpen(BptOpenLetter bptOpenLetter);
}
