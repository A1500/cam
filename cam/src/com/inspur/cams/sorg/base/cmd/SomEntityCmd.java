package com.inspur.cams.sorg.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.data.SomEntity;
import com.inspur.cams.sorg.base.domain.ISomEntityDomain;

/**
 * 举办实体备案
 * @author shgtch
 * @date 2011-10-13
 */
public class SomEntityCmd extends BaseAjaxCommand {
	
	private ISomEntityDomain somEntityDomain = ScaComponentFactory.getService(
			ISomEntityDomain.class, "somEntityDomain/somEntityDomain");

	// 插入
	public void insert() {
		Record record = (Record) getParameter("somEntityRecord");
		SomEntity dataBean = (SomEntity) record.toBean(SomEntity.class);
		somEntityDomain.insert(dataBean);
	}

	// 更新
	public void update() {
		Record record = (Record) getParameter("somEntityRecord");
		SomEntity dataBean = (SomEntity) record.toBean(SomEntity.class);
		somEntityDomain.update(dataBean);
	}
	
	public void del() {
		String taskCode = (String) getParameter("taskCode");
		somEntityDomain.del(taskCode);
	}
	
}
