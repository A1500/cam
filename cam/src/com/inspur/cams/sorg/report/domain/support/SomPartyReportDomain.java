package com.inspur.cams.sorg.report.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.sorg.report.dao.ISomPartyReportDao;
import com.inspur.cams.sorg.report.domain.ISomPartyReportDomain;
/**
 * @title 社会组织党建报表查询Domain
 * @author 闫亮亮
 * @time 2012年9月25日16:01:44
 */
public class SomPartyReportDomain implements ISomPartyReportDomain {
	@Reference
	private ISomPartyReportDao somPartyReportDao;
	/**
	 * 两年党员数综合比较
	 * @param pset
	 * @return
	 */
	public DataSet queryMemberTwoYearCompare(ParameterSet pset) {
		return somPartyReportDao.queryMemberTwoYearCompare(pset);
	}
	/**
	 * 党员基本情况
	 */
	public DataSet queryBaseCase(ParameterSet pset) {
		return somPartyReportDao.queryBaseCase(pset);
	}
	
	/**
	 * 党员入党时间情况
	 * @param pset
	 * @return
	 */
	public DataSet queryNormalDate(ParameterSet pset){
		return somPartyReportDao.queryNormalDate(pset);
	}
	
	/**
	 * 党员学历情况
	 * @param pset
	 * @return
	 */
	public DataSet queryEducation(ParameterSet pset){
		return somPartyReportDao.queryEducation(pset);
	}
	
	/**
	 * 党员年龄情况
	 * @param pset
	 * @return
	 */
	public DataSet queryAge(ParameterSet pset){
		return somPartyReportDao.queryAge(pset);
	}
	
	/**
	 * 党内表彰情况
	 * @param pset
	 * @return
	 */
	public DataSet queryPraise(ParameterSet pset){
		return somPartyReportDao.queryPraise(pset);
	}
	
	/**
	 * 发展党员情况
	 * @param pset
	 * @return
	 */
	public DataSet queryDevelop(ParameterSet pset){
		return somPartyReportDao.queryDevelop(pset);
	}
	
	/**
	 * 预备党员情况
	 * @param pset
	 * @return
	 */
	public DataSet queryJoin(ParameterSet pset){
		return somPartyReportDao.queryJoin(pset);
	}
}
