package com.inspur.cams.fis.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.fis.base.data.FisCemeCheckHistory;

/**
 * 公墓年检整改历史记录表dao
 * @author 
 * @date 2013-08-01
 */
public interface IFisCemeCheckHistoryDao extends BaseCURD<FisCemeCheckHistory> {

	
	public DataSet queryOrder(ParameterSet pset);
	public DataSet queryByCreateTime(ParameterSet pset);

}