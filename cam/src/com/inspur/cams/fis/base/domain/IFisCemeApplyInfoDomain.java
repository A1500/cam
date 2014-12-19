package com.inspur.cams.fis.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.fis.base.data.FisCemeAccessories;
import com.inspur.cams.fis.base.data.FisCemeApplyInfo;

/**
 * 公墓审批业务表domain
 * 
 * @author
 * @date 2013-08-01
 */
public interface IFisCemeApplyInfoDomain {

	/**
	 * 查询 公墓审批业务表
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 公墓审批业务表
	 * 
	 * @param pset
	 * @return
	 */
	public FisCemeApplyInfo get(String cemeApplyId);

	/**
	 * 增加 公墓审批业务表
	 * 
	 * @param fisCemeApplyInfo
	 */
	@Trans
	public void insert(FisCemeApplyInfo fisCemeApplyInfo);

	/**
	 * 修改 公墓审批业务表
	 * 
	 * @param fisCemeApplyInfo
	 */
	@Trans
	public void update(FisCemeApplyInfo fisCemeApplyInfo);

	/**
	 * 删除 公墓审批业务表
	 * 
	 * @param cemeApplyId
	 */
	@Trans
	public void delete(String cemeApplyId);
	
	
	 
	 //加载 公墓审批业务首页
	public DataSet queryDaiban(ParameterSet pset);
	
	public DataSet queryPublic(ParameterSet pset);
	@Trans
	public void insertAll(ParameterSet pset);
	@Trans
	public void deleteAll(ParameterSet pset);
	// 删除
	@Trans
	public void createAndSendYearlyCheck(ParameterSet pset);
	@Trans
	public void send(ParameterSet pset);
	@Trans
	public void sendMore(ParameterSet pset);
	@Trans
	public void updateAll(ParameterSet pset);

	/**
	 * 更新 并发起流程
	 * 
	 * @param pset
	 */
	@Trans
	public void updateAndSend(ParameterSet pset);

	/**
	 * 发送 撤销流程
	 * 
	 * @param pset
	 */
	@Trans
	public void sendLogoff(ParameterSet pset);
	
	/**
	 * 公益性公墓申建流程发起环节
	 * @param cemeApplyId
	 * */
	@Trans
	public void startCreate(String cemeApplyId);
	
	/**
	 * 公益性公墓申建流程审批环节
	 * @param fisCemeApplyInfo, result, assignmentId
	 * */
	@Trans
	public void sendOfCreate(FisCemeApplyInfo fisCemeApplyInfo,String result,String assignmentId);
	
	/**
	 * 经营性公墓申建流程发起环节
	 * @param cemeApplyId
	 * */
	@Trans
	public void startCreateOperation(String cemeApplyId);
	
	/**
	 * 经营性公墓申建流程审核审批环节
	 * @param fisCemeApplyInfo, result, assignmentId
	 * */
	@Trans
	public void sendOfCreateOperation(FisCemeApplyInfo fisCemeApplyInfo,String result,String assignmentId);
	
	@Trans
	public DataSet queryCreate(ParameterSet pset);
	
	@Trans
	public DataSet queryExpend(ParameterSet pset);


	/**
	 * 发送 变更流程
	 * 
	 * @param pset
	 */
	@Trans
	public void sendChange(ParameterSet pset);
	/**
	 * 查询公墓
	 * 关联info表和ApplyInfo表
	 * @param pset
	 * @return
	 */
	@Trans
	public DataSet queryCeme(ParameterSet pset);
	
	/**
	 * 查询公墓
	 * 关联info表和ApplyInfo表
	 * @param pset
	 * @return
	 */
	@Trans
	public DataSet queryCemeApply(ParameterSet pset);
	
	
	/**
	 * 更新公益性公墓关闭业务
	 * 
	 * @param pset
	 */
	@Trans
	public void cemeLogoffUpdate(ParameterSet pset);
	/**
	 * 新增 经营性公墓关闭业务
	 * 
	 * @param pset
	 */
	@Trans
	public void insertLogoff(ParameterSet pset);
	/**
	 * 更新 经营性公墓关闭业务
	 * 
	 * @param pset
	 */
	@Trans
	public void updateLogoff(ParameterSet pset);
	/**
	 * 审批 公益性公墓关闭业务
	 * 
	 * @param pset
	 */
	@Trans
	public void cemeLogoffSubmit(ParameterSet pset);
	@Trans
	public void cemeLogoffDelete(ParameterSet pset);
	@Trans
	public void cemeChangeDelete(ParameterSet pset);
	@Trans
	public DataSet queryAccessories(ParameterSet pset);
	@Trans
	public DataSet queryAccessoriesItem(ParameterSet pset);
	@Trans
	public DataSet queryAccessoryType(ParameterSet pset);
	/**
	 * 保存公墓年检历史记录的附件信息到数据库
	 * 
	 * @param list
	 */
	@Trans
	public void uploadSave(List<FisCemeAccessories> list);
	/**
	 * 根据Id删除公墓年检历史记录的附加信息
	 * 
	 * @param id
	 */
	@Trans
	public void delAccessoriesById(String id);

	@Trans
	public void deleteCreate(ParameterSet pset);
	//删除扩建信息
	@Trans
	public void deleteExpend(ParameterSet pset);
	@Trans
	public DataSet queryByCurActicity(ParameterSet pset);
	/*
	 * 公益性公墓变更流程_审批_驳回环节
	 * @param ParameterSet
	 */
	@Trans
	public void sendPublicChange(ParameterSet pset);
	
	@Trans
	public void startCreateExpendOp(String cemeApplyId);
	@Trans
	public void sendOfExpendOp(FisCemeApplyInfo fisCemeApplyInfo,String result,String assignmentId);;
	@Trans
	public void startOfExpend(String cemeApplyId);
	@Trans
	public void sendOfExpend(FisCemeApplyInfo fisCemeApplyInfo,String result,String assignmentId);

	
	/*
	 * 经营性公墓验收流程更新
	 */
	@Trans
	public void insertAcceptance(ParameterSet pset);
	@Trans
	public void insertAcceptanceForExpend(ParameterSet pset);

	public void startCemeAcceptance(String cemeApplyId);

	public void sendCemeAcceptance(FisCemeApplyInfo fisCemeApplyInfo, String result, String assignmentId);

	public void deleteAcceptance(ParameterSet pset);
	/**
	 * 查询公墓
	 * 关联info表、ApplyInfo表和expend表
	 * @param pset
	 * @return
	 */
	@Trans
	public DataSet queryYS(ParameterSet pset);
	
	public void sendCemeAcceptanceCity(FisCemeApplyInfo fisCemeApplyInfo, String result, String assignmentId);
	
	

}