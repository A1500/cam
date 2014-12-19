package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.data.D204d32;
import com.inspur.cams.drel.info.domain.ID204d32Domain;

/**
 * 社会保险缴费cmd
 * @author 
 * @date 2014-06-09
 */
public class D204d32Cmd extends BaseAjaxCommand {

	private ID204d32Domain d204d32Domain = ScaComponentFactory
			.getService(ID204d32Domain.class, "d204d32Domain/d204d32Domain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		D204d32 d204d32 = (D204d32) record.toBean(D204d32.class);
		d204d32Domain.insert(d204d32);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		D204d32 d204d32 = (D204d32) record.toBean(D204d32.class);
		d204d32Domain.update(d204d32);
	}
	
	// 删除
	public void delete() {
		String d204d32Id = (String) getParameter("d204d32Id");
		d204d32Domain.delete(d204d32Id);
	}
	// 完成比对，录入数据
	public void insertFromTemp() {
		Record[] records = (Record[]) getParameter("records");
		d204d32Domain.insertFromTemp(records);
	}
	// 完成比对，批量录入数据
	public void batchInsertFromTemp() {
		ParameterSet pset = getParameterSet();
		d204d32Domain.batchInsertFromTemp(pset);
	}
}