package com.inspur.cams.sorg.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.sorg.base.data.SomApply;

/**
 * 社会组织业务dao接口
 * @author shgtch
 * @date 2011-8-18
 */
public interface ISomApplyDao extends BaseCURD<SomApply> {
	
	public String queryProcessId(String id);
	
	public DataSet queryHisChange(ParameterSet pset);
	/**
	 * 查询社会团体流程信息（带组织机构过滤）
	 * @return
	 */
	public DataSet querySorgApply(ParameterSet pset);
	/**
	 * 查询带有社会组织信息的流程信息
	 * @return
	 */
	public DataSet queryOrgan(ParameterSet pset);
}
