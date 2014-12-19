package com.inspur.cams.sorg.apply.fund.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomApply;

public interface IFundBuildDomain {
	/**
	 * 保存社会团体成立登记
	 * 
	 * @param dataBean
	 */
	@Trans
	public void insertReportInfo(SomApply applyBean);
		
	/**
	 * 业务信息保存创建并发送
	 * @param sorgId
	 * @param flowBean
	 */
	@Trans
	public void createAndSend(SomApply applyBean);
	
	/**
	 * 更新社会团体成立登记
	 * 
	 * @param dataBean
	 */
	@Trans
	public void updateReportInfo(SomApply applyBean);	
	
	/**
	 * 更新并发送流程
	 * @param somApply
	 */
	@Trans
	public void updateForSendReport(SomApply somApply);
	
	/**
	 * 保存社会团体成立登记
	 * 
	 * @param dataBean
	 */
	@Trans
	public void insertBuildInfo(SomApply applyBean);
	
	
	/**
	 * 业务信息保存创建并发送
	 * @param sorgId
	 * @param flowBean
	 */
	@Trans
	public void saveAndSendBuild(SomApply applyBean);
	
	/**
	 * 更新社会团体成立登记
	 * 
	 * @param dataBean
	 */
	@Trans
	public void updateBuildInfo(SomApply applyBean);
	
	/**
	 * 更新业务意见信息
	 * @param applyBean
	 */
	@Trans
	public void updateApply(SomApply applyBean);
	
	/**
	 * 保存并发送
	 * @param sorgId
	 * @param actDefUniqueId
	 * @param flowBean
	 */
	@Trans
	public void send(SomApply applyBean);
	
	/**
	 * 打印环节发送
	 * @param applyBean
	 */
	@Trans
	public void printForSend(SomApply applyBean);
	
	/**
	 * 获取最后环节processId
	 * @param id assignmentId
	 * @return
	 */
	public String queryProcessId(String id);
	
	/**
	 * 通过processId获取taskCode
	 * @param processId
	 * @return
	 */
	public SomApply queryTaskCode(String processId);
	
	/**
	 * 社会组织主表查询
	 * @param pset
	 * @return
	 */
	public DataSet queryOrgan(ParameterSet pset);
	
	/**
	 * 业务流程意见表查询
	 * @param pset
	 * @return
	 */
	public DataSet queryFlow(ParameterSet pset);
	/**
	 * 更新并发送流程
	 * @param somApply
	 */
	@Trans
	public void updateForSend(SomApply somApply);
	/**
	 * 登记发证中的保存
	 * @param somApply
	 */
	@Trans
	public void saveRegister(SomApply somApply);
	
	/**
	 * 保存照片并返回照片Id
	 * @param pset
	 */
	@Trans
	public String savePhoto(String photoText);
	
	/**
	 * 更新照片
	 * @param photoId
	 * @param photoText
	 */
	@Trans
	public String updatePhoto(String photoId,String photoText);
}
