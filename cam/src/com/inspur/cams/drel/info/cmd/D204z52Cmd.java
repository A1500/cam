package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.data.D204z52;
import com.inspur.cams.drel.info.domain.ID204z52Domain;

/**
 * 救助信息cmd
 * @author 
 * @date 2014-06-09
 */
public class D204z52Cmd extends BaseAjaxCommand {

	private ID204z52Domain d204z52Domain = ScaComponentFactory
			.getService(ID204z52Domain.class, "d204z52Domain/d204z52Domain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		D204z52 d204z52 = (D204z52) record.toBean(D204z52.class);
		d204z52Domain.insert(d204z52);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		D204z52 d204z52 = (D204z52) record.toBean(D204z52.class);
		d204z52Domain.update(d204z52);
	}
	
	// 删除
	public void delete() {
		String d204z52Id = (String) getParameter("d204z52Id");
		d204z52Domain.delete(d204z52Id);
	}
	// 完成比对，录入数据
	public void insertFromTemp() {
		Record[] records = (Record[]) getParameter("records");
		d204z52Domain.insertFromTemp(records);
	}
	// 完成比对，批量录入数据
	public void batchInsertFromTemp() {
		ParameterSet pset = getParameterSet();
		d204z52Domain.batchInsertFromTemp(pset);
	}
}