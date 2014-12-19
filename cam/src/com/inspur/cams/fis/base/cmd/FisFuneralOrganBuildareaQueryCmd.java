package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;
import com.inspur.cams.fis.base.domain.IFisFuneralOrganBuildareaDomain;

/**
 * @Path com.inspur.cams.fis.base.cmd.FisFuneralOrganBuildareaQueryCmd
 * @Description: TODO 殡葬业务殡仪馆信息表查询Cmd
 * @author xuexzh
 * @date 2012-7-12
 */
public class FisFuneralOrganBuildareaQueryCmd extends BaseQueryCommand {
	IFisFuneralOrganBuildareaDomain service = ScaComponentFactory
			.getService(IFisFuneralOrganBuildareaDomain.class, "FisFuneralOrganBuildareaDomain/FisFuneralOrganBuildareaDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return service.query(pset);
	}
}
