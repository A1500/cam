package com.inspur.cams.bpt.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.base.data.BptDecisionLetter;

public interface IBptDecisionLetterDomain {

	public DataSet queryDecisionLetter(ParameterSet pset);
	
	public void updateDecisionLetter(BptDecisionLetter bptDecisionLetter);
	
	public void saveDecisionLetter(BptDecisionLetter bptDecisionLetter);
}
