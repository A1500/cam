package com.inspur.cams.sorg.manage.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.manage.domain.ISomFundDomain;
/**
 * 
 * @author Muqi
 * @date 2011年6月3日11:41:44
 */
public class SomFundPeopleQueryCmd extends BaseQueryCommand {
	// ------------------------------------muqi-------------------------------------------------------------------
	private ISomFundDomain service = ScaComponentFactory.getService(
			ISomFundDomain.class, "somFundDomain/somFundDomain");

	public DataSet execute(){
		ParameterSet pset = getParameterSet();
		return service.queryPeople(pset);
	}
	/**
	 * 根据社会组织ID和人员类型或人员ID查询人员信息
	 * 
	 * @param pset
	 * @return DataSet
	 */
	public DataSet queryPeopleByParam(){
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryPeopleByParam(pset);
		return ds;
	}
	/**
	 * 根据身份证号查询人员信息
	 * @param pset
	 * @return DataSet
	 */
	public DataSet queryPeopleByIdCard(){
		ParameterSet pset = getParameterSet();
		return service.queryPeopleByIdCard(pset);
	}
	/**
	 * 根据社会组织ID和人员ID查询成员信息
	 * @param pset
	 * @return DataSet
	 */
	public DataSet queryMember(){
		ParameterSet pset = getParameterSet();
		return service.queryMember(pset);
	}
	/**
	 * 查询负责人管理列表
	 */
	public DataSet queryPeopleList(){
		ParameterSet pset = getParameterSet();
		return service.queryPeopleList(pset);
	}
	/**
	 * 根据人员ID查询Member表
	 * @return
	 */
	public DataSet queryMemberByPeopleId(){
		ParameterSet pset = getParameterSet();
		return service.queryMemberByPeopleId(pset);
	}
}
