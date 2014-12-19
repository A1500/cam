package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.data.D204d31;
import com.inspur.cams.drel.info.domain.ID204d31Domain;

/**
 * 公共事业缴费cmd
 * @author 
 * @date 2014-06-09
 */
public class D204d31Cmd extends BaseAjaxCommand {

	private ID204d31Domain d204d31Domain = ScaComponentFactory
			.getService(ID204d31Domain.class, "d204d31Domain/d204d31Domain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		D204d31 d204d31 = (D204d31) record.toBean(D204d31.class);
		d204d31Domain.insert(d204d31);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		D204d31 d204d31 = (D204d31) record.toBean(D204d31.class);
		d204d31Domain.update(d204d31);
	}
	
	// 删除
	public void delete() {
		String d204d31Id = (String) getParameter("d204d31Id");
		d204d31Domain.delete(d204d31Id);
	}
	
}