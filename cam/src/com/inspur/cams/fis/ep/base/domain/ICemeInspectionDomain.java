package com.inspur.cams.fis.ep.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.fis.ep.base.data.CemeInspection;
import com.inspur.cams.fis.ep.base.data.FisCemeAccessories;
import com.inspur.cams.fis.ep.base.data.FisCemeCheckAudit;
import com.inspur.cams.fis.ep.base.data.FisCemeCheckResult;
import com.inspur.cams.fis.ep.base.data.FisCemeCheckScore;

/**
 * @title:IInspectionDomain
 * @description:公墓年检表单domain接口
 * @author:lidongdong
 * @since:2011-11-17
 * @version:1.0
 */
public interface ICemeInspectionDomain {

	/**
	 * 查询公墓基本信息 如果是初检则按照公墓ID加载 如果是复审，则按照初检的applayId
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

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
	public void updateInfo(CemeInspection info);

	/**
	 * 保存年检信息到数据库
	 * 
	 * @param info
	 * @param audit
	 * @param score
	 * @param result
	 */
	@Trans
	public void save(CemeInspection info, FisCemeCheckAudit audit,
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

}