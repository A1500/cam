package com.inspur.cams.drel.funds.release.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.funds.release.data.SamReleaseDetail;
import com.inspur.cams.drel.funds.release.domain.ISamReleaseDetailDomain;
import com.inspur.cams.drel.funds.release.domain.ISamReleaseSummaryDomain;


/**
 * @title:SamReleaseDetailQueryCommand
 * @description:
 * @author:
 * @since:2012-05-08
 * @version:1.0
*/
public class SamReleaseDetailQueryCmd extends BaseQueryCommand{

	ISamReleaseDetailDomain samReleaseDetailDomain = ScaComponentFactory.getService(ISamReleaseDetailDomain.class,
			"SamReleaseDetailDomain/SamReleaseDetailDomain");
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return samReleaseDetailDomain.query(pset);
	}
	/**
	* @Title: queryDetailByIfSpecial
	* @Description: TODO(发放明细查询)
	* @return DataSet  
	* @throws
	* @author luguosui
	 */
	public DataSet queryDetailByIfSpecial(){
		ParameterSet pset = getParameterSet();
		return samReleaseDetailDomain.queryDetailByIfSpecial(pset);
	}
	/**
	* @Title: queryAssistancePeo
	* @Description: TODO(报表下钻时查询保障人员信息)
	* @return DataSet  
	* @throws
	* @author luguosui
	 */
	public DataSet queryAssistancePeo(){
		ParameterSet pset = getParameterSet();
		return samReleaseDetailDomain.queryAssistancePeo(pset);
	}
	/**
	* @Title: queryAllDetail
	* @Description: TODO(导出包括专项补贴的明细Excel查询方法)
	* @return DataSet  
	* @throws
	* @author luguosui
	 */
	public DataSet queryAllDetail() {
		ParameterSet pset = getParameterSet();
		return samReleaseDetailDomain.queryAllDetail(pset);
	}
	/**
	 * @Title: queryPeopleDetail
	* @Description: TODO(导出家庭成员的信息)
	* @return DataSet  
	* @throws
	* @author sunlei
	 */
	public DataSet queryPeopleDetail() {
		ParameterSet pset = getParameterSet();
		return samReleaseDetailDomain.queryPeopleDetail(pset);
	}
}
