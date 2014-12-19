package com.inspur.cams.sorg.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomSignet;

public interface ISomSignetDomain {
	
	/**
	 * 查询社会组织举办实体
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);
	
	/**
	 * 增加社会组织举办实体
	 * @param somEntity
	 */
	@Trans
	public void insert(SomSignet somSignet);
	
	/**
	 * 更新社会组织举办实体
	 * @param somEntity
	 */
	@Trans
	public void update(SomSignet somSignet);
	
	@Trans
	public void del(String taskCode);
}
