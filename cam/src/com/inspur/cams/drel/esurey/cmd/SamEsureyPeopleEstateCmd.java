package com.inspur.cams.drel.esurey.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.esurey.data.SamEsureyPeopleEstate;
import com.inspur.cams.drel.esurey.domain.ISamEsureyPeopleEstateDomain;

public class SamEsureyPeopleEstateCmd extends BaseAjaxCommand{
	ISamEsureyPeopleEstateDomain server = ScaComponentFactory.getService(ISamEsureyPeopleEstateDomain.class,
	"SamEsureyPeopleEstateDomain/SamEsureyPeopleEstateDomain");
	
	public void insert() {
		Record record = (Record) getParameter("record");
		SamEsureyPeopleEstate dataBean=(SamEsureyPeopleEstate)record.toBean(SamEsureyPeopleEstate.class);
		server.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SamEsureyPeopleEstate dataBean=(SamEsureyPeopleEstate)record.toBean(SamEsureyPeopleEstate.class);
		server.update(dataBean);
	}

	public void delete() {
		String id=(String) getParameter("id");
		server.delete(id);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SamEsureyPeopleEstate> list = new ArrayList<SamEsureyPeopleEstate>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SamEsureyPeopleEstate dataBean = (SamEsureyPeopleEstate) records[i].toBean(SamEsureyPeopleEstate.class);
			list.add(dataBean);
		}

		server.save(list);
	}
}
