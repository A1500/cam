package com.inspur.cams.sorg.online.apply.delayElection.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomElection;
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.online.apply.delayElection.domain.ISomElectionDelayOnlineDomain;

/**
 * 延期换届选举报批
 * @author 
 * @date 
 */
public class SomElectionDelayOnlineCmd extends BaseAjaxCommand {

	private ISomElectionDelayOnlineDomain somElectionDelayOnlineDomain = ScaComponentFactory.getService(
			ISomElectionDelayOnlineDomain.class, "somElectionDelayOnlineDomain/somElectionDelayOnlineDomain");

	// 保存
	public void insert() {
		Record somApplyRecord = (Record) getParameter("somApplyRecord");
		SomApply somApply = (SomApply) somApplyRecord.toBean(SomApply.class);
		Record somOrganRecord = (Record) getParameter("somOrganRecord");
		somApply.setSomOrgan((SomOrgan)somOrganRecord.toBean(SomOrgan.class));
		somElectionDelayOnlineDomain.insert(somApply, getSomElection());
	}
	// 受理更新
	public void update() {
		Record somApplyRecord = (Record) getParameter("somApplyRecord");
		SomApply somApply = (SomApply) somApplyRecord.toBean(SomApply.class);
		Record somOrganRecord = (Record) getParameter("somOrganRecord");
		somApply.setSomOrgan((SomOrgan)somOrganRecord.toBean(SomOrgan.class));
		somElectionDelayOnlineDomain.update(somApply, getSomElection());
	}
	
	// 前台页面获取数据并组装
	private SomElection getSomElection() {
		Record somElectionRecord = (Record) getParameter("somElectionRecord");
		SomElection somElection = (SomElection) somElectionRecord.toBean(SomElection.class);
		return somElection;
	}
}
