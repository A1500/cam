package com.inspur.cams.fis.ep.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.fis.ep.base.data.FisCemeAccessories;
import com.inspur.cams.fis.ep.base.data.FisCemeCheckAudit;
import com.inspur.cams.fis.ep.base.data.FisCemeCheckInfo;
import com.inspur.cams.fis.ep.base.data.FisCemeCheckResult;
import com.inspur.cams.fis.ep.base.data.FisCemeCheckScore;
import com.inspur.cams.fis.ep.base.data.FisCemeCheckWf;

/**
 * @title: IFisCemeCheckDomain
 * @description:公墓年检表单domain接口
 * @version:1.0
 */
public interface IFisCemeCheckDomain {

	/**
	 * 查询公墓基本信息 如果是初检则按照公墓ID加载 如果是复审，则按照初检的applayId
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);
	
	public String queryPrint(ParameterSet pset);
	
	public String queryJYPrint(ParameterSet pset);
	
	/**
	 * 获得年检结果信息
	 * 
	 * @param resultId
	 * @return
	 */
	@Trans
	public FisCemeCheckResult getResult(String resultId);

	/**
	 * 更新年检结果记录
	 * 
	 * @param result
	 */
	@Trans
	public void updateResult(FisCemeCheckResult result);

	/**
	 * 保存公墓年检结果到数据库
	 * 
	 * @param result
	 */
	@Trans
	public void insert(FisCemeCheckResult result);

	/**
	 * 查询公墓年检历史记录的附件信息 只用来显示基本信息
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryAccessories(ParameterSet pset);

	/**
	 * 保存公墓年检历史记录的附件信息到数据库
	 * 
	 * @param list
	 */
	@Trans
	public void uploadSave(List<FisCemeAccessories> list);

	/**
	 * 查询公墓年检历史记录的附件信息 只用来显示基本信息
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryAccessoriesItem(ParameterSet pset);

	/**
	 * 根据Id删除公墓年检历史记录的附加信息
	 * 
	 * @param id
	 */
	@Trans
	public void delAccessoriesById(String id);

	/**
	 * 更新年检报告
	 * 
	 * @param audit
	 */
	@Trans
	public void updateAudit(FisCemeCheckAudit audit);

	/**
	 * 更新公墓年检基本
	 * 
	 * @param info
	 */
	@Trans
	public void updateInfo(FisCemeCheckInfo info);

	/**
	 * 保存年检信息到数据库
	 * 
	 * @param info
	 * @param audit
	 * @param score
	 * @param result
	 */
	@Trans
	public void save(FisCemeCheckInfo info, FisCemeCheckAudit audit,
			FisCemeCheckScore score);

	/**
	 * 查询年检报告信息
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryAudit(ParameterSet pset);

	/**
	 * 查询年检打分信息
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryScore(ParameterSet pset);
	
	/**
	 * 查询公墓基本信息
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryForCemeInfo(ParameterSet pset);

	/**
	 * @Description: 插入公益性公墓信息
	 */
	@Trans
	public void insertNoProfitCheck(FisCemeCheckWf wf);

	/**
	 * @param isUpdate 
	 * @Description: 更新公益性公墓信息
	 */
	@Trans
	public void updateNoProfitCheck(FisCemeCheckWf wf, boolean isUpdate);

	/**
	 * @Description: 上报公益性公墓信息
	 */
	@Trans
	public void reportNoProfitCheck(ParameterSet pset);

	/**
	 * @Description: 整改公益性公墓信息
	 */
	@Trans
	public void fullChangeNoProfitCheck(ParameterSet parameterSet);

	/**
	 * @Description: 插入公益性公墓检查信息
	 */
	@Trans
	public void insertProfitCheck(FisCemeCheckWf wf);

	/**
	 * @Description: 上报经营性公墓信息-检查
	 */
	@Trans
	public void reportProfitCheck(ParameterSet parameterSet);

	/**
	 * @param isUpdate 
	 * @Description: 更新经营性公墓信息
	 */
	@Trans
	public void updateProfitCheck(FisCemeCheckWf wf, boolean isUpdate);

	/**
	 * @Description: 上报经营性公墓信息-年检
	 */
	@Trans
	public void reportProfitFinalCheck(ParameterSet parameterSet);

	/**
	 * @Description: 整改经营性公墓信息-年检
	 */
	@Trans
	public void fullChangeProfitFinalCheck(ParameterSet parameterSet);
}