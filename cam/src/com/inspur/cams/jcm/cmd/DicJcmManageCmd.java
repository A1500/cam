package com.inspur.cams.jcm.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.jcm.data.DicJcmManage;
import com.inspur.cams.jcm.domain.IDicJcmManageDomain;

/**
 * 字典维护cmd
 * @author 
 * @date 2014-05-22
 */
public class DicJcmManageCmd extends BaseAjaxCommand {

	private IDicJcmManageDomain dicJcmManageDomain = ScaComponentFactory
			.getService(IDicJcmManageDomain.class, "dicJcmManageDomain/dicJcmManageDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		DicJcmManage dicJcmManage = (DicJcmManage) record.toBean(DicJcmManage.class);
		dicJcmManageDomain.insert(dicJcmManage);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		DicJcmManage dicJcmManage = (DicJcmManage) record.toBean(DicJcmManage.class);
		dicJcmManageDomain.update(dicJcmManage);
	}
	
	// 删除
	public void delete() {
		String dicType = (String) getParameter("dicType");
		dicJcmManageDomain.delete(dicType);
	}
	
}