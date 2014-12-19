package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.data.D204d39;
import com.inspur.cams.drel.info.domain.ID204d39Domain;

/**
 * 地税-投资方纳税信息cmd
 * @author 
 * @date 2014-08-26
 */
public class D204d39Cmd extends BaseAjaxCommand {

	private ID204d39Domain d204d39Domain = ScaComponentFactory
			.getService(ID204d39Domain.class, "d204d39Domain/d204d39Domain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		D204d39 d204d39 = (D204d39) record.toBean(D204d39.class);
		d204d39Domain.insert(d204d39);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		D204d39 d204d39 = (D204d39) record.toBean(D204d39.class);
		d204d39Domain.update(d204d39);
	}
	
	// 删除
	public void delete() {
		String d204d39Id = (String) getParameter("d204d39Id");
		d204d39Domain.delete(d204d39Id);
	}
	
}