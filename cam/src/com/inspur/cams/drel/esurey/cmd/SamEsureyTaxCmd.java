package com.inspur.cams.drel.esurey.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.esurey.data.SamEsureyTax;
import com.inspur.cams.drel.esurey.domain.ISamEsureyTaxDomain;

public class SamEsureyTaxCmd extends BaseAjaxCommand {
	ISamEsureyTaxDomain samEsureyTaxDomain = ScaComponentFactory.getService(ISamEsureyTaxDomain.class,
	"SamEsureyTaxDomain/SamEsureyTaxDomain");
	
	public void insert() {
		Record record = (Record) getParameter("record");
		SamEsureyTax dataBean=(SamEsureyTax)record.toBean(SamEsureyTax.class);
		dataBean.setId(IdHelp.getUUID30());
		samEsureyTaxDomain.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SamEsureyTax dataBean=(SamEsureyTax)record.toBean(SamEsureyTax.class);
		samEsureyTaxDomain.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		samEsureyTaxDomain.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SamEsureyTax> list = new ArrayList<SamEsureyTax>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SamEsureyTax dataBean = (SamEsureyTax) records[i].toBean(SamEsureyTax.class);
			list.add(dataBean);
		}

		samEsureyTaxDomain.save(list);
	}
}
