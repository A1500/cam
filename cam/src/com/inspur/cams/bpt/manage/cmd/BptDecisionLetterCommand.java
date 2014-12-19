package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.base.data.BptDecisionLetter;
import com.inspur.cams.bpt.base.domain.IBptDecisionLetterDomain;

public class BptDecisionLetterCommand extends BaseAjaxCommand{
	IBptDecisionLetterDomain decisionLetterService = ScaComponentFactory.getService(IBptDecisionLetterDomain.class,
	"bptDecisionLetterDomain/bptDecisionLetterDomain");
	@Trans
	public void updateDecisionLetter() {
		Record record = (Record)this.getParameter("record");
		BptDecisionLetter bptDecisionLetter = (BptDecisionLetter)record.toBean(BptDecisionLetter.class);
		String applyId = (String)record.get("applyId");
		ParameterSet pset = new ParameterSet();
		pset.setParameter("APPLY_ID", applyId);
		DataSet ds = decisionLetterService.queryDecisionLetter(pset);
		if(ds.getCount()>0){
			decisionLetterService.updateDecisionLetter(bptDecisionLetter);
		}else{
			decisionLetterService.saveDecisionLetter(bptDecisionLetter);
		}
		
	}
	
	
	/**
	 * 查询是否含有公式书详细信息
	 * @return
	 */
	public void ifHave() {
		String applyId = (String)getParameter("applyId");
		ParameterSet pset = new ParameterSet();
		pset.setParameter("APPLY_ID",applyId);
		DataSet ds = decisionLetterService.queryDecisionLetter(pset);
		if(ds.getCount() == 0) {
			setReturn("ifhave", false);
		} else {
			setReturn("ifhave", true);
		}
	}
}
