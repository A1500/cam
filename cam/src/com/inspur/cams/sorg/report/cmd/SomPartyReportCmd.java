package com.inspur.cams.sorg.report.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.report.domain.ISomPartyReportDomain;
/**
 * @title 社会组织党建报表查询Cmd
 * @author 闫亮亮
 * @time 2012年9月25日16:01:44
 */
public class SomPartyReportCmd extends BaseQueryCommand {
	private ISomPartyReportDomain service = ScaComponentFactory.getService(ISomPartyReportDomain.class, "somPartyReportDomain/somPartyReportDomain");
	
	/**
	 * 两年党员数综合比较
	 * @param pset
	 * @return
	 */
	public DataSet queryMemberTwoYearCompare() {
		ParameterSet pset = getParameterSet();
		return service.queryMemberTwoYearCompare(pset);
	}
	/**
	 * 党员基本情况
	 * @return
	 */
	public DataSet queryBaseCase(){
		ParameterSet pset = getParameterSet();
		return service.queryBaseCase(pset);
	}
	
	/**
	 * 党员入党时间情况
	 * @return
	 */
	public DataSet queryNormalDate(){
		ParameterSet pset = getParameterSet();
		return service.queryNormalDate(pset);
	}
	
	/**
	 * 党员学历情况
	 * @return
	 */
	public DataSet queryEducation(){
		ParameterSet pset = getParameterSet();
		return service.queryEducation(pset);
	}
	
	/**
	 * 党员年龄情况
	 * @return
	 */
	public DataSet queryAge(){
		ParameterSet pset = getParameterSet();
		return service.queryAge(pset);
	}
	
	/**
	 * 党内表彰情况
	 * @return
	 */
	public DataSet queryPraise(){
		ParameterSet pset = getParameterSet();
		return service.queryPraise(pset);
	}
	
	/**
	 * 发展党员情况
	 * @return
	 */
	public DataSet queryDevelop(){
		ParameterSet pset = getParameterSet();
		return service.queryDevelop(pset);
	}
	
	/**
	 * 预备党员情况
	 * @return
	 */
	public DataSet queryJoin(){
		ParameterSet pset = getParameterSet();
		return service.queryJoin(pset);
	}
}
