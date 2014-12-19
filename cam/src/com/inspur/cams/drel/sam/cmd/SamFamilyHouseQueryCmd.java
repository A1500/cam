package com.inspur.cams.drel.sam.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.sam.domain.ISamFamilyHouseDomain;
/**
 * 家庭房产信息查询Cmd
 * @author yanll
 *
 */
public class SamFamilyHouseQueryCmd extends BaseQueryCommand {
	private ISamFamilyHouseDomain samFamilyHouseDomain = ScaComponentFactory.getService(ISamFamilyHouseDomain.class, "samFamilyHouseDomain/samFamilyHouseDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return samFamilyHouseDomain.query(pset);
	}
}
