package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.data.FisCemeInfo;
import com.inspur.cams.fis.base.domain.IFisCemeInfoDomain;

/**
 * 殡葬业务公墓信息表cmd
 * @author 
 * @date 2013-08-01
 */
public class FisCemeInfoCmd extends BaseAjaxCommand {

	private IFisCemeInfoDomain fisCemeInfoDomain = ScaComponentFactory
			.getService(IFisCemeInfoDomain.class, "fisCemeInfoDomain/fisCemeInfoDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		FisCemeInfo fisCemeInfo = (FisCemeInfo) record.toBean(FisCemeInfo.class);
		fisCemeInfoDomain.insert(fisCemeInfo);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		FisCemeInfo fisCemeInfo = (FisCemeInfo) record.toBean(FisCemeInfo.class);
		fisCemeInfoDomain.update(fisCemeInfo);
	}
	
	// 删除
	public void delete() {
		String recordId = (String) getParameter("recordId");
		fisCemeInfoDomain.delete(recordId);
	}
	
}