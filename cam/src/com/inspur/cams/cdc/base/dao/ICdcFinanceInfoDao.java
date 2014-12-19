package com.inspur.cams.cdc.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.cdc.base.data.CdcFinanceInfo;

/**
 * @title:ICdcFinanceInfoDao
 * @description:
 * @author:
 * @since:2012-02-29
 * @version:1.0
*/
 public interface ICdcFinanceInfoDao extends BaseCURD<CdcFinanceInfo>{
	public void save(List<CdcFinanceInfo> list);

	public DataSet queryList(ParameterSet pset);
}

