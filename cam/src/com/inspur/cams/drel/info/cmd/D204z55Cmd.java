package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.data.D204z55;
import com.inspur.cams.drel.info.domain.ID204z55Domain;

/**
 * 优待抚恤信息cmd
 * @author 
 * @date 2014-06-09
 */
public class D204z55Cmd extends BaseAjaxCommand {

	private ID204z55Domain d204z55Domain = ScaComponentFactory
			.getService(ID204z55Domain.class, "d204z55Domain/d204z55Domain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		D204z55 d204z55 = (D204z55) record.toBean(D204z55.class);
		d204z55Domain.insert(d204z55);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		D204z55 d204z55 = (D204z55) record.toBean(D204z55.class);
		d204z55Domain.update(d204z55);
	}
	
	// 删除
	public void delete() {
		String d204z55Id = (String) getParameter("d204z55Id");
		d204z55Domain.delete(d204z55Id);
	}
	// 完成比对，录入数据
	public void insertFromTemp() {
		Record[] records = (Record[]) getParameter("records");
		d204z55Domain.insertFromTemp(records);
	}
	// 完成比对，批量录入数据
	public void batchInsertFromTemp() {
		ParameterSet pset = getParameterSet();
		d204z55Domain.batchInsertFromTemp(pset);
	}
}