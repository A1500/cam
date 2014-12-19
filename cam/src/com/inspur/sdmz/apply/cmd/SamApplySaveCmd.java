package com.inspur.sdmz.apply.cmd;

import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.sdmz.apply.data.SamApply;
import com.inspur.sdmz.apply.domain.ISamApplyDomain;

/**
 * 保存业务
 * @author Administrator
 * @date 2011-4-23
 */
public class SamApplySaveCmd extends BaseAjaxCommand{
	
	ISamApplyDomain samapplyDomain = ScaComponentFactory.getService(ISamApplyDomain.class, "SamApplyDomain/SamApplyDomain");
	
	/**
	 * 救助业务的保存方法
	 */
	public void assistanceSave() {
		SamApply samapply = (SamApply) getParameter("applyRecord");
		String area=(String)getParameter("area");
		
		samapply.setApplyType("1");
		samapplyDomain.saveSamApply(samapply,area);
	}
	
	/**
	 * 投诉业务的保存方法
	 */
	public void complaintSave() {
		SamApply samapply = (SamApply) getParameter("complaintRecord");
		String area=(String)getParameter("area");
		samapply.setApplyType("2");
		samapplyDomain.saveSamApply(samapply,area);
	}
	
	/**
	 * 咨询业务的保存方法
	 */
	public void consultSave() {
		SamApply samapply = (SamApply) getParameter("consultRecord");
		String area=(String)getParameter("area");
		samapply.setApplyType("3");
		samapplyDomain.saveSamApply(samapply,area);
	}
	
	/**
	 * 更新页面里的更新方法
	 */
	public void samapplyUpdate() {
		String area=(String) getParameter("area");
		SamApply samapply = (SamApply) getParameter("samapplyRecord");
		samapplyDomain.updateSamApply(samapply,area);
		
	}
	public void samapplybgUpdate() {
		SamApply samapply = (SamApply) getParameter("samapplyRecord");
		samapplyDomain.updatebgSamApply(samapply);
		
	}
	/**
	 * 回访业务的保存2
	 */
	public void ywhf() {
		SamApply samapply = (SamApply) getParameter("ywhfRecord");
		String[] applyId=(String[])getParameter("delIds");
		samapplyDomain.ywhf(samapply,applyId);
	}
	
}
