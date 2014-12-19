package com.inspur.cams.bpt.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.bpt.base.dao.IBptApplyDisabilityDao;
import com.inspur.cams.bpt.base.data.BptApplyDisability;
import com.inspur.cams.bpt.base.domain.IBptApplyDisabilityDomain;

/**
 * 伤残申请审批
 */
public class BptApplyDisabilityDomain implements IBptApplyDisabilityDomain{
	@Reference
	IBptApplyDisabilityDao bptApplyDisabilityDao;
	
	/**
	 * 添加一条伤残申请审批记录
	 */
	public void insert(BptApplyDisability bptApplyDisability){
		bptApplyDisabilityDao.insert(bptApplyDisability);
	}
	
	/**
	 * 更新一条伤残申请审批记录
	 */
	public void update(BptApplyDisability bptApplyDisability){
		bptApplyDisabilityDao.update(bptApplyDisability);
	}
	
	/**
	 * 查询伤残申请审批记录
	 */
	public DataSet query(ParameterSet pset){
		return bptApplyDisabilityDao.query(pset);
	}
	
	/**
	 * 查询未提交的调残人员列表
	 * @param pset
	 * @return
	 */
	public DataSet queryUnCommiAdjust(ParameterSet pset){
		return bptApplyDisabilityDao.queryUnCommiAdjust(pset);
	}
	/**
	 * 删除伤残相关信息
	 * @param pset
	 */
	public void deleteAboutDisability(ParameterSet pset){
		bptApplyDisabilityDao.deleteAboutDisability(pset);
	}
	
	/**
	 * 查询审批后打证信息
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryPrintInfo(ParameterSet pset) {
		return bptApplyDisabilityDao.queryPrintInfo(pset);
	}
	
	/**
	 * 修改打印标示
	 * @param pset
	 */
	public void editPrintFlag(ParameterSet pset) {
		bptApplyDisabilityDao.editPrintFlag(pset);
	}
	
	/**
	 * 通过applyId获得实体
	 */
	public BptApplyDisability getBeanByKey(ParameterSet pset){
		return bptApplyDisabilityDao.get((String)pset.getParameter("applyId"));
	}

	public DataSet queryApplyInfoForCheck(ParameterSet pset) {
		return bptApplyDisabilityDao.queryApplyInfoForCheck(pset);
	}
}