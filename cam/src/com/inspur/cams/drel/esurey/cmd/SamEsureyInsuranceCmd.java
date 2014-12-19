package com.inspur.cams.drel.esurey.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.esurey.data.SamEsureyInsurance;
import com.inspur.cams.drel.esurey.domain.ISamEsureyInsuranceDomain;

public class SamEsureyInsuranceCmd extends BaseAjaxCommand {
	ISamEsureyInsuranceDomain samEsureyInsuranceDomain = ScaComponentFactory.getService(ISamEsureyInsuranceDomain.class,
	"SamEsureyInsuranceDomain/SamEsureyInsuranceDomain");
	
	public void insert() {
		Record record = (Record) getParameter("record");
		SamEsureyInsurance dataBean=(SamEsureyInsurance)record.toBean(SamEsureyInsurance.class);
		dataBean.setId(IdHelp.getUUID30());
		samEsureyInsuranceDomain.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SamEsureyInsurance dataBean=(SamEsureyInsurance)record.toBean(SamEsureyInsurance.class);
		samEsureyInsuranceDomain.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		samEsureyInsuranceDomain.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SamEsureyInsurance> list = new ArrayList<SamEsureyInsurance>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SamEsureyInsurance dataBean = (SamEsureyInsurance) records[i].toBean(SamEsureyInsurance.class);
			list.add(dataBean);
		}

		samEsureyInsuranceDomain.save(list);
	}
}
