package com.inspur.cams.sorg.apply.fund.cmd;

import java.util.ArrayList;
import java.util.List;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import com.inspur.cams.sorg.apply.fund.domain.IFundElectionApplyDomain;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomAspchief;
import com.inspur.cams.sorg.base.data.SomElection;
import com.inspur.cams.sorg.util.Activity;
/**
 * 换届事先报批
 * @author yanliangliang
 * @date 2012年6月25日
 */
public class FundElectionApplyCmd extends BaseAjaxCommand {

	private IFundElectionApplyDomain fundElectionApplyDomain = ScaComponentFactory.getService(
			IFundElectionApplyDomain.class, "fundElectionApplyDomain/fundElectionApplyDomain");

	// 保存
	public void create() {
		Record somApplyRecord = (Record) getParameter("somApplyRecord");
		SomApply somApply = (SomApply) somApplyRecord.toBean(SomApply.class);
		fundElectionApplyDomain.create(somApply, getSomElection());
	}
	// 保存并提交
	public void createAndSend() {
		Record somApplyRecord = (Record) getParameter("somApplyRecord");
		SomApply somApply = (SomApply) somApplyRecord.toBean(SomApply.class);
		fundElectionApplyDomain.createAndSend(somApply, getSomElection());
	}
	public void send(){
		Record somApplyRecord = (Record) getParameter("somApplyRecord");
		SomApply somApply = (SomApply) somApplyRecord.toBean(SomApply.class);
		if(Activity.ACT_SUPPLY_CN.equals(somApply.getCurActivity())||Activity.ACT_ACCEPT_CN.equals(somApply.getCurActivity())){
			fundElectionApplyDomain.update(somApply, getSomElection());
		}
		fundElectionApplyDomain.send(somApply);
		
	}
	// 受理更新
	public void update() {
		Record somApplyRecord = (Record) getParameter("somApplyRecord");
		SomApply somApply = (SomApply) somApplyRecord.toBean(SomApply.class);
		fundElectionApplyDomain.update(somApply, getSomElection());
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
