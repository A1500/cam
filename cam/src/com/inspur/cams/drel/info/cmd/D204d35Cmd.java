package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.data.D204d35;
import com.inspur.cams.drel.info.domain.ID204d35Domain;

/**
 * 大病支出cmd
 * @author 
 * @date 2014-06-09
 */
public class D204d35Cmd extends BaseAjaxCommand {

	private ID204d35Domain d204d35Domain = ScaComponentFactory
			.getService(ID204d35Domain.class, "d204d35Domain/d204d35Domain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		D204d35 d204d35 = (D204d35) record.toBean(D204d35.class);
		d204d35Domain.insert(d204d35);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		D204d35 d204d35 = (D204d35) record.toBean(D204d35.class);
		d204d35Domain.update(d204d35);
	}
	
	// 删除
	public void delete() {
		String d204d35Id = (String) getParameter("d204d35Id");
		d204d35Domain.delete(d204d35Id);
	}
	
}