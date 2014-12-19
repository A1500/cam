package com.inspur.cams.sorg.apply.fund.cmd;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import com.inspur.cams.sorg.apply.fund.domain.IFundBuildDomain;
import com.inspur.cams.sorg.apply.fund.domain.IFundNameApprovalDomain;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomAspchief;
import com.inspur.cams.sorg.base.data.SomHeldOrgan;
import com.inspur.cams.sorg.base.data.SomHeldPeople;
import com.inspur.cams.sorg.base.data.SomOrgan;

public class FundNameApprovalCmd  extends BaseAjaxCommand{
	// 获取SCA组件
	private IFundNameApprovalDomain service = ScaComponentFactory.getService(IFundNameApprovalDomain.class, "fundNameApprovalDomain/fundNameApprovalDomain");
	/**
	 * 新增业务             
	 */
	public void create() {
		service.create(getReportSomApply());
	}
	
	/**
	 * 新增业务并提交流程
	 */
	public void createAndSend() {
		service.createAndSend(getReportSomApply());
	}
	/**
	 * 修改保存业务
	 */
	public void update() {
		service.update(getReportSomApply());
	}
	
	/**
	 * 修改保存业务并提交流程
	 */
	public void updateAndSend() {
		service.updateAndSend(getReportSomApply());
	}
	//从后台获取数据
	private SomApply getReportSomApply() {
		Record somApplyRecord = (Record) getParameter("somApplyRecord");
		SomApply somApply = (SomApply) somApplyRecord.toBean(SomApply.class);
		
		Record somOrganRecord = (Record) getParameter("somOrganRecord");
		SomOrgan somOrgan = (SomOrgan) somOrganRecord.toBean(SomOrgan.class);
		
		List<SomHeldPeople> somHeldPeopleList = new ArrayList<SomHeldPeople>();
		List<SomHeldOrgan> somHeldOrganList = new ArrayList<SomHeldOrgan>();

		Record[] somHeldPeopleRecord = (Record[]) getParameter("somHeldPeopleRecord");
		Record[] somHeldOrganRecord = (Record[]) getParameter("somHeldOrganRecord");
		Record aspChief = (Record) getParameter("aspChief");
		
		SomAspchief somAspChief=(SomAspchief)aspChief.toBean(SomAspchief.class);
		List<SomAspchief> somAspChiefList = new ArrayList<SomAspchief>();
		somAspChiefList.add(somAspChief);
		
		if (somHeldPeopleRecord != null) {
			for (int i = 0; i < somHeldPeopleRecord.length; i++) {
				SomHeldPeople somHeldPeople = (SomHeldPeople) somHeldPeopleRecord[i].toBean(SomHeldPeople.class);
				somHeldPeopleList.add(somHeldPeople);
			}
		}
		if (somHeldOrganRecord != null) {
			for (int i = 0; i < somHeldOrganRecord.length; i++) {
				SomHeldOrgan somHeldOrgan = (SomHeldOrgan) somHeldOrganRecord[i].toBean(SomHeldOrgan.class);
				somHeldOrganList.add(somHeldOrgan);
			}
		}
		somOrgan.setSomHeldPeopleList(somHeldPeopleList);
		somOrgan.setSomHeldOrganList(somHeldOrganList);
		somOrgan.setSomAspchiefList(somAspChiefList);
		//维护organ表中联系人与联系电话
		somOrgan.setSorgPeople(somApply.getAppPeople());
		somOrgan.setSorgPeoplePhone(somApply.getAppPhone());
		somApply.setSomOrgan(somOrgan);
		
		return somApply;
	}
 
}
