package com.inspur.cams.sorg.apply.ungov.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import com.inspur.cams.sorg.apply.ungov.domain.IUngovNameApprovalDomain;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomAspchief;
import com.inspur.cams.sorg.base.data.SomHeldOrgan;
import com.inspur.cams.sorg.base.data.SomHeldPeople;
import com.inspur.cams.sorg.base.data.SomOrgan;
/**
 *民办非企业单位名称核准Cmd
 * @author yanliangliang
 * 2012年3月19日
 */
public class UngovNameApprovalCmd extends BaseAjaxCommand {

	IUngovNameApprovalDomain ungovNameApprovalDomain = ScaComponentFactory.getService(IUngovNameApprovalDomain.class, "ungovNameApprovalDomain/ungovNameApprovalDomain");
	
	/**
	 * 新增业务             
	 */
	public void create() {
		ungovNameApprovalDomain.create(getSomApply());
	}
	
	/**
	 * 新增业务并提交流程
	 */
	public void createAndSend() {
		ungovNameApprovalDomain.createAndSend(getSomApply());
	}
	/**
	 * 修改保存业务
	 */
	public void update() {
		ungovNameApprovalDomain.update(getSomApply());
	}
	
	/**
	 * 修改保存业务并提交流程
	 */
	public void updateAndSend() {
		ungovNameApprovalDomain.updateAndSend(getSomApply());
	}
	
	
	// 前台页面获取数据并组装
	private SomApply getSomApply() {
		Record somApplyRecord = (Record) getParameter("somApplyRecord");
		SomApply somApply = (SomApply) somApplyRecord.toBean(SomApply.class);
		
		Record somOrganRecord = (Record) getParameter("somOrganRecord");
		SomOrgan somOrgan = (SomOrgan) somOrganRecord.toBean(SomOrgan.class);
		
		List<SomHeldPeople> somHeldPeopleList = new ArrayList<SomHeldPeople>();
		List<SomHeldOrgan> somHeldOrganList = new ArrayList<SomHeldOrgan>();
		List<SomAspchief> somAspchiefList = new ArrayList<SomAspchief>();

		Record[] somHeldPeopleRecord = (Record[]) getParameter("somHeldPeopleRecord");
		Record[] somHeldOrganRecord = (Record[]) getParameter("somHeldOrganRecord");
		Record[] somAspchiefRecord = (Record[]) getParameter("somAspchiefRecord");
		
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
		if (somAspchiefRecord != null) {
			for (int i = 0; i < somAspchiefRecord.length; i++) {
				SomAspchief somAspchief = (SomAspchief) somAspchiefRecord[i].toBean(SomAspchief.class);
				somAspchiefList.add(somAspchief);
			}
		}
		somOrgan.setSomHeldPeopleList(somHeldPeopleList);
		somOrgan.setSomHeldOrganList(somHeldOrganList);
		somOrgan.setSomAspchiefList(somAspchiefList);
		//维护organ表中联系人与联系电话
		somOrgan.setSorgPeople(somApply.getAppPeople());
		somOrgan.setSorgPeoplePhone(somApply.getAppPhone());
		somApply.setSomOrgan(somOrgan);
		
		return somApply;
	}

}

