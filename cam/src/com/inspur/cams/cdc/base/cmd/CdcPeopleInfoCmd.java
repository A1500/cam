package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcPeopleInfo;
import com.inspur.cams.cdc.base.domain.ICdcPeopleInfoDomain;

/**
 * 基础信息两委成员与工作者信息表cmd
 * @author 
 * @date 2012-05-25
 */
public class CdcPeopleInfoCmd extends BaseAjaxCommand {

	private ICdcPeopleInfoDomain cdcPeopleInfoDomain = ScaComponentFactory
			.getService(ICdcPeopleInfoDomain.class, "cdcPeopleInfoDomain/cdcPeopleInfoDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		CdcPeopleInfo cdcPeopleInfo = (CdcPeopleInfo) record.toBean(CdcPeopleInfo.class);
		cdcPeopleInfoDomain.insert(cdcPeopleInfo);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		CdcPeopleInfo cdcPeopleInfo = (CdcPeopleInfo) record.toBean(CdcPeopleInfo.class);
		cdcPeopleInfoDomain.update(cdcPeopleInfo);
	}
	
	// 删除
	public void delete() {
		String peopleId = (String) getParameter("peopleId");
		cdcPeopleInfoDomain.delete(peopleId);
	}
	
}