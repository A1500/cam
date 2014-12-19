package com.inspur.cams.sorg.apply.ungov.domain;

import org.loushang.sca.transaction.Trans;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomChangeApply;
/**
 * 基金会主体变更domain接口
 * @author yanliangliang
 * @date 2011-8-17
 */
public interface IUngovChangeDomain {
	/**
	 * 业务流程中的保存发送流程
	 * @param somChangeApply
	 */
	@Trans
	public void saveAndSendForChange(SomChangeApply somChangeApply);
	/**
	 * 变更业务流程发送下一步
	 *  @param somChangeApply
	 */
	@Trans
	public void sendForChange(SomChangeApply somChangeApply);
	/**
	 * 最后环节获取processId
	 * @param id assignmentId
	 * @return
	 */
	@Trans
	public String queryProcessId(String id);
	/**
	 * 打印证书环节的相关操作
	 *  @param somChangeApply
	 */
	@Trans
	public void endForChange(SomChangeApply somChangeApply);
	/**
	 * 创建流程并保存信息，不发送流程
	 *  @param somChangeApply
	 */
	@Trans
	public void createForChange(SomChangeApply somChangeApply);
	/**
	 * 删除变更时做的操作
	 * @param id
	 * @param changeItem
	 * @param sorgId
	 * @param taskCode 
	 */
	@Trans
	public void deleteForChange(String id, String changeItem, String sorgId, String taskCode);
	/**
	 * 修改页面的保存
	 * @param somChangeApply
	 */
	@Trans
	public void updateSomApply(SomChangeApply somChangeApply);
	/**
	 * 通过processId获得somApply
	 */
	public SomApply getSomApplyByProcessId(String id);
	/**
	 * 通过sorgId获得法定代表人姓名
	 * @param sorgId
	 * @return
	 */
	public String getLegalPeopleNameByTaskCode(String sorgId);
	/**
	 * 保存意见
	 * @param somApply
	 */
	@Trans
	public void saveFlow(SomApply somApply);
	
	@Trans
	public void createForChangeOnline(SomChangeApply somChangeApply);
	
	@Trans
	public void saveAndSendForChangeOnline(SomChangeApply somChangeApply);
	
}
