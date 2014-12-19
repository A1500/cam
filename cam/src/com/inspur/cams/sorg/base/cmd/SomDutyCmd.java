package com.inspur.cams.sorg.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomDuty;
import com.inspur.cams.sorg.base.data.SomPeopleResume;
import com.inspur.cams.sorg.base.data.SomSession;
import com.inspur.cams.sorg.base.domain.ISomDutyDomain;

/**
 * 负责人任职备案
 * @author shgtch
 * @date 2011-9-23
 */
public class SomDutyCmd extends BaseAjaxCommand {

	private ISomDutyDomain somDutyDomain = ScaComponentFactory.getService(ISomDutyDomain.class, "somDutyDomain/somDutyDomain");

	// 换届备案
	public void changeRegPeople() {
		somDutyDomain.changeRegPeople(getSomSession());
	}
	// 更新当前备案
	public void updateRegPeople() {
		somDutyDomain.updateRegPeople(getSomSession());
	}
	/**
	 * 换届备案外网申请受理
	 */ 
	public void changeRegPeopleOnline() {
		Record somApplyRecord = (Record) getParameter("applyRecord");
		SomApply somApply = (SomApply) somApplyRecord.toBean(SomApply.class);
		somDutyDomain.changeRegPeopleOnline(somApply,getSomSession());
	}
	// 组装页面返回数据
	private SomSession getSomSession() {
		Record somSessionRecord = (Record) getParameter("somSessionRecord");
		SomSession somSession = (SomSession) somSessionRecord.toBean(SomSession.class);
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
		return somSession;
	}
	/**
	 * 通过人员Id和社会组织类型查询此人是否已经是该类型下的法定代表人
	 */
	public void checkLegalPeopleRepeat(){
		String peopleId=(String)getParameter("peopleId");
		String sorgType=(String)getParameter("sorgType");
		String sorgId=(String)getParameter("sorgId");
		String flag=somDutyDomain.checkLegalPeopleRepeat(peopleId,sorgType,sorgId);
		setReturn("flag", flag);
	}
	/**
	 * 基金会分支负责人备案时的保存
	 */
	public void saveBranchPeople(){
		Record somdutyRecord = (Record) getParameter("somDutyRecord");
		Record[] somResumeRecords = (Record[])getParameter("somResumeRecords");
		//String sorgId=(String)getParameter("sorgId");
		//TODO 删除之前任职信息
	//	somDutyDomain.deleteByRegStatus(sorgId,"3");
		
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
			somDutyDomain.saveBranchPeople(somDuty);
		}
		
	}
	/**
	 * 给页面返回一个新生成的dutyId
	 */
	public void getDutyId(){
		setReturn("dutyId", IdHelp.getUUID32());
	}
	
	public void deleteSessionAllByTaskCode(){
		String taskCode=(String)getParameter("taskCode");
		somDutyDomain.deleteSessionAllByTaskCode(taskCode);
	}
}
