package com.inspur.cams.drel.info.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.info.data.D204c23;

/**
 * 存款dao
 * @author 
 * @date 2014-06-09
 */
public interface ID204c23Dao extends BaseCURD<D204c23> {

	public DataSet queryBank(ParameterSet pset);
}