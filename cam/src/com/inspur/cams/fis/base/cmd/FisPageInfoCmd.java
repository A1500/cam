package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.data.FisPageInfo;
import com.inspur.cams.fis.base.domain.IFisPageInfoDomain;

/**
 * 页面信息表cmd
 * @author 
 * @date 2012-07-16
 */
public class FisPageInfoCmd extends BaseAjaxCommand {

	private IFisPageInfoDomain fisPageInfoDomain = ScaComponentFactory
			.getService(IFisPageInfoDomain.class, "fisPageInfoDomain/fisPageInfoDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		FisPageInfo fisPageInfo = (FisPageInfo) record.toBean(FisPageInfo.class);
		fisPageInfoDomain.insert(fisPageInfo);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		FisPageInfo fisPageInfo = (FisPageInfo) record.toBean(FisPageInfo.class);
		fisPageInfoDomain.update(fisPageInfo);
	}
	
	// 删除
	public void delete() {
		String pageId = (String) getParameter("pageId");
		fisPageInfoDomain.delete(pageId);
	}
	
}