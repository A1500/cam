package com.inspur.cams.sorg.apply.group.cmd;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.apply.group.domain.IGroupBranchBuildDomain;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomDuty;
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.base.data.SomPeopleResume;
import com.inspur.cams.sorg.base.data.SomSession;

/**
 * 社会团体分支成立登记流程cmd
 * @author zhaojin
 * @date 2011-8-23
 */
public class GroupBranchBuildCmd extends BaseAjaxCommand {
	
	IGroupBranchBuildDomain service = ScaComponentFactory.getService(IGroupBranchBuildDomain.class, "groupBranchBuildDomain/groupBranchBuildDomain");
	
	/**
	 * 新增业务
	 */
	public void create() {
		service.create(getSomApply());
	}
	
	/**
	 * 新增业务并提交流程
	 */
	public void createAndSend() {
		service.createAndSend(getSomApply());
	}

	/**
	 * 修改保存业务
	 */
	public void update() {
		service.update(getSomApply());
	}
	
	/**
	 * 修改保存业务并提交流程
	 */
	public void updateAndSend() {
		service.updateAndSend(getSomApply());
	}
	
	/**
	 * 更新业务意见信息
	 */
	public void updateApply(){
		//获取前台业务意见信息
		Record applyRd = (Record) getParameter("somApplyRecord");
		SomApply applyBean = (SomApply) applyRd.toBean(SomApply.class);
		service.updateApply(applyBean);
	}
	
	/**
	 *  保存并发送
	 */
	public void send(){
		//根据环节定义获取环节信息
		Record applyRd = (Record) getParameter("somApplyRecord");
		SomApply applyBean = (SomApply) applyRd.toBean(SomApply.class);
		Map<String, String> map=new HashMap<String, String>();
		map.put("fetchPeople", (String)getParameter("fetchPeople"));
		map.put("fetchDate", (String)getParameter("fetchDate"));
		map.put("fetchPhone", (String)getParameter("fetchPhone"));
		applyBean.setMap(map);
		service.send(applyBean);
	}

	/**
	 * 打印环节发送
	 */
	public void printForSend(){
		Record applyRd = (Record) getParameter("somApplyRecord");
		SomApply applyBean = (SomApply) applyRd.toBean(SomApply.class);
		Map<String, String> map=new HashMap<String, String>();
		map.put("certType", (String)getParameter("certType"));
		map.put("endDate", (String)getParameter("endDate"));
		map.put("beginDate", (String)getParameter("beginDate"));
		map.put("PrintDate", (String)getParameter("PrintDate"));
		map.put("issueReasonDesc", (String)getParameter("issueReasonDesc"));
		map.put("sorgCode", (String)getParameter("sorgCode"));
		map.put("business", (String)getParameter("business"));
		map.put("actArea", (String)getParameter("actArea"));
		map.put("fetchPeople", (String)getParameter("fetchPeople"));
		map.put("fetchDate", (String)getParameter("fetchDate"));
		map.put("fetchPhone", (String)getParameter("fetchPhone"));
		applyBean.setMap(map);
		service.printForSend(applyBean);
	}
	
	// 前台页面获取数据并组装
	private SomApply getSomApply() {
		Record organRd = (Record) getParameter("somOrganRecord");
		SomOrgan organBean = (SomOrgan) organRd.toBean(SomOrgan.class);
		//获取前台业务意见信息
		Record applyRd = (Record) getParameter("somApplyRecord");
		SomApply applyBean = (SomApply) applyRd.toBean(SomApply.class);
		Record somSessionRecord = (Record) getParameter("somSessionRecord");
		Record[] somDutyRecords = (Record[])getParameter("somDutyRecords");
		Record[] somResumeRecords = (Record[])getParameter("somResumeRecords");
		List<SomDuty> somDutyList = new ArrayList<SomDuty>();
		SomSession somSession=(SomSession)somSessionRecord.toBean(SomSession.class);
		if(somDutyRecords != null){
			for(int i=0;i<somDutyRecords.length;i++){
				SomDuty somDuty=(SomDuty)somDutyRecords[i].toBean(SomDuty.class);
				//处理个人简历
				List<SomPeopleResume> somPeopleResumeList = new ArrayList<SomPeopleResume>();
				if(somResumeRecords!=null){
					for(int j=0;j<somResumeRecords.length;j++){
						SomPeopleResume somPeopleResume =(SomPeopleResume) somResumeRecords[j].toBean(SomPeopleResume.class);
						if(somPeopleResume.getDutyId().equals(somDuty.getDutyId())){
							somPeopleResumeList.add(somPeopleResume);
						}
					}
					somDuty.setSomPeopleResumeList(somPeopleResumeList);
				}
				//处理个人简历完成
				somDutyList.add(somDuty);
				organBean.setBranchCharger(somDuty.getName());
			}
		}
		organBean.setSomSession(somSession);
		organBean.setSomDutyList(somDutyList);
		//封装map信息
		Map<String, String> map=new HashMap<String, String>();
		//制证信息
		map.put("certType", (String)getParameter("certType"));
		map.put("endDate", (String)getParameter("endDate"));
		map.put("beginDate", (String)getParameter("beginDate"));
		map.put("PrintDate", (String)getParameter("PrintDate"));
		map.put("issueReasonDesc", (String)getParameter("issueReasonDesc"));
		//发证信息
		map.put("fetchDate", (String)getParameter("fetchDate"));
		map.put("fetchPeople", (String)getParameter("fetchPeople"));
		map.put("fetchPhone", (String)getParameter("fetchPhone"));
		//封装参数
		applyBean.setMap(map);
		applyBean.setSomOrgan(organBean);
		return applyBean;
	}
}
