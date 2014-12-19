package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.data.D204z60;
import com.inspur.cams.drel.info.domain.ID204z60Domain;

/**
 * 第三方支付信息cmd
 * @author 
 * @date 2014-06-09
 */
public class D204z60Cmd extends BaseAjaxCommand {

	private ID204z60Domain d204z60Domain = ScaComponentFactory
			.getService(ID204z60Domain.class, "d204z60Domain/d204z60Domain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		D204z60 d204z60 = (D204z60) record.toBean(D204z60.class);
		d204z60Domain.insert(d204z60);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		D204z60 d204z60 = (D204z60) record.toBean(D204z60.class);
		d204z60Domain.update(d204z60);
	}
	
	// 删除
	public void delete() {
		String d204z60Id = (String) getParameter("d204z60Id");
		d204z60Domain.delete(d204z60Id);
	}
	
}