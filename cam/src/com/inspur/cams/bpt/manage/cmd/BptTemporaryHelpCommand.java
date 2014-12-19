package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.base.data.BptTemporaryHelp;
import com.inspur.cams.bpt.base.domain.IBptTemporaryHelpDomain;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * @title:BptTemporaryHelpCommand
 * @description:
 * @author:
 * @since:2011-06-09
 * @version:1.0
 */
public class BptTemporaryHelpCommand extends BaseAjaxCommand {

	IBptGroupDomain service = ScaComponentFactory.getService(
			IBptGroupDomain.class, "bptGroupDomain/bptGroupDomain");

	private IBptTemporaryHelpDomain bptTemporaryService = ScaComponentFactory
			.getService(IBptTemporaryHelpDomain.class,
					"bptTemporaryHelpDomain/bptTemporaryHelpDomain");

	@Trans
	public void save() {
		Record record = (Record) getParameter("record");
		String applyId = IdHelp.getUUID32();
		String peopleId = (String) record.get("peopleId");
		BptTemporaryHelp dataBean = (BptTemporaryHelp) record
				.toBean(BptTemporaryHelp.class);
		dataBean.setApplyId(applyId);
		dataBean.setRegId(BspUtil.getEmpOrganId());
		dataBean.setRegTime(DateUtil.getTime());
		dataBean.setModId(BspUtil.getEmpOrganId());
		dataBean.setModTime(DateUtil.getTime());
		dataBean.setSubmitFlag("0");
		bptTemporaryService.insertTemporaryHelp(dataBean);
		ParameterSet pset = new ParameterSet();
		pset.setParameter("PEOPLE_ID", peopleId);
		DataSet ds = service.queryPeople(pset);
		String familyId = (String) ds.getRecord(0).get("familyId");
		this.setReturn("applyId", applyId);
		this.setReturn("familyId", familyId);
	}

	@Trans
	public void submit() {
		Record[] records = (Record[]) getParameter("records");
		BptTemporaryHelp dataBean = null;
		String id = "";
		ParameterSet pset = new ParameterSet();
		for (int i = 0; i < records.length; i++) {
			id = (String) records[i].get("APPLY_ID");
			pset.setParameter("APPLY_ID", id);
			dataBean = (BptTemporaryHelp) bptTemporaryService.query(pset)
					.getRecord(0).toBean(BptTemporaryHelp.class);
			dataBean.setSubmitFlag("1");
			bptTemporaryService.updateTemporaryHelp(dataBean);
		}
	}

	@Trans
	public void submitById() {
		BptTemporaryHelp dataBean = null;
		String applyId = (String) getParameter("applyId");
		ParameterSet pset = new ParameterSet();
		pset.setParameter("APPLY_ID", applyId);
		dataBean = (BptTemporaryHelp) bptTemporaryService.query(pset)
				.getRecord(0).toBean(BptTemporaryHelp.class);
		dataBean.setSubmitFlag("1");
		bptTemporaryService.updateTemporaryHelp(dataBean);
	}

	@Trans
	public void update() {
		Record record = (Record) getParameter("records");
		BptTemporaryHelp dataBean = (BptTemporaryHelp) record
				.toBean(BptTemporaryHelp.class);
		service.updateTemporaryHelp(dataBean);
	}

	@Trans
	public void delete() {
		String[] delIds = (String[]) getParameter("delIds");
		service.deleteTemporaryHelp(delIds);
	}
	
	@Trans
	public void queryAdvice() {
		BptTemporaryHelp dataBean = null;
		String applyId = (String) getParameter("applyId");
		ParameterSet pset = new ParameterSet();
		pset.setParameter("APPLY_ID", applyId);
		DataSet ds = bptTemporaryService.query(pset);
		if(ds.getCount()>0){
			dataBean = (BptTemporaryHelp) bptTemporaryService.query(pset)
					.getRecord(0).toBean(BptTemporaryHelp.class);
			String v = dataBean.getVerifyAdvice();
			if(v!=null&&!"".equals(v)){
				this.setReturn("flag", true);
			}else{
				this.setReturn("flag", false);
			}
		}else{
			this.setReturn("flag", false);
		}
		
		
	}
}
