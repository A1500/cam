package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.base.data.BptDisabilityOpen;
import com.inspur.cams.bpt.base.domain.IBptBaseinfoPeopleDomain;
import com.inspur.cams.bpt.base.domain.IBptDisabilityOpenDomain;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;

public class BptDisabilityOpenCommand extends BaseAjaxCommand {
	@Trans
	public void updateOpen(){
		IBptDisabilityOpenDomain openService = ScaComponentFactory.getService(IBptDisabilityOpenDomain.class,
		"bptDisbilityOpenDomain/bptDisbilityOpenDomain");
		
		IBptBaseinfoPeopleDomain bptBaseinfoPeopleDomain= ScaComponentFactory.getService(IBptBaseinfoPeopleDomain.class,
		"bptBaseinfoPeopleDomain/bptBaseinfoPeopleDomain");
		
		ParameterSet pset = this.getParameterSet();
		Record record=(Record)pset.getParameter("BptPeopleDisabilityRecord");
		BptDisabilityOpen bptDisabilityOpen =(BptDisabilityOpen)record.toBean(BptDisabilityOpen.class);
		BaseinfoPeople bptBaseinfoPeople = (BaseinfoPeople)record.toBean(BaseinfoPeople.class);
		
		pset.clear();
		pset.setParameter("apply_id", bptDisabilityOpen.getApplyId());
		DataSet ds = openService.queryDisabilityOpen(pset);
		if(ds.getCount()==0){
			openService.saveOpen(bptDisabilityOpen);
		}else{
			openService.updateOpen(bptDisabilityOpen);
		}
		bptBaseinfoPeopleDomain.updateBaseinfoPeople(bptBaseinfoPeople);
	}
}
