package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcPicInfoDomain;

/**
 * 社区图片展示查询cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcPicInfoQueryCmd extends BaseQueryCommand {

	private ICdcPicInfoDomain cdcPicInfoDomain = ScaComponentFactory
			.getService(ICdcPicInfoDomain.class, "cdcPicInfoDomain/cdcPicInfoDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcPicInfoDomain.query(pset);
	}
	
	public DataSet queryPicInfo(){
		ParameterSet pset = getParameterSet();
		return cdcPicInfoDomain.queryPicInfo(pset);
	}
	
}