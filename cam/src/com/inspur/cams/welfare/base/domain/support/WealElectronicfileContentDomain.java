package com.inspur.cams.welfare.base.domain.support;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.welfare.base.dao.support.WealElectronicfileContentDao;
import com.inspur.cams.welfare.base.data.WealElectronicfileContent;
import com.inspur.cams.welfare.base.domain.IWealElectronicfileContentDomain;

public class WealElectronicfileContentDomain implements IWealElectronicfileContentDomain{
	private WealElectronicfileContentDao wealElectronicfileContentDao = (WealElectronicfileContentDao) DaoFactory
			.getDao("com.inspur.cams.welfare.base.dao.support.WealElectronicfileContentDao");

			public DataSet query(ParameterSet pset) {
				return wealElectronicfileContentDao.query(pset);
			}


			public void insert(WealElectronicfileContent wealElectronicfileContent) {
				//wealFitApply.setTaskCode(IdHelp.getUUID32());
				wealElectronicfileContentDao.insert(wealElectronicfileContent);
			}
			
			public void update(WealElectronicfileContent wealElectronicfileContent) {
				wealElectronicfileContentDao.update(wealElectronicfileContent);
			}
			
	
}
