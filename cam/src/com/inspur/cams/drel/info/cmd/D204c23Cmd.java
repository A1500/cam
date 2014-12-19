package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.data.D204c23;
import com.inspur.cams.drel.info.domain.ID204c23Domain;

/**
 * 存款cmd
 * @author 
 * @date 2014-06-09
 */
public class D204c23Cmd extends BaseAjaxCommand {

	private ID204c23Domain d204c23Domain = ScaComponentFactory
			.getService(ID204c23Domain.class, "d204c23Domain/d204c23Domain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		D204c23 d204c23 = (D204c23) record.toBean(D204c23.class);
		d204c23Domain.insert(d204c23);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		D204c23 d204c23 = (D204c23) record.toBean(D204c23.class);
		d204c23Domain.update(d204c23);
	}
	
	// 删除
	public void delete() {
		String d204c23Id = (String) getParameter("d204c23Id");
		d204c23Domain.delete(d204c23Id);
	}
	// 完成比对，录入数据
	public void insertFromTemp() {
		Record[] records = (Record[]) getParameter("records");
		d204c23Domain.insertFromTemp(records);
	}
	// 完成比对，批量录入数据
	public void batchInsertFromTemp() {
		ParameterSet pset = getParameterSet();
		d204c23Domain.batchInsertFromTemp(pset);
	}
}