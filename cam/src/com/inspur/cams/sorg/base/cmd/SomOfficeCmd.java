package com.inspur.cams.sorg.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.data.SomOffice;
import com.inspur.cams.sorg.base.domain.ISomOfficeDomain;

/**
 * 举办实体备案
 * @author shgtch
 * @date 2011-10-13
 */
public class SomOfficeCmd extends BaseAjaxCommand {
	
	private ISomOfficeDomain somOfficeDomain = ScaComponentFactory.getService(
			ISomOfficeDomain.class, "somOfficeDomain/somOfficeDomain");

	// 插入
	public void insert() {
		Record record = (Record) getParameter("somOfficeRecord");
		SomOffice somOffice = (SomOffice) record.toBean(SomOffice.class);
		somOfficeDomain.insert(somOffice);
	}
	
	/**
	 * 备案中增加内设机构信息，增加一条apply信息
	 */
	public void insertOfficeAndApply() {
		Record record = (Record) getParameter("somOfficeRecord");
		SomOffice somOffice = (SomOffice) record.toBean(SomOffice.class);
		somOfficeDomain.insertOfficeAndApply(somOffice);
	}

	// 更新
	public void update() {
		Record record = (Record) getParameter("somOfficeRecord");
		SomOffice somOffice = (SomOffice) record.toBean(SomOffice.class);
		somOfficeDomain.update(somOffice);
	}
	
	public void del() {
		String taskCode = (String) getParameter("taskCode");
		somOfficeDomain.delByTaskCode(taskCode);
	}
	
}
