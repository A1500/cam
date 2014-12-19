package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.data.FisCemeExpendInfo;
import com.inspur.cams.fis.base.domain.IFisCemeExpendInfoDomain;

/**
 * cmd
 * @author 
 * @date 2013-09-29
 */
public class FisCemeExpendInfoCmd extends BaseAjaxCommand {

	private IFisCemeExpendInfoDomain fisCemeExpendInfoDomain = ScaComponentFactory
			.getService(IFisCemeExpendInfoDomain.class, "fisCemeExpendInfoDomain/fisCemeExpendInfoDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		FisCemeExpendInfo fisCemeExpendInfo = (FisCemeExpendInfo) record.toBean(FisCemeExpendInfo.class);
		fisCemeExpendInfoDomain.insert(fisCemeExpendInfo);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		FisCemeExpendInfo fisCemeExpendInfo = (FisCemeExpendInfo) record.toBean(FisCemeExpendInfo.class);
		fisCemeExpendInfoDomain.update(fisCemeExpendInfo);
	}
	
	// 删除
	public void delete() {
		String recordId = (String) getParameter("recordId");
		fisCemeExpendInfoDomain.delete(recordId);
	}
	
}