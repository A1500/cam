package com.inspur.cams.bpt.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.base.data.BptPeopleWar;

/**
 * 
 * @author zhanghui
 *
 */
public interface IWarDomain {

	/**
	 * 查询优扶参战
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	public void insert(BptPeopleWar war);
	
	public DataSet queryWar(ParameterSet pset);
	//public DataSet query(DicHealth dicHealth);
	
	public void updateWar(BptPeopleWar war);
	
	//删除
	public void delete(ParameterSet pSet);
	
	/**
	 * 查询未提交参战人员
	 * @param pSet
	 * @return
	 */
	public DataSet queryUnCommitWar(ParameterSet pSet);
	
}
