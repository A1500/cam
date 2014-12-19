package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.data.FisCemeChange;
import com.inspur.cams.fis.base.domain.IFisCemeChangeDomain;

/**
 * 公墓信息变更备案表cmd
 * @author 
 * @date 2013-08-01
 */
public class FisCemeChangeCmd extends BaseAjaxCommand {

	private IFisCemeChangeDomain fisCemeChangeDomain = ScaComponentFactory
			.getService(IFisCemeChangeDomain.class, "fisCemeChangeDomain/fisCemeChangeDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		FisCemeChange fisCemeChange = (FisCemeChange) record.toBean(FisCemeChange.class);
		fisCemeChangeDomain.insert(fisCemeChange);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		FisCemeChange fisCemeChange = (FisCemeChange) record.toBean(FisCemeChange.class);
		fisCemeChangeDomain.update(fisCemeChange);
	}
	
	// 删除
	public void delete() {
		String changeId = (String) getParameter("changeId");
		fisCemeChangeDomain.delete(changeId);
	}
	
}