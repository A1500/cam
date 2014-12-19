package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.data.D204z51;
import com.inspur.cams.drel.info.domain.ID204z51Domain;

/**
 * 教育信息cmd
 * @author 
 * @date 2014-06-09
 */
public class D204z51Cmd extends BaseAjaxCommand {

	private ID204z51Domain d204z51Domain = ScaComponentFactory
			.getService(ID204z51Domain.class, "d204z51Domain/d204z51Domain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		D204z51 d204z51 = (D204z51) record.toBean(D204z51.class);
		d204z51Domain.insert(d204z51);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		D204z51 d204z51 = (D204z51) record.toBean(D204z51.class);
		d204z51Domain.update(d204z51);
	}
	
	// 删除
	public void delete() {
		String d204z51Id = (String) getParameter("d204z51Id");
		d204z51Domain.delete(d204z51Id);
	}
	
}