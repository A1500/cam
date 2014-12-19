package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.data.D204a03;
import com.inspur.cams.drel.info.domain.ID204a03Domain;

/**
 * 家庭基本信息cmd
 * @author 
 * @date 2014-06-09
 */
public class D204a03Cmd extends BaseAjaxCommand {

	private ID204a03Domain d204a03Domain = ScaComponentFactory
			.getService(ID204a03Domain.class, "d204a03Domain/d204a03Domain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		D204a03 d204a03 = (D204a03) record.toBean(D204a03.class);
		d204a03Domain.insert(d204a03);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		D204a03 d204a03 = (D204a03) record.toBean(D204a03.class);
		d204a03Domain.update(d204a03);
	}
	
	// 删除
	public void delete() {
		String familiyId = (String) getParameter("familiyId");
		d204a03Domain.delete(familiyId);
	}
	// 完成比对，录入数据
	public void insertFromTemp() {
		Record[] records = (Record[]) getParameter("records");
		d204a03Domain.insertFromTemp(records);
	}
	// 完成比对，批量录入数据
	public void batchInsertFromTemp() {
		ParameterSet pset = getParameterSet();
		d204a03Domain.batchInsertFromTemp(pset);
	}
}