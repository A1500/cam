package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.data.D204z53;
import com.inspur.cams.drel.info.domain.ID204z53Domain;

/**
 * 司法援助信息cmd
 * @author 
 * @date 2014-06-09
 */
public class D204z53Cmd extends BaseAjaxCommand {

	private ID204z53Domain d204z53Domain = ScaComponentFactory
			.getService(ID204z53Domain.class, "d204z53Domain/d204z53Domain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		D204z53 d204z53 = (D204z53) record.toBean(D204z53.class);
		d204z53Domain.insert(d204z53);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		D204z53 d204z53 = (D204z53) record.toBean(D204z53.class);
		d204z53Domain.update(d204z53);
	}
	
	// 删除
	public void delete() {
		String d204z53Id = (String) getParameter("d204z53Id");
		d204z53Domain.delete(d204z53Id);
	}
	
}