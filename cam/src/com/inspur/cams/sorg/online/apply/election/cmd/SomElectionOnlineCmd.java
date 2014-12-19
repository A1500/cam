package com.inspur.cams.sorg.online.apply.election.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomAspchief;
import com.inspur.cams.sorg.base.data.SomElection;
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.online.apply.election.domain.ISomElectionOnlineDomain;

/**
 * 换届事先报批
 * @author 
 * @date 2011-10-8
 */
public class SomElectionOnlineCmd extends BaseAjaxCommand {

	private ISomElectionOnlineDomain somElectionOnlineDomain = ScaComponentFactory.getService(
			ISomElectionOnlineDomain.class, "somElectionOnlineDomain/somElectionOnlineDomain");

	// 插入
	public void insert() {
		Record somApplyRecord = (Record) getParameter("somApplyRecord");
		SomApply somApply = (SomApply) somApplyRecord.toBean(SomApply.class);
		Record somOrganRecord = (Record) getParameter("somOrganRecord");
		somApply.setSomOrgan((SomOrgan)somOrganRecord.toBean(SomOrgan.class));
		somElectionOnlineDomain.insertElectionApply(somApply, getSomElection());
	}

	// 更新
	public void update() {
		Record somApplyRecord = (Record) getParameter("somApplyRecord");
		SomApply somApply = (SomApply) somApplyRecord.toBean(SomApply.class);
		Record somOrganRecord = (Record) getParameter("somOrganRecord");
		somApply.setSomOrgan((SomOrgan)somOrganRecord.toBean(SomOrgan.class));
		somElectionOnlineDomain.updateElectionApply(somApply, getSomElection());
	}
	
	// 前台页面获取数据并组装
	private SomElection getSomElection() {
		Record somElectionRecord = (Record) getParameter("somElectionRecord");
		SomElection somElection = (SomElection) somElectionRecord.toBean(SomElection.class);
		
		List<SomAspchief> somAspchiefList = new ArrayList<SomAspchief>();
		Record[] somAspchiefRecord = (Record[]) getParameter("somAspchiefRecord");
		if (somAspchiefRecord != null) {
			for (int i = 0; i < somAspchiefRecord.length; i++) {
				SomAspchief somAspchief = (SomAspchief) somAspchiefRecord[i].toBean(SomAspchief.class);
				somAspchiefList.add(somAspchief);
			}
		}
		somElection.setSomAspchiefList(somAspchiefList);
		return somElection;
	}
}
