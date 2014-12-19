package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.data.D204z56;
import com.inspur.cams.drel.info.domain.ID204z56Domain;

/**
 * 核对统计信息cmd
 * @author 
 * @date 2014-06-09
 */
public class D204z56Cmd extends BaseAjaxCommand {

	private ID204z56Domain d204z56Domain = ScaComponentFactory
			.getService(ID204z56Domain.class, "d204z56Domain/d204z56Domain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		D204z56 d204z56 = (D204z56) record.toBean(D204z56.class);
		d204z56Domain.insert(d204z56);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		D204z56 d204z56 = (D204z56) record.toBean(D204z56.class);
		d204z56Domain.update(d204z56);
	}
	
	// 删除
	public void delete() {
		String d204z56Id = (String) getParameter("d204z56Id");
		d204z56Domain.delete(d204z56Id);
	}
	
}