package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.data.D204c21;
import com.inspur.cams.drel.info.domain.ID204c21Domain;

/**
 * 车辆cmd
 * @author 
 * @date 2014-06-09
 */
public class D204c21Cmd extends BaseAjaxCommand {

	private ID204c21Domain d204c21Domain = ScaComponentFactory
			.getService(ID204c21Domain.class, "d204c21Domain/d204c21Domain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		D204c21 d204c21 = (D204c21) record.toBean(D204c21.class);
		d204c21Domain.insert(d204c21);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		D204c21 d204c21 = (D204c21) record.toBean(D204c21.class);
		d204c21Domain.update(d204c21);
	}
	
	// 删除
	public void delete() {
		String d204c21Id = (String) getParameter("d204c21Id");
		d204c21Domain.delete(d204c21Id);
	}
	// 完成比对，录入数据
	public void insertFromTemp() {
		Record[] records = (Record[]) getParameter("records");
		d204c21Domain.insertFromTemp(records);
	}
	// 完成比对，批量录入数据
	public void batchInsertFromTemp() {
		ParameterSet pset = getParameterSet();
		d204c21Domain.batchInsertFromTemp(pset);
	}
}