package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.data.D204b11;
import com.inspur.cams.drel.info.domain.ID204b11Domain;

/**
 * 工资性收入cmd
 * @author 
 * @date 2014-06-09
 */
public class D204b11Cmd extends BaseAjaxCommand {

	private ID204b11Domain d204b11Domain = ScaComponentFactory
			.getService(ID204b11Domain.class, "d204b11Domain/d204b11Domain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		D204b11 d204b11 = (D204b11) record.toBean(D204b11.class);
		d204b11Domain.insert(d204b11);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		D204b11 d204b11 = (D204b11) record.toBean(D204b11.class);
		d204b11Domain.update(d204b11);
	}
	
	// 删除
	public void delete() {
		String d204b11Id = (String) getParameter("d204b11Id");
		d204b11Domain.delete(d204b11Id);
	}
	
}