package com.inspur.cams.drel.esurey.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.esurey.data.SamEsureyHousingFund;
import com.inspur.cams.drel.esurey.domain.ISamEsureyHousingFundDomain;

public class SamEsureyHousingFundCmd extends BaseAjaxCommand {
	ISamEsureyHousingFundDomain samEsureyHousingFundDomain = ScaComponentFactory.getService(ISamEsureyHousingFundDomain.class,
	"SamEsureyHousingFundDomain/SamEsureyHousingFundDomain");
	
	public void insert() {
		Record record = (Record) getParameter("record");
		SamEsureyHousingFund dataBean=(SamEsureyHousingFund)record.toBean(SamEsureyHousingFund.class);
		dataBean.setId(IdHelp.getUUID30());
		samEsureyHousingFundDomain.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SamEsureyHousingFund dataBean=(SamEsureyHousingFund)record.toBean(SamEsureyHousingFund.class);
		samEsureyHousingFundDomain.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		samEsureyHousingFundDomain.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SamEsureyHousingFund> list = new ArrayList<SamEsureyHousingFund>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SamEsureyHousingFund dataBean = (SamEsureyHousingFund) records[i].toBean(SamEsureyHousingFund.class);
			list.add(dataBean);
		}

		samEsureyHousingFundDomain.save(list);
	}
}
