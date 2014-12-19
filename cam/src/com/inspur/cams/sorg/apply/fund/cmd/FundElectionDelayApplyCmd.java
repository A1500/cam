package com.inspur.cams.sorg.apply.fund.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.apply.fund.domain.IFundElectionDelayApplyDomain;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomElection;
import com.inspur.cams.sorg.util.Activity;

/**
 * 延期换届选举报批
 * @author yanliangliang
 * @date 2012年6月25日
 */
public class FundElectionDelayApplyCmd extends BaseAjaxCommand {

	private IFundElectionDelayApplyDomain fundElectionDelayApplyDomain = ScaComponentFactory.getService(
			IFundElectionDelayApplyDomain.class, "fundElectionDelayApplyDomain/fundElectionDelayApplyDomain");

	// 保存
	public void create() {
		Record somApplyRecord = (Record) getParameter("somApplyRecord");
		SomApply somApply = (SomApply) somApplyRecord.toBean(SomApply.class);
		fundElectionDelayApplyDomain.create(somApply, getSomElection());
	}
	// 保存并提交
	public void createAndSend() {
		Record somApplyRecord = (Record) getParameter("somApplyRecord");
		SomApply somApply = (SomApply) somApplyRecord.toBean(SomApply.class);
		fundElectionDelayApplyDomain.createAndSend(somApply, getSomElection());
	}
	public void send(){
		Record somApplyRecord = (Record) getParameter("somApplyRecord");
		SomApply somApply = (SomApply) somApplyRecord.toBean(SomApply.class);
		SomElection somElection = getSomElection();
		if(Activity.ACT_SUPPLY_CN.equals(somApply.getCurActivity())){
			fundElectionDelayApplyDomain.update(somApply, somElection);
		}
		if(Activity.ACT_AUDIT_CN.equals(somApply.getCurActivity())){
			if("1".equals(somApply.getCurOpinionId())){
				fundElectionDelayApplyDomain.updateSomSession(somElection);
			}
		}
		fundElectionDelayApplyDomain.send(somApply);
		
	}
	// 受理更新
	public void update() {
		Record somApplyRecord = (Record) getParameter("somApplyRecord");
		SomApply somApply = (SomApply) somApplyRecord.toBean(SomApply.class);
		fundElectionDelayApplyDomain.update(somApply, getSomElection());
	}
	
	// 前台页面获取数据并组装
	private SomElection getSomElection() {
		Record somElectionRecord = (Record) getParameter("somElectionRecord");
		SomElection somElection = (SomElection) somElectionRecord.toBean(SomElection.class);
		return somElection;
	}
}
