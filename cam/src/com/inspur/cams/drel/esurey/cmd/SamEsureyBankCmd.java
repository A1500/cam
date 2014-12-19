package com.inspur.cams.drel.esurey.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.esurey.data.SamEsureyBank;
import com.inspur.cams.drel.esurey.data.SamEsureyPeopleEstate;
import com.inspur.cams.drel.esurey.domain.ISamEsureyBankDomain;
import com.inspur.cams.drel.esurey.domain.ISamEsureyPeopleEstateDomain;
import com.inspur.cams.comm.util.IdHelp;
/**
 * 银行信息Command
 * @author 路国隋
 *
 */
public class SamEsureyBankCmd extends BaseAjaxCommand {
	ISamEsureyBankDomain samEsureyBankDomain = ScaComponentFactory.getService(ISamEsureyBankDomain.class,
	"SamEsureyBankDomain/SamEsureyBankDomain");
	ISamEsureyPeopleEstateDomain samEsureyPeopleEstateDomain = ScaComponentFactory.getService(ISamEsureyPeopleEstateDomain.class,
	"SamEsureyPeopleEstateDomain/SamEsureyPeopleEstateDomain");
	
	public void insert() {
		Record record = (Record) getParameter("record");
		SamEsureyBank dataBean=(SamEsureyBank)record.toBean(SamEsureyBank.class);
		dataBean.setId(IdHelp.getUUID30());
		samEsureyBankDomain.insert(dataBean);
		//经济核对_财产收入申报信息存储
		Record estateRecord = (Record) getParameter("estateRecord");
		if(estateRecord!=null){
			SamEsureyPeopleEstate estateDataBean=(SamEsureyPeopleEstate)estateRecord.toBean(SamEsureyPeopleEstate.class);
			estateDataBean.setId(IdHelp.getUUID30());
			samEsureyPeopleEstateDomain.insert(estateDataBean);
		}
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SamEsureyBank dataBean=(SamEsureyBank)record.toBean(SamEsureyBank.class);
		samEsureyBankDomain.update(dataBean);
		//经济核对_财产收入申报信息存储
		Record estateRecord = (Record) getParameter("estateRecord");
		if(estateRecord!=null){
			SamEsureyPeopleEstate estateDataBean=(SamEsureyPeopleEstate)estateRecord.toBean(SamEsureyPeopleEstate.class);
			samEsureyPeopleEstateDomain.upadetPeopleEstate(estateDataBean);
		}
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		samEsureyBankDomain.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SamEsureyBank> list = new ArrayList<SamEsureyBank>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SamEsureyBank dataBean = (SamEsureyBank) records[i].toBean(SamEsureyBank.class);
			list.add(dataBean);
		}

		samEsureyBankDomain.save(list);
	}
}
