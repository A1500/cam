package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.domain.IFisCemeteryOrganDomain;

/**
 * @Path com.inspur.cams.fis.base.cmd.FisCemeteryOrganQueryCmd  
 * @Description: TODO 殡葬业务公墓信息表查询Cmd
 * @author muqi
 * @date 2012-04-09
 */
public class FisCemeteryOrganQueryCmd extends BaseQueryCommand {
	IFisCemeteryOrganDomain service = ScaComponentFactory.getService(
			IFisCemeteryOrganDomain.class,
			"FisCemeteryOrganDomain/FisCemeteryOrganDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return service.query(pset);
	}
}
