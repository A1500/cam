package com.inspur.cams.sorg.query.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.sorg.base.data.SomOrgan;

public interface ISomEntityStaticDao extends BaseCURD<SomOrgan> {

	/**
	 * 社团举办实体统计
	 * 
	 * @return
	 */
	public DataSet groupEntityStatic(ParameterSet pset);
}
