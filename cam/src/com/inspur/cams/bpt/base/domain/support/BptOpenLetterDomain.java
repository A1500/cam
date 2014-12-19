package com.inspur.cams.bpt.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.bpt.base.dao.IBptOpenLetterDao;
import com.inspur.cams.bpt.base.data.BptOpenLetter;
import com.inspur.cams.bpt.base.domain.IBptOpenLetterDomain;

public class BptOpenLetterDomain implements IBptOpenLetterDomain {
	@Reference
	private IBptOpenLetterDao bptOpenLetterDao;
	
	public DataSet queryOpenLetter(ParameterSet pset) {
		return bptOpenLetterDao.query(pset);
	}

	public void updateOpen(BptOpenLetter bptOpenLetter) {
		
		bptOpenLetterDao.update(bptOpenLetter);
	}
	
	
	public void saveOpen(BptOpenLetter bptOpenLetter) {
		bptOpenLetterDao.insert(bptOpenLetter);
	}
}
