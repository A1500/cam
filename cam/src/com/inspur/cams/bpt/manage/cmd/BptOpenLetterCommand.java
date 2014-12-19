package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.base.data.BptDisabilityOpen;
import com.inspur.cams.bpt.base.data.BptOpenLetter;
import com.inspur.cams.bpt.base.domain.IBptBaseinfoPeopleDomain;
import com.inspur.cams.bpt.base.domain.IBptDisabilityOpenDomain;
import com.inspur.cams.bpt.base.domain.IBptOpenLetterDomain;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;

public class BptOpenLetterCommand extends BaseAjaxCommand {
	@Trans
	public void updateOpen(){
		IBptOpenLetterDomain openService = ScaComponentFactory.getService(IBptOpenLetterDomain.class,
		"bptOpenLetterDomain/bptOpenLetterDomain");
		
		IBptBaseinfoPeopleDomain bptBaseinfoPeopleDomain= ScaComponentFactory.getService(IBptBaseinfoPeopleDomain.class,
		"bptBaseinfoPeopleDomain/bptBaseinfoPeopleDomain");
		
		ParameterSet pset = this.getParameterSet();
		Record record=(Record)pset.getParameter("BptOpenLetterRecord");
		BptOpenLetter bptOpenLetter =(BptOpenLetter)record.toBean(BptOpenLetter.class);
		//BaseinfoPeople bptBaseinfoPeople = (BaseinfoPeople)record.toBean(BaseinfoPeople.class);
		/*pset.clear();
		pset.setParameter("peopel_id", bptOpenLetter.getPeopleId());
		BaseinfoPeople bptBaseinfoPeople = (BaseinfoPeople)bptBaseinfoPeopleDomain.queryBaseinfoPeople(pset).getRecord(0).toBean(BaseinfoPeople.class);
		bptBaseinfoPeople.setAddress(bptOpenLetter.get);
		bptBaseinfoPeople.setWorkUnitName(bptOpenLetter.get)*/
		pset.clear();
		pset.setParameter("apply_id", bptOpenLetter.getApplyId());
		DataSet ds = openService.queryOpenLetter(pset);
		if(ds.getCount()==0){
			openService.saveOpen(bptOpenLetter);
		}else{
			openService.updateOpen(bptOpenLetter);
		}
		//bptBaseinfoPeopleDomain.updateBaseinfoPeople(bptBaseinfoPeople);
	}
}
