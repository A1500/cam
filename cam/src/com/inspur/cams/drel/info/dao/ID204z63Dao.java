package com.inspur.cams.drel.info.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.info.data.D204z63;


/**
 * 婚姻信息dao
 * @author 
 * @date 2014-08-21
 */
public interface ID204z63Dao extends BaseCURD<D204z63> {
	DataSet queryMarry(ParameterSet pset);

}