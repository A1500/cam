package com.inspur.cams.drel.esurey.cmd;

import java.util.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.esurey.data.SamEsureyPeopleEstate;
import com.inspur.cams.drel.esurey.data.SamEsureySocial;
import com.inspur.cams.drel.esurey.domain.ISamEsureyPeopleEstateDomain;
import com.inspur.cams.drel.esurey.domain.ISamEsureySocialDomain;

/**
 * @title:SamEsureySocialCommand
 * @description:人力资源与社会保障Command
 * @author:luguosui
 * @since:2011-06-29
 * @version:1.0
*/
public class SamEsureySocialCmd extends BaseAjaxCommand{
	ISamEsureySocialDomain samEsureySocialDomain = ScaComponentFactory.getService(ISamEsureySocialDomain.class,
	"SamEsureySocialDomain/SamEsureySocialDomain");
	ISamEsureyPeopleEstateDomain samEsureyPeopleEstateDomain = ScaComponentFactory.getService(ISamEsureyPeopleEstateDomain.class,
	"SamEsureyPeopleEstateDomain/SamEsureyPeopleEstateDomain");
	
	public void insert() {
		Record record = (Record) getParameter("record");
		SamEsureySocial dataBean=(SamEsureySocial)record.toBean(SamEsureySocial.class);
		dataBean.setId(IdHelp.getUUID30());
		samEsureySocialDomain.insert(dataBean);
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
		SamEsureySocial dataBean=(SamEsureySocial)record.toBean(SamEsureySocial.class);
		samEsureySocialDomain.update(dataBean);
		//经济核对_财产收入申报信息存储
		Record estateRecord = (Record) getParameter("estateRecord");
		if(estateRecord!=null){
			SamEsureyPeopleEstate estateDataBean=(SamEsureyPeopleEstate)estateRecord.toBean(SamEsureyPeopleEstate.class);
			samEsureyPeopleEstateDomain.upadetPeopleEstate(estateDataBean);
			//samEsureyPeopleEstateDomain.update(estateDataBean);
		}
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		samEsureySocialDomain.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SamEsureySocial> list = new ArrayList<SamEsureySocial>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SamEsureySocial dataBean = (SamEsureySocial) records[i].toBean(SamEsureySocial.class);
			list.add(dataBean);
		}

		samEsureySocialDomain.save(list);
	}
	
	public void delete(String peopleId){
		String sql="delete from sam_esurey_social where peopleId='"+peopleId+"'";
	}
}
