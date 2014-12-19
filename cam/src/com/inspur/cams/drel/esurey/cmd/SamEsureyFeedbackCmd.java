package com.inspur.cams.drel.esurey.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.esurey.data.SamEsureyFeedback;
import com.inspur.cams.drel.esurey.data.SamEsureyPeopleEstate;
import com.inspur.cams.drel.esurey.domain.ISamEsureyFeedbackDomain;
import com.inspur.cams.drel.esurey.domain.ISamEsureyPeopleEstateDomain;
/**
 * @title:SamEsureySocialCommand
 * @description:经济核对_外部单位填报信息Command
 * @author:luguosui
 * @since:2011-06-30
 * @version:1.0
*/
public class SamEsureyFeedbackCmd extends BaseAjaxCommand {
	private ISamEsureyFeedbackDomain service = ScaComponentFactory.getService(
			ISamEsureyFeedbackDomain.class, "SamEsureyFeedbackDomain/SamEsureyFeedbackDomain");
	private ISamEsureyPeopleEstateDomain samEsureyPeopleEstateDomain = ScaComponentFactory.getService(ISamEsureyPeopleEstateDomain.class,
	"SamEsureyPeopleEstateDomain/SamEsureyPeopleEstateDomain");
	public void insert() {
		Record record = (Record) getParameter("record");
		SamEsureyFeedback dataBean=(SamEsureyFeedback)record.toBean(SamEsureyFeedback.class);
		service.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SamEsureyFeedback dataBean=(SamEsureyFeedback)record.toBean(SamEsureyFeedback.class);
		service.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		service.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SamEsureyFeedback> list = new ArrayList<SamEsureyFeedback>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SamEsureyFeedback dataBean = (SamEsureyFeedback) records[i].toBean(SamEsureyFeedback.class);
			list.add(dataBean);
		}

		service.save(list);
	}
	//更新经济核对_外部单位填报信息表中提交标志
	public void updateCheckFlg(){
		ParameterSet paramSet=getParameterSet();
		//经济核对_财产收入申报信息存储
		Record estateRecord = (Record) getParameter("estateRecord");
		if(estateRecord!=null){
			SamEsureyPeopleEstate estateDataBean=(SamEsureyPeopleEstate)estateRecord.toBean(SamEsureyPeopleEstate.class);
			estateDataBean.setId(IdHelp.getUUID30());
			samEsureyPeopleEstateDomain.insert(estateDataBean);
		}
		service.updateCheckFlg(paramSet);	
	}
}
