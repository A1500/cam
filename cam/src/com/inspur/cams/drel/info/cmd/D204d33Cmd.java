package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.data.D204d33;
import com.inspur.cams.drel.info.domain.ID204d33Domain;

/**
 * 纳税情况cmd
 * @author 
 * @date 2014-06-09
 */
public class D204d33Cmd extends BaseAjaxCommand {

	private ID204d33Domain d204d33Domain = ScaComponentFactory
			.getService(ID204d33Domain.class, "d204d33Domain/d204d33Domain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		D204d33 d204d33 = (D204d33) record.toBean(D204d33.class);
		d204d33Domain.insert(d204d33);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		D204d33 d204d33 = (D204d33) record.toBean(D204d33.class);
		d204d33Domain.update(d204d33);
	}
	
	// 删除
	public void delete() {
		String d204d33Id = (String) getParameter("d204d33Id");
		d204d33Domain.delete(d204d33Id);
	}
	
}