package com.inspur.cams.bpt.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.bpt.base.dao.IBptApplyMartyrOffspringDao;
import com.inspur.cams.bpt.base.data.BptApplyMartyrOffspring;
import com.inspur.cams.bpt.base.domain.IBptApplyMartyrOffspringDomain;

/**
 * @title:IBptApplyMartyrOffspringDao
 * @description:部分烈士（错杀被平反人员）子女\60周岁以上农村籍退役士兵 申请信息 domain层
 * @author:
 * @since: 
 * @version: 
*/
public class BptApplyMartyrOffspringDomain implements IBptApplyMartyrOffspringDomain{
	@Reference
	IBptApplyMartyrOffspringDao applyMartyrOffspringDao;
	
	/**
	 * 添加
	 */
	public void insert(BptApplyMartyrOffspring bptApplyMartyrOffspring){
		applyMartyrOffspringDao.insert(bptApplyMartyrOffspring);
	}
	
	/**
	 * 删除
	 */
	public void delete(BptApplyMartyrOffspring bptApplyMartyrOffspring){
		applyMartyrOffspringDao.delete(bptApplyMartyrOffspring);
	}
	
	/**
	 * 修改
	 * @param bptApplyMartyrOffspring
	 */
	public void update(BptApplyMartyrOffspring bptApplyMartyrOffspring){
		applyMartyrOffspringDao.update(bptApplyMartyrOffspring);
	}
	
	/**
	 * 查询
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset){
		return applyMartyrOffspringDao.query(pset);
	}
	
	/**
  	 * 查询未提交部分烈士（错杀被平反人员）子女人员信息
  	 * @param pset
  	 * @return
  	 */
  	public DataSet queryUnCommitRecord(ParameterSet pset){
  		return applyMartyrOffspringDao.queryUnCommitRecord(pset);
  	}
  	
  	 /**
	  * 删除部分烈士（错杀被平反人员）子女申请信息
	  */
	public void deleteMartyrOffspring(ParameterSet pset){
		applyMartyrOffspringDao.deleteMartyrOffspring(pset);
	}
	
	/**
	 * 查询 已提交 部分烈士（错杀被平反人员）子女申请信息
	 * @param pset
	 * @return
	 */
	public DataSet queryMartyrOffspirng(ParameterSet pset){
		return applyMartyrOffspringDao.queryMartyrOffspirng(pset);
	}
	
	
}

