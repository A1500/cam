package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.data.D204a02;
import com.inspur.cams.drel.info.domain.ID204a02Domain;

/**
 * 家庭成员就业信息cmd
 * @author 
 * @date 2014-06-09
 */
public class D204a02Cmd extends BaseAjaxCommand {

	private ID204a02Domain d204a02Domain = ScaComponentFactory
			.getService(ID204a02Domain.class, "d204a02Domain/d204a02Domain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		D204a02 d204a02 = (D204a02) record.toBean(D204a02.class);
		d204a02Domain.insert(d204a02);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		D204a02 d204a02 = (D204a02) record.toBean(D204a02.class);
		d204a02Domain.update(d204a02);
	}
	
	// 删除
	public void delete() {
		String d204a02Id = (String) getParameter("d204a02Id");
		d204a02Domain.delete(d204a02Id);
	}
	
}