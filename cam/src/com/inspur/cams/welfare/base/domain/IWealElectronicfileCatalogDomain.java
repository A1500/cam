package com.inspur.cams.welfare.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.welfare.base.data.WealElectronicfileCatalog;

/**
 * 
 * @author 
 *
 */
public interface IWealElectronicfileCatalogDomain {
	public DataSet query(ParameterSet pset);

	public void insert(WealElectronicfileCatalog wealElectronicfileCatalog);
	
	public void update(WealElectronicfileCatalog wealElectronicfileCatalog);
	
}
