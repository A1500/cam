package com.inspur.cams.drel.application.cityLow.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.application.cityLow.data.SamLowApplyInfo;
import com.inspur.cams.drel.application.cityLow.domain.ISamLowApplyInfoDomain;

/**
 * 低收入家庭认定业务表cmd
 * @author 
 * @date 2014-03-11
 */
public class SamLowApplyInfoCmd extends BaseAjaxCommand {

	private ISamLowApplyInfoDomain samLowApplyInfoDomain = ScaComponentFactory
			.getService(ISamLowApplyInfoDomain.class, "samLowApplyInfoDomain/samLowApplyInfoDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		SamLowApplyInfo samLowApplyInfo = (SamLowApplyInfo) record.toBean(SamLowApplyInfo.class);
		samLowApplyInfoDomain.insert(samLowApplyInfo);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		SamLowApplyInfo samLowApplyInfo = (SamLowApplyInfo) record.toBean(SamLowApplyInfo.class);
		samLowApplyInfoDomain.update(samLowApplyInfo);
	}
	
	// 删除
	public void delete() {
		String lowApplyId = (String) getParameter("lowApplyId");
		samLowApplyInfoDomain.delete(lowApplyId);
	}
	
}