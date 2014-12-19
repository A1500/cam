package com.inspur.cams.prs.prsproblemdeal.cmd;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.upload.MultipartRequestWrapper;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;
import org.loushang.next.data.Record;

import com.inspur.cams.prs.prsproblemdeal.domain.IPrsProblemDealDomain;
import com.inspur.cams.prs.prsproblemdeal.dao.PrsProblemDeal;
/**
 * @title:PrsProblemDealCmd
 * @description:问题处理信息管理
 * @author:jiangzhaobao
 * @since:2011年8月26日16:32:52
 * @version:1.0
*/
public class PrsProblemDealCmd extends BaseAjaxCommand{
	
	IPrsProblemDealDomain service=ScaComponentFactory.getService(IPrsProblemDealDomain.class,"PrsProblemDealDomain/PrsProblemDealDomain");

	/**
	 * 新增问题处理
	 */
	@Trans
	public void insertProblemDeal(){
		ParameterSet pset=getParameterSet();
		MultipartRequestWrapper wrapRequest=(MultipartRequestWrapper)getRequest();
		service.insert(pset,wrapRequest);
		
	}
	/**
	 * 问题处理
	 */
	@Trans
	public void processProblemDeal(){
		ParameterSet pset=getParameterSet();
		service.process(pset);
	}
	/**
	 * 更新问题处理
	 */
	@Trans
	public void updateProblemDeal(){
		ParameterSet pset=getParameterSet();
		MultipartRequestWrapper wrapRequest=(MultipartRequestWrapper)getRequest();
		service.update(pset,wrapRequest);
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
