package com.inspur.cams.sorg.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomPrepare;

/**
 * 社会组织筹备domain
 * @author shgtch
 * @date 2011-8-9
 */
public interface ISomPrepareDomain {

	/**
	 * 查询社会组织筹备
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加社会组织筹备
	 * @param somMeeting
	 */
	@Trans
	public void insert(SomPrepare somPrepare);
	
	/**
	 * 更新社会组织筹备
	 * @param somMeeting
	 */
	@Trans
	public void update(SomPrepare somPrepare);
	
 }