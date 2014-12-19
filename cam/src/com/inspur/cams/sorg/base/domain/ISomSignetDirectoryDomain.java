package com.inspur.cams.sorg.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

/**
 * 印章名录domain接口
 * 
 * @author zhangjian
 * @date 2011-12-12
 */
public interface ISomSignetDirectoryDomain {

	/**
	 * 查询社会组织印章名录
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);
}
