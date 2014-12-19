package com.inspur.cams.bpt.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.base.data.BptApplyMartyrOffspring;

/**
 * @title:IBptApplyMartyrOffspringDao
 * @description:部分烈士（错杀被平反人员）子女\60周岁以上农村籍退役士兵 申请信息 domain层接口
 * @author:
 * @since: 
 * @version: 
*/
public interface IBptApplyMartyrOffspringDomain{
	/**
	 * 添加
	 */
	public void insert(BptApplyMartyrOffspring bptApplyMartyrOffspring);
	
	/**
	 * 删除
	 */
	public void delete(BptApplyMartyrOffspring bptApplyMartyrOffspring);
	
	/**
	 * 修改
	 * @param bptApplyMartyrOffspring
	 */
	public void update(BptApplyMartyrOffspring bptApplyMartyrOffspring);
	
	/**
	 * 查询
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);
	
	/**
  	 * 查询未提交部分烈士（错杀被平反人员）子女人员信息
  	 * @param pset
  	 * @return
  	 */
  	public DataSet queryUnCommitRecord(ParameterSet pset);
  	
  	 /**
	  * 删除部分烈士（错杀被平反人员）子女申请信息
	  */
	public void deleteMartyrOffspring(ParameterSet pset);
	
	/**
	 * 
	 * 查询 已提交 部分烈士（错杀被平反人员）子女申请信息
	 * @param pset
	 * @return
	 */
	public DataSet queryMartyrOffspirng(ParameterSet pset);
}

