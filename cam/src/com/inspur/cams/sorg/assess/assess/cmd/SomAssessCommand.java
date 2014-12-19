package com.inspur.cams.sorg.assess.assess.cmd;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.assess.assess.dao.SomAssessDao;
import com.inspur.cams.sorg.assess.assess.data.SomAssess;
import com.inspur.cams.sorg.assess.assess.domain.ISomAssessDomain;

/**
 * @title:SomAssessCommand
 * @description:
 * @author:
 * @since:2011-12-06
 * @version:1.0
*/
public class SomAssessCommand extends BaseAjaxCommand{
	private SomAssessDao dao = (SomAssessDao) DaoFactory
			.getDao("com.inspur.cams.sorg.assess.assess.dao.SomAssessDao");
	private ISomAssessDomain service = (ISomAssessDomain) ScaComponentFactory.getService(ISomAssessDomain.class,"somAssessDomain/somAssessDomain");

	public void insert() {
		Record record = (Record) getParameter("record");
		String taskCode = IdHelp.getUUID32();
		record.set("taskCode", taskCode);
		SomAssess dataBean=(SomAssess)record.toBean(SomAssess.class);
		dao.insert(dataBean);
		this.setReturn("taskCode", taskCode);
	}
	
	public void saveScore(){
		String[] addIds = (String[]) getParameter("addIds");
		String assessType = (String) getParameter("assessType");
		String taskCode = (String) getParameter("taskCode");
		Map<Object,Object> map = new HashMap<Object, Object>();
		map.put("addIds", addIds);
		map.put("assessType", assessType);
		map.put("taskCode", taskCode);
		service.saveScore(map);
	}
	
	public void updateScore(){
		String[] addIds = (String[]) getParameter("addIds");
		String assessType = (String) getParameter("assessType");
		String taskCode = (String) getParameter("taskCode");
		Map<Object,Object> map = new HashMap<Object, Object>();
		map.put("addIds", addIds);
		map.put("assessType", assessType);
		map.put("taskCode", taskCode);
		service.updateScore(map);
	}
	public void update() {
		Record record = (Record) getParameter("record");
		SomAssess dataBean=(SomAssess)record.toBean(SomAssess.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomAssess> list = new ArrayList<SomAssess>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomAssess dataBean = (SomAssess) records[i].toBean(SomAssess.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
