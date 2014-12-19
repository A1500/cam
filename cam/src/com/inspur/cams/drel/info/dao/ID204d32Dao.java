package com.inspur.cams.drel.info.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.info.data.D204d32;

/**
 * 社会保险缴费dao
 * @author 
 * @date 2014-06-09
 */
public interface ID204d32Dao extends BaseCURD<D204d32> {

	DataSet queryShebao(ParameterSet pset);

}