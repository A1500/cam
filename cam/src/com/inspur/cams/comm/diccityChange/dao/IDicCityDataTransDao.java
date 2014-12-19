package com.inspur.cams.comm.diccityChange.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.diccityChange.data.DicCityDataTrans;

/**
 * 数据迁移dao
 * @author 
 * @date 2013-12-23
 */
public interface IDicCityDataTransDao extends BaseCURD<DicCityDataTrans> {

	public DataSet getUnder(ParameterSet pset);
	
	public void transDicCity(String preChangeCode,String postChangeCode);
	
	public void deleteByTrans(String changeId);
}