package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.data.D204b14;
import com.inspur.cams.drel.info.domain.ID204b14Domain;

/**
 * 转移性收入cmd
 * @author 
 * @date 2014-06-09
 */
public class D204b14Cmd extends BaseAjaxCommand {

	private ID204b14Domain d204b14Domain = ScaComponentFactory
			.getService(ID204b14Domain.class, "d204b14Domain/d204b14Domain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		D204b14 d204b14 = (D204b14) record.toBean(D204b14.class);
		d204b14Domain.insert(d204b14);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		D204b14 d204b14 = (D204b14) record.toBean(D204b14.class);
		d204b14Domain.update(d204b14);
	}
	
	// 删除
	public void delete() {
		String d204b14Id = (String) getParameter("d204b14Id");
		d204b14Domain.delete(d204b14Id);
	}
	
}