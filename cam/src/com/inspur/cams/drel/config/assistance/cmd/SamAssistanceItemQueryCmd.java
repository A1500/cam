package com.inspur.cams.drel.config.assistance.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.config.assistance.domain.ISamAssistanceItemDomain;

/**
 * @title:救助项目queryCmd
 * @description:
 * @author:
 * @since:2012-05-29
 * @version:1.0
 */
public class SamAssistanceItemQueryCmd extends BaseQueryCommand {
	private ISamAssistanceItemDomain service = ScaComponentFactory.getService(ISamAssistanceItemDomain.class,"samAssistanceItemDomain/samAssistanceItemDomain");

	public DataSet execute() {
		return service.query(getParameterSet());
	}
}