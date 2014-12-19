package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.dao.ICdcElectionSumDao;

/**
 * 民主选举选举信息表查询cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcElectionSumQueryCmd extends BaseQueryCommand {

	private ICdcElectionSumDao cdcElectionSumDao = ScaComponentFactory
			.getService(ICdcElectionSumDao.class, "cdcElectionSumDao/cdcElectionSumDao");
	
	public DataSet query(){
		ParameterSet pset = getParameterSet();
		return cdcElectionSumDao.query(pset);
	}
	
	public DataSet queryByParentCode(){
		ParameterSet pset = getParameterSet();
		return cdcElectionSumDao.queryByParentCode(pset);
	}
	
}