package com.inspur.cams.drel.esurey.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.esurey.data.SamEsureyPeopleEstate;
import com.inspur.cams.drel.esurey.data.SamEsureySecurities;
import com.inspur.cams.drel.esurey.domain.ISamEsureyPeopleEstateDomain;
import com.inspur.cams.drel.esurey.domain.ISamEsureySecuritiesDomain;
/**
 * 证监Command
 * @author 路国隋
 *
 */
public class SamEsureySecuritiesCmd extends BaseAjaxCommand {
	ISamEsureySecuritiesDomain samEsureySecuritiesDomain = ScaComponentFactory.getService(ISamEsureySecuritiesDomain.class,
	"SamEsureySecuritiesDomain/SamEsureySecuritiesDomain");
	ISamEsureyPeopleEstateDomain samEsureyPeopleEstateDomain = ScaComponentFactory.getService(ISamEsureyPeopleEstateDomain.class,
	"SamEsureyPeopleEstateDomain/SamEsureyPeopleEstateDomain");
	
	public void insert() {
		Record record = (Record) getParameter("record");
		SamEsureySecurities dataBean=(SamEsureySecurities)record.toBean(SamEsureySecurities.class);
		dataBean.setId(IdHelp.getUUID30());
		samEsureySecuritiesDomain.insert(dataBean);
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
		SamEsureySecurities dataBean=(SamEsureySecurities)record.toBean(SamEsureySecurities.class);
		samEsureySecuritiesDomain.update(dataBean);
		//经济核对_财产收入申报信息存储
		Record estateRecord = (Record) getParameter("estateRecord");
		if(estateRecord!=null){
			SamEsureyPeopleEstate estateDataBean=(SamEsureyPeopleEstate)estateRecord.toBean(SamEsureyPeopleEstate.class);
			samEsureyPeopleEstateDomain.upadetPeopleEstate(estateDataBean);
		}
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		samEsureySecuritiesDomain.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SamEsureySecurities> list = new ArrayList<SamEsureySecurities>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SamEsureySecurities dataBean = (SamEsureySecurities) records[i].toBean(SamEsureySecurities.class);
			list.add(dataBean);
		}

		samEsureySecuritiesDomain.save(list);
	}
}
