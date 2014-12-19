package com.inspur.cams.welfare.base.domain.support;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.welfare.base.dao.support.WealCertDao;
import com.inspur.cams.welfare.base.data.WealCert;
import com.inspur.cams.welfare.base.domain.IWealCertDomain;

public class WealCertDomain implements IWealCertDomain{
	private WealCertDao wealCertDao = (WealCertDao) DaoFactory
			.getDao("com.inspur.cams.welfare.base.dao.support.WealCertDao");

			public DataSet query(ParameterSet pset) {
				return wealCertDao.query(pset);
			}


			public void insert(WealCert wealCert) {
				//wealFitApply.setTaskCode(IdHelp.getUUID32());
				wealCertDao.insert(wealCert);
			}
			
			public void update(WealCert wealCert) {
				wealCertDao.update(wealCert);
			}
			
			public void delete(String taskCode) {
				wealCertDao.delete(taskCode);
			}
	
}
