package com.inspur.cams.sorg.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomRule;
/**
 * 章程信息会议domain接口
 * @author yanliangliang
 * @date 2011-9-21
 */
public interface ISomRuleDomain {
	
	/**
	 * 查询章程信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 查询章程信息
	 * @param pset
	 * @return
	 */
	public DataSet queryRule(ParameterSet pset);
	
	/**
	 * 增加章程信息
	 * @param somRule
	 */
	@Trans
	public void insert(SomRule somRule);
	
	/**
	 * 更新章程信息
	 * @param somRule
	 */
	@Trans
	public void update(SomRule somRule);
	
	@Trans
	public void del(String taskCode);
	
	/**
	 * 增加章程核准业务
	 * @param somRule
	 */
	@Trans
	public void insertRuleApply(SomApply somApply, SomRule somRule);
	
	/**
	 * 更新章程业务
	 * @param somRule
	 */
	@Trans
	public void updateRuleApply(SomApply somApply, SomRule somRule);
	
	/**
	 * 外网申请调用插入
	 * @param somRule
	 */
	@Trans
	public void insertOnline(SomRule somRule);
	
	/**
	 * 增加章程核准业务不插入会议信息，章程核准页面调用
	 * @param somRule
	 */
	@Trans
	public void insertRuleApplyWithoutMeeting(SomApply somApply, SomRule somRule);
	
	@Trans
	public void insertWithOutMeetingInfo(SomRule somRule);
}
