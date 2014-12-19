package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.data.D204d36;
import com.inspur.cams.drel.info.domain.ID204d36Domain;

/**
 * 大额支出cmd
 * @author 
 * @date 2014-06-09
 */
public class D204d36Cmd extends BaseAjaxCommand {

	private ID204d36Domain d204d36Domain = ScaComponentFactory
			.getService(ID204d36Domain.class, "d204d36Domain/d204d36Domain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		D204d36 d204d36 = (D204d36) record.toBean(D204d36.class);
		d204d36Domain.insert(d204d36);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		D204d36 d204d36 = (D204d36) record.toBean(D204d36.class);
		d204d36Domain.update(d204d36);
	}
	
	// 删除
	public void delete() {
		String d204d36Id = (String) getParameter("d204d36Id");
		d204d36Domain.delete(d204d36Id);
	}
	
}