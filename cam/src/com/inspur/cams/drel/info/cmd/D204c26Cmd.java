package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.data.D204c26;
import com.inspur.cams.drel.info.domain.ID204c26Domain;

/**
 * 商业保险cmd
 * @author 
 * @date 2014-06-09
 */
public class D204c26Cmd extends BaseAjaxCommand {

	private ID204c26Domain d204c26Domain = ScaComponentFactory
			.getService(ID204c26Domain.class, "d204c26Domain/d204c26Domain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		D204c26 d204c26 = (D204c26) record.toBean(D204c26.class);
		d204c26Domain.insert(d204c26);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		D204c26 d204c26 = (D204c26) record.toBean(D204c26.class);
		d204c26Domain.update(d204c26);
	}
	
	// 删除
	public void delete() {
		String d204c26Id = (String) getParameter("d204c26Id");
		d204c26Domain.delete(d204c26Id);
	}
	// 完成比对，录入数据
	public void insertFromTemp() {
		Record[] records = (Record[]) getParameter("records");
		d204c26Domain.insertFromTemp(records);
	}
	// 完成比对，批量录入数据
	public void batchInsertFromTemp() {
		ParameterSet pset = getParameterSet();
		d204c26Domain.batchInsertFromTemp(pset);
	}
}