package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.data.D204z58;
import com.inspur.cams.drel.info.domain.ID204z58Domain;

/**
 * 涉农信息cmd
 * @author 
 * @date 2014-06-09
 */
public class D204z58Cmd extends BaseAjaxCommand {

	private ID204z58Domain d204z58Domain = ScaComponentFactory
			.getService(ID204z58Domain.class, "d204z58Domain/d204z58Domain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		D204z58 d204z58 = (D204z58) record.toBean(D204z58.class);
		d204z58Domain.insert(d204z58);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		D204z58 d204z58 = (D204z58) record.toBean(D204z58.class);
		d204z58Domain.update(d204z58);
	}
	
	// 删除
	public void delete() {
		String d204z58Id = (String) getParameter("d204z58Id");
		d204z58Domain.delete(d204z58Id);
	}
	
}