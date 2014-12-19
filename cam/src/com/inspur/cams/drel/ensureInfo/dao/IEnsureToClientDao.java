package com.inspur.cams.drel.ensureInfo.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.ensureInfo.data.EnsureToClient;

/**
 * 核查业务反馈表dao
 * @author 
 * @date 2014-07-23
 */
public interface IEnsureToClientDao extends BaseCURD<EnsureToClient> {
	//查询核对参考标准
	public DataSet queryInfo(ParameterSet pset);
	
	//核对婚姻信息
	public DataSet queryMarryInfo(ParameterSet pset);
	
	//查询疑似信息
	public DataSet querySuspectInfo(ParameterSet pset);
}