package com.inspur.cams.drel.esurey.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.esurey.data.SamEsureyCar;
import com.inspur.cams.drel.esurey.domain.ISamEsureyCarDomain;

public class SamEsureyCarCmd extends BaseAjaxCommand {
	ISamEsureyCarDomain samEsureyCarDomain = ScaComponentFactory.getService(ISamEsureyCarDomain.class,
	"SamEsureyCarDomain/SamEsureyCarDomain");
	
	public void insert() {
		Record record = (Record) getParameter("record");
		SamEsureyCar dataBean=(SamEsureyCar)record.toBean(SamEsureyCar.class);
		dataBean.setId(IdHelp.getUUID30());
		samEsureyCarDomain.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SamEsureyCar dataBean=(SamEsureyCar)record.toBean(SamEsureyCar.class);
		samEsureyCarDomain.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		samEsureyCarDomain.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SamEsureyCar> list = new ArrayList<SamEsureyCar>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SamEsureyCar dataBean = (SamEsureyCar) records[i].toBean(SamEsureyCar.class);
			list.add(dataBean);
		}

		samEsureyCarDomain.save(list);
	}
}
