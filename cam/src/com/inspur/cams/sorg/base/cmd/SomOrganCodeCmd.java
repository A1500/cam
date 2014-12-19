package com.inspur.cams.sorg.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.data.SomOrganCode;
import com.inspur.cams.sorg.base.domain.ISomOrganCodeDomain;

/**
 * 组织机构代码备案保存和修改
 * 
 * @author zhangjian
 * @date 2011-12-12
 */
public class SomOrganCodeCmd extends BaseAjaxCommand {

	private ISomOrganCodeDomain somOrganCodeDomain = ScaComponentFactory
			.getService(ISomOrganCodeDomain.class,
					"somOrganCodeDomain/somOrganCodeDomain");

	// 插入
	public void insert() {
		Record record = (Record) getParameter("somOrganCodeRecord");
		SomOrganCode somOrganCode = (SomOrganCode) record
				.toBean(SomOrganCode.class);
		somOrganCodeDomain.insert(somOrganCode);
	}

	// 更新
	public void update() {
		Record record = (Record) getParameter("somOrganCodeRecord");
		SomOrganCode somOrganCode = (SomOrganCode) record
				.toBean(SomOrganCode.class);
		somOrganCodeDomain.update(somOrganCode);
	}
	
	public void del() {
		String taskCode = (String) getParameter("taskCode");
		somOrganCodeDomain.del(taskCode);
	}
}
