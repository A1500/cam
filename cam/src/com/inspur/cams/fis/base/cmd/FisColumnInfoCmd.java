package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.data.FisColumnInfo;
import com.inspur.cams.fis.base.domain.IFisColumnInfoDomain;

/**
 * 页面列描述cmd
 * @author 
 * @date 2012-07-16
 */
public class FisColumnInfoCmd extends BaseAjaxCommand {

	private IFisColumnInfoDomain fisColumnInfoDomain = ScaComponentFactory
			.getService(IFisColumnInfoDomain.class, "fisColumnInfoDomain/fisColumnInfoDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		FisColumnInfo fisColumnInfo = (FisColumnInfo) record.toBean(FisColumnInfo.class);
		fisColumnInfoDomain.insert(fisColumnInfo);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		FisColumnInfo fisColumnInfo = (FisColumnInfo) record.toBean(FisColumnInfo.class);
		fisColumnInfoDomain.update(fisColumnInfo);
	}
	
	// 删除
	public void delete() {
		String columnId = (String) getParameter("columnId");
		fisColumnInfoDomain.delete(columnId);
	}
	
}