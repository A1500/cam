package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.data.D204c21Die;
import com.inspur.cams.drel.info.domain.ID204c21DieDomain;

/**
 * 户籍注销cmd
 * @author
 * @date 2014-06-09
 */
public class D204c21DieCmd extends BaseAjaxCommand {

	private ID204c21DieDomain d204c21DieDomain = ScaComponentFactory
			.getService(ID204c21DieDomain.class, "d204c21DieDomain/d204c21DieDomain");

	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		D204c21Die d204c21Die = (D204c21Die) record.toBean(D204c21Die.class);
		d204c21DieDomain.insert(d204c21Die);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		D204c21Die d204c21Die = (D204c21Die) record.toBean(D204c21Die.class);
		d204c21DieDomain.update(d204c21Die);
	}

	// 删除
	public void delete() {
		String d204c21DieId = (String) getParameter("d204c21DieId");
		d204c21DieDomain.delete(d204c21DieId);
	}
	// 完成比对，录入数据
	public void insertFromTemp() {
		Record[] records = (Record[]) getParameter("records");
		d204c21DieDomain.insertFromTemp(records);
	}
	// 完成比对，批量录入数据
	public void batchInsertFromTemp() {
		ParameterSet pset = getParameterSet();
		d204c21DieDomain.batchInsertFromTemp(pset);
	}
}