package com.inspur.cams.bpt.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.bpt.base.dao.IBptDecisionLetterDao;
import com.inspur.cams.bpt.base.data.BptDecisionLetter;
import com.inspur.cams.bpt.base.domain.IBptDecisionLetterDomain;

public class BptDecisionLetterDomain implements IBptDecisionLetterDomain {
	@Reference
	private IBptDecisionLetterDao bptdecisionLetterDao;
	public DataSet queryDecisionLetter(ParameterSet pset) {
		
		return bptdecisionLetterDao.query(pset);
	}

	public void saveDecisionLetter(BptDecisionLetter bptDecisionLetter) {
		bptdecisionLetterDao.insert(bptDecisionLetter);
	}

	public void updateDecisionLetter(BptDecisionLetter bptDecisionLetter) {
		bptdecisionLetterDao.update(bptDecisionLetter);
	}

}
