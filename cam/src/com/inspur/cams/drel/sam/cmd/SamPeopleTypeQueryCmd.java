package com.inspur.cams.drel.sam.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.sam.domain.ISamPeopleTypeDomain;

/**
 * @title:人员类型查询Cmd
 * @description:
 * @author:zhangjian
 * @since:2012-05-28
 * @version:1.0
 */
public class SamPeopleTypeQueryCmd extends BaseQueryCommand {
	private ISamPeopleTypeDomain service = ScaComponentFactory.getService(ISamPeopleTypeDomain.class,"samPeopleTypeDomain/samPeopleTypeDomain");

	public DataSet execute() {
		return service.query(getParameterSet());
	}
}