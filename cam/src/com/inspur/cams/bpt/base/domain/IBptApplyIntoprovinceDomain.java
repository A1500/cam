package com.inspur.cams.bpt.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.base.data.BptApplyIntoprovince;

/**
 * @description:外省优抚人员抚恤关系迁入我省
 * @author:
 * @since:2011-07-14
 * @version:1.0
*/
 public interface IBptApplyIntoprovinceDomain {
	 /**
	  * 查询
	  * @param pset
	  * @return
	  */
	public DataSet query(ParameterSet pset);
	
	/**
	 * 添加一条记录
	 */
	public void insert(BptApplyIntoprovince bptApplyIntoprovince);
	
	/**
	 * 修改一条记录
	 */
	public void update(BptApplyIntoprovince bptApplyIntoprovince);
	
	/**
	 * 查询未发起流程的外省残疾人员抚恤关系迁入我省人员信息列表
	 */
	public DataSet queryUnCommitDisaIntoprovi(ParameterSet pset);
	
	/**
	 * 查询未提交的三属外省迁入我省信息列表
	 * @param pset
	 * @return
	 */
	public DataSet queryUncommitDependIntoprovin(ParameterSet pset);
	
	//***********************************************参战***************************************
	/**
	 * 查询未提交的参战外省迁入我省信息列表
	 * @param pset
	 * @return
	 */
	public DataSet queryUnCommitWarIntoprovi(ParameterSet pset);

	/**
	 * 查询未提交的外省迁入我省参试抚恤关系列表
	 * 
	 */
	public DataSet queryUncommitTestedIntoprovin(ParameterSet pset);
	
	/**
	 * 查询其他抚恤关系外省迁入
	 * @return
	 */
	public DataSet queryIntoprovin(ParameterSet pset); 
	/**
	 * 删除抚恤关系跨省迁入
	 * @param pset
	 * @return
	 */
	public void deleteIntoprovince(ParameterSet pset);
}