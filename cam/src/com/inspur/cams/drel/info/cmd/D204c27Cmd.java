package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.data.D204c27;
import com.inspur.cams.drel.info.domain.ID204c27Domain;

/**
 * 券商cmd
 * @author 
 * @date 2014-06-09
 */
public class D204c27Cmd extends BaseAjaxCommand {

	private ID204c27Domain d204c27Domain = ScaComponentFactory
			.getService(ID204c27Domain.class, "d204c27Domain/d204c27Domain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		D204c27 d204c27 = (D204c27) record.toBean(D204c27.class);
		d204c27Domain.insert(d204c27);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		D204c27 d204c27 = (D204c27) record.toBean(D204c27.class);
		d204c27Domain.update(d204c27);
	}
	
	// 删除
	public void delete() {
		String d204c27Id = (String) getParameter("d204c27Id");
		d204c27Domain.delete(d204c27Id);
	}
	// 完成比对，录入数据
	public void insertFromTemp() {
		Record[] records = (Record[]) getParameter("records");
		d204c27Domain.insertFromTemp(records);
	}
	// 完成比对，批量录入数据
	public void batchInsertFromTemp() {
		ParameterSet pset = getParameterSet();
		d204c27Domain.batchInsertFromTemp(pset);
	}
}