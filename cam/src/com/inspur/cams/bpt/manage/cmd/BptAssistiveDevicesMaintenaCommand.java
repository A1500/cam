package com.inspur.cams.bpt.manage.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.base.dao.jdbc.BptAssistiveDevicesMaintenaDao;
import com.inspur.cams.bpt.base.data.BptAssistiveDevicesMaintena;
import com.inspur.cams.comm.util.IdHelp;

/**
 * @title:BptAssistiveDevicesMaintenaCommand
 * @description:伤残器械维护
 * @author:
 * @since:2011-05-31
 * @version:1.0
*/
public class BptAssistiveDevicesMaintenaCommand extends BaseAjaxCommand{
	private BptAssistiveDevicesMaintenaDao dao = (BptAssistiveDevicesMaintenaDao) DaoFactory
			.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptAssistiveDevicesMaintenaDao");
	@Trans
	public void insert() {
		Record record = (Record) getParameter("record");
		BptAssistiveDevicesMaintena dataBean=(BptAssistiveDevicesMaintena)record.toBean(BptAssistiveDevicesMaintena.class);
		dataBean.setId(IdHelp.getUUID32());
		dao.insert(dataBean);
	}
	@Trans
	public void update() {
		Record record = (Record) getParameter("record");
		BptAssistiveDevicesMaintena dataBean=(BptAssistiveDevicesMaintena)record.toBean(BptAssistiveDevicesMaintena.class);
		dao.update(dataBean);
	}
	@Trans
	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	@Trans
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<BptAssistiveDevicesMaintena> list = new ArrayList<BptAssistiveDevicesMaintena>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			BptAssistiveDevicesMaintena dataBean = (BptAssistiveDevicesMaintena) records[i].toBean(BptAssistiveDevicesMaintena.class);
			if(dataBean.isNew()){
				dataBean.setId(IdHelp.getUUID32());
			}
			list.add(dataBean);
		}
		dao.save(list);
	}
	public void checkDelete(){
		String id = (String) getParameter("id");
		ParameterSet pset = new ParameterSet();
		pset.setParameter("ups", id);
		DataSet  ds = dao.query(pset);
		this.setReturn("count", ds.getCount());
	}
	public void testDeviceId(){
		String applyApparatusId = (String) getParameter("applyApparatusId");
		ParameterSet pset = new ParameterSet();
		pset.setParameter("APPLY_APPARATUS_ID", applyApparatusId);
		DataSet  ds = dao.query(pset);
		if(ds.getCount()>0){
			this.setReturn("id", ds.getRecord(0).get("id"));
		}
		this.setReturn("count", ds.getCount());
	}
}
