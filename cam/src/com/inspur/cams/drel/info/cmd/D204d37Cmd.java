package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.data.D204d37;
import com.inspur.cams.drel.info.domain.ID204d37Domain;

/**
 * 地税-法人纳税信息cmd
 * @author 
 * @date 2014-08-26
 */
public class D204d37Cmd extends BaseAjaxCommand {

	private ID204d37Domain d204d37Domain = ScaComponentFactory
			.getService(ID204d37Domain.class, "d204d37Domain/d204d37Domain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		D204d37 d204d37 = (D204d37) record.toBean(D204d37.class);
		d204d37Domain.insert(d204d37);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		D204d37 d204d37 = (D204d37) record.toBean(D204d37.class);
		d204d37Domain.update(d204d37);
	}
	
	// 删除
	public void delete() {
		String d204d37Id = (String) getParameter("d204d37Id");
		d204d37Domain.delete(d204d37Id);
	}
	
}