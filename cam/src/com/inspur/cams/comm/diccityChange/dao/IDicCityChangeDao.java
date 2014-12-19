package com.inspur.cams.comm.diccityChange.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.diccityChange.data.DicCityChange;

/**
 * 行政区划变更dao
 * @author 
 * @date 2013-12-23
 */
public interface IDicCityChangeDao extends BaseCURD<DicCityChange> {

	public void changeDicCity(DicCityChange dicCityChange,String changeType);
	
	public String getNumber(String batchId);
	
	public DataSet queryTrans(ParameterSet pset);
}