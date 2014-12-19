package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.data.D204a01;
import com.inspur.cams.drel.info.domain.ID204a01Domain;

/**
 * 成员信息cmd
 * @author 
 * @date 2014-06-09
 */
public class D204a01Cmd extends BaseAjaxCommand {

	private ID204a01Domain d204a01Domain = ScaComponentFactory
			.getService(ID204a01Domain.class, "d204a01Domain/d204a01Domain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		D204a01 d204a01 = (D204a01) record.toBean(D204a01.class);
		d204a01Domain.insert(d204a01);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		D204a01 d204a01 = (D204a01) record.toBean(D204a01.class);
		d204a01Domain.update(d204a01);
	}
	
	// 删除
	public void delete() {
		String peopleId = (String) getParameter("peopleId");
		d204a01Domain.delete(peopleId);
	}
	// 删除家庭成员及其详细信息
	public void deletePersonAndInfo() {
		ParameterSet pset = getParameterSet();
		d204a01Domain.deletePersonAndInfo(pset);
	}
	// 完成比对，录入数据
	public void insertFromTemp() {
		Record[] records = (Record[]) getParameter("records");
		d204a01Domain.insertFromTemp(records);
	}
	// 完成比对，批量录入数据
	public void batchInsertFromTemp() {
		ParameterSet pset = getParameterSet();
		d204a01Domain.batchInsertFromTemp(pset);
	}
}