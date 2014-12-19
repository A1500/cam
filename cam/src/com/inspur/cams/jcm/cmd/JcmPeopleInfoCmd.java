package com.inspur.cams.jcm.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.jcm.data.JcmPeopleCompany;
import com.inspur.cams.jcm.data.JcmPeopleExam;
import com.inspur.cams.jcm.data.JcmPeopleInfo;
import com.inspur.cams.jcm.data.JcmPeopleResume;
import com.inspur.cams.jcm.domain.IJcmPeopleInfoDomain;

/**
 * 人员基本信息cmd
 * @author 
 * @date 2014-05-16
 */
public class JcmPeopleInfoCmd extends BaseAjaxCommand {

	private IJcmPeopleInfoDomain jcmPeopleInfoDomain = ScaComponentFactory
			.getService(IJcmPeopleInfoDomain.class, "jcmPeopleInfoDomain/jcmPeopleInfoDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		JcmPeopleInfo jcmPeopleInfo = (JcmPeopleInfo) record.toBean(JcmPeopleInfo.class);
		jcmPeopleInfoDomain.insert(jcmPeopleInfo);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		JcmPeopleInfo jcmPeopleInfo = (JcmPeopleInfo) record.toBean(JcmPeopleInfo.class);
		jcmPeopleInfoDomain.update(jcmPeopleInfo);
	}
	
	// 删除
	public void delete() {
		String peopleId = (String) getParameter("peopleId");
		jcmPeopleInfoDomain.delete(peopleId);
	}
	
	//保存全部的人员信息
	public void save() {
		
		List<JcmPeopleResume> resumeList = new ArrayList<JcmPeopleResume>();
		List<JcmPeopleCompany> companyList = new ArrayList<JcmPeopleCompany>();
		List<JcmPeopleExam> examList = new ArrayList<JcmPeopleExam>();
		
		
		Record record = (Record) getParameter("record");
		Record[] resumeRecords = (Record[]) getParameter("resumeRecords");
		Record[] companyRecords = (Record[]) getParameter("companyRecords");
		Record[] examRecords = (Record[]) getParameter("examRecords");
		JcmPeopleInfo jcmPeopleInfo = (JcmPeopleInfo) record.toBean(JcmPeopleInfo.class);
		if(resumeRecords!=null){
			for(int i=0;i<resumeRecords.length;i++){
				JcmPeopleResume jcmPeopleResume = (JcmPeopleResume) resumeRecords[i].toBean(JcmPeopleResume.class);
				resumeList.add(jcmPeopleResume);
			}
		}
		if(companyRecords!=null){
			for(int i=0;i<companyRecords.length;i++){
				JcmPeopleCompany jcmPeopleCompany = (JcmPeopleCompany) companyRecords[i].toBean(JcmPeopleCompany.class);
				companyList.add(jcmPeopleCompany);
			}
		}
		if(examRecords!=null){
			for(int i=0;i<examRecords.length;i++){
				JcmPeopleExam jcmPeopleExam = (JcmPeopleExam) examRecords[i].toBean(JcmPeopleExam.class);
				examList.add(jcmPeopleExam);
			}
		}
		
		jcmPeopleInfoDomain.save(jcmPeopleInfo,resumeList,companyList,examList);
	}
	
	// 删除全部
	public void deleteAll() {
		String peopleId = (String) getParameter("peopleId");
		jcmPeopleInfoDomain.deleteAll(peopleId);
	}
	
	
	
	
}