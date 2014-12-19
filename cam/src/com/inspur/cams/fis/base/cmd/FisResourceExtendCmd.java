package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.data.FisResourceExtend;
import com.inspur.cams.fis.base.domain.IFisResourceExtendDomain;

/**
 * 墓位特征扩展表cmd
 * @author 
 * @date Fri Apr 13 09:45:56 GMT+08:00 2012
 */
public class FisResourceExtendCmd extends BaseAjaxCommand {

	private IFisResourceExtendDomain fisResourceExtendDomain = ScaComponentFactory
			.getService(IFisResourceExtendDomain.class, "FisResourceExtendDomain/FisResourceExtendDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		FisResourceExtend fisResourceExtend = (FisResourceExtend) record.toBean(FisResourceExtend.class);
		fisResourceExtendDomain.insert(fisResourceExtend);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		FisResourceExtend fisResourceExtend = (FisResourceExtend) record.toBean(FisResourceExtend.class);
		fisResourceExtendDomain.update(fisResourceExtend);
	}
	
	// 删除
	public void delete() {
		String recordId = (String) getParameter("recordId");
		fisResourceExtendDomain.delete(recordId);
	}
	
}