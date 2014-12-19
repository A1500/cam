package com.inspur.cams.drel.esurey.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.esurey.data.SamEsureyHouse;
import com.inspur.cams.drel.esurey.domain.ISamEsureyHouseDomain;

public class SamEsureyHouseCmd extends BaseAjaxCommand {
	ISamEsureyHouseDomain samEsureyHouseDomain = ScaComponentFactory.getService(ISamEsureyHouseDomain.class,
	"SamEsureyHouseDomain/SamEsureyHouseDomain");
	
	public void insert() {
		Record record = (Record) getParameter("record");
		SamEsureyHouse dataBean=(SamEsureyHouse)record.toBean(SamEsureyHouse.class);
		dataBean.setId(IdHelp.getUUID30());
		samEsureyHouseDomain.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SamEsureyHouse dataBean=(SamEsureyHouse)record.toBean(SamEsureyHouse.class);
		samEsureyHouseDomain.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		samEsureyHouseDomain.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SamEsureyHouse> list = new ArrayList<SamEsureyHouse>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SamEsureyHouse dataBean = (SamEsureyHouse) records[i].toBean(SamEsureyHouse.class);
			list.add(dataBean);
		}

		samEsureyHouseDomain.save(list);
	}
}
