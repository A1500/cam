package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.data.FisCemeLogoff;
import com.inspur.cams.fis.base.domain.IFisCemeLogoffDomain;

/**
 * 公墓撤销备案表cmd
 * @author 
 * @date 2013-08-01
 */
public class FisCemeLogoffCmd extends BaseAjaxCommand {

	private IFisCemeLogoffDomain fisCemeLogoffDomain = ScaComponentFactory
			.getService(IFisCemeLogoffDomain.class, "fisCemeLogoffDomain/fisCemeLogoffDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		FisCemeLogoff fisCemeLogoff = (FisCemeLogoff) record.toBean(FisCemeLogoff.class);
		fisCemeLogoffDomain.insert(fisCemeLogoff);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		FisCemeLogoff fisCemeLogoff = (FisCemeLogoff) record.toBean(FisCemeLogoff.class);
		fisCemeLogoffDomain.update(fisCemeLogoff);
	}
	
	// 删除
	public void delete() {
		String logoffId = (String) getParameter("logoffId");
		fisCemeLogoffDomain.delete(logoffId);
	}
	
}