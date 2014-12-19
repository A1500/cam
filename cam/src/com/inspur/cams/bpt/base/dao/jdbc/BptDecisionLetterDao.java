package com.inspur.cams.bpt.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.base.dao.IBptDecisionLetterDao;
import com.inspur.cams.bpt.base.data.BptDecisionLetter;

public class BptDecisionLetterDao extends EntityDao<BptDecisionLetter> implements
		IBptDecisionLetterDao {

	@Override
	protected Class<BptDecisionLetter> getEntityClass() {
		return BptDecisionLetter.class;
	}

	public DataSet queryDecisionLetter(ParameterSet pset){
		return super.query(pset);
	}
	
	public void updateDecisionLetter(BptDecisionLetter bptDecisionLetter){
		super.update(bptDecisionLetter);
	}
	
	public void saveDecisionLetter(BptDecisionLetter bptDecisionLetter){
		super.insert(bptDecisionLetter);
	}
	

}
