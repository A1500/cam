package com.inspur.cams.drel.esurey.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.esurey.data.SamEsureyFamilySum;
import com.inspur.cams.drel.esurey.data.SamEsureyHouse;
import com.inspur.cams.drel.esurey.domain.ISamEsureyFamilySumDomain;
import com.inspur.cams.drel.esurey.domain.ISamEsureyHouseDomain;

public class SamEsureyFamilySumCmd extends BaseAjaxCommand {
	ISamEsureyFamilySumDomain samEsureyFamilySumDomain = ScaComponentFactory.getService(ISamEsureyFamilySumDomain.class,
	"SamEsureyFamilySumDomain/SamEsureyFamilySumDomain");
	
	public void insert() {
		Record record = (Record) getParameter("record");
		SamEsureyFamilySum dataBean=(SamEsureyFamilySum)record.toBean(SamEsureyFamilySum.class);
		samEsureyFamilySumDomain.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SamEsureyFamilySum dataBean=(SamEsureyFamilySum)record.toBean(SamEsureyFamilySum.class);
		samEsureyFamilySumDomain.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		samEsureyFamilySumDomain.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record record = (Record) getParameter("record");
		List<SamEsureyFamilySum> list = new ArrayList<SamEsureyFamilySum>();
	//	for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SamEsureyFamilySum dataBean = (SamEsureyFamilySum) record.toBean(SamEsureyFamilySum.class);
			list.add(dataBean);
		//}

		samEsureyFamilySumDomain.save(list);
	}
}
