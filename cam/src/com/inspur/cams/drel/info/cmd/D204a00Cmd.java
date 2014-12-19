package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.data.D204a00;
import com.inspur.cams.drel.info.domain.ID204a00Domain;

/**
 * 核对总体情况cmd
 * @author 
 * @date 2014-06-09
 */
public class D204a00Cmd extends BaseAjaxCommand {

	private ID204a00Domain d204a00Domain = ScaComponentFactory
			.getService(ID204a00Domain.class, "d204a00Domain/d204a00Domain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		D204a00 d204a00 = (D204a00) record.toBean(D204a00.class);
		d204a00Domain.insert(d204a00);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		D204a00 d204a00 = (D204a00) record.toBean(D204a00.class);
		d204a00Domain.update(d204a00);
	}
	
	// 删除
	public void delete() {
		String d204a00Id = (String) getParameter("d204a00Id");
		d204a00Domain.delete(d204a00Id);
	}
	
}