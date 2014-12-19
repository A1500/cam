package com.inspur.cams.drel.info.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.info.data.D204b12;

/**
 * 经营性收入dao
 * @author 
 * @date 2014-06-09
 */
public interface ID204b12Dao extends BaseCURD<D204b12> {

	DataSet queryGongshang(ParameterSet pset);

	
}