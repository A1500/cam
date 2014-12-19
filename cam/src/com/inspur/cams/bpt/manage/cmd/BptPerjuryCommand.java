package com.inspur.cams.bpt.manage.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.base.dao.jdbc.BptPerjuryDao;
import com.inspur.cams.bpt.base.data.BptPerjury;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
/**
 * @title:BptPerjuryCommand
 * @description:
 * @author:
 * @since:2014-03-20
 * @version:1.0
*/
public class BptPerjuryCommand extends BaseAjaxCommand{
	private BptPerjuryDao dao = (BptPerjuryDao) DaoFactory
			.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptPerjuryDao");

	IBptGroupDomain service = ScaComponentFactory.getService(IBptGroupDomain.class,
			"bptGroupDomain/bptGroupDomain");
	
	public void insert() {
		Record record = (Record) getParameter("record");
		BptPerjury dataBean=(BptPerjury)record.toBean(BptPerjury.class);
		dataBean.setPerjuryId(IdHelp.getUUID32());
		dataBean.setAddPerson(BspUtil.getOrganName());
		dataBean.setAddDate(DateUtil.getTime());
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		BptPerjury dataBean=(BptPerjury)record.toBean(BptPerjury.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	@Trans
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<BptPerjury> list = new ArrayList<BptPerjury>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			BptPerjury dataBean = (BptPerjury) records[i].toBean(BptPerjury.class);
			if(dataBean.getPerjuryId()==null||"".equals(dataBean.getPerjuryId())){
				dataBean.setPerjuryId(IdHelp.getUUID32());
				dataBean.setAddPerson(BspUtil.getOrganName());
				dataBean.setAddDate(DateUtil.getDay());
			}
			list.add(dataBean);
		}

		dao.save(list);
	}
	public void checkDoublePerson(){
		String idCard = (String) getParameter("idCard");
		String peopleId = (String) getParameter("peopleId");
		ParameterSet pset = new ParameterSet();
		pset.setParameter("peopleId", peopleId);
		pset.setParameter("idCard", idCard);
		DataSet ds = dao.queryDoubPerjury(pset);
		if(ds.getCount()>0){
			this.setReturn("flag", "1");
		}else{
			this.setReturn("flag", "0");
		}
	}
	@Trans
	public void savefromflow() {
		String peopleId = (String) getParameter("peopleId");
		String serviceType = (String) getParameter("serviceType");
		BptPerjury dataBean=new BptPerjury();
		ParameterSet pset = new ParameterSet();
		pset.setParameter("people_Id", peopleId);
		DataSet peopleDataSet =  service.queryPeople(pset);
		if(peopleDataSet.getCount()>0){
			dataBean.setIdCard(peopleDataSet.getRecord(0).get("idCard")+"");
			dataBean.setName(peopleDataSet.getRecord(0).get("name")+"");
			dataBean.setDomicileCode(peopleDataSet.getRecord(0).get("domicileCode")+"");
		}
		dataBean.setPerjuryId(IdHelp.getUUID32());
		dataBean.setServiceType(serviceType);
		dataBean.setAddPerson(BspUtil.getOrganName());
		dataBean.setAddDate(DateUtil.getDay());
		dao.insert(dataBean);
	}
}
