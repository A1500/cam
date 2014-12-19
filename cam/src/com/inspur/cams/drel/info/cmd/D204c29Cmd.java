package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.data.D204c29;
import com.inspur.cams.drel.info.domain.ID204c29Domain;

/**
 * 理财cmd
 * @author 
 * @date 2014-06-09
 */
public class D204c29Cmd extends BaseAjaxCommand {

	private ID204c29Domain d204c29Domain = ScaComponentFactory
			.getService(ID204c29Domain.class, "d204c29Domain/d204c29Domain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		D204c29 d204c29 = (D204c29) record.toBean(D204c29.class);
		d204c29Domain.insert(d204c29);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		D204c29 d204c29 = (D204c29) record.toBean(D204c29.class);
		d204c29Domain.update(d204c29);
	}
	
	// 删除
	public void delete() {
		String d204c29Id = (String) getParameter("d204c29Id");
		d204c29Domain.delete(d204c29Id);
	}
	// 完成比对，录入数据
	public void insertFromTemp() {
		Record[] records = (Record[]) getParameter("records");
		d204c29Domain.insertFromTemp(records);
	}
	// 完成比对，批量录入数据
	public void batchInsertFromTemp() {
		ParameterSet pset = getParameterSet();
		d204c29Domain.batchInsertFromTemp(pset);
	}
}