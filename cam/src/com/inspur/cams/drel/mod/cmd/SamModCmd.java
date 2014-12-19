package com.inspur.cams.drel.mod.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.drel.his.city.domain.ISamCityHisDomain;
import com.inspur.cams.drel.sam.data.SamApplyDiscussion;
import com.inspur.cams.drel.sam.data.SamApplyInfo;
import com.inspur.cams.drel.sam.data.SamApplyNotice;
import com.inspur.cams.drel.sam.data.SamApplySurvey;
import com.inspur.cams.drel.sam.data.SamBankAccount;
import com.inspur.cams.drel.sam.data.SamFamilyAssistance;

/**
 * 区县基本数据修改Cmd
 * @author 
 * @date 
 */
public class SamModCmd  extends BaseAjaxCommand {
	// 获取SCA组件
	private ISamCityHisDomain service = ScaComponentFactory.getService(ISamCityHisDomain.class, "samCityHisDomain/samCityHisDomain");
	/**
	 * 保存
	 */
	public void insertInfo() {
		SamApplyInfo samApplyInfo=service.saveModInfo(getApplyInfo());
		setReturn("familyId",samApplyInfo.getFamilyId());
		setReturn("applyId",samApplyInfo.getApplyId());
		setReturn("photoId",samApplyInfo.getBaseInfoFamily().getPhotoId());
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
		//处理银行信息
		Record bankAccount=(Record)getParameter("bankAccount");
		SamBankAccount bank=(SamBankAccount)bankAccount.toBean(SamBankAccount.class);
		samApplyInfo.setSamBankAccount(bank);
		return samApplyInfo;
	}
}
