package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.data.D204z62;
import com.inspur.cams.drel.info.domain.ID204z62Domain;

/**
 * 殡葬信息cmd
 * @author 
 * @date 2014-08-21
 */
public class D204z62Cmd extends BaseAjaxCommand {

	private ID204z62Domain d204z62Domain = ScaComponentFactory
			.getService(ID204z62Domain.class, "d204z62Domain/d204z62Domain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		D204z62 d204z62 = (D204z62) record.toBean(D204z62.class);
		d204z62Domain.insert(d204z62);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		D204z62 d204z62 = (D204z62) record.toBean(D204z62.class);
		d204z62Domain.update(d204z62);
	}
	
	// 删除
	public void delete() {
		String d204z62Id = (String) getParameter("d204z62Id");
		d204z62Domain.delete(d204z62Id);
	}
	
}