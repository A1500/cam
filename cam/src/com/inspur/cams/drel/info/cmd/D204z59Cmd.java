package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.data.D204z59;
import com.inspur.cams.drel.info.domain.ID204z59Domain;

/**
 * 新农合信息cmd
 * @author 
 * @date 2014-06-09
 */
public class D204z59Cmd extends BaseAjaxCommand {

	private ID204z59Domain d204z59Domain = ScaComponentFactory
			.getService(ID204z59Domain.class, "d204z59Domain/d204z59Domain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		D204z59 d204z59 = (D204z59) record.toBean(D204z59.class);
		d204z59Domain.insert(d204z59);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		D204z59 d204z59 = (D204z59) record.toBean(D204z59.class);
		d204z59Domain.update(d204z59);
	}
	
	// 删除
	public void delete() {
		String d204z59Id = (String) getParameter("d204z59Id");
		d204z59Domain.delete(d204z59Id);
	}
	
}