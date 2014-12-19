package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.domain.IFisServicesPeopleInfoDomain;

/**
 * 殡葬服务机构工作人员信息表查询cmd
 * @author 
 * @date Wed May 02 09:01:05 GMT+08:00 2012
 */
public class FisServicesPeopleInfoQueryCmd extends BaseQueryCommand {

	private IFisServicesPeopleInfoDomain fisServicesPeopleInfoDomain = ScaComponentFactory
			.getService(IFisServicesPeopleInfoDomain.class, "fisServicesPeopleInfoDomain/fisServicesPeopleInfoDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return fisServicesPeopleInfoDomain.query(pset);
	}
	/**
	 * @Title: queryForPeopleRecords 
	 * @Description: TODO(查询服务机构人员信息) 
	 * @author wangziming
	 */
	public DataSet queryForPeopleRecords() {
		ParameterSet pset = getParameterSet();
		return fisServicesPeopleInfoDomain.queryForPeopleRecords(pset);
	}
}