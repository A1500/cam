package com.inspur.cams.drel.info.cmd;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.jfree.data.general.Dataset;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.check.base.domain.IdrelInfoQueryDomain;
import com.inspur.cams.drel.comm.util.BspExtUtil;
import com.inspur.cams.drel.info.data.D204c22;
import com.inspur.cams.drel.info.domain.ID204c22Domain;


/**
 * 房产cmd
 * @author 
 * @date 2014-06-09
 */
public class D204c22Cmd extends BaseAjaxCommand {

	private ID204c22Domain d204c22Domain = ScaComponentFactory
			.getService(ID204c22Domain.class, "d204c22Domain/d204c22Domain");
	private IdrelInfoQueryDomain infoDomain = ScaComponentFactory
			.getService(IdrelInfoQueryDomain.class, "drelInfoQueryDomain/drelInfoQueryDomain");
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		D204c22 d204c22 = (D204c22) record.toBean(D204c22.class);
		d204c22Domain.insert(d204c22);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		D204c22 d204c22 = (D204c22) record.toBean(D204c22.class);
		d204c22Domain.update(d204c22);
	}
	
	// 删除
	public void delete() {
		String d204c22Id = (String) getParameter("d204c22Id");
		d204c22Domain.delete(d204c22Id);
	}
	
	// 完成比对，录入数据
	public void insertFromTemp() {
		Record[] records = (Record[]) getParameter("records");
		d204c22Domain.insertFromTemp(records);
	}
	// 完成比对，批量录入数据
	public void batchInsertFromTemp() {
		ParameterSet pset = getParameterSet();
		d204c22Domain.batchInsertFromTemp(pset);
	}
}