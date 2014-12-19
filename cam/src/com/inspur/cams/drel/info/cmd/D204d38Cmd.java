package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.data.D204d38;
import com.inspur.cams.drel.info.domain.ID204d38Domain;

/**
 * 地税-个人所得税cmd
 * @author 
 * @date 2014-08-26
 */
public class D204d38Cmd extends BaseAjaxCommand {

	private ID204d38Domain d204d38Domain = ScaComponentFactory
			.getService(ID204d38Domain.class, "d204d38Domain/d204d38Domain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		D204d38 d204d38 = (D204d38) record.toBean(D204d38.class);
		d204d38Domain.insert(d204d38);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		D204d38 d204d38 = (D204d38) record.toBean(D204d38.class);
		d204d38Domain.update(d204d38);
	}
	
	// 删除
	public void delete() {
		String d204d38Id = (String) getParameter("d204d38Id");
		d204d38Domain.delete(d204d38Id);
	}
	
}