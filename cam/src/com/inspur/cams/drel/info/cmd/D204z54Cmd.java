package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.data.D204z54;
import com.inspur.cams.drel.info.domain.ID204z54Domain;

/**
 * 社会组织管理信息cmd
 * @author 
 * @date 2014-06-09
 */
public class D204z54Cmd extends BaseAjaxCommand {

	private ID204z54Domain d204z54Domain = ScaComponentFactory
			.getService(ID204z54Domain.class, "d204z54Domain/d204z54Domain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		D204z54 d204z54 = (D204z54) record.toBean(D204z54.class);
		d204z54Domain.insert(d204z54);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		D204z54 d204z54 = (D204z54) record.toBean(D204z54.class);
		d204z54Domain.update(d204z54);
	}
	
	// 删除
	public void delete() {
		String d204z54Id = (String) getParameter("d204z54Id");
		d204z54Domain.delete(d204z54Id);
	}
	// 完成比对，录入数据
	public void insertFromTemp() {
		Record[] records = (Record[]) getParameter("records");
		d204z54Domain.insertFromTemp(records);
	}
	// 完成比对，批量录入数据
	public void batchInsertFromTemp() {
		ParameterSet pset = getParameterSet();
		d204z54Domain.batchInsertFromTemp(pset);
	}
}