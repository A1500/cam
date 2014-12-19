package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.data.D204a04;
import com.inspur.cams.drel.info.domain.ID204a04Domain;

/**
 * 区划信息cmd
 * @author 
 * @date 2014-06-09
 */
public class D204a04Cmd extends BaseAjaxCommand {

	private ID204a04Domain d204a04Domain = ScaComponentFactory
			.getService(ID204a04Domain.class, "d204a04Domain/d204a04Domain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		D204a04 d204a04 = (D204a04) record.toBean(D204a04.class);
		d204a04Domain.insert(d204a04);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		D204a04 d204a04 = (D204a04) record.toBean(D204a04.class);
		d204a04Domain.update(d204a04);
	}
	
	// 删除
	public void delete() {
		String d204a04Id = (String) getParameter("d204a04Id");
		d204a04Domain.delete(d204a04Id);
	}
	
}