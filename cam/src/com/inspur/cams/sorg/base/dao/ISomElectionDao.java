package com.inspur.cams.sorg.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.sorg.base.data.SomElection;

/**
 * 社会组织选举dao接口
 * 
 * @author zhangjian
 * @date 2011-9-19
 */
public interface ISomElectionDao extends BaseCURD<SomElection> {
	
	public void save(List<SomElection> list);
	public DataSet electionForQuery(ParameterSet pset);
}
