package com.inspur.cams.prs.prsproblemhistory.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.prs.prsproblemhistory.dao.PrsProblemHistory;

@Trans
public interface IPrsProblemHistoryDomain {
	/**
	 * 新增问题历史记录
	 */
	@Trans
	public void insert(PrsProblemHistory bean);
	/**
	 * 修改问题历史记录
	 */
	@Trans
	public void update(PrsProblemHistory bean);
	/**
	 * 查看问题历史记录
	 */
	@Trans
	public DataSet query(ParameterSet pset);
}
