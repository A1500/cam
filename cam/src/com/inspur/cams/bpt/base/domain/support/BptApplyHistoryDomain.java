package com.inspur.cams.bpt.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.bpt.base.dao.IBptApplyHistoryDao;
import com.inspur.cams.bpt.base.data.BptApplyHistory;
import com.inspur.cams.bpt.base.domain.IBptApplyHistoryDomain;

/**
 * 审批记录历史domain
 * @author zhanghui
 *
 */
public class BptApplyHistoryDomain implements IBptApplyHistoryDomain{
	
	@Reference
	private IBptApplyHistoryDao bptApplyHistoryDao;
	
	/**
	 * 添加审批记录
	 */
	public void insert(BptApplyHistory bptApplyHistory) {
		bptApplyHistoryDao.insert(bptApplyHistory);
	}
	
	/**
	 * 查询审批历史记录
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return bptApplyHistoryDao.query(pset);
	}
	/**
	 * 根据applyId删除历史表信息
	 * @param pset
	 */
	public void delHistoryByApplyId(ParameterSet pset){
		bptApplyHistoryDao.delHistoryByApplyId(pset);
	}

}
