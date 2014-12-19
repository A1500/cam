package com.inspur.cams.drel.sam.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.sam.domain.ISamFamilyAssistanceDomain;

/**
 * @title:SamFamilyAssistanceCmd救助基本信息
 * @description:
 * @author:
 * @since:2011-04-18
 * @version:1.0
*/
public class SamFamilyAssistanceCmd extends BaseQueryCommand {
	private ISamFamilyAssistanceDomain service = ScaComponentFactory.getService(ISamFamilyAssistanceDomain.class,"samFamilyAssistanceDomain/samFamilyAssistanceDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return service.query(pset);
	}

}