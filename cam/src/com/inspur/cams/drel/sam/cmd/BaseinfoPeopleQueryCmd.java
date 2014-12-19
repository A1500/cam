package com.inspur.cams.drel.sam.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.baseinfo.domain.IBaseinfoDomain;

/**
 * 人员信息查询Cmd
 * 
 * @author yanll
 * 
 */
public class BaseinfoPeopleQueryCmd extends BaseQueryCommand {
	IBaseinfoDomain baseinfoDomain = ScaComponentFactory.getService(
			IBaseinfoDomain.class, "baseinfoDomain/baseinfoDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return baseinfoDomain.queryPeople(pset);
	}

	public DataSet queryPeopleForSam() {
		ParameterSet pset = getParameterSet();
		return baseinfoDomain.queryPeopleForSam(pset);
	}
	/**
	 * @Title: querySamPeopleList 
	 * @Description: TODO(低保对象查询列表) 
	 * @author wangziming
	 */
	public DataSet querySamPeopleList(){
		ParameterSet pset = getParameterSet();
		return baseinfoDomain.querySamPeopleList(pset);
	}
	/**
	 * 可能成为五保对象的人员查询
	 * @return
	 */
	public DataSet queryMaybeFiveList(){
		ParameterSet pset = getParameterSet();
		return baseinfoDomain.queryMaybeFiveList(pset);
	}
	/**
	 * @Title: queryBaseChangePeople 
	 * @Description:  (低保保障对象变动) 
	 * @author YLL
	 */
	public DataSet queryBaseChange(){
		ParameterSet pset = getParameterSet();
		return baseinfoDomain.queryBaseChangePeople(pset);
	}
	
	/**
	 * 查询人员火化信息
	 * 
	 * */
	public DataSet queryCremationInfo(){
		ParameterSet pset = getParameterSet();
		return baseinfoDomain.queryCremationInfo(pset);
	}
}
