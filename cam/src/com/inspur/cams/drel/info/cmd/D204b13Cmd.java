package com.inspur.cams.drel.info.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.info.data.D204b13;
import com.inspur.cams.drel.info.domain.ID204b13Domain;

/**
 * 财产性收入cmd
 * @author 
 * @date 2014-06-09
 */
public class D204b13Cmd extends BaseAjaxCommand {

	private ID204b13Domain d204b13Domain = ScaComponentFactory
			.getService(ID204b13Domain.class, "d204b13Domain/d204b13Domain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		D204b13 d204b13 = (D204b13) record.toBean(D204b13.class);
		d204b13Domain.insert(d204b13);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		D204b13 d204b13 = (D204b13) record.toBean(D204b13.class);
		d204b13Domain.update(d204b13);
	}
	
	// 删除
	public void delete() {
		String d204b13Id = (String) getParameter("d204b13Id");
		d204b13Domain.delete(d204b13Id);
	}
	
}