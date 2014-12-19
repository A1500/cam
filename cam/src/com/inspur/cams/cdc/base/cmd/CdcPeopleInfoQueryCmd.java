package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcPeopleInfoDomain;

/**
 * 基础信息两委成员与工作者信息表查询cmd
 * @author 
 * @date 2012-05-25
 */
public class CdcPeopleInfoQueryCmd extends BaseQueryCommand {

	private ICdcPeopleInfoDomain cdcPeopleInfoDomain = ScaComponentFactory
			.getService(ICdcPeopleInfoDomain.class, "cdcPeopleInfoDomain/cdcPeopleInfoDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcPeopleInfoDomain.query(pset);
	}
	public DataSet getSeasons(){
		ParameterSet pset = getParameterSet();
		return cdcPeopleInfoDomain.getSeasons(pset);
	}
}