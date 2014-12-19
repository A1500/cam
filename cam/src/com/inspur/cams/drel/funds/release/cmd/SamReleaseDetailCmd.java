package com.inspur.cams.drel.funds.release.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.*;

import com.inspur.cams.drel.funds.release.dao.*;
import com.inspur.cams.drel.funds.release.dao.*;
import com.inspur.cams.drel.funds.release.data.SamReleaseDetail;
import com.inspur.cams.drel.funds.release.domain.ISamReleaseSummaryDomain;

/**
 * @title:SamReleaseDetailCommand
 * @description:
 * @author:
 * @since:2012-05-07
 * @version:1.0
*/
public class SamReleaseDetailCmd extends BaseQueryCommand {

	public DataSet execute() {
		ISamReleaseSummaryDomain samreleasesummaryDomain = ScaComponentFactory.getService(ISamReleaseSummaryDomain.class,
		"SamReleaseSummaryDomain/SamReleaseSummaryDomain");
		ParameterSet pset = getParameterSet();
		return samreleasesummaryDomain.querySamReleaseDetail(pset);
	}

	public void save() {
		ISamReleaseSummaryDomain samreleasesummaryDomain = ScaComponentFactory.getService(ISamReleaseSummaryDomain.class,
				"SamReleaseSummaryDomain/SamReleaseSummaryDomain");
		Record[] samreleasedetailRecords = (Record[]) getParameter("samreleasedetailRecords");
		List<SamReleaseDetail> list = new ArrayList<SamReleaseDetail>();
		for (int i = 0; i < samreleasedetailRecords.length; i++) {
			SamReleaseDetail samreleasedetail = (SamReleaseDetail)samreleasedetailRecords[i].toBean(SamReleaseDetail.class);
			list.add(samreleasedetail);
		}
		samreleasesummaryDomain.saveDetail(list);
	}
	public void delete() {
		EntityDao<SamReleaseDetail> dao = (EntityDao<SamReleaseDetail>) DaoFactory
		.getDao("com.inspur.cams.drel.funds.release.dao.SamReleaseDetailDao");
		String delId = (String) getParameter("delId");
		dao.delete(delId);
	}
}