package com.inspur.cams.drel.esurey.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.esurey.data.SamEsureyBusiness;
import com.inspur.cams.drel.esurey.domain.ISamEsureyBusinessDomain;

public class SamEsureyBusinessCmd extends BaseAjaxCommand {
	ISamEsureyBusinessDomain samEsureyBusinessDomain = ScaComponentFactory.getService(ISamEsureyBusinessDomain.class,
	"SamEsureyBusinessDomain/SamEsureyBusinessDomain");
	
	public void insert() {
		Record record = (Record) getParameter("record");
		SamEsureyBusiness dataBean=(SamEsureyBusiness)record.toBean(SamEsureyBusiness.class);
		dataBean.setId(IdHelp.getUUID30());
		samEsureyBusinessDomain.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SamEsureyBusiness dataBean=(SamEsureyBusiness)record.toBean(SamEsureyBusiness.class);
		samEsureyBusinessDomain.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		samEsureyBusinessDomain.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SamEsureyBusiness> list = new ArrayList<SamEsureyBusiness>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SamEsureyBusiness dataBean = (SamEsureyBusiness) records[i].toBean(SamEsureyBusiness.class);
			list.add(dataBean);
		}

		samEsureyBusinessDomain.save(list);
	}
}
