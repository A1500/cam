package com.inspur.cams.sorg.online.apply.managePeople.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomDuty;
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.base.data.SomPeopleResume;
import com.inspur.cams.sorg.base.data.SomSession;
import com.inspur.cams.sorg.online.apply.managePeople.domain.IManagePeopleDomain;

/**
 * 负责人任职备案
 * @author 
 * @date 
 */
public class ManagePeopleCmd extends BaseAjaxCommand {

	private IManagePeopleDomain managePeopleDomain = ScaComponentFactory.getService(IManagePeopleDomain.class, "managePeopleDomain/managePeopleDomain");

	// 换届备案
	public void changeRegPeople() {
		
		managePeopleDomain.changeRegPeople(getSomSessionApply());
	}
	// 更新当前备案
	public void updateRegPeople() {
		managePeopleDomain.updateRegPeople(getSomSessionApply());
	}
	
	// 组装页面返回数据
	private SomApply getSomSessionApply() {
		Record somSessionRecord = (Record) getParameter("somSessionRecord");
		SomSession somSession = (SomSession) somSessionRecord.toBean(SomSession.class);
		Record somApplyRecord = (Record) getParameter("somApplyRecord");
		SomApply somApply = (SomApply) somApplyRecord.toBean(SomApply.class);
		Record somOrganRecord = (Record) getParameter("somOrganRecord");
		SomOrgan somOrgan = (SomOrgan)somOrganRecord.toBean(SomOrgan.class);
		List<SomDuty> somDutyList = new ArrayList<SomDuty>();
		Record[] somDutyRecord = (Record[]) getParameter("somDutyRecord");
		Record[] somResumeRecords = (Record[])getParameter("somResumeRecords");
		if (somDutyRecord != null) {
			for (int i = 0; i < somDutyRecord.length; i++) {
				SomDuty somDuty = (SomDuty) somDutyRecord[i].toBean(SomDuty.class);
				//处理个人简历
				if(somResumeRecords != null){
					List<SomPeopleResume> somPeopleResumeList = new ArrayList<SomPeopleResume>();
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
			}
		}
		somSession.setSomDutyList(somDutyList);
		somOrgan.setSomSession(somSession);
		somApply.setSomOrgan(somOrgan);
		return somApply;
	}
	/**
	 * 基金会分支负责人备案时的保存
	 */
	public void saveBranchPeople(){
		Record somdutyRecord = (Record) getParameter("somDutyRecord");
		Record[] somResumeRecords = (Record[])getParameter("somResumeRecords");
		//String sorgId=(String)getParameter("sorgId");
		//TODO 删除之前任职信息
	//	managePeopleDomain.deleteByRegStatus(sorgId,"3");
		
		if(somdutyRecord!=null){
			SomDuty somDuty=(SomDuty)somdutyRecord.toBean(SomDuty.class);
			//处理个人简历
			if(somResumeRecords != null){
				List<SomPeopleResume> somPeopleResumeList = new ArrayList<SomPeopleResume>();
				for(int j=0;j<somResumeRecords.length;j++){
					SomPeopleResume somPeopleResume =(SomPeopleResume) somResumeRecords[j].toBean(SomPeopleResume.class);
					somPeopleResumeList.add(somPeopleResume);
				}
				somDuty.setSomPeopleResumeList(somPeopleResumeList);
			}
			managePeopleDomain.saveBranchPeople(somDuty);
		}
		
	}
	/**
	 * 给页面返回一个新生成的dutyId
	 */
	public void getDutyId(){
		setReturn("dutyId", IdHelp.getUUID32());
	}
}
