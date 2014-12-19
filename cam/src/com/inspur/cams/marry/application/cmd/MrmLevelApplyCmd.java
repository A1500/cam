package com.inspur.cams.marry.application.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.marry.application.domain.IMrmLevelApplyDomain;
import com.inspur.cams.marry.base.data.MrmOrganStandardApply;

/**
 * 婚姻登记机关等级评定申报cmd
 */
public class MrmLevelApplyCmd extends BaseAjaxCommand {
	private IMrmLevelApplyDomain service = ScaComponentFactory.getService(IMrmLevelApplyDomain.class,"mrmLevelApplyDomain/mrmLevelApplyDomain");
	/**
	 * 新增业务信息
	 */
	public void insert(){
		String applyId=service.insert(getApply());
		setReturn("applyId", applyId);
	}
	public void insertu(){
		String applyId=service.insertu(getApply());
		setReturn("applyId", applyId);
	}
	/**
	 * 新增并提交
	 */
	public void insertAndSend(){
		service.insertAndSend(getApply());
	}
	public void insertuAndSend(){
		service.insertuAndSend(getApply());
	}
	/**
	 * 修改业务信息
	 */
	public void update(){
		service.update(getApply());
	}
	/**
	 * 修改并提交
	 */
	public void updateAndSend(){
		service.updateAndSend(getApply());
	}
	/**
	 * 删除业务信息
	 */
	public void delete(){
		String applyId = (String) getParameter("applyId");
		service.delete(applyId);
	}
	public void deleteElec(){
		String applyId = (String) getParameter("applyId");
		service.deleteElec(applyId);
	}
	private MrmOrganStandardApply getApply(){
		Record applyRecord = (Record) getParameter("applyRecord");
		MrmOrganStandardApply mrmOrganStandardApply=(MrmOrganStandardApply)applyRecord.toBean(MrmOrganStandardApply.class);		
		return mrmOrganStandardApply;
	}
}
