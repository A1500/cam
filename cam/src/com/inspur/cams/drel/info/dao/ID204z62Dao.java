package com.inspur.cams.drel.info.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.info.data.D204z62;


/**
 * 殡葬信息dao
 * @author 
 * @date 2014-08-21
 */
public interface ID204z62Dao extends BaseCURD<D204z62> {

	DataSet queryBinzang(ParameterSet pset);

}