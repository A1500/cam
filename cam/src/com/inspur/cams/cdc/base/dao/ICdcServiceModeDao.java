package com.inspur.cams.cdc.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.cdc.base.data.CdcServiceMode;

/**
 * @title:ICdcServiceModeDao
 * @description:
 * @author:
 * @since:2012-02-29
 * @version:1.0
*/
 public interface ICdcServiceModeDao extends BaseCURD<CdcServiceMode>{

	DataSet queryList(ParameterSet pset);
}

