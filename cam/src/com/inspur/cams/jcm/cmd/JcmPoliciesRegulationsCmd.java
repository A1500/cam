package com.inspur.cams.jcm.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.jcm.data.JcmPoliciesRegulations;
import com.inspur.cams.jcm.domain.IJcmPoliciesRegulationsDomain;

/**
 * 政策法规表cmd
 * @author 
 * @date 2014-05-16
 */
public class JcmPoliciesRegulationsCmd extends BaseAjaxCommand {

	private IJcmPoliciesRegulationsDomain jcmPoliciesRegulationsDomain = ScaComponentFactory
			.getService(IJcmPoliciesRegulationsDomain.class, "jcmPoliciesRegulationsDomain/jcmPoliciesRegulationsDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		JcmPoliciesRegulations jcmPoliciesRegulations = (JcmPoliciesRegulations) record.toBean(JcmPoliciesRegulations.class);
		jcmPoliciesRegulationsDomain.insert(jcmPoliciesRegulations);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		JcmPoliciesRegulations jcmPoliciesRegulations = (JcmPoliciesRegulations) record.toBean(JcmPoliciesRegulations.class);
		jcmPoliciesRegulationsDomain.update(jcmPoliciesRegulations);
	}
	
	// 删除
	public void delete() {
		String prId = (String) getParameter("prId");
		jcmPoliciesRegulationsDomain.delete(prId);
	}
	
}