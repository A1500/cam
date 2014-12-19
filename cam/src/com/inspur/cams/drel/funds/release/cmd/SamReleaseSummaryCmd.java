package com.inspur.cams.drel.funds.release.cmd;

import java.util.*;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.*;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.funds.release.dao.*;
import  com.inspur.cams.drel.funds.release.dao.*;
import com.inspur.cams.drel.funds.release.dao.support.SamReleaseDetailDao;
import com.inspur.cams.drel.funds.release.data.SamReleaseDetail;
import com.inspur.cams.drel.funds.release.data.SamReleaseSummary;
import com.inspur.cams.drel.funds.release.domain.ISamReleaseSummaryDomain;

/**
 * @title:SamReleaseSummarySaveCommand
 * @description:
 * @author:
 * @since:2012-05-07
 * @version:1.0
*/
public class SamReleaseSummaryCmd extends BaseAjaxCommand {
	ISamReleaseSummaryDomain summaryDomain = ScaComponentFactory.getService(ISamReleaseSummaryDomain.class,
			"SamReleaseSummaryDomain/SamReleaseSummaryDomain");
	public void save() {
		
		Record summaryRecord = (Record) getParameter("SamReleaseSummaryRecord");
		SamReleaseSummary releaseSummary = (SamReleaseSummary)summaryRecord.toBean(SamReleaseSummary.class);

		releaseSummary.setReleaseId(IdHelp.getUUID32()); //名册主键
		releaseSummary.setRegId(BspUtil.getEmpOrganId());//名册登记人
		releaseSummary.setRegTime(DateUtil.getTime());   //名册登记时间
		//保存名册
		summaryDomain.insert(releaseSummary);
	}
	

	public void delete() {
		String[] delId = (String[]) getParameter("delIds");
		summaryDomain.delete(delId);
	}

	public void addDetail(){

	}
	public void delDetail(){
		String[] delIds = (String[]) getParameter("delIds");
		String releaseId= (String) getParameter("releaseId");
		summaryDomain.delDetail(releaseId, delIds);
	}
		
	private List<SamReleaseDetail> getSamReleaseDetailList() {
		Record[] samreleasedetailRecords = (Record[]) getParameter("SamReleaseDetailRecords");
		if (samreleasedetailRecords == null || samreleasedetailRecords.length == 0) {
			return null;
		}
		List<SamReleaseDetail> list = new ArrayList<SamReleaseDetail>();
		for (int i = 0; i < samreleasedetailRecords.length; i++) {
			SamReleaseDetail samreleasedetail = (SamReleaseDetail) samreleasedetailRecords[i].toBean(SamReleaseDetail.class);
			list.add(samreleasedetail);
		}

		return list;
	}
	
	public void confirm(){
		String status = (String) getParameter("releaseStatus");
		String releaseId= (String) getParameter("releaseId");
		summaryDomain.confirm(releaseId, status);
	}

	/**
	* @Title: insertRes
	* @Description: TODO(选中救助对象确定插入明细方法) void  
	* @throws
	* @author luguosui
	 */
	public void insertReleaseDetail() {
		ParameterSet pSet=getParameterSet();
		summaryDomain.insertReleaseDetail(pSet);
	}
}