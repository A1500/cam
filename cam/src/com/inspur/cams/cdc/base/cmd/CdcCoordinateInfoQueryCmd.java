package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcCoordinateInfoDomain;

/**
 * 社区建设领导协调机制信息表查询cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcCoordinateInfoQueryCmd extends BaseQueryCommand {

	private ICdcCoordinateInfoDomain cdcCoordinateInfoDomain = ScaComponentFactory
			.getService(ICdcCoordinateInfoDomain.class, "cdcCoordinateInfoDomain/cdcCoordinateInfoDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcCoordinateInfoDomain.query(pset);
	}
	public DataSet queryList(){
		ParameterSet pset = getParameterSet();
		return cdcCoordinateInfoDomain.queryList(pset);
	}
}