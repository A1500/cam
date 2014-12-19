package com.inspur.cams.prs.prspoliciesregulations.cmd;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.upload.MultipartRequestWrapper;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.prs.prspoliciesregulations.dao.PrsPoliciesRegulations;
import com.inspur.cams.prs.prspoliciesregulations.domain.IPrsPoliciesRegulationsDomain;
/**
 * @title:PrsPoliciesRegulationsCmd
 * @description:政策法规信息cmd
 * @author:jiangzhaobao
 * @since:2011年8月26日20:44:46
 * @version:1.0
*/
public class PrsPoliciesRegulationsCmd extends BaseAjaxCommand{
	IPrsPoliciesRegulationsDomain service=ScaComponentFactory.getService(IPrsPoliciesRegulationsDomain.class,"PrsPoliciesRegulationsDomain/PrsPoliciesRegulationsDomain");
	/**
	 * 新增政策法规
	 */
	@Trans
	public void insertProblemDeal(){
		ParameterSet pset=getParameterSet();
		MultipartRequestWrapper wrapRequest=(MultipartRequestWrapper)getRequest();
		service.insertProblemDeal(pset,wrapRequest);
	}
	/**
	 * 更新政策法规
	 */
	@Trans
	public void updateProblemDeal(){
		Record record=(Record)getParameter("record");
		PrsPoliciesRegulations bean=(PrsPoliciesRegulations)record.toBean(PrsPoliciesRegulations.class);
		service.update(bean);
	}
	/**
	 * 批量删除
	 */
	@Trans
	public void batchDelete(){
		String[] delIds=(String[])getParameter("delIds");
		service.batchDelete(delIds);
	}
}
