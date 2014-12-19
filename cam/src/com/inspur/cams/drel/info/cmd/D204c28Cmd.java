package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.data.D204c28;
import com.inspur.cams.drel.info.domain.ID204c28Domain;

/**
 * 期货cmd
 * @author 
 * @date 2014-06-09
 */
public class D204c28Cmd extends BaseAjaxCommand {

	private ID204c28Domain d204c28Domain = ScaComponentFactory
			.getService(ID204c28Domain.class, "d204c28Domain/d204c28Domain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		D204c28 d204c28 = (D204c28) record.toBean(D204c28.class);
		d204c28Domain.insert(d204c28);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		D204c28 d204c28 = (D204c28) record.toBean(D204c28.class);
		d204c28Domain.update(d204c28);
	}
	
	// 删除
	public void delete() {
		String d204c28Id = (String) getParameter("d204c28Id");
		d204c28Domain.delete(d204c28Id);
	}
	// 完成比对，录入数据
	public void insertFromTemp() {
		Record[] records = (Record[]) getParameter("records");
		d204c28Domain.insertFromTemp(records);
	}
	// 完成比对，批量录入数据
	public void batchInsertFromTemp() {
		ParameterSet pset = getParameterSet();
		d204c28Domain.batchInsertFromTemp(pset);
	}
}