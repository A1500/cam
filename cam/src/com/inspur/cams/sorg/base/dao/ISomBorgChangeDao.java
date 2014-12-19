package com.inspur.cams.sorg.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.sorg.base.data.SomBorgChange;

/**
 * @title:业务主管单位变更dao接口
 * @description:
 * @author:
 * @since:2013-03-05
 * @version:1.0
 */
public interface ISomBorgChangeDao extends
		BaseCURD<SomBorgChange> {
	/**
	 * 查询数量
	 * @param pset
	 * @return
	 */
	public int queryCount(ParameterSet pset);
	
	/**
	 * 业务主管单位变更历史
	 */
	public DataSet showChange(ParameterSet pset);

	/**
	 * 当前业务主管单位名称
	 * @param pset
	 * @return
	 */
	public String nowBorgName(ParameterSet pset);
}
