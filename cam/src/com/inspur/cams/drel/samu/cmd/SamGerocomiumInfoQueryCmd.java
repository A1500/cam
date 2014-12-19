package com.inspur.cams.drel.samu.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.samu.domain.ISamGerocomiumInfoDomain;

/**
 * 敬老院基础信息查询cmd
 * @author 
 * @date 2012-09-26
 */
public class SamGerocomiumInfoQueryCmd extends BaseQueryCommand {

	private ISamGerocomiumInfoDomain samGerocomiumInfoDomain = ScaComponentFactory
			.getService(ISamGerocomiumInfoDomain.class, "samGerocomiumInfoDomain/samGerocomiumInfoDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return samGerocomiumInfoDomain.query(pset);
	}
	/**
	 * 查询敬老院——树
	 * @param pset
	 * @return
	 */
	public DataSet queryGero() {
		ParameterSet pset = getParameterSet();
		DataSet ds=samGerocomiumInfoDomain.queryGero(pset);
		ds.getMetaData().setIdProperty("RECORD_ID");
		return ds;
	}
	/**
	 * 敬老院基本情况统计
	 * @param pset
	 * @return
	 */
	public DataSet reportGeroInfo() {
		ParameterSet pset = getParameterSet();
		return samGerocomiumInfoDomain.reportGeroInfo(pset);
	}
}