package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.data.D204b12;
import com.inspur.cams.drel.info.domain.ID204b12Domain;

/**
 * 经营性收入cmd
 * @author 
 * @date 2014-06-09
 */
public class D204b12Cmd extends BaseAjaxCommand {

	private ID204b12Domain d204b12Domain = ScaComponentFactory
			.getService(ID204b12Domain.class, "d204b12Domain/d204b12Domain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		D204b12 d204b12 = (D204b12) record.toBean(D204b12.class);
		d204b12Domain.insert(d204b12);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		D204b12 d204b12 = (D204b12) record.toBean(D204b12.class);
		d204b12Domain.update(d204b12);
	}
	
	// 删除
	public void delete() {
		String d204b12Id = (String) getParameter("d204b12Id");
		d204b12Domain.delete(d204b12Id);
	}
	
}