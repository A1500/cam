package com.inspur.cams.drel.his.country.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.drel.his.country.domain.ISamCountryHisDomain;
import com.inspur.cams.drel.sam.data.SamApplyDiscussion;
import com.inspur.cams.drel.sam.data.SamApplyInfo;
import com.inspur.cams.drel.sam.data.SamApplyNotice;
import com.inspur.cams.drel.sam.data.SamApplySurvey;
import com.inspur.cams.drel.sam.data.SamBankAccount;
import com.inspur.cams.drel.sam.data.SamFamilyAssistance;

/**
 * 农村低保历史Cmd
 * @author 
 * @date 
 */
public class SamCountryHisCmd  extends BaseAjaxCommand {
	// 获取SCA组件
	private ISamCountryHisDomain service = ScaComponentFactory.getService(ISamCountryHisDomain.class, "samCountryHisDomain/samCountryHisDomain");
	/**
	 * 保存
	 */
	public void insertInfo() {
		SamApplyInfo samApplyInfo=service.insertInfo(getApplyInfo());
		setReturn("familyId",samApplyInfo.getFamilyId());
		setReturn("applyId",samApplyInfo.getApplyId());
		setReturn("photoId",samApplyInfo.getBaseInfoFamily().getPhotoId());
	}	
	/**
	 * 调用存储过程把记录保存到备用表中
	 */
	public void toDuplicateRecord(){
		Record applyRecord = (Record) getParameter("applyRecord");
		SamApplyInfo samApplyInfo=(SamApplyInfo)applyRecord.toBean(SamApplyInfo.class);
		service.toDuplicateRecord(samApplyInfo);
	}
	/**
	 * 封装数据
	 * @return
	 */
	private SamApplyInfo getApplyInfo() {
		Record applyRecord = (Record) getParameter("applyRecord");
		SamApplyInfo samApplyInfo=(SamApplyInfo)applyRecord.toBean(SamApplyInfo.class);
		//处理家庭
		Record familyRecord = (Record) getParameter("familyRecord");
		BaseinfoFamily baseinfoFamily=(BaseinfoFamily)familyRecord.toBean(BaseinfoFamily.class);
		samApplyInfo.setBaseInfoFamily(baseinfoFamily);
		//处理多选
		Record[] AssistanceRecords = (Record[])getParameter("AssistanceRecords");
		if(AssistanceRecords != null){
			List<SamFamilyAssistance> samFamilyAssistanceList = new ArrayList<SamFamilyAssistance>();
			for(int i=0;i<AssistanceRecords.length;i++){
				SamFamilyAssistance samFamilyAssistance=(SamFamilyAssistance)AssistanceRecords[i].toBean(SamFamilyAssistance.class);
				samFamilyAssistanceList.add(samFamilyAssistance);
			}
			samApplyInfo.setSamFamilyAssistanceList(samFamilyAssistanceList);
		}
		//处理入户调查
		Record acceptSurveyRecord = (Record) getParameter("acceptSurveyRecord");
		List<SamApplySurvey> samApplySurveyList = new ArrayList<SamApplySurvey>(); 
		SamApplySurvey samApplySurvey=(SamApplySurvey)acceptSurveyRecord.toBean(SamApplySurvey.class);
		samApplySurveyList.add(samApplySurvey);
		//处理评议结果
		Record acceptDiscussionRecord = (Record) getParameter("acceptDiscussionRecord");
		List<SamApplyDiscussion> samApplyDiscussionList = new ArrayList<SamApplyDiscussion>(); 
		SamApplyDiscussion samApplyDiscussion=(SamApplyDiscussion)acceptDiscussionRecord.toBean(SamApplyDiscussion.class);
		samApplyDiscussionList.add(samApplyDiscussion);
		samApplyInfo.setSamApplyDiscussionList(samApplyDiscussionList);
		//处理公告
		Record acceptNoticeRecord =(Record) getParameter("acceptNoticeRecord");
		List<SamApplyNotice> samApplyNoticeList = new ArrayList<SamApplyNotice>(); 
		SamApplyNotice samApplyNotice=(SamApplyNotice)acceptNoticeRecord.toBean(SamApplyNotice.class);
		samApplyNoticeList.add(samApplyNotice);
		
		//处理入户调查
		Record checkSurveyRecord = (Record) getParameter("checkSurveyRecord");
		SamApplySurvey checkSurvey=(SamApplySurvey)checkSurveyRecord.toBean(SamApplySurvey.class);
		samApplySurveyList.add(checkSurvey);
		//处理公示结果
		Record checkNoticeRecord = (Record) getParameter("checkNoticeRecord");
		SamApplyNotice checkNotice=(SamApplyNotice)checkNoticeRecord.toBean(SamApplyNotice.class);
		samApplyNoticeList.add(checkNotice);

		//处理入户调查
		Record auditSurveyRecord = (Record) getParameter("auditSurveyRecord");
		SamApplySurvey auditSurvey=(SamApplySurvey)auditSurveyRecord.toBean(SamApplySurvey.class);
		samApplySurveyList.add(auditSurvey);
		samApplyInfo.setSamApplySurveyList(samApplySurveyList);
		//处理公示结果
		Record auditNoticeRecord = (Record) getParameter("auditNoticeRecord");
		SamApplyNotice auditNotice=(SamApplyNotice)auditNoticeRecord.toBean(SamApplyNotice.class);
		samApplyNoticeList.add(auditNotice);
		samApplyInfo.setSamApplyNoticeList(samApplyNoticeList);	
		//处理银行信息
		Record bankAccount=(Record)getParameter("bankAccount");
		SamBankAccount bank=(SamBankAccount)bankAccount.toBean(SamBankAccount.class);
		samApplyInfo.setSamBankAccount(bank);
		return samApplyInfo;
	}
}
