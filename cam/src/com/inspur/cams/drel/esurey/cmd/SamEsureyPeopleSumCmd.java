package com.inspur.cams.drel.esurey.cmd;

import java.util.*;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.drel.esurey.data.SamEsureyPeopleSum;
import com.inspur.cams.drel.esurey.domain.ISamEsureyPeopleSumDomain;

/**
 * @title:SamLowStandardsCommand
 * @description:
 * @author:
 * @since:2011-07-06
 * @version:1.0
*/
public class SamEsureyPeopleSumCmd extends BaseAjaxCommand{
	
	private ISamEsureyPeopleSumDomain service = 
			ScaComponentFactory.getService(ISamEsureyPeopleSumDomain.class,"SamEsureyPeopleSumDomain/SamEsureyPeopleSumDomain");
	
	public void insert() {
		Record record = (Record) getParameter("record");
		SamEsureyPeopleSum dataBean=(SamEsureyPeopleSum)record.toBean(SamEsureyPeopleSum.class);
		service.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SamEsureyPeopleSum dataBean=(SamEsureyPeopleSum)record.toBean(SamEsureyPeopleSum.class);
		service.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		service.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SamEsureyPeopleSum> list = new ArrayList<SamEsureyPeopleSum>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SamEsureyPeopleSum dataBean = (SamEsureyPeopleSum) records[i].toBean(SamEsureyPeopleSum.class);
			list.add(dataBean);
		}

		service.save(list);
	}
	/**
	 * 汇总审核后人员信息存储
	 */
	public void saveSum() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		String surveyId =(String)getParameter("surveyId");
		List<SamEsureyPeopleSum> list = new ArrayList<SamEsureyPeopleSum>();
		for (int i = 0; i < records.length; i++) {
			SamEsureyPeopleSum dataBean = new SamEsureyPeopleSum();
			dataBean.setFamilyId((String)records[i].get("FAMILY_ID"));
			dataBean.setPeopleId((String)records[i].get("PEOPLE_ID"));
			dataBean.setIncomeMonth(records[i].get("MONEY")+"");
			dataBean.setIncomeYear((Double.parseDouble(records[i].get("MONEY")+"")*12)+"");
			dataBean.setSurveyId(surveyId);
		//	list.add(dataBean);
			service.insert(dataBean);
		}
	//	service.save(list);
	}
}
