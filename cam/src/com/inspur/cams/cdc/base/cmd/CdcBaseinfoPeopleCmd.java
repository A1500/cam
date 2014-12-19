package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcBaseinfoPeople;
import com.inspur.cams.cdc.base.domain.ICdcBaseinfoPeopleDomain;

/**
 * 人员基础信息cmd
 * @author 
 * @date 2012-05-25
 */
public class CdcBaseinfoPeopleCmd extends BaseAjaxCommand {

	private ICdcBaseinfoPeopleDomain cdcBaseinfoPeopleDomain = ScaComponentFactory
			.getService(ICdcBaseinfoPeopleDomain.class, "cdcBaseinfoPeopleDomain/cdcBaseinfoPeopleDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		CdcBaseinfoPeople cdcBaseinfoPeople = (CdcBaseinfoPeople) record.toBean(CdcBaseinfoPeople.class);
		cdcBaseinfoPeopleDomain.insert(cdcBaseinfoPeople);
		setReturn("familyId", cdcBaseinfoPeople.getFamilyId());
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		CdcBaseinfoPeople cdcBaseinfoPeople = (CdcBaseinfoPeople) record.toBean(CdcBaseinfoPeople.class);
		cdcBaseinfoPeopleDomain.update(cdcBaseinfoPeople);
	}
	
	// 删除
	public void delete() {
		String peopleId = (String) getParameter("peopleId");
		cdcBaseinfoPeopleDomain.delete(peopleId);
	}
	public void deleteFamily(){
		String peopleId = (String) getParameter("peopleId");
		cdcBaseinfoPeopleDomain.deleteFamily(peopleId);
	}
}