package com.inspur.cams.bpt.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.bpt.base.dao.IBptApplyDependantDao;
import com.inspur.cams.bpt.base.data.BptApplyDependant;
import com.inspur.cams.bpt.base.domain.IBptApplyDependantDomain;

public class BptApplyDependantDomain implements IBptApplyDependantDomain {

	@Reference
	private IBptApplyDependantDao bptApplyDependantDao;
	
	public void insert(BptApplyDependant aptApplyDependant) {
		bptApplyDependantDao.insert(aptApplyDependant);
	}
	
	/**
	 * 修改三属申请审批信息
	 * @param bptApplyDependant
	 */
	public void update(BptApplyDependant bptApplyDependant) {
		bptApplyDependantDao.update(bptApplyDependant);
	}

	/**
	 * 查询审批信息
	 * @param applyId
	 * @return
	 */
	public DataSet queryApplyDependant(String applyId) {
		return bptApplyDependantDao.queryApplyDependant(applyId);
	}
	/**
	 * 查询审批信息
	 * @param ParameterSet
	 * @return
	 */
	public DataSet queryApplyDependant(ParameterSet pst){
		return bptApplyDependantDao.query(pst);
		
	}
	public void deleteDependant (ParameterSet pset){
		bptApplyDependantDao.deleteDependant(pset);
	}
}
