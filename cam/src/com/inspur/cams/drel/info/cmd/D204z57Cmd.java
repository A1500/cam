package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.data.D204z57;
import com.inspur.cams.drel.info.domain.ID204z57Domain;

/**
 * 财政供养人员工资信息cmd
 * @author 
 * @date 2014-06-09
 */
public class D204z57Cmd extends BaseAjaxCommand {

	private ID204z57Domain d204z57Domain = ScaComponentFactory
			.getService(ID204z57Domain.class, "d204z57Domain/d204z57Domain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		D204z57 d204z57 = (D204z57) record.toBean(D204z57.class);
		d204z57Domain.insert(d204z57);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		D204z57 d204z57 = (D204z57) record.toBean(D204z57.class);
		d204z57Domain.update(d204z57);
	}
	
	// 删除
	public void delete() {
		String d204z57Id = (String) getParameter("d204z57Id");
		d204z57Domain.delete(d204z57Id);
	}
	
}