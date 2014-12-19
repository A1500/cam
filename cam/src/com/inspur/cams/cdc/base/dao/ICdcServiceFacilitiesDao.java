package com.inspur.cams.cdc.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.cdc.base.data.CdcServiceFacilities;

/**
 * @title:ICdcServiceFacilitiesDao
 * @description:
 * @author:
 * @since:2012-02-29
 * @version:1.0
*/
 public interface ICdcServiceFacilitiesDao extends BaseCURD<CdcServiceFacilities>{
	public void save(List<CdcServiceFacilities> list);
	public DataSet queryList(ParameterSet pset);
}

