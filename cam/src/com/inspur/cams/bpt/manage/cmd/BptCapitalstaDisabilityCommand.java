package com.inspur.cams.bpt.manage.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.capital.dao.jdbc.BptCapitalstaDisabilityDao;
import com.inspur.cams.bpt.capital.data.BptCapitalstaDisability;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * @title:BptCapitalstaDisabilityCommand
 * @description:
 * @author:
 * @since:2011-05-23
 * @version:1.0
*/           
public class BptCapitalstaDisabilityCommand extends BaseAjaxCommand{
	private BptCapitalstaDisabilityDao dao = (BptCapitalstaDisabilityDao) DaoFactory
			.getDao("com.inspur.cams.bpt.capital.dao.jdbc.BptCapitalstaDisabilityDao");
	@Trans
	public void insert() {
		Record record = (Record) getParameter("record");
		BptCapitalstaDisability dataBean=(BptCapitalstaDisability)record.toBean(BptCapitalstaDisability.class);
		dao.insert(dataBean);
	}
	@Trans
	public void update() {
		Record record = (Record) getParameter("record");
		BptCapitalstaDisability dataBean=(BptCapitalstaDisability)record.toBean(BptCapitalstaDisability.class);
		dao.update(dataBean);
	}
	@Trans
	public void delete() {
		
		String[] counties=(String[]) getParameter("counties");
		String[] startDates=(String[]) getParameter("startDates");
		String[] endDates=(String[]) getParameter("endDates");
		
		for(int i=0;i<counties.length && i<startDates.length&& i<endDates.length;i++){
			dao.deleteBatch(counties[i], startDates[i], endDates[i]);
		}
		//dao.batchDelete(delIds);
	}
	@Trans
	public void save() {
		Record[] records = (Record[]) getParameter("records");
		List<BptCapitalstaDisability> list = new ArrayList<BptCapitalstaDisability>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			BptCapitalstaDisability dataBean = (BptCapitalstaDisability) records[i].toBean(BptCapitalstaDisability.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
	@Trans
	public void saveData() {
		Record[] records = (Record[]) getParameter("records");
		
		String standardsCounties = (String) this.getParameter("standardsCounties");
		String startDate = (String) this.getParameter("startDate");
		List<BptCapitalstaDisability> list = new ArrayList<BptCapitalstaDisability>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			BptCapitalstaDisability dataBean = (BptCapitalstaDisability) records[i].toBean(BptCapitalstaDisability.class);
			dataBean.setStandardsCounties(standardsCounties);
			
			dataBean.setStartDate(startDate);
			
			dataBean.setEndDate("2030-01-01");
			dataBean.setObjectType("1");
			dataBean.setId(IdHelp.getUUID32());
			dataBean.setRegId(BspUtil.getEmpOrganId());
			dataBean.setRegTime(DateUtil.getTime());
			dataBean.setModId(BspUtil.getEmpOrganId());
			dataBean.setModTime(DateUtil.getTime());
			list.add(dataBean);
		}

		dao.batchInsert(list);
	}
}
