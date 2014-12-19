package com.inspur.cams.sorg.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.sorg.base.dao.ISomPartyChangeDao;
import com.inspur.cams.sorg.base.data.SomPartyChange;
import com.inspur.cams.sorg.base.domain.ISomPartyChangeDomain;
/**
 * 
 * @title 社会组织党建变更domain
 *
 */
public class SomPartyChangeDomain implements ISomPartyChangeDomain{
	@Reference
	private ISomPartyChangeDao somPartyChangeDao;
	public DataSet query(ParameterSet pset) {
		return somPartyChangeDao.query(pset);
	}
	public void insert(SomPartyChange somPartyChange) {
		somPartyChangeDao.insert(somPartyChange);
	}
	public void update(SomPartyChange somPartyChange) {
		somPartyChangeDao.update(somPartyChange);
	}
	public void delete(String changeId) {
		somPartyChangeDao.delete(changeId);		
	}
	public void uploadSave_change(SomPartyChange somPartyChange){
		somPartyChangeDao.updateWithFile(somPartyChange);
	}
}
