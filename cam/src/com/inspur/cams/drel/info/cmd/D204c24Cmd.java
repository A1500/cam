package com.inspur.cams.drel.info.cmd;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.data.D204c22;
import com.inspur.cams.drel.info.data.D204c24;
import com.inspur.cams.drel.info.domain.ID204c24Domain;

/**
 * 股票cmd
 * @author 
 * @date 2014-06-09
 */
public class D204c24Cmd extends BaseAjaxCommand {

	private ID204c24Domain d204c24Domain = ScaComponentFactory
			.getService(ID204c24Domain.class, "d204c24Domain/d204c24Domain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		D204c24 d204c24 = (D204c24) record.toBean(D204c24.class);
		d204c24Domain.insert(d204c24);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		D204c24 d204c24 = (D204c24) record.toBean(D204c24.class);
		d204c24Domain.update(d204c24);
	}
	
	// 删除
	public void delete() {
		String d204c24Id = (String) getParameter("d204c24Id");
		d204c24Domain.delete(d204c24Id);
	}
	// 完成比对，录入数据
	public void insertFromTemp() {
		Record[] records = (Record[]) getParameter("records");
		d204c24Domain.insertFromTemp(records);
	}
	// 完成比对，批量录入数据
	public void batchInsertFromTemp() {
		ParameterSet pset = getParameterSet();
		d204c24Domain.batchInsertFromTemp(pset);
	}
}