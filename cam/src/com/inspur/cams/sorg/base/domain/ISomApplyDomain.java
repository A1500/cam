package com.inspur.cams.sorg.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomOrgan;

/**
 * 社会组织业务domain接口
 * @author shgtch
 * @date 2011-8-12
 */
public interface ISomApplyDomain {

	/**
	 * 查询社会组织业务
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	public DataSet queryHisChange(ParameterSet pset);
	/**
	 * 查询一条社会组织业务信息
	 * @param taskCode
	 * @return
	 */
	public SomApply getSomApply(String taskCode);
	
	/**
	 * 增加社会组织业务
	 * @param somApply
	 */
	@Trans
	public void insert(SomApply somApply);
	
	/**
	 * 更新社会组织业务
	 * @param somApply
	 */
	@Trans
	public void update(SomApply somApply);

	/**
	 * 获取最后环节processId
	 * @param id
	 * @return
	 */
	public String queryProcessId(String id);

	/**
	 * 通过processId获取taskCode
	 * @param processId
	 * @return
	 */
	public SomApply queryTaskCodeByProcessId(String processId);
	
	/**
	 * 通过processId获取photoId
	 * @param processId
	 * @return
	 */
	public String queryPhotoIdByProcessId(String processId);
	
	/**
	 * 维护历史处理意见
	 * @param somApply
	 */
	@Trans
	public void dealHisOpinion(SomApply somApply);
	
	/**
	 * 清空业务信息中的当前信息
	 * @param applyBean 业务信息
	 * @param activityName 当前环节名称
	 */
	@Trans
	public void emptySomApply(SomApply applyBean, String activityName);

	/**
	 * 更新业务信息中的当前信息
	 * @param applyBean
	 */
	@Trans
	public void curSomApply(SomApply applyBean);
	
	/**
	 * 查询社会团体流程信息（带组织机构过滤）
	 * @return
	 */
	public DataSet querySorgApply(ParameterSet pset);/**
	 * 查询带有社会组织信息的流程信息
	 * @return
	 */
	public DataSet queryOrgan(ParameterSet pset);
	/**
	 * 更新somApply的社会组织名称和类别字段
	 * @param somOrgan
	 */
	@Trans
	public void updateSomApplyInfo(SomOrgan somOrgan);
	/**
	 * 如果环节是补齐补正，清空业务表的初审审核审批意见
	 * @param somApply
	 */
	@Trans
	public void emptyExamToAudit(SomApply somApply);
	
	public void insertOnline(SomApply somApply);
}
