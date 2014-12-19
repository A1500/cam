package com.inspur.cams.bpt.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.base.data.BptApplyHistory;

/**
 * 审批记录历史记录
 * 
 * @author zhanghui
 * 
 */

public interface IBptApplyHistoryDao extends BaseCURD<BptApplyHistory> {
	/**
	 * 根据applyId删除历史表信息
	 * @param pset
	 */
	public void delHistoryByApplyId(ParameterSet pset);
}
