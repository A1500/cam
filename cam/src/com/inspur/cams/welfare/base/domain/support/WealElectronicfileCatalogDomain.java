package com.inspur.cams.welfare.base.domain.support;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.welfare.base.dao.support.WealElectronicfileCatalogDao;
import com.inspur.cams.welfare.base.data.WealElectronicfileCatalog;
import com.inspur.cams.welfare.base.domain.IWealElectronicfileCatalogDomain;

public class WealElectronicfileCatalogDomain implements IWealElectronicfileCatalogDomain{
	private WealElectronicfileCatalogDao wealElectronicfileCatalogDao = (WealElectronicfileCatalogDao) DaoFactory
			.getDao("com.inspur.cams.welfare.base.dao.support.WealElectronicfileCatalogDao");

			public DataSet query(ParameterSet pset) {
				return wealElectronicfileCatalogDao.query(pset);
			}


			public void insert(WealElectronicfileCatalog wealElectronicfileCatalog) {
				//wealFitApply.setTaskCode(IdHelp.getUUID32());
				wealElectronicfileCatalogDao.insert(wealElectronicfileCatalog);
			}
			
			public void update(WealElectronicfileCatalog wealElectronicfileCatalog) {
				wealElectronicfileCatalogDao.update(wealElectronicfileCatalog);
			}
			
	
}
