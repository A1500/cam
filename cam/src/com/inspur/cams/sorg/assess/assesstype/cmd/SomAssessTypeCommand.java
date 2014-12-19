package com.inspur.cams.sorg.assess.assesstype.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.assess.assesstype.dao.SomAssessType;
import com.inspur.cams.sorg.assess.assesstype.domain.ISomAssessTypeDomain;

/**
 * @title:SomAssessTypeCommand
 * @description:
 * @author:
 * @since:2011-12-03
 * @version:1.0
*/
public class SomAssessTypeCommand extends BaseAjaxCommand{
	private ISomAssessTypeDomain service = (ISomAssessTypeDomain) ScaComponentFactory.getService(ISomAssessTypeDomain.class,"somAssessTypeDomain/somAssessTypeDomain");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomAssessType dataBean=(SomAssessType)record.toBean(SomAssessType.class);
		System.out.println(dataBean.getSorgType());
		dataBean.setId(IdHelp.getUUID30());
		service.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomAssessType dataBean=(SomAssessType)record.toBean(SomAssessType.class);
		service.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		service.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomAssessType> list = new ArrayList<SomAssessType>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomAssessType dataBean = (SomAssessType) records[i].toBean(SomAssessType.class);
			dataBean.setId(IdHelp.getUUID30());
			list.add(dataBean);
		}

		service.save(list);
	}
}
