package com.inspur.cams.drel.funds.release.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.funds.release.data.SamReleaseStat;
import com.inspur.cams.drel.funds.release.domain.ISamReleaseStatDomain;

/**
 * @title:SamReleaseStatQueryCommand
 * @description:
 * @author:
 * @since:2012-06-11
 * @version:1.0
*/
public class SamReleaseStatQueryCmd extends BaseQueryCommand{

	ISamReleaseStatDomain samReleaseStatDomain = ScaComponentFactory.getService(ISamReleaseStatDomain.class,
			"SamReleaseStatDomain/SamReleaseStatDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SamReleaseStat> dao = (EntityDao<SamReleaseStat>) DaoFactory
				.getDao("com.inspur.cams.drel.funds.release.dao.support.SamReleaseStatDao");
		return dao.query(pset);
	}	
	/**
	 * @Title: queryStatistics 
	 * @Description: TODO(分类施保资金统计) 
	 * @author wangziming
	 */
	public DataSet queryStatistics() {
		ParameterSet pset = getParameterSet();
		return samReleaseStatDomain.queryStatistics(pset);
	}
}
