package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.data.D204c30;
import com.inspur.cams.drel.info.domain.ID204c30Domain;

/**
 * 贵金属cmd
 * @author 
 * @date 2014-06-09
 */
public class D204c30Cmd extends BaseAjaxCommand {

	private ID204c30Domain d204c30Domain = ScaComponentFactory
			.getService(ID204c30Domain.class, "d204c30Domain/d204c30Domain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		D204c30 d204c30 = (D204c30) record.toBean(D204c30.class);
		d204c30Domain.insert(d204c30);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		D204c30 d204c30 = (D204c30) record.toBean(D204c30.class);
		d204c30Domain.update(d204c30);
	}
	
	// 删除
	public void delete() {
		String d204c30Id = (String) getParameter("d204c30Id");
		d204c30Domain.delete(d204c30Id);
	}
	// 完成比对，录入数据
	public void insertFromTemp() {
		Record[] records = (Record[]) getParameter("records");
		d204c30Domain.insertFromTemp(records);
	}
	// 完成比对，批量录入数据
	public void batchInsertFromTemp() {
		ParameterSet pset = getParameterSet();
		d204c30Domain.batchInsertFromTemp(pset);
	}
}