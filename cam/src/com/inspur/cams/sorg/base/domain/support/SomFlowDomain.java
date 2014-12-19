package com.inspur.cams.sorg.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.base.dao.ISomFlowDao;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomFlow;
import com.inspur.cams.sorg.base.domain.ISomFlowDomain;

/**
 * 社会组织业务流程意见domain实现类
 * @author shgtch
 * @date 2011-8-12
 */
public class SomFlowDomain implements ISomFlowDomain {
	
	@Reference
	private ISomFlowDao somFlowDao;

	/**
	 * 流程意见查询
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return somFlowDao.query(pset);
	}
	
	/**
	 * 保存流程意见
	 * @param dataBean
	 */
	@Trans
	public void insert(SomFlow somFlow) {
		somFlowDao.insert(somFlow);
	}

	/**
	 * 根据业务获取流程历史意见并保持
	 * @param somApply
	 */
	@Trans
	public void insertBySomApply(SomApply somApply) {
		somFlowDao.insert(getSomFlow(somApply));
	}
	/**
	 * 更新流程意见
	 * @param somFlow
	 */
	@Trans
	public void update(SomFlow somFlow){
		somFlowDao.update(somFlow);
	}
	
	// 根据业务当前信息获取流程历史意见并保存
	private SomFlow getSomFlow(SomApply somApply){
		SomFlow somFlow = new SomFlow();
		somFlow.setLogId(IdHelp.getUUID30());
		somFlow.setTaskCode(somApply.getTaskCode());
		somFlow.setSorgId(somApply.getSorgId());
		somFlow.setApplyType(somApply.getApplyType());
		somFlow.setActivity(somApply.getCurActivity());
		somFlow.setOpinionId(somApply.getCurOpinionId());
		somFlow.setOpinion(somApply.getCurOpinion());
		somFlow.setOrganId(somApply.getCurOrganId());
		somFlow.setOrganName(somApply.getCurOrganName());
		somFlow.setDeptId(somApply.getCurDeptId());
		somFlow.setDeptName(somApply.getCurDeptName());
		somFlow.setActorId(somApply.getCurPeopleId());
		somFlow.setActorName(somApply.getCurPeopleName());
		somFlow.setCommitTime(DateUtil.getTime());
		return somFlow;
	}
	
}
