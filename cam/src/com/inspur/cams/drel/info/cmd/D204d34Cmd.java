package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.data.D204d34;
import com.inspur.cams.drel.info.domain.ID204d34Domain;

/**
 * 公积金缴纳情况cmd
 * @author 
 * @date 2014-06-09
 */
public class D204d34Cmd extends BaseAjaxCommand {

	private ID204d34Domain d204d34Domain = ScaComponentFactory
			.getService(ID204d34Domain.class, "d204d34Domain/d204d34Domain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		D204d34 d204d34 = (D204d34) record.toBean(D204d34.class);
		d204d34Domain.insert(d204d34);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		D204d34 d204d34 = (D204d34) record.toBean(D204d34.class);
		d204d34Domain.update(d204d34);
	}
	
	// 删除
	public void delete() {
		String d204d34Id = (String) getParameter("d204d34Id");
		d204d34Domain.delete(d204d34Id);
	}
	// 完成比对，录入数据
	public void insertFromTemp() {
		Record[] records = (Record[]) getParameter("records");
		d204d34Domain.insertFromTemp(records);
	}
	// 完成比对，批量录入数据
	public void batchInsertFromTemp() {
		ParameterSet pset = getParameterSet();
		d204d34Domain.batchInsertFromTemp(pset);
	}
}