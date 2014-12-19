package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.data.D204z63;
import com.inspur.cams.drel.info.domain.ID204z63Domain;


/**
 * 婚姻信息cmd
 * @author 
 * @date 2014-08-21
 */
public class D204z63Cmd extends BaseAjaxCommand {

	private ID204z63Domain d204z63Domain = ScaComponentFactory
			.getService(ID204z63Domain.class, "d204z63Domain/d204z63Domain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		D204z63 d204z63 = (D204z63) record.toBean(D204z63.class);
		d204z63Domain.insert(d204z63);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		D204z63 d204z63 = (D204z63) record.toBean(D204z63.class);
		d204z63Domain.update(d204z63);
	}
	
	// 删除
	public void delete() {
		String d204z63Id = (String) getParameter("d204z63Id");
		d204z63Domain.delete(d204z63Id);
	}
	
}