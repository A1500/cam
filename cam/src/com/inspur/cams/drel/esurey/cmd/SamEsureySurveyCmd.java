package com.inspur.cams.drel.esurey.cmd;

import java.util.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.esurey.data.SamEsureySurvey;
import com.inspur.cams.drel.esurey.domain.ISamEsureySurveyDomain;

/**
 * @title:SamEsureySurveyCommand
 * @description:经济核对_核对流水Command
 * @author:luguosui
 * @since:2011-06-29
 * @version:1.0
*/
public class SamEsureySurveyCmd extends BaseAjaxCommand{
	ISamEsureySurveyDomain samEsureySurveyDomain = ScaComponentFactory.getService(ISamEsureySurveyDomain.class,
	"SamEsureySurveyDomain/SamEsureySurveyDomain");
	
	public void insert() {
		ParameterSet pset=getParameterSet();
		samEsureySurveyDomain.insert(pset);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SamEsureySurvey dataBean=(SamEsureySurvey)record.toBean(SamEsureySurvey.class);
		samEsureySurveyDomain.update(dataBean);
	}

	public void delete() { 
		String[] delIds=(String[]) getParameter("delIds");
		samEsureySurveyDomain.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SamEsureySurvey> list = new ArrayList<SamEsureySurvey>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SamEsureySurvey dataBean = (SamEsureySurvey) records[i].toBean(SamEsureySurvey.class);
			list.add(dataBean);
		}

		samEsureySurveyDomain.save(list);
	}
	
	public void delete(String peopleId){
		String sql="delete from sam_esurey_social where peopleId='"+peopleId+"'";
	}
}
