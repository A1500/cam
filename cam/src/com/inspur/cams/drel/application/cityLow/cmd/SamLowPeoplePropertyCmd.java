package com.inspur.cams.drel.application.cityLow.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.application.cityLow.data.SamLowPeopleProperty;
import com.inspur.cams.drel.application.cityLow.domain.ISamLowPeoplePropertyDomain;

/**
 * 低收入家庭成员财产表cmd
 * @author 
 * @date 2014-03-11
 */
public class SamLowPeoplePropertyCmd extends BaseAjaxCommand {

	private ISamLowPeoplePropertyDomain samLowPeoplePropertyDomain = ScaComponentFactory
			.getService(ISamLowPeoplePropertyDomain.class, "samLowPeoplePropertyDomain/samLowPeoplePropertyDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		SamLowPeopleProperty samLowPeopleProperty = (SamLowPeopleProperty) record.toBean(SamLowPeopleProperty.class);
		samLowPeoplePropertyDomain.insert(samLowPeopleProperty);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		SamLowPeopleProperty samLowPeopleProperty = (SamLowPeopleProperty) record.toBean(SamLowPeopleProperty.class);
		samLowPeoplePropertyDomain.update(samLowPeopleProperty);
	}
	
	// 删除
	public void delete() {
		String propertyId = (String) getParameter("propertyId");
		samLowPeoplePropertyDomain.delete(propertyId);
	}
	
}