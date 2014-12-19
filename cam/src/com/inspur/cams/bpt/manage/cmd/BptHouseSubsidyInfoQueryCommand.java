package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;
import com.inspur.cams.bpt.base.domain.IBptHouseSubsidyInfoDomain;

/**
 * @title:BptHouseSubsidyInfoQueryCommand
 * @description: 建购房补助信息
 * @author:
 * @since:2011-07-04
 * @version:1.0
*/
public class BptHouseSubsidyInfoQueryCommand extends BaseQueryCommand{
	
	IBptHouseSubsidyInfoDomain service = ScaComponentFactory.getService(IBptHouseSubsidyInfoDomain.class,
	"bptHouseSubsidyInfoDomain/bptHouseSubsidyInfoDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return service.query(pset);
	}
}
