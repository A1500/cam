package com.inspur.cams.bpt.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.bpt.base.dao.IBptTemporaryHelpDao;
import com.inspur.cams.bpt.base.data.BptTemporaryHelp;
import com.inspur.cams.bpt.base.domain.IBptTemporaryHelpDomain;

public class BptTemporaryHelpDomain implements IBptTemporaryHelpDomain {
    
	@Reference
	private IBptTemporaryHelpDao bptTemporaryHelpDao;
	public DataSet queryTemporary(ParameterSet params) {
	  return	bptTemporaryHelpDao.queryTemporary(params);
	}
	public void batchInsertTemporaryHelp(List list) {
		bptTemporaryHelpDao.batchInsert(list);
		
	}
	public DataSet queryTemporaryHelp(ParameterSet params) {
		// TODO Auto-generated method stub
		return bptTemporaryHelpDao.queryTemporaryHelp(params);
	}
	public DataSet queryUpdateTemporaryHelp(ParameterSet params) {
		// TODO Auto-generated method stub
		return bptTemporaryHelpDao.queryUpdateTemporaryHelp(params);
	}
	public void updateTemporaryHelp(BptTemporaryHelp bean) {
		// TODO Auto-generated method stub
		bptTemporaryHelpDao.update(bean);
	}
	public void deleteTemporaryHelp(String[] delIds ) {
		// TODO Auto-generated method stub
		bptTemporaryHelpDao.batchDelete(delIds);
	}
    
	public void insertTemporaryHelp(BptTemporaryHelp bptTemporaryHelp) {
		bptTemporaryHelpDao.insert(bptTemporaryHelp);
	}
	
	public DataSet query(ParameterSet pset) {
		return bptTemporaryHelpDao.query(pset);
	}
}
