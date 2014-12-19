package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.data.D204z61;
import com.inspur.cams.drel.info.domain.ID204z61Domain;

/**
 * 船舶信息cmd
 * @author 
 * @date 2014-06-09
 */
public class D204z61Cmd extends BaseAjaxCommand {

	private ID204z61Domain d204z61Domain = ScaComponentFactory
			.getService(ID204z61Domain.class, "d204z61Domain/d204z61Domain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		D204z61 d204z61 = (D204z61) record.toBean(D204z61.class);
		d204z61Domain.insert(d204z61);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		D204z61 d204z61 = (D204z61) record.toBean(D204z61.class);
		d204z61Domain.update(d204z61);
	}
	
	// 删除
	public void delete() {
		String d204z61Id = (String) getParameter("d204z61Id");
		d204z61Domain.delete(d204z61Id);
	}
	
}