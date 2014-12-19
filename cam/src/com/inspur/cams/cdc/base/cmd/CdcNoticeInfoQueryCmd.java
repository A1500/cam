package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcNoticeInfoDomain;

public class CdcNoticeInfoQueryCmd extends BaseQueryCommand {
	private ICdcNoticeInfoDomain service = ScaComponentFactory
	.getService(ICdcNoticeInfoDomain.class, "cdcNoticeInfoDomain/cdcNoticeInfoDomain");
	
	public DataSet query(){
		ParameterSet pset = getParameterSet();
		return service.query(pset);
	}
	
	/**
	 * 查询下属的申报
	 * @param pset
	 * @return DataSet
	 */
	public DataSet queryReport(){
		ParameterSet pset = getParameterSet();
		return service.queryReport(pset);
	}
	/**
	 * 查询上司的通知
	 * @param pset
	 * @return DataSet
	 */
	public DataSet queryNotice(){
		ParameterSet pset = getParameterSet();
		return service.queryNotice(pset);
	}
	/**
	 * 查询自己的申报
	 * @param pset
	 * @return DataSet
	 */
	public DataSet queryMyReport(){
		ParameterSet pset = getParameterSet();
		return service.queryMyReport(pset);
	}
	/**
	 * 查询自己的通知
	 * @param pset
	 * @return DataSet
	 */
	public DataSet queryMyNotice(){
		ParameterSet pset = getParameterSet();
		return service.queryMyNotice(pset);
	}
}
