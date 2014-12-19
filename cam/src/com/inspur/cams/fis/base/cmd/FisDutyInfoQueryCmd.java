package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.domain.IFisDutyInfoDomain;

/**
 * @Path com.inspur.cams.fis.base.cmd.FisDutyInfoQueryCmd  
 * @Description: TODO 殡葬业务人员岗位信息表查询Cmd
 * @author jiangzhaobao
 * @date 2011-11-15
 */
public class FisDutyInfoQueryCmd extends BaseQueryCommand{
	IFisDutyInfoDomain service = ScaComponentFactory.getService(IFisDutyInfoDomain.class,
	"FisDutyInfoDomain/FisDutyInfoDomain");
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return service.query(pset);
	}
}
