package com.inspur.cams.sorg.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomRule;
import com.inspur.cams.sorg.base.domain.ISomRuleDomain;

/**
 * 章程核准保存和修改
 * @author shgtch
 * @date 2011-10-8
 */
public class SomRuleCmd extends BaseAjaxCommand {

	private ISomRuleDomain somRuleDomain = ScaComponentFactory.getService(
			ISomRuleDomain.class, "somRuleDomain/somRuleDomain");

	// 插入
	public void insert() {
		Record somRuleRecord = (Record) getParameter("somRuleRecord");
		SomRule somRule = (SomRule) somRuleRecord.toBean(SomRule.class);
		Record somApplyRecord = (Record) getParameter("somApplyRecord");
		SomApply somApply = (SomApply) somApplyRecord.toBean(SomApply.class);
		somRuleDomain.insertRuleApply(somApply, somRule);
	}

	// 更新
	public void update() {
		Record somRuleRecord = (Record) getParameter("somRuleRecord");
		SomRule somRule = (SomRule) somRuleRecord.toBean(SomRule.class);
		Record somApplyRecord = (Record) getParameter("somApplyRecord");
		SomApply somApply = (SomApply) somApplyRecord.toBean(SomApply.class);
		somRuleDomain.updateRuleApply(somApply, somRule);
	}
	
	/**
	 * 不插入会议信息，章程核准页面调用
	 */
	public void insertWithoutMeeting() {
		Record somRuleRecord = (Record) getParameter("somRuleRecord");
		SomRule somRule = (SomRule) somRuleRecord.toBean(SomRule.class);
		Record somApplyRecord = (Record) getParameter("somApplyRecord");
		SomApply somApply = (SomApply) somApplyRecord.toBean(SomApply.class);
		somRuleDomain.insertRuleApplyWithoutMeeting(somApply, somRule);
	}
	
	public void del() {
		String taskCode = (String) getParameter("taskCode");
		somRuleDomain.del(taskCode);
	}

}
