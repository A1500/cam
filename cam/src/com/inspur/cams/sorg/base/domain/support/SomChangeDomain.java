package com.inspur.cams.sorg.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.sorg.base.dao.ISomChangeDao;
import com.inspur.cams.sorg.base.data.SomChange;
import com.inspur.cams.sorg.base.data.SomDuty;
import com.inspur.cams.sorg.base.domain.ISomChangeDomain;

public class SomChangeDomain implements ISomChangeDomain{
	@Reference
	private	ISomChangeDao somChangeDao;
	
	public void insert(SomChange somChange) {
		somChangeDao.insert(somChange);
	}

	public DataSet query(ParameterSet pset) {
		
		return somChangeDao.query(pset);
	}
	public void update(SomChange somChange){
		somChangeDao.update(somChange);
	}

	public void deleteChange(String id) {
		somChangeDao.deleteChange(id);
	}
	public void deleteChangeByTaskCode(String taskCode){
		somChangeDao.deleteChangeByTaskCode(taskCode);
	}
	
	public void updateDutyId(String oldDutyId, String dutyId) {
		ParameterSet pset=new ParameterSet();
		pset.setParameter("LEGAL_DUTY_ID", oldDutyId);
		DataSet dutyDs = somChangeDao.query(pset);
		for (int i = 0; i < dutyDs.getCount(); i++) {
			SomChange somDuty = (SomChange) dutyDs.getRecord(i).toBean(SomChange.class);
			somDuty.setLegalDutyId(dutyId);
			somChangeDao.update(somDuty);
		}
		
	}
	
	public DataSet queryChangeInfo(ParameterSet pset){
		return somChangeDao.queryChangeInfo(pset);
	}
}
