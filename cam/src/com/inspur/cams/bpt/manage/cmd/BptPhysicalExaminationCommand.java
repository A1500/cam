package com.inspur.cams.bpt.manage.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;

import com.inspur.cams.bpt.base.dao.jdbc.BptPhysicalExaminationDao;
import com.inspur.cams.bpt.base.data.BptPhysicalExamination;

/**
 * @title:BptPhysicalExaminationCommand
 * @description:
 * @author:
 * @since:2011-12-27
 * @version:1.0
*/
public class BptPhysicalExaminationCommand extends BaseAjaxCommand{
	private BptPhysicalExaminationDao dao = (BptPhysicalExaminationDao) DaoFactory
			.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptPhysicalExaminationDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		BptPhysicalExamination dataBean=(BptPhysicalExamination)record.toBean(BptPhysicalExamination.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		BptPhysicalExamination dataBean=(BptPhysicalExamination)record.toBean(BptPhysicalExamination.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<BptPhysicalExamination> list = new ArrayList<BptPhysicalExamination>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			BptPhysicalExamination dataBean = (BptPhysicalExamination) records[i].toBean(BptPhysicalExamination.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
	//判定是否填写数据
	public void queryIsNull(){
		
		ParameterSet pset = new ParameterSet();
		pset.setParameter("apply_id", getParameter("applyId"));
		pset.setParameter("people_Id", getParameter("peopleId"));
		DataSet  ds = dao.query(pset);
		if(ds.getCount()>0){
			String applyReason= (String)ds.getRecord(0).get("applyReason");
			if(applyReason!=null&&applyReason!=""){
				this.setReturn("flag", true);
			}else{
				this.setReturn("flag", false);
			}
		}else{
			this.setReturn("flag", false);
		}
	}
}
