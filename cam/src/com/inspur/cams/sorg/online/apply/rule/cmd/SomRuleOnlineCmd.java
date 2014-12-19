package com.inspur.cams.sorg.online.apply.rule.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.base.data.SomRule;
import com.inspur.cams.sorg.online.apply.rule.domain.ISomRuleOnlineDomain;

/**
 * 章程核准保存和修改
 * @author shgtch
 * @date 2011-10-8
 */
public class SomRuleOnlineCmd extends BaseAjaxCommand {

	private ISomRuleOnlineDomain somRuleOnlineDomain = ScaComponentFactory.getService(
			ISomRuleOnlineDomain.class, "somRuleOnlineDomain/somRuleOnlineDomain");

	// 插入
	public void insert() {
		Record somRuleRecord = (Record) getParameter("somRuleRecord");
		SomRule somRule = (SomRule) somRuleRecord.toBean(SomRule.class);
		Record somApplyRecord = (Record) getParameter("somApplyRecord");
		SomApply somApply = (SomApply) somApplyRecord.toBean(SomApply.class);
		Record somOrganRecord = (Record) getParameter("somOrganRecord");
		somApply.setSomOrgan((SomOrgan)somOrganRecord.toBean(SomOrgan.class));
		somRuleOnlineDomain.insertRuleApply(somApply, somRule);
	}

	// 更新
	public void update() {
		Record somRuleRecord = (Record) getParameter("somRuleRecord");
		SomRule somRule = (SomRule) somRuleRecord.toBean(SomRule.class);
		Record somApplyRecord = (Record) getParameter("somApplyRecord");
		SomApply somApply = (SomApply) somApplyRecord.toBean(SomApply.class);
		Record somOrganRecord = (Record) getParameter("somOrganRecord");
		somApply.setSomOrgan((SomOrgan)somOrganRecord.toBean(SomOrgan.class));
		somRuleOnlineDomain.updateRuleApply(somApply, somRule);
	}

}
