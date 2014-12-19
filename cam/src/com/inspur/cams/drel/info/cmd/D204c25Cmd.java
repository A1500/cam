package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.data.D204c25;
import com.inspur.cams.drel.info.domain.ID204c25Domain;

/**
 * 基金cmd
 * @author 
 * @date 2014-06-09
 */
public class D204c25Cmd extends BaseAjaxCommand {

	private ID204c25Domain d204c25Domain = ScaComponentFactory
			.getService(ID204c25Domain.class, "d204c25Domain/d204c25Domain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		D204c25 d204c25 = (D204c25) record.toBean(D204c25.class);
		d204c25Domain.insert(d204c25);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		D204c25 d204c25 = (D204c25) record.toBean(D204c25.class);
		d204c25Domain.update(d204c25);
	}
	
	// 删除
	public void delete() {
		String d204c25Id = (String) getParameter("d204c25Id");
		d204c25Domain.delete(d204c25Id);
	}
	// 完成比对，录入数据
	public void insertFromTemp() {
		Record[] records = (Record[]) getParameter("records");
		d204c25Domain.insertFromTemp(records);
	}
	// 完成比对，批量录入数据
	public void batchInsertFromTemp() {
		ParameterSet pset = getParameterSet();
		d204c25Domain.batchInsertFromTemp(pset);
	}
}