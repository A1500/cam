package com.inspur.cams.drel.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.base.data.DrelStandingbook;
import com.inspur.cams.drel.base.domain.IDrelStandingbookDomain;

/**
 * 台账表cmd
 * @author 
 * @date 2013-09-09
 */
public class DrelStandingbookCmd extends BaseAjaxCommand {

	private IDrelStandingbookDomain drelStandingbookDomain = ScaComponentFactory
			.getService(IDrelStandingbookDomain.class, "drelStandingbookDomain/drelStandingbookDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		DrelStandingbook drelStandingbook = (DrelStandingbook) record.toBean(DrelStandingbook.class);
		drelStandingbookDomain.insert(drelStandingbook);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		DrelStandingbook drelStandingbook = (DrelStandingbook) record.toBean(DrelStandingbook.class);
		drelStandingbookDomain.update(drelStandingbook);
	}
	
	// 删除
	public void delete() {
		String domicileCode = (String) getParameter("domicileCode");
		drelStandingbookDomain.delete(domicileCode);
	}
	
}