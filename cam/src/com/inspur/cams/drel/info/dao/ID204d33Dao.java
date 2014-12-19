package com.inspur.cams.drel.info.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.info.data.D204d33;

/**
 * 纳税情况dao
 * @author 
 * @date 2014-06-09
 */
public interface ID204d33Dao extends BaseCURD<D204d33> {

	DataSet queryGuoshui(ParameterSet pset);

}